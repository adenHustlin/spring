package com.lhw.persistence;

import java.util.List;

import com.lhw.domain.Member;

public interface MemberDao {
	
	public String getTime();
	
	
	public boolean insertMember(Member mem)throws Exception ;
	public List<Member> selectAllMembers();
	public List<Member> getMemberByUserId(Member mem);
}
