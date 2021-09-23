/**
 * 
 */
package com.gootdate.reply.dao.lhw;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gootdate.domain.ReplyVo;
import com.mysql.cj.Session;

/**
 * @author baekd
 * @packageName: persistence.reply
 * @fileName: ReplyDaoImpl.java
 * @date: 2021. 9. 8.
 * description:
 */
@Repository
public class CsReplyDaoImpl implements CsReplyDao {
	private static String ns="com.gootdate.mapper.replyMapper";
	@Inject
	private SqlSession ses;
	@Override
	public List<ReplyVo> read(int bno) throws Exception {
		
		return ses.selectList(ns+".replyList",bno);
	}

	@Override
	public int create(ReplyVo vo) throws Exception {
		
		return ses.insert(ns+".create",vo);
	}

	@Override
	public int update(ReplyVo vo) throws Exception {
		
		return ses.update(ns+".modify",vo);
	}

	@Override
	public int delete(int no) throws Exception {
		
		return ses.delete(ns+".remove",no);
	}

}
