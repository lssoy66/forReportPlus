package com.forreport.service;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.forreport.domain.OrderVO;
import com.forreport.domain.ProductVO;
import com.forreport.mapper.CartMapperTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartServiceTests {
	
	@Setter(onMethod_ = @Autowired)
	private CartService service;

	@Test
	public void testGetCartList() {
		
		List<ProductVO> productList = service.getCartList("user3");
		log.info(productList);
		
	}

}
