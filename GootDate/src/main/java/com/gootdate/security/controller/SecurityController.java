
package com.gootdate.security.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.gootdate.domain.MemberVo;
import com.gootdate.domain.SocialRegisterVo;
import com.gootdate.security.service.lhw.SecurityService;

@Controller
@RequestMapping("/security")
public class SecurityController {
	@Inject
	SecurityService service;

	@Value("${GoogleApiKey}")
	String GoogleApiKey;

	@Value("${GoogleClientId}")
	String GoogleClientId;

	@Value("${NaverClientId}")
	String NaverClientId;

	@Value("${KakaoClientId}")
	String KakaoClientId;

	@Value("${FaceBookClientId}")
	String FaceBookClientId;
	
	@Value("${NaverClientIdPrac}")
	String NaverClientIdPrac;
	@Value("${NaverClientIdAws}")
	String NaverClientIdAws;
	// 회원가입 로그인 로그아웃 아이디중복확인
	// loginPage move
	@RequestMapping(value = "/loginPage", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginPage(Model model) {
		model.addAttribute("GoogleApiKey", GoogleApiKey);
		model.addAttribute("GoogleClientId", GoogleClientId);
		model.addAttribute("NaverClientId", NaverClientId);
		model.addAttribute("KakaoClientId", KakaoClientId);
		model.addAttribute("FaceBookClientId", FaceBookClientId);
		model.addAttribute("NaverClientIdPrac", NaverClientIdPrac);
		model.addAttribute("NaverClientIdAws", NaverClientIdAws);
		return "/member/loginPage";
	}

	@RequestMapping(value = "/loginPageCallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginPageC(Model model) {
		model.addAttribute("GoogleApiKey", GoogleApiKey);
		model.addAttribute("GoogleClientId", GoogleClientId);
		model.addAttribute("NaverClientId", NaverClientId);
		model.addAttribute("KakaoClientId", KakaoClientId);
		model.addAttribute("FaceBookClientId", FaceBookClientId);
		model.addAttribute("NaverClientIdPrac", NaverClientIdPrac);
		model.addAttribute("NaverClientIdAws", NaverClientIdAws);
		return "/member/loginPageCallback";
	}

	// memberRegister move
	@RequestMapping("/memberRegisterPage")
	public String toRegisterPage() {

		return "/member/memberRegisterPage";
	}

	@RequestMapping("/SocialMemberRegisterPage")
	public String toSOcialRegisterPage(HttpServletRequest request, Model model) {
		model.addAttribute("userid", request.getParameter("userid"));
		model.addAttribute("name", request.getParameter("name"));
		return "/member/SocialMemberRegisterPage";
	}

	@RequestMapping(value = "/SocialMemberRegister", method = RequestMethod.POST)
	public String SocialregisterMember(@RequestBody SocialRegisterVo vo) throws Exception {
		System.out.println("Social register process");
		vo.setEmailConfirm("Y");
		vo.setEnabled(1);
		System.out.println(vo.toString());
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encPassword = encoder.encode(vo.getPassword());
		vo.setPassword("{bcrypt}" + encPassword);
		service.SocialMemberRegister(vo);

		return "welcomePage";
	}

	@RequestMapping(value = "/SocialMemberRegister1")
	public String SocialregisterMember1(@RequestParam String[] memberVo) throws Exception {
		System.out.println(memberVo.toString());

		return "welcomePage";
	}

	@RequestMapping(value = "/memberRegister", method = RequestMethod.POST)
	public String registerMember(HttpSession session, MemberVo vo, HttpServletRequest request, Model model)
			throws Exception {
		System.out.println("register process");
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encPassword = encoder.encode(vo.getPassword());
		vo.setPassword("{bcrypt}" + encPassword);
		vo.setEmailConfirm("N");
		System.out.println(vo.toString());
		if (service.memberRegister(vo) == 1) {
			model.addAttribute("name", vo.getName());
			model.addAttribute("message", "please confirm your email '" + vo.getEmail() + "' to enable your account");
		}
		service.sendMail(vo.getEmail(), "registrEmailConfirm");

		return "welcomePage";
	}

	@RequestMapping("/emailConfirm")
	public String RegisterEmailConfirm(@RequestParam String email, Model model) {

		if (service.confirmEmail(email) == 1) {
			model.addAttribute("email", email);
		}

		return "emailConfirmPage";
	}

//아이디중복
	@ResponseBody
	@RequestMapping(value = "/useridConfirm/{userid}", method = RequestMethod.GET)
	public String useridConfirm(HttpServletRequest request, @PathVariable String userid) throws Exception {

		if (service.useridExistance(userid) == null) {// 아이디 중복 안됨
			return "does not exist";
		} else {
			return "exists";
		}

	}

//회원가입 핸드폰인증
	@ResponseBody
	@RequestMapping(value = "/phoneConfirm", method = RequestMethod.POST)
	public String phoneConfirm(HttpServletRequest request) throws Exception {
		System.out.println("come on");
		System.out.println(request.getParameter("toNumber"));
		String toNumber = request.getParameter("toNumber");
		Random random = new Random();
		String randomNumber = "";
		for (int i = 0; i < 4; i++) {
			randomNumber += Integer.toString(random.nextInt(10));
		}

		service.sendMessage(toNumber, randomNumber);
		return randomNumber;

	}

	//
	@ResponseBody
	@RequestMapping(value = "/memberExistance", method = RequestMethod.GET)
	public String FindUseridAndPasswordUserExistance(HttpServletRequest request) throws Exception {// 여기는 이메일이 디비에
																									// 있는지만확인하는걸로 일단합시다
		Map<String, String> STNK = new HashMap<>();
		String keyword = request.getParameter("keyword");
		String searchType = request.getParameter("searchType");
		STNK.put("searchType", searchType);
		STNK.put("keyword", keyword);
		MemberVo vo = service.getMemberVo(STNK);
		if (vo == null) {

			return "does not exist";
		} else {
			return "exists";
		}

	}

	@ResponseBody
	@RequestMapping("/sendUseridToEmail/{email}")
	public String sendUseridToEmail(@PathVariable String email, Model model) throws MessagingException {

		service.sendMail(email, "sendUseridToEmail");

		return "success";
	}

	@ResponseBody
	@RequestMapping("/changePassword/")
	public String changePassword(HttpServletRequest request, Model model) throws MessagingException {
		String Npwd = request.getParameter("Npwd");
		String userid = request.getParameter("userid");

		if (service.changePassword(userid, Npwd) == 1) {
			return "success";
		} else {
			return "fail";
		}

	}

	@ResponseBody
	@RequestMapping(value = "/memberVoListExistance", method = RequestMethod.GET)
	public String phoneExistance(HttpServletRequest request) throws Exception {// 여기는 이메일이 디비에
																				// 있는지만확인하는걸로 일단합시다
		Map<String, String> STNK = new HashMap<>();
		String keyword = request.getParameter("keyword");
		String searchType = request.getParameter("searchType");
		STNK.put("searchType", searchType);
		STNK.put("keyword", keyword);
		System.out.println(service.MemberVoList(STNK));
		if (service.MemberVoList(STNK).size() >= 1) {
			return "exists";
		} else {
			return "does not exist";
		}
	}
}
