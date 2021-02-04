package com.forreport.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/")
@AllArgsConstructor
public class MainController {

	// http://localhost/forreport.fr :: 메인 페이지로 이동
	@RequestMapping("forreport.fr")
	public String mainPage() {
		return "main";
	}

	// http://localhost/forreportAdmin.fr :: 관리자 전용 메인 페이지로 이동
	@RequestMapping("forreportAdmin.fr")
	public String mainPageAdmin() {
		return "mainAdmin";
	}

}
