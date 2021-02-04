package com.forreport.domain;

import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	public String id;
	public String password;
	public String name;
	public String phone;
	public String email;
	public int grade;
	public boolean enabled;
	
	
	private List<AuthVO> authList;
	
}

