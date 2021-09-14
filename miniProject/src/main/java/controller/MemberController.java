
package controller;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import domain.LoginDTO;
import domain.MemberVo;
import service.member.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Inject
	private MemberService service;


	@RequestMapping(value = "/memberPage", method = RequestMethod.GET)
	public String memberPage() {

		return "memberPage";
	}

	// 로그아웃 하는 부분
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response, LoginDTO dto)
			throws Exception {

		MemberVo vo = (MemberVo) session.getAttribute("loginMember");

		session.removeAttribute("loginMember");
		session.invalidate(); // 세션 초기화
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		dto.setUserid(vo.getUserid());
		if (loginCookie != null) {
			loginCookie.setMaxAge(0);
			loginCookie.setPath("/");
			response.addCookie(loginCookie);
			service.keepLogin(dto);
		}

		return "index"; // 로그아웃 후 로그인화면으로 이동
	}

	@RequestMapping(value = "/memberRegister", method = RequestMethod.POST)
	public String registerMember(HttpSession session, MemberVo vo, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		if (service.memberRegister(vo) == 1) {
			model.addAttribute("userid", vo.getUserid());
			session.setAttribute("loginMember", vo);
		}
		return "/welcomePage";
	}

	@ResponseBody // @RestController = @Controller + @ResponseBody 여기선 유저아이디만 받아오고 중복되는지 여부만
					// 돌려주면되니까
	@RequestMapping(value = "/useridConfirm/{userid}", method = RequestMethod.GET)
	public String useridConfirm(HttpSession session, MemberVo vo, HttpServletRequest request, Model model,
			@PathVariable String userid) throws Exception {
		System.out.println("register" + userid);

		if (service.useridConfirm(userid) == null) {// 아이디 중복 안됨
			return "does not exist";
		} else {
			return "exists";
		}

	}
}
