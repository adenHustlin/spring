package controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class CommonExceptionProcess {
	private static Logger logger = LoggerFactory.getLogger(CommonExceptionProcess.class);
	
//	@ExceptionHandler(Exception.class)
//	public String commonExceptionHandler(Exception e, Model model) {
//		logger.info("예외처리 이동");
//		
//		model.addAttribute("error", e);
//		return "commonError";   // commonError.jsp로 이동
//	}
	
	@ExceptionHandler(Exception.class)
	public ModelAndView commonExceptionHandler(Exception e) {
		logger.info("예외처리 이동");
		e.printStackTrace();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("commonError");
		mav.addObject("error", e.getStackTrace());
		mav.addObject("errorMsg",e.getMessage());
		return mav;
	}
	
	
}
