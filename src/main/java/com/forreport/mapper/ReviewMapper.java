package com.forreport.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.ReviewVO;

public interface ReviewMapper {
	
	/*새로운 리뷰 추가하기*/
	public int insertReview(ReviewVO reviewVO);
	
	/*게시글의 총 리뷰 개수 구하기*/
	public int getReviewCnt(@Param("pronum") int pronum);
	
	/*게시글의 리뷰 구하기 + 페이징*/
	public List<ReviewVO> getReviewList(@Param("reviewCri") ReviewCriteria reviewCri, @Param("pronum") int pronum);
	
	/*게시글 평균 별점 구하기*/
	public Double getAvgRate(@Param("pronum") int pronum);
	
	/*특정 리뷰 번호 리뷰 삭제하기*/
	public int removeReview(int reviewNum);
	
	/*각 점수 별 사람수*/
	public int getRateFive(@Param("pronum") int pronum);
	public int getRateFour(@Param("pronum") int pronum);
	public int getRateThree(@Param("pronum") int pronum);
	public int getRateTwo(@Param("pronum") int pronum);
	public int getRateOne(@Param("pronum") int pronum);
	
	/* 리뷰 작성자와 삭제 요청자 일치 여부 확인*/
	public int getDeleteData(@Param("id") String id, @Param("pronum") int pronum, @Param("reviewnum") int reviewnum);

	
	
	
}
