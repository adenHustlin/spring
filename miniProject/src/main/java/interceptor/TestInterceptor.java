/**
 * 
 */
package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


/**
 * @author baekd
 * @packageName: interceptor
 * @fileName: TestInterceptor.java
 * @date: 2021. 9. 8.
 * description:
 */
public class TestInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//interceptor실행전 로그인이 되어있는지 안되어있는지 확인 
		//안되어있으면 로그인페이지로 이동
		//되어있으면 그대로 패스
		
	
		System.out.println("preHandle"+request.getContextPath());
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		//interceptor실행후
		System.out.println("postHandle");
		response.sendRedirect("/controller/fileUpload");
		System.out.println("postHandle end");
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	
}
