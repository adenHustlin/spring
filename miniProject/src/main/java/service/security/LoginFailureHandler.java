/**
 * 
 */
package service.security;

import java.io.IOException;
import java.util.Enumeration;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.jdt.internal.compiler.ast.ReturnStatement;
import org.springframework.dao.DeadlockLoserDataAccessException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.web.bind.annotation.RequestMapping;

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

		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		String errormsg = null;
		if (securityService.UpdateFailureCnt(userid) == 1) {// 로그인 실패횟수 증가
			System.out.println("로그인실패횟수늘림");
			int cnt = securityService.checkFailureCount(userid);// 로그인 실패횟수 조회
			if (exception instanceof BadCredentialsException) {
				int remainingLife = 5 - cnt;
				if (cnt == 5) {
					securityService.disableMember(userid);// 로그인실패 5개시 계정잠금
					errormsg = "계정 잠김 ";
				}
				errormsg = "" + remainingLife + "trials left";
			} else if (exception instanceof DisabledException) {
				errormsg = "계정 잠김 ";
			} else if (exception instanceof CredentialsExpiredException) {
				errormsg = "비밀번호 만료됨";
			}
		} else {
			errormsg = "없는 아이디임";
		}

		request.setAttribute("userid", userid);
		request.setAttribute("password", password);
		request.setAttribute("ERRORMSG", errormsg);

		request.getRequestDispatcher("../security/loginPage").forward(request, response);

	}
//
//	private int loginFailureCount(String userid) {
//		securityService.UpdateFailureCnt(userid);
//		int cnt = securityService.checkFailureCount(userid);
//		if (cnt == 5) {
//			securityService.disableMember(userid);
//		}
//		return cnt;
//
//	}

}
