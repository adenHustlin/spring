/**
 * 
 */
package service.security;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.configurers.userdetails.DaoAuthenticationConfigurer;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import domain.MemberDetailsDto;
import domain.MemberVo;
import domain.SocialRegisterVo;
import persistence.security.SecurityDao;
import persistence.security.SecurityDaoImpl;

/**
 * @author baekd
 * @packageName: service.security
 * @fileName: MemberDetailsServiceCustom.java
 * @date: 2021. 9. 16.
 * description:
 */
@Service("MemberLoginService")
public class SecurityService  implements UserDetailsService {
	@Inject
	SecurityDaoImpl SecurityDaoImpl;

	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
		MemberDetailsDto memberDetailsDto=SecurityDaoImpl.getMemberDetails(userid);
		if(memberDetailsDto==null) {
			throw new UsernameNotFoundException(userid);

		}
		return memberDetailsDto;
	}
	
	public MemberDetailsDto useridConfirm(String userid) {
		
		return SecurityDaoImpl.getMemberDetails(userid);
	}


	public int memberRegister(MemberVo vo) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.memberRegister(vo);
	}

	
	public int UpdateFailureCnt(String userid) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.updateFailureCount(userid);
	}

	
	public int checkFailureCount(String userid) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.checkFailureCount(userid);
	}

	
	public void disableMember(String userid) {
		SecurityDaoImpl.updateDisabled(userid);
		
	}

	public void resetFailureCnt(String userid) {
		
		SecurityDaoImpl.resetFailureCnt(userid);
	}

	/**
	 * @date:2021. 9. 17.
	 * @param loginidname
	 * @return
	 * return value:
	 */
	public MemberVo getMemberVoForSession(String userid) {
		
		return SecurityDaoImpl.getMemberVoForSession( userid);
	}

	/**
	 * @date:2021. 9. 19.
	 * @param vo
	 * @return
	 * return value:
	 */
	public int SocialMemberRegister(SocialRegisterVo vo) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.SocialMemberRegister(vo);
	}
	

}
