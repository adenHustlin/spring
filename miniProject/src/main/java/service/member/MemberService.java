/**
 * 
 */
package service.member;

import domain.LoginDTO;
import domain.MemberVo;

/**
 * @author baekd
 * @packageName: service.member
 * @fileName: MemberService.java
 * @date: 2021. 9. 8.
 * description:
 */
public interface MemberService {

	public MemberVo login(LoginDTO dto)throws Exception;
	
	void keepLogin(LoginDTO dto)throws Exception;
	
	MemberVo checkLoginBefore(String value)throws Exception;
}
