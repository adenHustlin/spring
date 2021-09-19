
package controller;

import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.filechooser.FileSystemView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import domain.LoginDTO;
import domain.MemberDetailsDto;
import domain.MemberVo;
import domain.SocialRegisterVo;
import persistence.member.MemberDao;
import service.member.MemberService;
import service.security.SecurityService;

@Controller
@RequestMapping("/security")
public class SecurityController {
	@Inject
	SecurityService service;
	
	// 회원가입 로그인 로그아웃 아이디중복확인
	//loginPage move
	@RequestMapping(value = "/loginPage", method = {RequestMethod.GET, RequestMethod.POST})
	
	public String loginPage() {
		
		return "/member/loginPage";
	}
	
	//memberRegister move
	@RequestMapping("/memberRegisterPage")
	public String toRegisterPage() {
		
		return "/member/memberRegisterPage";
	}
//	@RequestMapping("/SocialMemberRegisterPage")
//	public String socialRegister() {
//		
//		return "/member/SocialMemberRegisterPage";
//	}
	@RequestMapping("/emailConfirm")
	public String emailConfirm() {
		
		return "/member/SocialMemberRegisterPage";
	}
@RequestMapping(value = "/loginPageCallBack", method = {RequestMethod.GET, RequestMethod.POST})
	
	public String loginPageCallBack() {
		
		return "/member/loginPageCallBack";
	}
//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public void loginPost(HttpSession session, LoginDTO dto, HttpServletRequest request) throws Exception {
//		System.out.println("login Process");
//		MemberDetailsDto memberDetailsDto = dao.login(dto.getUserid());
//		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
//		if (encoder.matches(dto.getPassword(), memberDetailsDto.getPassword())) {
//			session.setAttribute("loginMember", memberDetailsDto);
//			return true;
//		} else {
//			return false;
//		}
//		MemberDetailsDto dto = service.login(dto);
//
//		if (dto == null) {// 로그인 오류
//			return;
//		}
//		session.setAttribute("loginMember", vo);

//	}

	// 로그아웃 하는 부분
//	@RequestMapping(value = "/logout")
//	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response, LoginDTO dto)
//			throws Exception {
//
//		MemberVo vo = (MemberVo) session.getAttribute("loginMember");
//
//		session.removeAttribute("loginMember");
//		session.invalidate(); // 세션 초기화
//		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
//		dto.setUserid(vo.getUserid());
//		if (loginCookie != null) {
//			loginCookie.setMaxAge(0);
//			loginCookie.setPath("/");
//			response.addCookie(loginCookie);
//			service.keepLogin(dto);
//		}
//
//		return "index"; // 로그아웃 후 로그인화면으로 이동
//	}
	//ajax로 객체를 받아와서 페이지까지넘겨야하기때문에 방법 생각
	@RequestMapping(value = "/SocialMemberRegister", method = RequestMethod.POST)	
	public void SocialregisterMember(HttpSession session,@RequestBody SocialRegisterVo vo, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		System.out.println("Social register process");
		System.out.println(vo.toString());		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encPassword = encoder.encode(vo.getPassword());
		vo.setPassword("{bcrypt}"+encPassword);
		if (service.SocialMemberRegister(vo) == 1) {
			model.addAttribute("userid",vo.getUserid());
			session.setAttribute("loginMember", vo);
		}
	
	}

	@RequestMapping(value = "/memberRegister", method = RequestMethod.POST)	
	public String registerMember(HttpSession session, MemberVo vo, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		System.out.println("register process");
		System.out.println(vo.toString());		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encPassword = encoder.encode(vo.getPassword());
		vo.setPassword("{bcrypt}"+encPassword);
		if (service.memberRegister(vo) == 1) {
			model.addAttribute("userid",vo.getUserid());
			session.setAttribute("loginMember", vo);
		}
		return "welcomePage";
	}

	@ResponseBody // @RestController = @Controller + @ResponseBody 여기선 유저아이디만 받아오고 중복되는지 여부만
					// 돌려주면되니까
	@RequestMapping(value = "/useridConfirm/{userid}", method = RequestMethod.GET)
	public String useridConfirm(HttpServletRequest request, @PathVariable String userid) throws Exception {

		if (service.useridConfirm(userid) == null) {// 아이디 중복 안됨
			return "does not exist";
		} else {
			return "exists";
		}

	}
}
