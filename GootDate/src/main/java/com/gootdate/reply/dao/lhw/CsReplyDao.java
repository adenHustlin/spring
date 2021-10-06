/*
 * 
 */
package com.gootdate.reply.dao.lhw;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gootdate.domain.CSLikeVo;
import com.gootdate.domain.CSReplyVo;

/**
 * @author baekd
 * @packageName: persistence.reply
 * @fileName: ReplyDao.java
 * @date: 2021. 9. 8. description:
 */

public interface CsReplyDao {
	// select all replies

	public List<CSReplyVo> replyList(@Param("bno") int bno, @Param("userid") String userid) throws Exception;

	// create reply
	public int create(CSReplyVo vo) throws Exception;

	// modify reply
	public int update(CSReplyVo vo) throws Exception;

	// delete reply
	public int delete(int no) throws Exception;

	public CSLikeVo getCsLikeVo(CSLikeVo vo);

	public void makeLikeTo1(CSLikeVo vo);

	public void makeLikeToMinus1(CSLikeVo vo);

	public void deleteLike(CSLikeVo vo);

	public void insertLike(CSLikeVo vo);
}
