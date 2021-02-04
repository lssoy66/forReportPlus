package com.forreport.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.ReviewPageDTO;
import com.forreport.domain.ReviewVO;
import com.forreport.mapper.OrderMapper;
import com.forreport.mapper.ReviewMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@AllArgsConstructor // mapper 의존성 주입해준다.
@Service
public class ReviewServiceImpl implements ReviewService {

	private ReviewMapper mapper;
	
	private OrderMapper orderMapper;
	
	/*특정 리뷰 번호 리뷰 삭제하기*/
	@Override
	public int removeReview(int reviewNum) {
		return mapper.removeReview(reviewNum);
	}

	
	/*새로운 리뷰 추가하기*/
	@Override
	public int insertReview(ReviewVO reviewVO) {
		return mapper.insertReview(reviewVO);
	}
	
	/*게시글의 총 리뷰 개수 구하기*/
	@Override
	public int getReviewCnt(int pronum) {
		
		return mapper.getReviewCnt(pronum);
	}

	/*게시글의 리뷰 구하기 + 페이징  */
	@Override
	public List<ReviewVO> getReviewList(ReviewCriteria reviewCri, int pronum) {
		
		return mapper.getReviewList(reviewCri, pronum);
	}

	
	/*게시글 번호에 맞는 댓글, 평균 별점만 가져오기*/
	@Override
	public ReviewPageDTO getReviewPageDTO(int pronum) {
		
		ReviewPageDTO dto = new ReviewPageDTO(mapper.getReviewCnt(pronum));
		
		if(mapper.getAvgRate(pronum)==null) { // 댓글이 하나도 없는 경우
			
			dto.setAvgRate(0.0); 
			 
		} else { // 댓글이 하나라도 있는 경우
			
			dto.setAvgRate(mapper.getAvgRate(pronum));
			
			// 각 점수별 이용자 수
			dto.setRateOne(mapper.getRateOne(pronum)|0);
			dto.setRateTwo(mapper.getRateTwo(pronum)|0);
			dto.setRateThree(mapper.getRateThree(pronum)|0);
			dto.setRateFour(mapper.getRateFour(pronum)|0);
			dto.setRateFive(mapper.getRateFive(pronum)|0);
			
		}
		
		return dto;
				
	}


//	@Override
//	public ReviewPageDTO getReviewPageDTO(ReviewCriteria reviewCri, int pronum) {
//		// TODO Auto-generated method stub
//		return null;
//	}
	
	@Override
	/* 리뷰작성자가 해당 제품 구매했는지 여부 확인 */
	public int getOrderData(String id, int pronum) {
		return orderMapper.getOrderData(id, pronum);
	}
	
	@Override
	/* 리뷰 작성자와 삭제 요청자 일치 여부 확인*/
	public int getDeleteData(String id, int pronum, int reviewnum) {
		return mapper.getDeleteData(id, pronum, reviewnum);
	}
			
}
