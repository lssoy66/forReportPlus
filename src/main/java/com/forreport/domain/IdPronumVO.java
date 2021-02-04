package com.forreport.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

// 장바구니, 주문 시 주문자 id와 주문할 상품번호를 한번에 담기 위한 VO
@Data
public class IdPronumVO {

	private String id;
	private long pronum;
	
}
