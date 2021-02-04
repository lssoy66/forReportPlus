package com.forreport.domain;

import lombok.Data;

@Data
public class CartVO {
	
	private long cartNum;	// 장바구니 번호
	private String id;		// 사용자 id(장바구니 주인)
	private long proNum;		// 상품 번호
	
}
