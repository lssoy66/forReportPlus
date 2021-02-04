package com.forreport.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class QuestionControllerTests {
	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@Before
	public void setup2() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList2() throws Exception {
		log.info(
		mockMvc.perform(MockMvcRequestBuilders.get("/question/list"))
		.andReturn()
		.getModelAndView()
		.getModelMap());
	}
	
	@Test
	public void testRegister2() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/question/register")
				.param("questiontitle", "테스트 새글 제목")
				.param("question", "테스트 새글 내용")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	@Test
	public void testGet1() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/question/get")
				.param("questionnum", "26"))
				.andReturn()
				.getModelAndView().getModelMap());
	}
	
	@Test
	public void testModify2() throws Exception {
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/question/modify")
						.param("questionnum", "103")
						.param("questiontitle", "수정된 테스트 새글 제목")
						.param("question", "수정된 테스트 새글 내용"))
						.andReturn().getModelAndView().getViewName();
		                log.info(resultPage);
	}
	
	@Test
	public void testRemove2() throws Exception {
		//삭제 전 데이터베이스에 게시물 번호 확인할 것
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/question/remove")
				.param("questionnum", "41")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}

}































