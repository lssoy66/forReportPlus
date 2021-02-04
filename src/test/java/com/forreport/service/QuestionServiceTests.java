package com.forreport.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.forreport.domain.NoticeVO;
import com.forreport.domain.QuestionVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class QuestionServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private QuestionService service2;
	
	@Test
	public void testExist2() {
		log.info(service2);
		assertNotNull(service2);
	}
	
	@Test
	public void testRegister2() {
		QuestionVO question = new QuestionVO();
		question.setQuestiontitle("새로 작성하는 글");
		question.setQuestion("새로 작성하는 내용");
		service2.register2(question);
		log.info("생성된 게시물의 번호: "+question.getQuestionnum());
	}
	
	@Test
	public void testGetList2() {
		service2.getList2().forEach(question -> log.info(question));
	}
	
	@Test
	public void testGet2() {
		log.info(service2.get2(81));
	}
	
	@Test
	public void testDelete2() {
		//게시물 번호의 존재 여부를 확인하고 테스트할 것
		log.info("REMOVE RESULT: "+service2.remove2(81));
	}
	
	@Test
	public void testUpdate2() {
		QuestionVO question = service2.get2(82);
		if(question == null) {
			return;
		}
		question.setQuestiontitle("제목 수정합니다.");
		log.info("MODIFY RESULT: "+service2.modify2(question));
	}
	
}




















