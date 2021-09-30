/**
 * 
 */
package com.gootdate.reply.service.lhw;

import java.util.List;

import com.gootdate.domain.CSReplyVo;

/**
 * @author baekd
 * @packageName: service.reply
 * @fileName: ReplyService.java
 * @date: 2021. 9. 8.
 * description:
 */

public interface CsReplyService {
	//select all replies
		public List<CSReplyVo> listReply(int bno)throws Exception;
		//create reply
		public boolean addReply(CSReplyVo vo) throws Exception;
		//modify reply
		public boolean modifyReply(CSReplyVo vo)throws Exception;
		//delete reply
		public boolean removeReply(int no)throws Exception;

}
