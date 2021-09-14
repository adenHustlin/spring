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
	
	int memberRegister(MemberVo vo)throws Exception;

	/**
	 * @date:2021. 9. 13.
	 * @param parameter
	 * return value:
	 */
	public MemberVo useridConfirm(String userid);
}
