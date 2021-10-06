/**
 * 
 */
package com.gootdate.reply.service.lhw;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gootdate.domain.CSLikeVo;
import com.gootdate.domain.CSReplyVo;
import com.gootdate.reply.dao.lhw.CsReplyDao;

/**
 * @author baekd
 * @packageName: service.reply
 * @fileName: ReplyServiceImpl.java
 * @date: 2021. 9. 8. description:
 */
@Service
public class CsReplyServiceImpl implements CsReplyService {
	@Autowired
	private CsReplyDao dao;

	@Override
	public List<CSReplyVo> listReply(int bno, String userid) throws Exception {

		return dao.replyList(bno, userid);
	}

	@Override
	public boolean addReply(CSReplyVo vo) throws Exception {
		boolean result = false;
		int row = dao.create(vo);
		if (row == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean modifyReply(CSReplyVo vo) throws Exception {
		boolean result = false;
		int row = dao.update(vo);
		if (row == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean removeReply(int no) throws Exception {
		boolean result = false;
		int row = dao.delete(no);
		if (row == 1) {
			result = true;
		}
		return result;
	}

	// 좋아요 정보받아오기
	@Override
	public CSLikeVo getCSLikeVo(CSLikeVo vo) {
		// TODO Auto-generated method stub
		return dao.getCsLikeVo(vo);
	}

	// 좋아요 status 바꾸기
	@Override
	public void makeLikeTo1(CSLikeVo vo) {
		// TODO Auto-generated method stub
		dao.makeLikeTo1(vo);
	}

	@Override
	public void makeLikeToMinus1(CSLikeVo vo) {
		// TODO Auto-generated method stub
		dao.makeLikeToMinus1(vo);
	}

	// 좋아요 삭제
	@Override
	public void deleteLike(CSLikeVo vo) {
		// TODO Auto-generated method stub
		dao.deleteLike(vo);
	}

	// 좋아요
	@Override
	public void insertLike(CSLikeVo vo) {
		// TODO Auto-generated method stub
		dao.insertLike(vo);
	}

}
