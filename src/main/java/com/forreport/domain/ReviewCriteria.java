package com.forreport.domain;

import java.util.Date;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Data
@Log4j
public class ReviewCriteria {
	
	private int pageNum; // 리뷰 페이지 번호
	private int amount; // 한 페이지 당 리뷰 개수
	
	public ReviewCriteria() { // 기본 페이지 출력은 1페이지, 한페이지에 댓글 10개씩
		this(1,10);
	}
	
	public ReviewCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 검색처리 추가
	private String type;			// 검색 조건
	private String keywordOnum;		// 키워드1 - 주문번호
	private String keywordDay;		// 키워드2 - 주문일자
	private String keywordPname;	// 키워드3 - 상품명
	private String keywordOme;		// 키워드4 - 결제방식

	/*
	 * public String[] getTypeArr() { return type == null? new String[] {} :
	 * type.split(""); }
	 */


}
