package com.forreport.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@AllArgsConstructor
@ToString
@Setter
@Getter
public class AdminCriteriaVO {
	
	private String keyword; // 입력한 키워드	
	
	private int pageNum; // 페이지 번호
	private int amount; // 한 페이지 당 글의 개수
	
	
	
	public AdminCriteriaVO() { // 기본 페이지 출력은 1페이지
		this(1,10);
	}
	
	public AdminCriteriaVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	
	private String type;
	
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
		.queryParam("pageNum", this.pageNum)
		.queryParam("amount", this.getAmount())
		.queryParam("type", this.getType())
		.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
		
	}

}
