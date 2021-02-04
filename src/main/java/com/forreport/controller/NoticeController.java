package com.forreport.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.forreport.domain.NoticeVO;
import com.forreport.domain.PageDTO;
import com.forreport.domain.ReviewCriteria;
import com.forreport.service.NoticeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {
	
	private NoticeService service1;
	
	@GetMapping("list.fr")
	public void list(ReviewCriteria criteria, Model model) {
		log.info("list");
		model.addAttribute("list", service1.getNoticeListAllWithPaging(criteria));
		
		// 화면 페이지 처리를 위한 정보 전달
		model.addAttribute("pageMaker", new PageDTO(criteria, service1.getTotalCount(criteria)));
		log.info(new PageDTO(criteria, service1.getTotalCount(criteria)));
	}
	
	@GetMapping("/view.fr")
	public void view(Model model, int noticenum) {

		log.info("view");
		model.addAttribute("NoticeVO", service1.get1(noticenum));
		
	}
	
	@PostMapping("/register")
	public String register(NoticeVO notice, RedirectAttributes rttr) {
		log.info("register: "+notice);
		service1.register1(notice);
		rttr.addFlashAttribute("result", notice.getNoticenum());
		return "redirect:/notice/list.fr";
		
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("noticenum") int noticenum, Model model) {
		log.info("/get");
		model.addAttribute("notice", service1.get1(noticenum));
	}
	
	@PostMapping("/modify")
	public String modify(NoticeVO notice, RedirectAttributes rttr) {
		log.info("modify:"+notice);
		if(service1.modify1(notice)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirct:/notice/list.fr";
		
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("noticenum") int noticenum, RedirectAttributes rttr) {
		log.info("remove....."+noticenum);
		if(service1.remove1(noticenum)) {
			rttr.addFlashAttribute("result", "success");			
		}
		return "redirect:/notice/list.fr";		
	}

}




























