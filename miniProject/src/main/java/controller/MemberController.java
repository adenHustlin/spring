package controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import domain.LoginDTO;
import domain.MemberVo;
import service.member.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	//memberpage move
		@RequestMapping(value = "/memberPage", method = RequestMethod.GET)
		public String memberPage() {

			return "/member/memberPage";
		}

	

//로그인페이지이동 겟방식임
//	@RequestMapping(value = "/login", method = RequestMethod.GET)
//	public String loginPage(Authentication authentication) {
//		if(authentication!=null) {
//			return "/";
//		}
//		return "/member/loginPage";
//	}

	// 로그인 처리하는 부분
	

	
}
