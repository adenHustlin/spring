/**
 * 
 */
package com.gootdate.reply.dao.lhw;

import java.util.List;

import com.gootdate.domain.CSReplyVo;

/**
 * @author baekd
 * @packageName: persistence.reply
 * @fileName: ReplyDao.java
 * @date: 2021. 9. 8.
 * description:
 */
public interface CsReplyDao {
	//select all replies
	public List<CSReplyVo> read(int bno)throws Exception;
	//create reply
	public int create(CSReplyVo vo) throws Exception;
	//modify reply
	public int update(CSReplyVo vo)throws Exception;
	//delete reply
	public int delete(int no)throws Exception;
}
