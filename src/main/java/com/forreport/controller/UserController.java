package com.forreport.controller;



import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forreport.domain.UserVO;
import com.forreport.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	BCryptPasswordEncoder pwEncoder;


	// 이용 약관 페이지 이동
	@RequestMapping("/provision.fr")
	public void provision() throws Exception {
		log.info("provision");
	}
	
	
	// 이메일 인증 페이지 이동
	@RequestMapping("/certification.fr")
	public void certification() throws Exception {
		log.info("certification");
	}

	// 이메일 중복 체크
	@PostMapping("/emailCheck.fr")
	@ResponseBody
	public String emailCheck(String email) throws Exception {

		int result = userService.emailCheck(email);

		if (result != 0) {
			return "fail"; // 중복아이디 존재
		} else {
			return "success";
		}
	}


	// 본인 인증 (메일 발송) 
	@GetMapping("/certificationProcess.fr")
	@ResponseBody
	public String certificationProcess(String email) throws Exception {
		
		log.info("이메일 = "+email);

		// 이메일로 받는 인증코드 부분 (난수)
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;

		log.info("인증번호 = " + checkNum);

		// 이메일 발송
		String setFrom = "forreport0202@gmail.com";
		String toMail = email;
		String title = "[For Report] 회원가입 인증 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + " 입니다." + "<br><br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

			helper.setFrom(setFrom); // 보내는사람 생략하면 정상작동을 안함
			helper.setTo(toMail); // 받는사람 이메일
			helper.setSubject(title); // 메일제목은 생략 가능
			helper.setText(content); // 메일 내용

			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		String num = Integer.toString(checkNum);

		return num;

	}


	// 아이디 중복 확인
	@ResponseBody
	@PostMapping("/idCheck.fr")
	public String idCheck(String id) throws Exception {
		int result = userService.idCheck(id);

		if (result != 0) {
			return "fail"; // 중복아이디 존재
		} else {
			return "success";
		}
	}
	
	// 회원가입 페이지 이동
	@RequestMapping("/join.fr")
	public void join() throws Exception{
		log.info("join");
	}

	// 회원 가입 처리 후, 메인페이지 이동
	@RequestMapping("/joinProcess.fr")
	public String joinProcess(UserVO vo) throws Exception {
		log.info("join");
		
		
		// 비밀번호 암호화
		String inputPw = vo.getPassword();
		String pw = pwEncoder.encode(inputPw);
		vo.setPassword(pw);
		
		userService.joinProcess(vo);

		return "redirect:/";
	}
	
	// 아이디 찾기 페이지 이동
	@RequestMapping("/findId.fr")
	public void findId() throws Exception{
		log.info("findId");
	}
	
	// 아이디 찾기
	@PostMapping("/findIdProcess.fr")
	public String find_id(HttpServletResponse response, @RequestParam("email") String email, Model md) throws Exception{
		md.addAttribute("id", userService.findId(response, email));
		return "/user/findIdResult";
	}

	
	// 아이디 찾기 결과 페이지 이동
	@RequestMapping("/findIdResult.fr")
	public void findIdResult() throws Exception{
		log.info("findIdResult");
	}
	
	// 비밀번호 찾기 페이지 이동
	@RequestMapping("/findPw.fr")
	public void findPw() throws Exception{
		log.info("findPw");
	}
	
	// 비밀번호 찾기 - 이메일 일치 여부 확인
	@RequestMapping("/infoCheck.fr")
	@ResponseBody
	public String infoCheck(String id) throws Exception{
		
		String infoResult = userService.infoCheck(id);

		log.info("infoResult controller");
		if (infoResult != "") {
			log.info("infoResult" + infoResult);
			return infoResult; // 아이디 존재
		} else {
			return null;
		}
	}
	
	
	// 비밀번호 찾기 (메일 발송) 
	@RequestMapping("/findPwProcess.fr")
	public String fincPwProcess(String email, UserVO vo) throws Exception {
		
		log.info("이메일 = "+email);

		// 이메일로 받는 임시 비밀번호 부분 (난수)
		Random r = new Random();
		int num = r.nextInt(888888) + 111111;
		
		String newPw = Integer.toString(num);

		log.info("임시 비밀번호 = " + newPw);
		
		// 임시 비밀번호 암호화 + 저장
		String pw = pwEncoder.encode(newPw);
		vo.setPassword(pw);
		
		userService.updatePw(vo);

		// 이메일 발송
		String setFrom = "forreport0202@gmail.com";
		String toMail = email;
		String title = "[For Report] 임시 비밀번호 안내 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "임시 비밀번호는 " + newPw + " 입니다." + "<br><br>"
				+ "해당 임시 비밀번호로 로그인 후, 비밀번호를 변경해 주세요.";

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

			helper.setFrom(setFrom); // 보내는사람 생략하면 정상작동을 안함
			helper.setTo(toMail); // 받는사람 이메일
			helper.setSubject(title); // 메일제목은 생략 가능
			helper.setText(content); // 메일 내용

			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/";

	}
	
	// 마이페이지 이동
	@RequestMapping("/mypage.fr")
	public void mypage() throws Exception{
		log.info("mypage");
	}

	// 비밀번호 변경
	@RequestMapping("/updatePw.fr")
	public String updatePw(HttpSession session, UserVO vo) throws Exception{
		log.info("updatePw");
		
		// 비밀번호 암호화
		String inputPw = vo.getPassword();
		String pw = pwEncoder.encode(inputPw);
		vo.setPassword(pw);
		
		userService.updatePw(vo);
		
		session.invalidate();
		
		return "redirect:/login/customLogin.fr";
		
	}
	
	// 회원정보 변경
	@RequestMapping("/updateInfo.fr")
	public String updateInfo(HttpSession session, UserVO vo) throws Exception{
		log.info("updateInfo");
		
		userService.updateInfo(vo);
		
		return "redirect:/user/mypage.fr";
	}
	

	// 회원탈퇴 -> 수정 전
//	@RequestMapping("/withdrawal.fr")
//	public String withdrawal(@RequestParam(value="password") String pw, HttpSession session, UserVO vo) throws Exception{
//		log.info("withdrawal");
//		
//		
//		String newPw = vo.getPassword();
//		
//		log.info("pw" + pw);
//		log.info("newpw" + newPw);
//		
//		boolean pwCheck = pwEncoder.matches(pw, newPw);
//		
//		if(!pw.equals(newPw)) {
//			
//			return "redirect:/user/mypage.fr";
//		}
//		
//		userService.withdrawal(vo);
//		session.invalidate();
//		
//		return "redirect:/";
//	}
	
	// 회원탈퇴 -> 수정 후
	@RequestMapping("/withdrawal.fr")
	public String withdrawal(@RequestParam(value="inputPassword") String pw, HttpSession session, UserVO vo) throws Exception{
		
		log.info("withdrawal");		
		
		String newPw = vo.getPassword();
		
		log.info("pw" + pw);
		log.info("newpw" + newPw);
		
		boolean pwCheck = pwEncoder.matches(pw, newPw);
		
		log.info("비번 일치 여부: " + pwCheck);
		
		// vo에서 id만 넘기는거로 바꾸기
		if(pwCheck) {
			
			userService.withdrawal(vo.getId());
			session.invalidate();
			
			return "redirect:/";
		}
		
		return "redirect:/user/mypage.fr";
		
	}

}
