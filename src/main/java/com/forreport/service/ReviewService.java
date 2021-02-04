package com.forreport.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.ReviewPageDTO;
import com.forreport.domain.ReviewVO;

public interface ReviewService {
	
	/*새로운 리뷰 추가하기*/
	public int insertReview(ReviewVO reviewVO);
	
	/*게시글의 총 리뷰 개수 구하기*/
	public int getReviewCnt(int pronum);
	
	/*게시글의 리뷰 구하기 + 페이징*/
	public List<ReviewVO> getReviewList(ReviewCriteria reviewCri, int pronum);
	
	/*게시글 번호에 맞는 댓글, 평균 별점만 가져오기*/
	public ReviewPageDTO getReviewPageDTO(int pronum);
	
//	/*게시글 번호에 맞는 reviewCriteria까지 이용해서 DTO 가져오기*/
//	public ReviewPageDTO getReviewPageDTO(ReviewCriteria reviewCri, int pronum);
	
	/*특정 리뷰 번호 리뷰 삭제하기*/
	public int removeReview(int reviewNum);
	
	/* 리뷰작성자가 해당 제품 구매했는지 여부 확인 */
	public int getOrderData(String id, int pronum);
	
	/* 리뷰 작성자와 삭제 요청자 일치 여부 확인*/
	public int getDeleteData(String id, int pronum, int reviewnum);
	
	
}
