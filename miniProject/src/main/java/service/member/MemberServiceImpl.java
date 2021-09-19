/**
 * 
 */
package service.member;

import java.net.PasswordAuthentication;

import javax.inject.Inject;
import javax.management.loading.PrivateClassLoader;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import domain.LoginDTO;
import domain.MemberDetailsDto;
import domain.MemberVo;
import persistence.member.MemberDao;

/**
 * @author baekd
 * @packageName: service.member
 * @fileName: MemberServiceImpl.java
 * @date: 2021. 9. 8. description:
 */
@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	private MemberDao dao;
	
//	@Override
//	public MemberVo login(MemberDetailsDto dto) throws Exception {
//
//		return dao.login(dto);
//	}

	@Override
	public void keepLogin(LoginDTO dto) throws Exception {
		dao.keepLogin(dto);
	}

	@Override
	public MemberVo checkLoginBefore(String value) throws Exception {
		// TODO Auto-generated method stub
		return dao.checkUserWithSessionKey(value);
	}

	@Override
	public int memberRegister(MemberDetailsDto dto) throws Exception {
		
		return dao.memberRegister(dto);
	}

	@Override
	public MemberDetailsDto useridConfirm(String userid) {
		// TODO Auto-generated method stub
		return dao.getMemberDetails(userid);
	}

}
