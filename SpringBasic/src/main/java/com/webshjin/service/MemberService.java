package com.webshjin.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.webshjin.domain.Member;
import com.webshjin.persistence.MemberDAO;

@Service
public class MemberService {
	@Inject
	private MemberDAO dao; // dao객체 주입
	
	public String selectCurTime() {
		return dao.getTime();
	}
	
	public boolean addMember(Member m) {
		return dao.insertMember(m);
		
		
	}
}
