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
@RequestMapping("/admin*")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Inject
	MemberService service;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/adminPage", method = RequestMethod.GET)
	public String adminPage() {

		return "adminPage";
	}

	
	

}
