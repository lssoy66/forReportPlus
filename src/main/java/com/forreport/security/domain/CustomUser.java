package com.forreport.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.forreport.domain.UserVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;
// (668) MemberVO를 UserDetails 변환
	
	private UserVO user;
	public CustomUser(String name, String password, Collection<? extends GrantedAuthority> authorities) {
		super(name, password, authorities);
	}
	
	public CustomUser(UserVO vo) {
		super(vo.getId(), vo.getPassword(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		
		this.user = vo;
	}
}

