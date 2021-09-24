/**
 * 
 */
package com.gootdate.security.service.lhw;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.gootdate.cs.controller.lhw.CsController;
import com.gootdate.domain.MemberDetailsDto;

@Service("authenticationProvider")
public class AuthenticationProvider implements org.springframework.security.authentication.AuthenticationProvider {
	@Autowired
	private UserDetailsService securityService;
	private static Logger logger = LoggerFactory.getLogger(AuthenticationProvider.class);
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// 로그인 페이지에서 입력한정보를 athentication이 담고있음 loginDto랑 같은역할인듯
		String userid = (String) authentication.getPrincipal();
		String password = (String) authentication.getCredentials();
		MemberDetailsDto member = (MemberDetailsDto) securityService.loadUserByUsername(userid);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if (member == null) {
			throw new InternalAuthenticationServiceException(userid);
		}
		if (!encoder.matches(password, member.getPassword())) {
			throw new BadCredentialsException(userid);

		}
		if(member.getEmailconfirm().compareTo("N") == 0) {
			throw new AuthenticationCredentialsNotFoundException(userid);
			
		}
		if (!member.isEnabled() || !member.isCredentialsNonExpired()) {
			throw new AuthenticationCredentialsNotFoundException(userid);
		}
	
		return new UsernamePasswordAuthenticationToken(userid, password, member.getAuthorities());

	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return false;
	}

}
