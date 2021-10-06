/**
 * 
 */
package com.gootdate.reply.controller.lhw;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gootdate.domain.CSLikeVo;
import com.gootdate.domain.CSReplyVo;
import com.gootdate.reply.service.lhw.CsReplyService;

/**
 * @author baekd
 * @packageName: controller
 * @fileName: ReplyController.java
 * @date: 2021. 9. 10. description:
 */
@RestController
@RequestMapping("/CSreplies")
public class CsReplyController {
	@Inject
	private CsReplyService service;

	// 댓글추가
	@RequestMapping(value = "/addReply", method = RequestMethod.POST)
	public ResponseEntity<String> addReply(@RequestBody CSReplyVo vo, HttpServletRequest request) {
		System.out.println("reply process " + vo);
		System.out.println(request.getRequestURI());
		ResponseEntity<String> result = null;
		try {
			service.addReply(vo);
			result = new ResponseEntity<String>("success", HttpStatus.OK);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		return result;

	}

//댓글목록
	@RequestMapping(value = "/viewReplies/{bno}/{userid}", method = RequestMethod.GET)
	public List<CSReplyVo> viewReply(@PathVariable("bno") String value,@PathVariable("userid")String userid)
			throws Exception {
		int bno = Integer.parseInt(value);
		
		System.out.println("view replies process " + bno +userid);
		
		List<CSReplyVo> vo = service.listReply(bno,userid);
		return vo;

	}

//댓글수정
	@PutMapping("/editReply")
	public boolean editReply(@RequestBody CSReplyVo vo) throws Exception {
		System.out.println(vo.toString());
		return service.modifyReply(vo);
		
	}

	// 댓글삭제
	@DeleteMapping("/deleteReply")
	public boolean deleteReply(@RequestParam(value = "rno") int no) throws Exception {
		System.out.println(no);
		return service.removeReply(no);
	}
	@RequestMapping("/processLike")
	public String processLike(@RequestBody CSLikeVo vo) {
//		

		if (service.getCSLikeVo(vo) == null) {// 처음눌렀을떄 0

			vo.setLikeordislike(1);
			service.insertLike(vo);

			return "insertLike";
		} else if (service.getCSLikeVo(vo).getLikeordislike() == 1) {// 다시눌렀을떄 1
			vo.setLikeordislike(0);
			service.deleteLike(vo);

			return "deleteLike";
		} else {// 싫어요눌렀다가 바로 좋아요눌렀을떄 -1
			
			service.makeLikeTo1(vo);
			
			return "increaseLike";
		}

	}
	@RequestMapping("/processDislike")
	@ResponseBody
	public String processDislike(@RequestBody CSLikeVo vo) {
//		

		if (service.getCSLikeVo(vo) == null) {
			vo.setLikeordislike(-1);
			service.insertLike(vo);

			return "insertDislike";
		} else if (service.getCSLikeVo(vo).getLikeordislike()== -1) {

			vo.setLikeordislike(0);
			service.deleteLike(vo);

			return "deleteDislike";
		} else {
		
			service.makeLikeToMinus1(vo);
			
			return "increaseDislike";
		}

	}
}
