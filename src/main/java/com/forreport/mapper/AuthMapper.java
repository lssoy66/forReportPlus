package com.forreport.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forreport.domain.UserVO;

public interface AuthMapper {
	
	/* 은지 - auth ROLE MEMBER 추가*/
	public int grantAuth(String id);
}
