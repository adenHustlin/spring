package com.lhw.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ControllerExam2 {
	@RequestMapping("param.do")
	public String paramExam(@ModelAttribute("no")String no) {
		//@ModelAttribute: param.do 가 겟방식으로 호출될때 no라는 파라메터가 있다면 그 값을 String no 라는 이름으로 바인딩시켜 view로 전송
		//@request.param: 파라메터 얻어옴(뷰 전송 x)
		System.out.println(no);
		
		return "param";
	}

}
