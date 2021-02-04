package com.forreport.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.forreport.domain.ProductVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.SearchingVO;
import com.forreport.domain.UploadVO;

public interface ProductMapper {
	
	/*전체 리스트 가져오기 (approval=1로 고정)*/
	public List<ProductVO> getProductListWithPaging(SearchingVO searchingVO);
	
	/*전체 게시글 개수 가져오기*/
	public int getTotalCount(SearchingVO searchingVO);
	
	/*상품 상세페이지 만들기 위해서 tbl_product 한 행의 정보 가져오기*/
	public ProductVO getProduct(int pronum);
	
	/*등록 상품 내역 tbl_product에 업로드*/
	public int uploadTblProduct(ProductVO productVO);
	
	/*등록 상품 내역 tbl_upload에 업로드*/
	public int uploadTblUpload(UploadVO uploadVO);
	
	/* 썸네일 정보 가져오기*/
	public UploadVO getThumbnail(int pronum);
	
	/* UUID, fileName을 이용해서 pronum 가져오기 */
	public Integer getPronum(@Param("UUID") String UUID, @Param("fileName") String fileName);
	
	/* 관리자 페이지 - 페이징 처리된 상품 목록 전달*/
	public List<ProductVO> getProductListWithPagingInAdmin(SearchingVO searchingVO);

	
	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 전체 가져오기(페이징X) */
	public List<ProductVO> getProductByIdNotPaging(String id);
	
	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 전체 가져오기(페이징) */
	public List<ProductVO> getProductById(@Param("id") String id, @Param("criteria") ReviewCriteria criteria);
	
	/* 수연 추가 :: 사용자(판매자)가 등록한 상품 총 개수 */
	public int getTotalCountById(String id);

	/* 관리자 페이지 조건에 맞는 상품 개수를 가져온다.*/
	public int getTotalInAdmin(SearchingVO searchingVO);
	
	/* 관리자 페이지 - 상품 승인 변경*/
	public int updateApproval(ProductVO productVO);
	
	/* 회원 등급 조정용 - 해당 유저의 아이디로 업로드된 게시물 중 승인된(approval=1) 게시글 개수 세기*/
	public int countApproval(String id);
	
	/* view - 삭제 요청(숨김처리) */
	public int deleteRequest(int pronum);
		

}
