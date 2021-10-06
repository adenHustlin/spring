package com.gootdate.cs.dao.lhw;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gootdate.domain.CSLikeVo;
import com.gootdate.domain.CSVo;
import com.gootdate.domain.MemberPointVo;
import com.gootdate.domain.PagingInfoDTO;

@Repository
public class CsDAOImpl implements CsDAO {

	private static String namespace = "com.gootdate.mapper.csMapper";

	@Inject
	private SqlSession ses;

	@Override
	public int insertCSVo(CSVo bo) throws NamingException, SQLException {
		return ses.insert(namespace + ".createBoard", bo);
	}

	@Override
	public List<CSVo>  selectAllBoard(PagingInfoDTO pi) throws NamingException, SQLException {
		return ses.selectList(namespace + ".selectAllBoard", pi);
	}

	@Override
	public int insertMemberPoint(MemberPointVo mp) throws NamingException, SQLException {
		return ses.insert(namespace + ".insertMemberPoint", mp);
	}

	@Override
	public int selectCntPost() throws NamingException, SQLException {

		return Integer.parseInt(ses.selectOne(namespace + ".getTotalPostCnt").toString());
	}

	@Override
	public CSVo selectBoard(int no) throws NamingException, SQLException {
		// TODO Auto-generated method stub
		return ses.selectOne(namespace + ".selectBoard", no);
	}

	@Override
	public void updateCs(int no) throws NamingException, SQLException {
		ses.update(namespace + ".increaseReadCount", no);
	}

	@Override
	public void deleteBoard(int bno) {
		ses.delete(namespace + ".deleteBoard", bno);

	}

	// 좋아요
	@Override
	public CSLikeVo getCSLikeVo(CSLikeVo vo) {
		// TODO Auto-generated method stub
		return ses.selectOne(namespace + ".getCsLikeVo", vo);
	}

	@Override
	public int countLikes(CSLikeVo vo) {
		// TODO Auto-generated method stub
		return ses.selectOne(namespace + ".countLikes", vo);
	}

	@Override
	public int countDisLikes(CSLikeVo vo) {
		// TODO Auto-generated method stub
		return ses.selectOne(namespace + ".countDisLikes", vo);
	}

	@Override
	public void makeLikeTo1(CSLikeVo vo) {
		// TODO Auto-generated method stub
		ses.update(namespace + ".makeLikeTo1", vo);
	}

	@Override
	public void makeLikeToMinus1(CSLikeVo vo) {
		// TODO Auto-generated method stub
		ses.update(namespace + ".makeLikeToMinus1", vo);
	}

	@Override
	public void deleteLike(CSLikeVo vo) {
		// TODO Auto-generated method stub
		ses.delete(namespace + ".deleteLike", vo);
	}

	@Override
	public void inserLike(CSLikeVo vo) {
		// TODO Auto-generated method stub
		ses.insert(namespace + ".insertLike", vo);
	}

	@Override
	public void processCs(CSLikeVo vo) {
		// TODO Auto-generated method stub
		ses.update(namespace + ".processCs", vo);
	}

	@Override
	public void switchingLike(CSLikeVo vo) {
		// TODO Auto-generated method stub
		ses.update(namespace + ".switchingLike", vo);
	}

	@Override
	public void editBoard(CSVo vo) {
		// TODO Auto-generated method stub
		ses.update(namespace+".editBoard",vo);
	}

	@Override
	public List<CSVo> getList(CSVo vo) {
		// TODO Auto-generated method stub
		return ses.selectList(namespace+".getList",vo);
	}

}
