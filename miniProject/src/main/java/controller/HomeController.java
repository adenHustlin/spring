package controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Inject
	MemberService service;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {

		return "index";
	}

	@RequestMapping("/memberRegister")
	public String toRegisterPage() {
		return "/member/memberRegister";
	}

//로그인페이지이동 겟방식임
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPage() {

		return "/member/loginPage";
	}

	// 로그인 처리하는 부분
//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public void loginPost(HttpSession session, LoginDTO dto, HttpServletRequest request, Model model,
//			HttpServletResponse response) throws Exception {
//
//		MemberVo vo = service.login(dto);
//
//		if (vo == null) {// 로그인 오류
//			return;
//		}
//		session.setAttribute("loginMember", vo);
//
//	}

	@RequestMapping("/accessDeniedPage")
	public String accessDeniedPage() {
		return "accessDeniedPage";
	}

}
