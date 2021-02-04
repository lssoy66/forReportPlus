package com.forreport.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	
	private int reviewNum;
	private int pronum;
	private String id;
	private String review;
	private Date reviewDate;
	private long rate;

}
