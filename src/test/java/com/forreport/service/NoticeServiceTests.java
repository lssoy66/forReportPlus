package com.forreport.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.forreport.domain.NoticeVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class NoticeServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private NoticeService service1;
	
	@Test
	public void testExist1() {
		log.info(service1);
		assertNotNull(service1);
	}
	
	@Test
	public void testRegister1() {
		NoticeVO notice = new NoticeVO();
		notice.setNoticetitle("새로 작성하는 글");
		notice.setNotice("새로 작성하는 글");
		service1.register1(notice);
		log.info("생성된 게시물의 번호: "+notice.getNoticenum());
	}
	
	@Test
	public void testGetList1() {
		service1.getList1().forEach(notice -> log.info(notice));
	}
	
	@Test
	public void testGet1() {
		log.info(service1.get1(46));
	}
	
	@Test
	public void testDelete1() {
		//게시물 번호의 존재 여부를 확인하고 테스트할 것
		log.info("REMOVE RESUTL: "+service1.remove1(46));
	}
	
	@Test
	public void testUpdate1() {
		NoticeVO notice = service1.get1(47);
		if(notice == null) {
			return;
		}
		notice.setNoticetitle("제목 수정합니다.");
		log.info("MODIFY RESULT: "+service1.modify1(notice));
	}
	
}



















