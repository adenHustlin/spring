/**
 * 
 */
package com.gootdate.security.service.lhw;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.jasper.tagplugins.jstl.core.If;
import org.apache.velocity.runtime.parser.node.ASTElseIfStatement;
import org.eclipse.jdt.internal.compiler.ast.ReturnStatement;
import org.springframework.dao.DeadlockLoserDataAccessException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gootdate.domain.MemberVo;

/**
 * @author baekd
 * @packageName: service.security
 * @fileName: LoginFailureHandler.java
 * @date: 2021. 9. 16. description:
 */
public class LoginFailureHandler implements AuthenticationFailureHandler {
	@Inject
	SecurityService securityService;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		System.out.println("login Failure");
		System.out.println(exception.getMessage());
		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		String errormsg = null;
		Map<String,String> STNK=new HashMap<String,String>();
		STNK.put("searchType","userid");
		STNK.put("keyword", userid);
		if (securityService.getMemberVo(STNK) != null) {// 계정있음 진짜 이클립스 개빡치게하네
			MemberVo vo = securityService.getMemberVo(STNK);
			System.out.println(vo.toString());
			System.out.println(vo.getEmailConfirm().compareTo("N"));
			if (vo.getEmailConfirm().compareTo("N") == 0) {// 이거에 3시간낭비함 개빡친다
				errormsg = "Please confirm your email '" + vo.getEmail() + "'";
			} else {
				if (securityService.checkFailureCount(userid) == 5) {
					securityService.disableMember(userid);
					errormsg = "Disabled Account, please reset your password";
				} else {
					securityService.UpdateFailureCnt(userid);
					int cnt = securityService.checkFailureCount(userid);
					int remainingLife = 5 - cnt;

					errormsg = remainingLife + " login trials left";
				}
			}
		} else {// 계정없음
			errormsg = "User  '" + userid + "' does not exist ";
		}

		request.setAttribute("userid", userid);
		request.setAttribute("password", password);
		request.setAttribute("ERRORMSG", errormsg);

		request.getRequestDispatcher("../security/loginPage").forward(request, response);

	}

}
