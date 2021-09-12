/**
 * 
 */
package interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import domain.MemberVo;
import service.member.MemberService;


/**
 * @author baekd
 * @packageName: interceptor
 * @fileName: TestInterceptor.java
 * @date: 2021. 9. 8.
 * description:
 */
public class KeepLoginInterceptor extends HandlerInterceptorAdapter {

	@Inject
	private MemberService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("keeplogin interceptor");
		
	HttpSession ses=request.getSession();
	Cookie loginCookie=WebUtils.getCookie(request, "loginCookie");
	if(loginCookie!=null) {
		System.out.println("cookie exists");
		MemberVo vo=service.checkLoginBefore(loginCookie.getValue());
		
		if(vo!=null) {
			ses.setAttribute("loginMember", vo);
		}
	}else {
		System.out.println("cookie does not exist");
	}
		
	
		
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		//interceptor실행후
		System.out.println("keeplogin end");
		
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	
}
