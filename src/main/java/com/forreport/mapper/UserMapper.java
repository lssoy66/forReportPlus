package com.forreport.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forreport.domain.SearchingVO;
import com.forreport.domain.UserVO;

public interface UserMapper {
	
	// 회원 가입
	public void joinProcess(UserVO vo) throws Exception;

	// 회원 목록
//	public List<UserVO> getUserList(String id);

	// 페이징 처리 된 전체 회원 목록
	public List<UserVO> getUserListWithPaging(SearchingVO searchingVO);
	
	// 화면 페이지 처리를 위한 정보 전달
	public int getTotalCount(SearchingVO searchingVO);

	// 이메일 중복 확인
	public int emailCheck(String email) throws Exception;

	// 아이디 중복 확인
	public int idCheck(String id);
	
	public UserVO read(String id);
	
	// 아이디 찾기
	public String findId(String email) throws Exception;
	
	// 비밀번호 찾기 - 이메일 일치 여부 확인
	public String infoCheck(String id);
	
	// 비밀번호 변경
	public void updatePw(UserVO vo) throws Exception;
	
	// 회원정보 변경
	public void updateInfo(UserVO vo) throws Exception;
	

	// 회원탈퇴
	public void withdrawal(@Param("id") String id) throws Exception;

  
	// 은지 - 등급 업데이트
	public int updateGrade(@Param("id") String id, @Param("grade")int grade);

	/* 은지  - view - 작성자 등급 보여주기*/
	public int getGrade(String id);

}
