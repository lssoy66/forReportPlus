package com.forreport.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.forreport.domain.UserVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTests {
	//(664) MemberMapperTest
	@Setter(onMethod_= @Autowired)
	private UserMapper mapper;
	
	@Test
	public void testRead() {
		UserVO vo = mapper.read("admin");
		log.info(vo);
		vo.getAuthList().forEach(authVO -> log.info(authVO));
	}
}

