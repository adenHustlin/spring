
package controller;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;

import domain.LoginDTO;
import domain.MemberVo;
import service.member.MemberService;


@Controller
@RequestMapping("/member")
public class MemberController {
	@Inject
	private MemberService service;
	 // 로그인 폼을 띄우는 부분
    @RequestMapping(value="/login",method=RequestMethod.GET)
    public String loginForm(){
    	
        return "/member/login";
    }
      
    // 로그인 처리하는 부분
    @RequestMapping(value="/loginPost",method=RequestMethod.POST)
    public void loginCheck(HttpSession session,LoginDTO dto,HttpServletRequest request,Model model,HttpServletResponse response) throws Exception{
    
     
        	MemberVo vo =service.login(dto);
          System.out.println(vo.toString());
        if(vo==null) {//로그인 오류
        	
        	return; 
        	
        }
        session.setAttribute("loginMember",vo);
		
        
    }
  
    // 로그아웃 하는 부분
    @RequestMapping(value="/logout")
    public String logout(HttpSession session,HttpServletRequest request,HttpServletResponse response,LoginDTO dto) throws Exception {
    	
    	MemberVo vo=(MemberVo)session.getAttribute("loginMember");
    	
    	session.removeAttribute("loginMember");
        session.invalidate(); // 세션 초기화
        Cookie loginCookie=WebUtils.getCookie(request, "loginCookie");
       dto.setUserid(vo.getUserid());
        if(loginCookie!=null) {
        	loginCookie.setMaxAge(0);
        	loginCookie.setPath("/");
        	response.addCookie(loginCookie);
        	service.keepLogin(dto);
        }
    	
        return "index"; // 로그아웃 후 로그인화면으로 이동
    }
}
