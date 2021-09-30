package com.gootdate.cs.dao.lhw;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
	public List<CSVo> selectAllBoard(int pageNo,PagingInfoDTO pi) throws NamingException, SQLException {
		return ses.selectList(namespace + ".selectAllBoard",pi);
	}

	@Override
	public int insertMemberPoint(MemberPointVo mp) throws NamingException, SQLException {
		return ses.insert(namespace + ".insertMemberPoint", mp);
	}

	@Override
	public int selectCntPost() throws NamingException, SQLException {
		
		return Integer.parseInt(ses.selectOne(namespace+".getTotalPostCnt").toString());
	}

	@Override
	public CSVo selectBoard(int no) throws NamingException, SQLException {
		// TODO Auto-generated method stub
		return ses.selectOne(namespace+".selectBoard",no);
	}

	@Override
	public void updateReadCount(int no) throws NamingException, SQLException {


		ses.update(namespace+".increaseReadCount",no);
	}
	@Override
	public void deleteBoard(int bno) {
		ses.delete(namespace+".deleteBoard",bno);
		
	}
	

}
