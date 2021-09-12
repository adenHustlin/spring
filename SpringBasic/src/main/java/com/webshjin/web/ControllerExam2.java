package com.webshjin.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ControllerExam2 {
	
	@RequestMapping("param.do")
	public String paramExam(@RequestParam("no") String no) {
		// @ModelAttribute : param.do가 GET방식으로 호출될 때 no라는 파라메터가 있다면
		//                    그 값을 String no라는 이름으로 바인딩 시켜 View에 전송
		// @RequestParam : 파라메터를 얻어옴(뷰에 전송 x)
		
		System.out.println("no : " + Integer.parseInt(no));
		
		return "param";
	}
}
