package com.forreport.mapper;

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
public class NoticeMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;
	
	@Test
	public void testGetList1() {
		mapper.getList1().forEach(notice -> log.info(notice));
	}
	
	@Test
	public void testInsert1() {
		NoticeVO notice = new NoticeVO();
		notice.setNoticetitle("새로 작성하는 글");
		notice.setNotice("새로 작성하는 글");
		mapper.insert1(notice);
		log.info(notice);
	}
	
	@Test
	public void testInsertSelectKey1() {
		NoticeVO notice = new NoticeVO();
		notice.setNoticetitle("새로 작성하는 글 selectkey");
		notice.setNotice("새로 작성하는 글 selectkey");
		mapper.insertSelectKey1(notice);
		log.info(notice);
	}
	
	@Test
	public void testread1() {
		//존재하는 게시판 번호로 테스트
		NoticeVO notice = mapper.read1(102);
		log.info(notice);				
	}
	
	@Test
	public void testDelete1() {
		log.info("DELETE COUNT: "+mapper.delete1(102));
	}
	
	@Test
	public void testUpdate1() {
		NoticeVO notice = new NoticeVO();
		// 실행 전 존재하는 번호인지 확인할 것
		notice.setNoticenum(63);
		notice.setNoticetitle("수정된 제목");
		notice.setNotice("수정된 내용");
		int count1 = mapper.update1(notice);
		log.info("UPDATE COUNT: "+count1);
		
	}

}


























