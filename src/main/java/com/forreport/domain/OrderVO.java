package com.forreport.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderVO {

	private long ordernum;	// 주문 번호
	private long pronum;		// 상품 번호
	private String id;		// 주문자 id
	private String paymethod;	// 결제방식
	private long payprice;	// 결제금액
	private Date orderdate;	// 주문일자
	
	// 상품 이름(mapper에서 두 테이블을 조인하여 가져와 주문리스트에 상품번호 대신 이름을 표시)
	private String proname;	
	
	private List<Long> pronumList;	// 상품번호 리스트
	
	// 신용카드 결제 시
	private long applynum;	// 카드 승인번호
	
	// 무통장 결제 시(가상계좌)
	private String vbnum;	// 입금계좌명
	private String vbname;	// 은행명
	private String vbholder;	// 예금주
	private String vbdate;	// 입금기한
	
	
}
