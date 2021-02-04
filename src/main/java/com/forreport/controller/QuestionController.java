package com.forreport.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.forreport.domain.PageDTO;
import com.forreport.domain.QuestionVO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.service.QuestionService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/question/*")
@AllArgsConstructor
public class QuestionController {
	
	private QuestionService service2;
	
	@GetMapping("/list.fr")
	public void list(ReviewCriteria criteria, Model model) {
		log.info("list");
		model.addAttribute("list", service2.getQuestionListAllWithPaging2(criteria));
		
		//화면 페이지 처리를 위한 정보 전달
		model.addAttribute("pageMaker", new PageDTO(criteria, service2.getTotalCount2(criteria)));
		log.info(new PageDTO(criteria, service2.getTotalCount2(criteria)));		
	}
	
	@GetMapping("/view.fr")
	public void view(Model model, int questionnum) {
		
		log.info("view");
		model.addAttribute("QuestionVO", service2.get2(questionnum));
		
	}
	
	@PostMapping
	public String register(QuestionVO question, RedirectAttributes rttr) {
		log.info("register: "+question);
		service2.register2(question);
		rttr.addFlashAttribute("result",question.getQuestionnum());
		return "redirect:/question/list.fr";
		
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("questionnum") int qeustionnum, Model model) {
		log.info("/get");
		model.addAttribute("question", service2.get2(qeustionnum));
	}
	
	@PostMapping("/modify")
	public String modify(QuestionVO question, RedirectAttributes rttr) {
		log.info("modify:"+question);
		if(service2.modify2(question)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirct:/question/list.fr";
		
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("questionnum") int questionnum, RedirectAttributes rttr) {
		log.info("remove....."+questionnum);
		if(service2.remove2(questionnum)) {
			rttr.addFlashAttribute("result", "success");			
		}
		return "redirect:/question/list.fr";		
	}

}































