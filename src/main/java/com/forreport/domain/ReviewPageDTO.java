package com.forreport.domain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.JsonObject;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReviewPageDTO {

	private int reviewTotal; /*전체 리뷰 개수*/
	private List<ReviewVO> reviewList; /*리뷰 리스트*/
	private Double avgRate; /*리뷰 평균*/
	
	private ReviewCriteria reviewCriteria; /*리뷰 페이지 상세 정보*/
	
	private int rateFive; /*5점을 준 구매자 수*/
	private int rateFour; /*4점을 준 구매자 수*/
	private int rateThree; /*3점을 준 구매자 수*/
	private int rateTwo; /*2점을 준 구매자 수*/
	private int rateOne; /*1점을 준 구매자 수*/
	
	/*리뷰 개수만으로 생성자 만들기 -> 가장 기본이 되는 내용이라 생성자로 만들어둠*/
	public ReviewPageDTO(int reviewTotal) {
		this.reviewTotal = reviewTotal;
	}
	
	/*리스트에서 사용 - 리뷰 개수, 평균 별점*/
	public ReviewPageDTO(int reviewTotl, double avgRate) {
		this.reviewTotal = reviewTotl;
		this.avgRate = avgRate;
	}

	/* 각 점수별 구매자 수*/
	public ReviewPageDTO(int rateFive, int rateFour, int rateThree, int rateTwo, int rateOne) {
		
		this.rateFive = rateFive;
		this.rateFour = rateFour;
		this.rateThree = rateThree;
		this.rateTwo = rateTwo;
		this.rateOne = rateOne;
	}
	
}
