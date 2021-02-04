package com.forreport.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {
	
	private long pronum; /*상품번호*/
	private String id; /*아이디*/
	private long largeCa; /*대분류*/
	private long smallCa; /*소분류*/
	private String title; /*제목*/
	private String proname; /*상품명*/
	private String prodsc; /*상품설명*/
	private long price; /*가격*/
	private Date uploadDate; /*작성일*/
	
	// 수연 추가 :: 판매 개수
	private int count;

	private long approval; /*승인여부 -- 미승인(0) 승인(1) 승인거부(2) 삭제요청(3)*/ 
	
	private List<ProductVO> productVOList; /* 폼 여러개 보내기 위해서 리스트 설정*/


}
