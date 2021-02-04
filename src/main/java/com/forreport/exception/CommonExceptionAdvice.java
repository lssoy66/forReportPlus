package com.forreport.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

//@ControllerAdvice : 공통적용, AOP
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

	// 일반적인 예외 처리
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		log.error("Exception......" + ex.getMessage());
		model.addAttribute("exception", ex);
		log.error(model);
		return "error_page";
	}

	// 404 에러 페이지 처리
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handler404(NoHandlerFoundException ex) {
		return "custom404";
	}

}