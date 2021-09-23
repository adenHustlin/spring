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
@RequestMapping("/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	//memberpage move
		@RequestMapping(value = "/memberPage", method = RequestMethod.GET)
		public String memberPage() {

			return "/member/memberPage";
		}

 

	
}
