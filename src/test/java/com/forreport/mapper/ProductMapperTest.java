package com.forreport.mapper;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.forreport.domain.ProductVO;
import com.forreport.domain.UploadVO;
import com.forreport.service.ProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ProductMapperTest {
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private ProductService service;
	
	
	// 주문자의 장바구니 리스트 가져오기
	@Test
	public void testGetMapper() {
		
		ProductVO productVO = new ProductVO();
				
		productVO.setId("aa");
		productVO.setLargeCa(0);
		productVO.setSmallCa(0);
		productVO.setTitle("144 JUNIT");
		productVO.setProname("asdf");
		productVO.setProdsc("테스트이니다.");
		productVO.setPrice(10000L);		

		UploadVO uploadVO = new UploadVO();
		
		uploadVO.setUUID("asdf");
		uploadVO.setFileDirectory("testDirectory");
		uploadVO.setFileName("testFile");
		
		service.uploadProduct(productVO, uploadVO);
	}

}
