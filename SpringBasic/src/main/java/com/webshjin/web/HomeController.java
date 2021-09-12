package com.webshjin.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller // 현재 클래스가 Controller 임을 명시
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET) // / 매핑으로 GET방식으로 요청 되어 되면
	public String home(Locale locale, Model mav) {
		// 이 메서드가 자동으로 호출한다.
		
		logger.info("Welcome home! The client locale is {}.", locale); // INFO 로그 남김
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		mav.addAttribute("serverTime", formattedDate ); // Model객체에 바인딩 하여 view단으로 전송
		
		return "home";   // /WEB-INF/views/home.jsp로 이동
	}
	
	@RequestMapping(value="exam.do", method = RequestMethod.GET) // exam.do URI로 GET방식으로 호출
	public String exam() {
		System.out.println("exam.do가 호출되면 exam() 실행");		
		
		// service단 호출
		
		
		return "exam"; // /WEB-INF/views/exam.jsp로 페이지 이동
	}
	
}
