package com.webshjin.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.webshjin.domain.Member;

@Controller
public class ControllerExam3 {
	@RequestMapping("/doJson")
	public @ResponseBody List<Member> outputMember() { // @ResponseBody : 응답을 json으로 하고자 할때
		List<Member> lst = new ArrayList<Member>();
		Member m = new Member("abc", "1234", "백두산", "22", null, null, null);
		Member m2 = new Member("hanla", "1234", "한라산", "22", null, null, null);
		lst.add(m);
		lst.add(m2);
		return lst;
	}
}
