package com.lhw.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.lhw.domain.Member;

@Repository
public class MemberDAOImpl implements MemberDao {

	@Inject
	private SqlSession ses; // sqlSessionTemplate 객체 주입
	
	
	private static final String ns = "com.weblhw.mapper.MemberMapper";
	
	@Override
	public String getTime() {
		String query = ns + ".getCurTime";

		
		return ses.selectOne(query);
	}

	@Override
	public boolean insertMember(Member mem)throws Exception  {
		boolean result=false;
		String query = ns + ".insertMember";
		int rows=ses.insert(query, mem);
		if(rows==1) {
			result=true;
			
		}
		return result;
	}

	@Override
	public List<Member> selectAllMembers() {
		String query = ns + ".getMember";
	
		return ses.selectList(query);
	}

	@Override
	public List<Member> getMemberByUserId(Member mem) {
		String query = ns + ".getMemberByUserId";
		return ses.selectList(query, mem);
	}

	

}
