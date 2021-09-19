/**
 * 
 */
package service.member;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import domain.LoginDTO;
import domain.MemberDetailsDto;
import domain.MemberVo;

/**
 * @author baekd
 * @packageName: service.member
 * @fileName: MemberService.java
 * @date: 2021. 9. 8.
 * description:
 */
public interface MemberService {
//
//	public MemberVo login(MemberDetailsDto dto)throws Exception;
//	
	void keepLogin(LoginDTO dto)throws Exception;
	
	MemberVo checkLoginBefore(String value)throws Exception;
	
	int memberRegister(MemberDetailsDto dto)throws Exception;

	/**
	 * @date:2021. 9. 16.
	 * @param userid
	 * @return
	 * return value:
	 */
	public MemberDetailsDto useridConfirm(String userid);

}
