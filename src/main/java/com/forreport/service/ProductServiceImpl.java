package com.forreport.service;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.encryption.InvalidPasswordException;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xslf.XSLFSlideShow;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.apache.poi.xslf.usermodel.XSLFCommonSlideData;
import org.apache.poi.xslf.usermodel.XSLFSlide;
import org.apache.poi.xwpf.converter.pdf.PdfConverter;
import org.apache.poi.xwpf.converter.pdf.PdfOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.xmlbeans.XmlException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.forreport.domain.ProductVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.SearchingVO;
import com.forreport.domain.UploadVO;
import com.forreport.mapper.OrderMapper;
import com.forreport.mapper.ProductMapper;
import com.forreport.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor // mapper 의존성 주입해준다.
@Service
public class ProductServiceImpl implements ProductService {

	private ProductMapper mapper;
	private OrderMapper orderMapper;
	
	private UserMapper userMapper;
	
	/*검색조건을 넣어 ProductList를 가져온다.*/
	@Override
	public List<ProductVO> getProductListWithPaging(SearchingVO searchingVO) {
		
		log.info("get List");
		
		List<ProductVO> productList = mapper.getProductListWithPaging(searchingVO);
		return productList;
		
	}

	/* 조건에 맞는 게시글의 전체 개수 가져오기*/
	@Override
	public int getTotal(SearchingVO searchingVO) {
		log.info("get total count");
		return mapper.getTotalCount(searchingVO);
	}

	/* 게시글 번호를 이용해서 실제 게시글(상품내용) 가져오기*/
	@Override
	public ProductVO getProduct(int pronum) {
		log.info("getProduct");		
		
		return mapper.getProduct(pronum);
	}

