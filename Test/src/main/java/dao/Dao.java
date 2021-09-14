/**
 * 
 */
package dao;

import java.security.Signature;


import domain.MemberInfoVo;


public interface Dao {
	
	MemberInfoVo selectMember(String userid)throws Exception;

	 int MemberRegister(MemberInfoVo vo)throws Exception;
	
}
