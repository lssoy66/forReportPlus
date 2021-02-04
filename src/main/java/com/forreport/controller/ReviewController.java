package com.forreport.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forreport.domain.ReviewCriteria;
import com.forreport.domain.ReviewPageDTO;
import com.forreport.domain.ReviewVO;
import com.forreport.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/review/")
@AllArgsConstructor
public class ReviewController {
	
	private ReviewService reviewService;
	
	/* 제품 페이지에서 일치하는 댓글들 보여주기 + 페이징*/
	@GetMapping(value = "/get/pronum/{pronum}/{pageNum}",
				produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReviewPageDTO> getReviewList(
			@PathVariable("pronum") int pronum, @PathVariable("pageNum") int pageNum) {
		
		ReviewCriteria reviewCri = new ReviewCriteria(pageNum, 10);		
		ReviewPageDTO reviewPageDTO = reviewService.getReviewPageDTO(pronum); // 각 rate별 댓글수는 이미 들어가 있음
		
		reviewPageDTO.setReviewCriteria(reviewCri);
			
		log.info("get Review List pageNum: " + pageNum);
		reviewPageDTO.setReviewList(reviewService.getReviewList(reviewCri, pronum));
		
		log.info(reviewPageDTO.getRateFive());
		
		log.info(reviewPageDTO);
	
		// ResponseEntity<T>(T body, HttpStatus status)
		return new ResponseEntity<ReviewPageDTO>(reviewPageDTO, HttpStatus.OK);
	}

	
	/* 새 댓글 추가 */
	@PostMapping(value = "/new",
				 consumes = "application/json",
				 produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> reviewAdd(@RequestBody ReviewVO reviewVO) {
		
		log.info("reviewVO: " + reviewVO);
				
		int addCheck = reviewService.insertReview(reviewVO);
		
		return addCheck==1
				? new ResponseEntity<>("success", HttpStatus.OK) // 삽입 성공한 경우
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // 삽입 실패한 경우
	}
	
	
	/* 댓글 삭제 */
	@DeleteMapping( value = "/delete/{reviewNum}",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> removeReview(@PathVariable("reviewNum") String reviewNum){
		
		log.info("안녕하세요");
		log.info("remove: " + reviewNum);
		
		int reviewNumToNum = Integer.parseInt(reviewNum);
		
		return reviewService.removeReview(reviewNumToNum)==1
				? new ResponseEntity<> ("delete review", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	/* 리스트에서 사용할 댓글 수 + 평점*/
	@GetMapping(value= "forList/{pronum}",
				produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReviewPageDTO> getTotalAndAvgRate(@PathVariable("pronum") int pronum){
		return new ResponseEntity<> (reviewService.getReviewPageDTO(pronum), HttpStatus.OK);
	}
	
	/* 댓글 삭제 요청자와 댓글 작성자 비교*/
	@PostMapping(value = "deleteData.fr")
	@ResponseBody
	public String getDeleteData(String id, int pronum, int reviewnum) {
		
		if(reviewService.getDeleteData(id, pronum, reviewnum)==1) {
			return "success";
		} else {
			return "fail";
		}
		
	}
	/* 댓글 작성 요청자의 구매 여부 확인*/
	@PostMapping(value = "orderData.fr")
	@ResponseBody
	public String getDeleteData(String id, int pronum) {
		
		if(reviewService.getOrderData(id, pronum)==1) {
			return "success";
		} else {
			return "fail";
		}
		
	}
		
	
}