	/* 카테고리에 맞춰서 제품 썸네일 만들기 */
	/*
	 * 참고 사이트
	 *  PDF to img: https://m.blog.naver.com/PostView.nhn?blogId=bb_&logNo=221329660551&proxyReferer=http:%2F%2F203.233.24.233%2F
	 *  docx to pdf: https://www.programmersought.com/article/6545570299/
	 *  pptx to img: https://m.blog.naver.com/PostView.nhn?blogId=hgp33&logNo=220567612990&proxyReferer=https:%2F%2Fwww.google.com%2F
	 */
	@Override
	public boolean makeThumbnail(UploadVO uploadVO, long largeCa) {
							
		System.out.println("uploadVO: " + uploadVO);
		log.info("uploadVO: " + uploadVO);
		
		String filePath = uploadVO.getFileDirectory()+"\\"+uploadVO.getUUID() +"_"+ uploadVO.getFileName();
		String nonExtensionFileName = uploadVO.getFileName().substring(0, uploadVO.getFileName().lastIndexOf(".")); // 확장자없는 파일이름
		System.out.println(nonExtensionFileName);
		
		File file = new File(filePath);
		System.out.println("file.getPath(): " + file.getPath());
		
		// 1. (word) -> pdf -> image
		if(uploadVO.getFileName().endsWith("docx")||uploadVO.getFileName().endsWith("pdf")) { 
			
			// word 파일인 경우 pdf로 변환 후 이미지 변환 필요, 단점(일부 글자 깨짐)
			if(uploadVO.getFileName().endsWith("docx")) {
				
				String filePathWordToPDF = uploadVO.getFileDirectory()+"\\"+uploadVO.getUUID() +"_wordToPdf_" + nonExtensionFileName+".pdf";
				
				try {
					XWPFDocument doc = new XWPFDocument(new FileInputStream(file));
					PdfOptions options = PdfOptions.create();
					PdfConverter.getInstance().convert(doc, new FileOutputStream(filePathWordToPDF), options);
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				file = new File(filePathWordToPDF);
				System.out.println("filePathWordToPDF: " + filePathWordToPDF);
			}
			
			// 1-1. PDF 문서 객체 준비
			PDDocument document = null;
			
			try {
				
				document = PDDocument.load(file);
				
				// 1-2. PDF 파일의 페이지 수 가져오기 
				int pageCount = document.getNumberOfPages();
				
				// 1-3. PDF 파일을 JPG 파일로 변환
				
				PDFRenderer pdfRenderer = new PDFRenderer(document);
					
				if(largeCa==0) { // 레포트 > 썸네일 3장
					
					for(int i = 0; i<3; i ++) {
						
						if(i==pageCount) { // 원본 파일 페이지가 3장보다 작을 경우 해당 부분까지만 썸네일 만들기
							break;
						}
						
						/*
						 * BufferedImage클래스: 그림을 그릴 수 있게 해주는 클래스
						 * PDFRenderer: PDF 활용할 수 있게 해주는 클래스
						 * 		-- renderImageWithDPI(int pageIndex, float dpi, ImageType imageType)
						 * 				:: dpi로 해상도 조절, imageType은 어떤 이미지 타입으로 할건지 정하는것(종류 다양)
						 */
							
						BufferedImage imageObj = pdfRenderer.renderImageWithDPI(i, 100, ImageType.RGB);
						File outputfile = new File(uploadVO.getFileDirectory()+"\\th_"+uploadVO.getUUID() +"_"+i+"_"+nonExtensionFileName+".jpg");
						
						/*
						 * 썸네일 파일 이름 형태: 기존 날짜별 디렉토리\\th_썸네일번호_uuid_원본 파일이름
						 */
						
						ImageIO.write(imageObj, "jpg", outputfile);
					
					}
					
				} else if(largeCa==1) { // 논문 > 썸네일 5장
					
					for(int i = 0; i<5; i ++) {
						
						if(i==pageCount) {
							break; // 원본 파일 페이지가 5장보다 작을 경우 해당 부분까지만 썸네일 만들기
						}
						
						/*
						 * BufferedImage클래스: 그림을 그릴 수 있게 해주는 클래스
						 * PDFRenderer: PDF 활용할 수 있게 해주는 클래스
						 * 		-- renderImageWithDPI(int pageIndex, float dpi, ImageType imageType)
						 * 				:: dpi로 해상도 조절, imageType은 어떤 이미지 타입으로 할건지 정하는것(종류 다양)
						 */
							
						BufferedImage imageObj = pdfRenderer.renderImageWithDPI(i, 100, ImageType.RGB);
						File outputfile = new File(uploadVO.getFileDirectory()+"\\th_"+uploadVO.getUUID() +"_"+i+"_"+nonExtensionFileName+".jpg");
						
						/*
						 * 썸네일 파일 이름 형태: 기존 날짜별 디렉토리\\th_썸네일번호_uuid_원본 파일이름
						 */
						
						ImageIO.write(imageObj, "jpg", outputfile);
					}
				}
				
				document.close();
				
				File deleteFile = new File(uploadVO.getFileDirectory()+"\\"+uploadVO.getUUID() +"_wordToPdf_" + nonExtensionFileName+".pdf");
				if(deleteFile.exists()) {
					if(deleteFile.delete()) {
						System.out.println("파일삭제 성공");
					} else {
						System.out.println("파일 삭제 실패");
					}
				} else {
					System.out.println("파일 삭제할 필요 없습니다.");
				}
					
				return true;
							
			} catch (InvalidPasswordException e) {			
				e.printStackTrace();
				return false;
			} catch (IOException e) {			
				e.printStackTrace();	
				return false;
			} 
		}
			
		// pptx -> jpg
		if(uploadVO.getFileName().endsWith("pptx")) {
				
			try {
				
				// ppt 객체 만들기
				XMLSlideShow ppt = new XMLSlideShow(new FileInputStream(file));
				
				// ppt 페이지 사이즈 구하기
				Dimension pgsize = ppt.getPageSize();
				
				// ppt 장수 구하기
				int pageCount = ppt.getSlides().length;
				
				List<XSLFSlide> slide = new ArrayList<XSLFSlide>(Arrays.asList(ppt.getSlides())) ;
				
				// 이미지 객체 생성
				BufferedImage img = null;
				FileOutputStream out = null;
				
				// 카테고리에 맞게 썸네일 생성
				
				if(largeCa==0) { // 레포트 > 썸네일 3장
					
					for(int i = 0; i<3; i ++) {
						
						if(i==pageCount) { // 원본 파일 페이지가 3장보다 작을 경우 해당 부분까지만 썸네일 만들기
							break;
						}
						
						img = new BufferedImage(pgsize.width, pgsize.height, BufferedImage.TYPE_INT_BGR);
						Graphics2D graphics = img.createGraphics();
						
						// clear the drawing area
						graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
						graphics.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
						graphics.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
						
						graphics.setPaint(Color.white);
						graphics.fill(new Rectangle2D.Float(0,0,pgsize.width, pgsize.height));
						
						// render
						slide.get(i).draw(graphics);
						
						out = new FileOutputStream(uploadVO.getFileDirectory()+"\\th_"+uploadVO.getUUID() +"_"+i+"_"+nonExtensionFileName + ".jpg");
						ImageIO.write(img, "jpg", out);
						
						}
						
					} else if(largeCa==1) { // 논문 > 썸네일 5장
						
						for(int i = 0; i<5; i ++) {
							
							if(i==pageCount) { // 원본 파일 페이지가 3장보다 작을 경우 해당 부분까지만 썸네일 만들기
								break;
							}
							
							img = new BufferedImage(pgsize.width, pgsize.height, BufferedImage.TYPE_INT_BGR);
							Graphics2D graphics = img.createGraphics();
							
							// clear the drawing area
							graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
							graphics.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
							graphics.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
							
							graphics.setPaint(Color.white);
							graphics.fill(new Rectangle2D.Float(0,0,pgsize.width, pgsize.height));
							
							// render
							slide.get(i).draw(graphics);
							
							out = new FileOutputStream(uploadVO.getFileDirectory()+"\\th_"+uploadVO.getUUID() +"_"+i+"_"+nonExtensionFileName + ".jpg");
							ImageIO.write(img, "jpg", out);
							
							}
					}
				
			} catch (FileNotFoundException e) {
				
				e.printStackTrace();
			} catch (IOException e) {
			
				e.printStackTrace();
			}
			
		}
		
		return true;				
	}
	
	/* 제품 등록 */
	@Transactional
	@Override
	public boolean uploadProduct(ProductVO productVO, UploadVO uploadVO) {
		
		int resultAddProduct = mapper.uploadTblProduct(productVO);
		int resultAddUpload = mapper.uploadTblUpload(uploadVO);
		
		if(resultAddProduct==1 && resultAddUpload==1) {
			return true;
		}
		
		return false;
		
	}
	
	/* 썸네일 정보 가져오기*/
	@Override
	public UploadVO getThumbnail(int pronum) {
		return mapper.getThumbnail(pronum);
	}
	
	/* UUID, fileName을 이용해서 pronum 가져오기 */
	@Override
	public Integer getPronum(String UUID, String fileName) {
		return mapper.getPronum(UUID, fileName);
	}

	
	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 전체 가져오기(페이징X) */
	@Override
	public List<ProductVO> getProductByIdNotPaging(String id) {
		
		// 해당 사용자가 등록한 상품을 모두 가져온 후
		List<ProductVO> list = mapper.getProductByIdNotPaging(id);
		
		// 각각의 상품 객체(ProductVO)에 포함된 판매 수(count)를 추가
		for(ProductVO product : list) {
			product.setCount(orderMapper.getTotalCountByPronum(product.getPronum()));
		}
		
		return list;
	}

	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 전체 가져오기(페이징) */
	@Override
	public List<ProductVO> getProductById(String id, ReviewCriteria criteria) {
		
		List<ProductVO> list = mapper.getProductById(id, criteria);
		
		for(ProductVO product : list) {
			product.setCount(orderMapper.getTotalCountByPronum(product.getPronum()));
		}
		
		return list;
	}
	
	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 총 개수 */
	@Override
	public int getTotalCountById(String id) {
		return mapper.getTotalCountById(id);
	}

	

	/* 관리자 페이지 - 페이징 처리된 상품 목록 전달*/
	@Override
	public List<ProductVO> getProductListWithPagingInAdmin(SearchingVO searchingVO){
		return mapper.getProductListWithPagingInAdmin(searchingVO);
	}
	
	/* 관리자 페이지 조건에 맞는 상품 개수를 가져온다.*/
	public int getTotalInAdmin(SearchingVO searchingVO) {
		return mapper.getTotalInAdmin(searchingVO);
	}
	
	/* 관리자 페이지 - 상품 승인 변경 + 회원 등급 변경*/
	// 상품 승인 변경 -> 해당 아이디로 업로드된 게시글 확인 -> 만약 기준 통과했으면 회원 등급 변경
	@Override
	@Transactional
	public int updateApprovalAndGrade(ProductVO productVO) {
		
		// 상품 승인 변경
		int resultUpdateApproval = mapper.updateApproval(productVO);
		System.out.println("싱픔 승인 변경__resultUpdateApproval:"+ resultUpdateApproval);
		
		int count = mapper.countApproval(productVO.getId()); // 업로드 게시글 확인
		System.out.println("productVO.getId(): " + productVO.getId());
		System.out.println("해당 게시글 유저 업로드 개수__: "+ count);

		int resultUpdateUser = 0;
		int grade = 0;
		if(count >= 15) {
			grade = 3; // 골드
			resultUpdateUser = userMapper.updateGrade(productVO.getId(), grade);
		} else if(count >= 10) {
			grade = 2; // 실버
			resultUpdateUser = userMapper.updateGrade(productVO.getId(), grade);
		} else if(count >= 5) {
			grade = 1; // 브론즈
			resultUpdateUser = userMapper.updateGrade(productVO.getId(), grade);
		} else if(count <5) {
			grade = 0; // 일반
			resultUpdateUser = userMapper.updateGrade(productVO.getId(), grade);

		}
		System.out.println("grade: " + grade);
		System.out.println("회원 등급 변경__resultUpdateUser: " + resultUpdateUser);
		
		return resultUpdateApproval + resultUpdateUser;
		// 승인 변경 + 권한 변경 = 2
		// 승인변경 = 1
	}
	
	/* view - 작성자 등급 보여주기*/
	public int getGrade(String id) {
		return userMapper.getGrade(id);
	};
	
	/* view - 삭제 요청(숨김처리) */
	@Transactional
	public int deleteRequestAndGrade(int pronum, String id) {
		
		int resultDeleteApproval = mapper.deleteRequest(pronum);
		
		int count = mapper.countApproval(id); // 업로드 게시글 확인
		System.out.println("id: " + id);
		System.out.println("해당 게시글 유저 업로드 개수__: "+ count);

		int resultUpdateUser = 0;
		int grade = 0;
		if(count >= 15) {
			grade = 3; // 골드
			resultUpdateUser = userMapper.updateGrade(id, grade);
		} else if(count >= 10) {
			grade = 2; // 실버
			resultUpdateUser = userMapper.updateGrade(id, grade);
		} else if(count >= 5) {
			grade = 1; // 브론즈
			resultUpdateUser = userMapper.updateGrade(id, grade);
		} else if(count <5) {
			grade = 0; // 일반
			resultUpdateUser = userMapper.updateGrade(id, grade);

		}
		System.out.println("grade: " + grade);
		System.out.println("회원 등급 변경__resultUpdateUser: " + resultUpdateUser);

		
		return resultDeleteApproval + resultUpdateUser;
	};
}
