package com.forreport.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	
	private int noticenum;
	private String noticetitle;
	private String notice;
	private Date writedate;
	private Date revisedate;
	

}
