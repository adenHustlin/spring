/**
 * 
 */
package service.reply;


import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.sql.Date;
import java.text.SimpleDateFormat;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import domain.ReplyVo;
import persistence.reply.ReplyDao;

/**
 * @author baekd
 * @packageName: service.reply
 * @fileName: ReplyServiceImpl.java
 * @date: 2021. 9. 8.
 * description:
 */
@Service
public class ReplyServiceImpl implements ReplyService {
	@Inject
	private ReplyDao dao;
	
	@Override
	public List<ReplyVo> listReply(int bno) throws Exception {
		
		return dao.read(bno);
	}
	

	@Override
	public boolean addReply(ReplyVo vo) throws Exception {
		boolean result=false;
		int row=dao.create(vo);
		if(row==1) {
			result=true;
		}
		return result;
	}

	@Override
	public boolean modifyReply(ReplyVo vo) throws Exception {
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
