/**
 * 
 */
package dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.MemberInfoVo;


@Repository
public class DaoImpl implements Dao {
	@Inject
	private SqlSession ses;
	private static String ns="testMapper";
	@Override
	public MemberInfoVo selectMember(String userid) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".selectMember", userid);
	}
	@Override
	public int MemberRegister(MemberInfoVo vo) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns+".registerMember",vo);
	}
	

}
