package com.forreport.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.forreport.domain.SearchingVO;
import com.forreport.domain.UserVO;

public interface UserService {

	// 회원 가입
	public void joinProcess(UserVO vo) throws Exception;

	// 회원 목록 가져오기
//	public List<UserVO> getUserList(String id);

	// 페이징 처리 된 전체 회원 목록
	public List<UserVO> getUserListWithPaging(SearchingVO searchingVO);
	
	// 화면 페이지 처리를 위한 정보 전달
	public int getTotalCount(SearchingVO searchingVO);
	
	// 이메일 중복 확인
	public int emailCheck(String email) throws Exception;
	
	// 아이디 중복 확인
	public int idCheck(String id) throws Exception;

	// 아이디 찾기
	public String findId(HttpServletResponse response, String email) throws Exception;
	
	//비밀번호찾기
//	public void infoCheck(HttpServletResponse response, UserVO vo) throws Exception;
	
	// 비밀번호 찾기- 이메일 일치 여부 확인
	public String infoCheck(String id) throws Exception;


	// 비밀번호 변경
	public void updatePw(UserVO vo) throws Exception;
	
	// 회원 정보 변경
	public void updateInfo(UserVO vo) throws Exception;


	// 회원탈퇴
	public void withdrawal(String id) throws Exception;
}
