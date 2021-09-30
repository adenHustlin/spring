/**
 * 
 */
package com.gootdate.reply.service.lhw;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gootdate.domain.CSReplyVo;
import com.gootdate.reply.dao.lhw.CsReplyDao;

/**
 * @author baekd
 * @packageName: service.reply
 * @fileName: ReplyServiceImpl.java
 * @date: 2021. 9. 8.
 * description:
 */
@Service
public class CsReplyServiceImpl implements CsReplyService {
	@Inject
	private CsReplyDao dao;
	
	@Override
	public List<CSReplyVo> listReply(int bno) throws Exception {
		
		return dao.read(bno);
	}
	

	@Override
	public boolean addReply(CSReplyVo vo) throws Exception {
		boolean result=false;
		int row=dao.create(vo);
		if(row==1) {
			result=true;
		}
		return result;
	}

	@Override
	public boolean modifyReply(CSReplyVo vo) throws Exception {
		boolean result=false;
		int row=dao.update(vo);
		if(row==1) {
			result=true;
		}
		return result;
	}

	@Override
	public boolean removeReply(int no) throws Exception {
		boolean result=false;
		int row=dao.delete(no);
		if(row==1) {
			result=true;
		}
		return result;
	}

}
