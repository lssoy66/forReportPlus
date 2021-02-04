package com.forreport.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.head;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.multipart;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.websocket.server.PathParam;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.forreport.domain.PageDTO;
import com.forreport.domain.ProductVO;
import com.forreport.domain.ReviewPageDTO;
import com.forreport.domain.SearchingVO;
import com.forreport.domain.UploadVO;
import com.forreport.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product")
@AllArgsConstructor
public class ProductController {
	
	private ProductService productService;

	/* 각 페이지별로 조건(키워드, 카테고리)과 페이지 번호에 맞는 게시글 출력 */
	@GetMapping("list.fr")
	public void productPage(SearchingVO searchingVO, Model model) {
		
		int total = productService.getTotal(searchingVO);
		
		PageDTO pageDTO = new PageDTO(searchingVO, total);
		
		System.out.println(pageDTO);
		
		List<ProductVO> productList = productService.getProductListWithPaging(searchingVO);
				
		model.addAttribute("pageDTO", pageDTO);
		
		log.info(pageDTO.getEndPage());
		model.addAttribute("productList", productList);		
		
	}
	
	/* 댓글을 제외한 전체 상품 상세 뷰 살펴보기 -> 댓글은 ReviewController + Ajax를 이용해 확인 가능*/
	/* 탈퇴회원의 경우 작성자: 탈퇴회원, 작성자 등급: 등긊없음으로 표시*/
	@GetMapping("view.fr")
	public void productView(int pronum, Model model) {
		
		ProductVO productVO = productService.getProduct(pronum);
		
		log.info(productVO);
		log.info(productVO.getId());
		
		String writerGrade = "";
		System.out.println("writerGrade: " + writerGrade);		
		
		if(productVO.getId().equals("탈퇴회원")) {
			writerGrade = "등급없음";
		} else {
			
			int writerGradeInt = productService.getGrade(productVO.getId());
			
			if(writerGradeInt==0) {
				writerGrade = "일반";
			} else if(writerGradeInt==1) {
				writerGrade = "브론즈";
			} else if(writerGradeInt==2) {
				writerGrade = "실버";
			} else if(writerGradeInt==3) {
				writerGrade = "골드";

			}
		}
		
		model.addAttribute("writerGrade", writerGrade);
		model.addAttribute("productVO", productVO);
	}
	
	/* 상품 등록 전 규정 및 주의사항 */
	@GetMapping("agree.fr")
	public void productUploadAgree() {
		log.info("agree.fr");		
	}
	
	/* 상품 등록 관련 내용 작성*/
	@PostMapping("write.fr")
	public void productWrite() {
		log.info("write.fr -> 상품 등록 창 출력");
	}
	
	/* 상품 서버 등록 + DB 저장*/
	@PostMapping("upload.fr")
	public String productUpload(MultipartFile uploadFile, ProductVO productVO) {
				
		log.info("last productVO: " + productVO);
		
		log.info("upload.fr -> 상품 등록 진행");
		log.info("uploadFile: " + uploadFile);
		
		String uploadFolder = "C:\\upload";
		
		// 파일 업로드할 폴더 생성
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("uploadPath: " + uploadPath);
		
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
			
			 // File의 경로에 파일이 있는지 확인 >> 없을 경우 mkdirs를 이용해 폴더 생성
			 // File.mkdirs():: 상위 폴더가 없을경우 상위폴더들까지 생성
		}
		
		// 파일의 원래 이름을 UploadVO에 저장
		UploadVO uploadVO = new UploadVO();
		
		log.info("upload File Name: " + uploadFile.getOriginalFilename());
		log.info("upload File Size: " + uploadFile.getSize());
		
