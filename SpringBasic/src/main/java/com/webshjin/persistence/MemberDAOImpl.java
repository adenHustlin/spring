package com.webshjin.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webshjin.domain.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession ses;  // sqlSessionTemplate 객체 주입
	
	private static final String ns = "com.webshjin.mapper.MemberMapper";

	@Override
	public String getTime() {
		String query = ns + ".getCurTime"; // com.webshjin.mapper.MemberMapper.getCurTime
		
		return ses.selectOne(query); // SQL 실행;
	}

	@Override
	public boolean insertMember(Member mem) {
		boolean result = false;
		String query = ns + ".insertMember";
		int row = ses.insert(query, mem);
		if (row == 1) {
			result = true;
		} 
		return result;
	}

	@Override
	public List<Member> selectAllMembers() {
		return ses.selectList(ns + ".getEntireMembers");
	}

	@Override
	public Member selectMemberByUserId(String userid) {
		return ses.selectOne(ns + ".getMemberByUserId", userid);
	}

}
