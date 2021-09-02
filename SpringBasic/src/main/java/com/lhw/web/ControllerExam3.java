package com.lhw.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lhw.domain.Member;

@Controller
public class ControllerExam3 {
	@RequestMapping("/doJson")
	public @ResponseBody void outputMember() {//@리스폰스 바디: 응답을 제이슨으로 하려고할때
		
//		Member m= new Member("이현우", "990803");
//				
//		return m;
	}
}
