package com.forreport.persistence;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.forreport.mapper.TableTestMapper;
import com.forreport.mapper.TimeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TableTestMapperTests {

	@Setter(onMethod_ = @Autowired)
	private TableTestMapper tableTestMapper;
	
	// tbl_user 테이블의 정보를 가져오는지 테스트
	@Test
	public void testGetUserList() {
		log.info("getGetUserList"); 
		tableTestMapper.getUserList().forEach(user -> log.info(user));
	}
	
}
