package com.forreport.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.forreport.domain.UserVO;
import com.forreport.mapper.UserMapper;
import com.forreport.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Setter(onMethod_ = {@Autowired})
	private UserMapper userMapper;
	
	
	@Override
	public UserDetails loadUserByUsername(String name) throws UsernameNotFoundException {
		UserVO vo = userMapper.read(name);
		
	    log.warn("queried by user mapper : "+ vo);
		
	    return vo == null ? null : new CustomUser(vo);
	}

}
