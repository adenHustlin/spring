/**
 * 
 */
package interceptor;

import java.sql.Timestamp;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import domain.LoginDTO;
import domain.MemberVo;
import service.member.MemberService;

/**
 * @author baekd
 * @packageName: interceptor
 * @fileName: LoginInterceptor.java
 * @date: 2021. 9. 9.
 * description:
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Inject
	private MemberService service;
	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	System.out.println("login interceptor");
        HttpSession session = request.getSession();
       
        if ( session.getAttribute("loginMember") != null ){
            // 기존에 login이란 세션 값이 존재한다면
            session.removeAttribute("loginMember"); // 기존값을 제거해 준다.
        }
       
        
      
        return true;
    }
  
    // 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
    @Override 
    
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
    	
    	HttpSession session=request.getSession();
//   
//    	ModelMap modelMap=modelAndView.getModelMap();//problem
//    	
//    	System.out.println(modelMap.get("loginMember"));
//    	MemberVo vo=(MemberVo)modelMap.get("loginMember");
//    	
    	MemberVo vo=(MemberVo) session.getAttribute("loginMember");
    	
    	System.out.println("asd");
    	
//    		System.out.println("new login");
//    		session.setAttribute("loginMember", vo);
//    		
            if(request.getParameter("useCookie")!=null) {
            	System.out.println("remember me");
            	//create cookie
            	Cookie loginCookie= new Cookie("loginCookie", session.getId());
            	loginCookie.setPath("/");
            	loginCookie.setMaxAge(60*60*24);
            	service.keepLogin(new LoginDTO(vo.getUserid(), null, false, loginCookie.getValue(), new Timestamp(System.currentTimeMillis() + 60 * 60 * 24 * 1000)));
            	response.addCookie(loginCookie);
            
            Object desObject=session.getAttribute("destination");
            response.sendRedirect(desObject!=null?(String)desObject:"/");
			}
            Object desObject=session.getAttribute("destination");
            response.sendRedirect(desObject!=null?(String)desObject:"/");
    }
           
 
        

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
	

}
