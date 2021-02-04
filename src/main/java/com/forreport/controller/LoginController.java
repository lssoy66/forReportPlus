package com.forreport.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LoginController {
	
	@GetMapping("/login/all.fr")
	public void doAll() {
		log.info("do all can access everybody");
	}
	
	@GetMapping("/login/member.fr")
	public void doMember() {
		log.info("logined member");
	}
	
	@GetMapping("/login/admin.fr")
	public void doAdmin() {
		  log.info("admin only");
	}
	
	
}
