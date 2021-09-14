package controller;

import static org.hamcrest.CoreMatchers.nullValue;

import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.imageio.metadata.IIOMetadataFormat;
import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import domain.MemberInfoVo;
import service.Service;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/test")
public class MemberInfoController {
	@Inject
	Service service;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberInfoController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */

	@RequestMapping(value = "/get", method = RequestMethod.GET)
	public String GET(Locale locale, Model model,MemberInfoVo vo) throws Exception {
		logger.info(vo.toString());
		if(service.registerMember(vo)==1){
			MemberInfoVo vo2=service.selectMember(vo.getUserid());
			model.addAttribute("MemberInfo",vo2);
		}else {
			model.addAttribute("result","register fail");
		}
		
		return null;
	}
	@RequestMapping(value = "/post", method = RequestMethod.POST)
	public String POST(Locale locale, Model model,MemberInfoVo vo) throws NamingException, SQLException, Exception {
		if(service.registerMember(vo)==1){
			MemberInfoVo vo2=service.selectMember(vo.getUserid());
			model.addAttribute("MemberInfo",vo2);
		}else {
			model.addAttribute("result","register fail");
		}
		
		return "home";
	}
	@RequestMapping(value = "/userid", method = RequestMethod.POST)
	public Model idconfirm(Locale locale, Model model,HttpServletRequest request) throws NamingException, SQLException, Exception {
		logger.info(request.getParameter("userid"));
		if(service.selectMember(request.getParameter("userid"))==null) {
			model.addAttribute("result","does not exist");
			
		}else {
			model.addAttribute("result","exists");
		}
		
		
	
		return model;
	}
	
	
}
