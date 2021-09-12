package com.webshjin.web;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="*.exam") // *.exam URI가 GET방식으로 호출되면 현재 클래스가 실행됨
public class ControllerExam {
	
	private Logger logger = LoggerFactory.getLogger(ControllerExam.class);
	
	public ControllerExam() {
		logger.info("*.exam이 호출되어 ControllerExam 클래스가 객체화 됨!");
	}
	
	@RequestMapping("kor.exam")
	public String korExam() {
		return "kor";
	}
	
	@RequestMapping("math.exam")
	public String mathExam() {
		return "math";
	}
	
	@RequestMapping("eng.exam")
	public void engExam() {
		logger.info("eng.exam이 호출됨");
		
		// void를 반환하면 매핑 주소와 같은 jsp를 찾아 이동하게 된다.
		// eng.jsp로 이동
	}
	

}
