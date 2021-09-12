package com.webshjin.persistence;

import java.util.List;

import com.webshjin.domain.Member;

public interface MemberDAO {

	public String getTime(); // 연습삼아 현재시간 반환
	
	// 회원 가입하는 메서드
	public boolean insertMember(Member mem); 
	
	
	// 전체 회원의 정보를 얻어오는 메서드
	public List<Member> selectAllMembers();
	
	// userid로 회원 정보 가져오기
	public Member selectMemberByUserId(String userid);
	
}
