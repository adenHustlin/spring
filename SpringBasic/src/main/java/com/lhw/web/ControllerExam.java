package com.lhw.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="*.exam")
public class ControllerExam {
	private Logger logger=LoggerFactory.getLogger(ControllerExam.class);
	public ControllerExam() {
		
		logger.info("*.exam has been requested & objectified");
	}
	@RequestMapping("kor.exam")
	public void KorExam() {
		
		
	}
	@RequestMapping("eng.exam")
	public String EngExam() {
		
		return "eng";
	}
	//in case of returning void, you move directly to mapping address
	
}
