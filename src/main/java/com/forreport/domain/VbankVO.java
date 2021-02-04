package com.forreport.domain;

import java.util.Date;

import lombok.Data;

@Data
public class VbankVO {

	private String id;		// 구매자 아이디
	private long ordernum;	// 주문번호
	private String vbnum;	// 입금계좌명
	private String vbname;	// 은행명
	private String vbholder;	// 예금주
	private Date vbdate;	// 입금기한
	
}
