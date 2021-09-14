/**
 * 
 */
package service;

import java.sql.SQLException;

import javax.naming.NamingException;

import domain.MemberInfoVo;

public interface Service {

	public MemberInfoVo selectMember(String userid) throws NamingException, SQLException, Exception;
	
	public int registerMember(MemberInfoVo vo) throws NamingException, SQLException, Exception;
}
