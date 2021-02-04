package com.forreport.service;

import java.io.File;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forreport.domain.ProductVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.SearchingVO;
import com.forreport.domain.UploadVO;


public interface ProductService {
	
	/*검색조건을 넣어 ProductList를 가져온다.*/
	public List<ProductVO> getProductListWithPaging(SearchingVO searchingVO);
	
	/* 조건에 맞는 전체 게시글의 개수를 가져온다.*/
	public int getTotal(SearchingVO searchingVO);
	
	/* pronum과 일치하는 제품 상세 정보 가져오기*/
	public ProductVO getProduct(int pronum);
	
	/* 카테고리에 맞춰서 제품 썸네일 만들기 */
	public boolean makeThumbnail(UploadVO uploadVO, long largeCa);
	
	/* 제품 등록 */
	public boolean uploadProduct(ProductVO productVO, UploadVO uploadVO);
	
	/* 썸네일 정보 가져오기 +@ 관리자 페이지 파일 다운로드 구현*/
	public UploadVO getThumbnail(int pronum);
	
	/* UUID, fileName을 이용해서 pronum 가져오기 */
	public Integer getPronum(String UUID, String fileName);
	

	
	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 전체 가져오기(페이징X) */
	public List<ProductVO> getProductByIdNotPaging(String id);

	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 전체 가져오기(페이징) */
	public List<ProductVO> getProductById(String id, ReviewCriteria criteria);

	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 총 개수 */
	public int getTotalCountById(String id);

	/* 관리자 페이지 - 페이징 처리된 상품 목록 전달*/
	public List<ProductVO> getProductListWithPagingInAdmin(SearchingVO searchingVO);

	/* 관리자 페이지 조건에 맞는 상품 개수를 가져온다.*/
	public int getTotalInAdmin(SearchingVO searchingVO);
	
	/* 관리자 페이지 - 상품 승인 변경 + 회원 등급 변경*/
	public int updateApprovalAndGrade(ProductVO productVO);
	
	/* view - 작성자 등급 보여주기*/
	public int getGrade(String id);
	
	/* view - 삭제 요청(숨김처리) */
	public int deleteRequestAndGrade(int pronum, String id);

	
}
