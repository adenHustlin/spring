package com.lhw.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.lhw.domain.Member;
import com.lhw.persistence.MemberDao;

@Service
public class MemberService {
	@Inject
	private MemberDao dao;
	
	public String selectCurTime() {
		return dao.getTime();
	}
	public boolean insertMember(Member mem) throws Exception {
		boolean result=false;
		if(dao.insertMember(mem)) {
			result=true;
		}
		return result;
	}
}
