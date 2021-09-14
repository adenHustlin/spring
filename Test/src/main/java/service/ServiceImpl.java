/**
 * 
 */
package service;

import java.lang.annotation.Annotation;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import dao.Dao;
import domain.MemberInfoVo;

@Service
public class ServiceImpl implements service.Service {
	@Inject
	private Dao dao;

	@Override
	public MemberInfoVo selectMember(String userid) throws Exception {
		
		return dao.selectMember(userid);

	}

	@Override
	public int registerMember(MemberInfoVo vo) throws Exception {
		return dao.MemberRegister(vo);

	}


}
