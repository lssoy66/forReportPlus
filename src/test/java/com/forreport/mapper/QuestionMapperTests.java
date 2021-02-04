package com.forreport.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.forreport.domain.QuestionVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class QuestionMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private QuestionMapper mapper;
	
	@Test
	public void testGetList2() {
		mapper.getList2().forEach(question -> log.info(question));
	}
	
	@Test
	public void testInsert2() {
		QuestionVO question = new QuestionVO();
		question.setQuestiontitle("새로 작성하는 글");
		question.setQuestion("새로 작성하는 글");
		mapper.insert2(question);
		log.info(question);
	}
	
	@Test
	public void testInsertSelectKey2() {
		QuestionVO question = new QuestionVO();
		question.setQuestiontitle("새로 작성하는 글 selectkey");
		question.setQuestion("새로 작성하는 글 selectkey");
		mapper.insertSelectKey2(question);
		log.info(question);
	}
	
	@Test
	public void testread2() {
		//존재하는 게시물 번호로 테스트
		QuestionVO question = mapper.read2(45);
		log.info(question);
	}
	
	@Test
	public void testDelete2() {
		log.info("DELETE COUNT: "+mapper.delete2(45));
	}
	
	@Test
	public void testUpdate2() {
		QuestionVO question = new QuestionVO();
		//실행 전 존재하는 번호인지 확인할 것
		question.setQuestionnum(64);
		question.setQuestiontitle("수정된 제목");
		question.setQuestion("수정된 내용");
		int count2 = mapper.update2(question);
		log.info("UPDATE COUNT: "+question);
	}

}




























