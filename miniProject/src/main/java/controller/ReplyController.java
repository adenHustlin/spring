/**
 * 
 */
package controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import domain.ReplyVo;
import service.reply.ReplyService;

/**
 * @author baekd
 * @packageName: controller
 * @fileName: ReplyController.java
 * @date: 2021. 9. 10.
 * description:
 */
@RestController
@RequestMapping("/replies")
public class ReplyController {
	@Inject
	private ReplyService service;
	
	@RequestMapping(value = "/addReply",method = RequestMethod.POST)
	public ResponseEntity<String> addReply(@RequestBody ReplyVo vo,HttpServletRequest request) {
		System.out.println("reply process "+vo);
		System.out.println(request.getRequestURI());
		ResponseEntity<String> result= null;
		try {
			service.addReply(vo);
			result=new ResponseEntity<String>("success",HttpStatus.OK);
				
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result=new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);		}
		return result;
		
	}
	@RequestMapping(value = "/viewReplies/{bno}",method = RequestMethod.GET)
	public List<ReplyVo> viewReply(@PathVariable("bno")String value,Model model,HttpServletRequest request) throws Exception {
		int bno=Integer.parseInt(value);
		System.out.println("view replies process "+bno+request.getContextPath());
		List<ReplyVo> vo=service.listReply(bno);
		return vo;
		
	}

}
