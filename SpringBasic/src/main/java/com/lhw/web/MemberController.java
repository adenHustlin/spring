package com.lhw.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lhw.domain.Member;
import com.lhw.service.MemberService;

@Controller
public class MemberController {
	@Inject
	private MemberService service;
	private Logger logger=LoggerFactory.getLogger(ControllerExam.class);
@RequestMapping("/registerMember")
	public void memberController() {
	//jsp호출
}
	@RequestMapping(value="registerMember.do", method=RequestMethod.POST)
	public String RegisterMember(@ModelAttribute("myMem") Member member,RedirectAttributes rttr) throws Exception {
		//registerMember.jsp 에서 유저가 입력한 데이터를 스프링 컨테이너가 멤버의 세터 자동호출하여 멤버객체를 만들어서 이 메서드 호출
		logger.info(member.toString());
		rttr.addAttribute(member);
		if(service.insertMember(member)) {
			rttr.addFlashAttribute("status","success");
		}else {
			rttr.addFlashAttribute("status","fail");
		}
		
		//service 단을 거쳐서 dao로
		//addflashattribute 는 attribute 로 바인딩(임시적(flash) 으로 데이터를 바인딩) 임시적으로 필요한 데이터만 이걸로 새로고침하면 사라짐
//		rttr.addFlashAttribute("name",member.getName());
//		rttr.addFlashAttribute("birth",member.getEmail());
//		rttr.addFlashAttribute("member",member);
//		//addAttribute(): param에 데이터를 바인딩 jsp에서 param.으로 출력 , 계속 가져갈데이터는 이걸로 써야함
//		rttr.addAttribute("member",member.toString());
//		rttr.addAttribute("birth",member.getBirth());
//		rttr.addAttribute("name",member.getName());
		
		return "redirect:showMember";
	}
	@RequestMapping("/showMember")
	public void showMember() {
		//jsp호출
	}
	@RequestMapping("/memberInfo")
	public String memberInfo(Model Model) {
		//jsp호출
//		Member m=new Member("이현우", "990803");
//		logger.info(m.toString());
//		Model.addAttribute("memberInfo",m);
		return "showMember";
	}
	@RequestMapping("/curTime.do")
	public void curTime(Model model) {
		String now=service.selectCurTime();
		model.addAttribute("now",now);
	}
}
