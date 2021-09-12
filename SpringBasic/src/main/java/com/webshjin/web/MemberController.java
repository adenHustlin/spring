package com.webshjin.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webshjin.domain.Member;
import com.webshjin.service.MemberService;

@Controller
public class MemberController {
	
	@Inject
	private MemberService service;  // 서비스 객체 주입
	
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping("/registerMember")
	public void memberController() {
		// registerMember.jsp 호출
	}
	
	@RequestMapping(value="/registerMember.do", method=RequestMethod.POST)
	public String registerMember(Member member, RedirectAttributes rttr) {
		// registerMeber.jsp 에서 유저가 입력한 데이터를 스프링 컨테이너가 com.webshjin.dto.Member의 setter 자동 호출하여 
	    // Member 객체를 만들어서 이 메서드 호출
		logger.info(member.toString());
		
		// service단을 거쳐 dao거쳐 ~
		if(service.addMember(member)) {
			rttr.addFlashAttribute("status", "success");
		} else {
			rttr.addFlashAttribute("status", "fail");
		}
		
		// addFlashAttribute() : attribute에 바인딩(임시적(Flash)으로 데이터를 바인딩)
//		rttr.addFlashAttribute("userid", member.getUserid());
//		rttr.addFlashAttribute("pwd", member.getPassword());
//		rttr.addFlashAttribute("name", member.getName());
//		rttr.addFlashAttribute("age", member.getAge());
//		rttr.addFlashAttribute("memberInfo", member);
		
		// addAttribute() : parameter에 데이터를 바인딩. jsp에서 param.~ 출력 
		
		return "redirect:showMember";  // showMember.jsp 페이지로 redirect
	}
	
	@RequestMapping("/showMember")
	public void showMember() {
		// showMember.jsp 호출
	}
	
	@RequestMapping("/memberInfo")
	public String memberInfo(Model model) {
		Member m = new Member("bbb", "2222", "도우너", "bbb@bbb.com", "", null, null);
		
		logger.info(m.toString());
		
		model.addAttribute("memberInfo", m);
		
		return "showMember";  // showMember.jsp 이동 (포워딩)
	}
	
	@RequestMapping("/curTime.do") 
	public void curTime(Model model) {
		String now = service.selectCurTime();
		
		model.addAttribute("now", now);
		
	}
}
