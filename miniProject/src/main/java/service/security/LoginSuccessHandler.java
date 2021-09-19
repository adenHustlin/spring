/**
 * 
 */
package service.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import domain.MemberDetailsDto;
import domain.MemberVo;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();


	@Inject
	private SecurityService service;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		System.out.println("loginsucessprocess");
		System.out.println(authentication.getName());
		String userid = authentication.getName();
		clearAuthenticationAttributes(request, userid);
		resultRedirectStrategy(request, response, authentication, userid);
		
	}

	private void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication, String userid) throws IOException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		service.resetFailureCnt(userid);// 로그인실패횟수 초기화
		if (savedRequest != null) {
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStratgy.sendRedirect(request, response, targetUrl);
		} else {
			redirectStratgy.sendRedirect(request, response, "/");
		}

	}

	protected void clearAuthenticationAttributes(HttpServletRequest request, String userid) {
		HttpSession session = request.getSession();
		MemberVo vo = service.getMemberVoForSession(userid);// 세션에넣을 멤버정보 받아오기
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		session.setAttribute("loginMember", vo);
	}

}
