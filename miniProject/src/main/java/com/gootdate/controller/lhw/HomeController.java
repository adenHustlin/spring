package com.gootdate.controller.lhw;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {

		return "index";
	}

	@RequestMapping("/accessDeniedPage")
	public String accessDeniedPage() {
		return "accessDeniedPage";
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
	@RequestMapping("/welcomePage")
	public String welcomeString() {
		return "welcomePage";
	}
	@RequestMapping("/contact")
	public String conatct() {
		return "contact";
	}

	
}