		// IE인 경우 파일의 기존 디렉토리까지 다 나오기 때문에 파일 찐 이름만 가져오기 위해 subString 처리
		// 파일 이름은 uploadVO, productVO 각각 저장
		String uploadFileName = uploadFile.getOriginalFilename();
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1); 
		
		productVO.setProname(uploadFileName);		
		uploadVO.setFileName(uploadFileName);
		log.info("original File Name: " + uploadFileName);
		
		// 중복방지를 위한 UUID 생성
		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString()+"_"+uploadFileName;
		
		
		File saveFile = null;
		try {
			
			// 위에서 만들어둔 오늘 날짜로 된 폴더에 파일 업로드하기 위한 셋팅
			saveFile = new File(uploadPath, uploadFileName);
			uploadFile.transferTo(saveFile); // 업로드하려고 브라우저에서 올린 파일을 해당 위치에 저장
			
			uploadVO.setUUID(uuid.toString());
			uploadVO.setFileDirectory(uploadPath.toString());
			
			log.info("uploadVO.getUUID: " + uploadVO.getUUID());
			log.info("uploadVO.getFileDirectory: " + uploadVO.getFileDirectory());
			
		} catch(Exception e) {
			
			log.error(e.getMessage());
			
		} // try - catch
		
		
		log.info("last productVO: " + productVO);
		log.info("last uploadVO: " + uploadVO);
		
		boolean uploadCheck = productService.makeThumbnail(uploadVO, productVO.getLargeCa());
				
		if(uploadCheck) { // 업로드 된 경우 > DB에 등록
			
			// DB 등록
			boolean uploadResult = productService.uploadProduct(productVO, uploadVO);
						
			if(uploadResult) { // DB에도 제대로 등록이 된 경우
				log.info("등록이 완료되었습니다.");
				
				log.info("uploadVO.getUUID(): " + uploadVO.getUUID());
				log.info("uploadVO.getFileName(): " + uploadVO.getFileName());
				
				int pronum = productService.getPronum(uploadVO.getUUID(), uploadVO.getFileName());
				return "redirect:view.fr?pronum="+pronum;
			} else { // DB에 등록 안 된 경우
				log.info("등록에 실패했습니다.");
				return "redirect:write.fr";
				
			}
						
		} else { // 업로드 안 된 경우 > DB 등록 X
			log.info("상품 등록에 실패했습니다.");
			return "redirect:write.fr";
		}
		
	} // END: productUpload
	
	/*날짜별 폴더 만들어 파일 분산 저장*/
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	/* 썸네일 데이터 전달하기(1개씩) */
	@GetMapping("/showThumbnail.fr")
	public ResponseEntity<byte[]> getThumbnail(int pronum, int index) {
		
		UploadVO uploadVO = productService.getThumbnail(pronum);
		
		File file = null;
		ResponseEntity<byte[]> result = null;
		HttpHeaders header = new HttpHeaders();
			
				
		file = new File(uploadVO.getFileDirectory()+"\\th_"
				+uploadVO.getUUID()+"_"+index+"_"
				+uploadVO.getFileName().substring(0, uploadVO.getFileName().lastIndexOf("."))+".jpg");
			
		log.info(file);
		
		header = new HttpHeaders();
		
		try {
			header.add("Content-type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (IOException e) {
			byte[] nullByte = null;
			result = new ResponseEntity<byte[]>(nullByte, HttpStatus.NO_CONTENT);
			//e.printStackTrace();
			
		}
		
		return result;
	}
	

	// 첨부파일 다운로드
	// 상품번호를 전달받아 tbl_upload 테이블에 존재하는 상품 가져오도록
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, @RequestParam("pronum") int pronum){
		
		// pronum을 이용해 UploadVO 객체 얻기
		UploadVO uploadVO = productService.getThumbnail(pronum);
		
		String fileName = uploadVO.getFileDirectory() + "\\" + uploadVO.getUUID() + "_" + uploadVO.getFileName();
		
		Resource resource = new FileSystemResource(fileName);		

		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		// 다운로드 시 UUID 없는 파일 이름으로 저장할 수 있도록 UUID 제거
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		// 헤더를 사용해 브라우저 별로 다르게 처리(+한글 인코딩)
		HttpHeaders headers = new HttpHeaders();
		try {
			String downloadName = null;
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			}else if(userAgent.contains("Edge")){
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			}else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			log.info("*** downloadName : " + downloadName);
			
			headers.add("Content-Disposition", 
					"attachment; filename=" + downloadName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}	

	/* 게시글 삭제 요청 > 승인을 삭제 요청으로 변경 >> 관리자가 추후에 승인거부(숨김처리)해준다. */
	@PostMapping("/deleteRequest.fr")
	@ResponseBody
	public String deleteRequest(Integer pronum, String id) {
		
		log.info("deleteRequest pronum: " + pronum);
		
		String result = productService.deleteRequestAndGrade(pronum,id)==2 ? "success" : "fail";
		
		return result;

	}
	
}	
	
