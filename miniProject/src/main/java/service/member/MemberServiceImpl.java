/**
 * 
 */
package service.member;

import javax.inject.Inject;
import javax.management.loading.PrivateClassLoader;

import org.springframework.stereotype.Service;

import domain.LoginDTO;
import domain.MemberVo;
import persistence.member.MemberDao;

/**
 * @author baekd
 * @packageName: service.member
 * @fileName: MemberServiceImpl.java
 * @date: 2021. 9. 8.
 * description:
 */
@Service
public class MemberServiceImpl implements MemberService{
	@Inject
	private MemberDao dao;
	@Override
	public MemberVo login(LoginDTO dto) throws Exception {
		
		return dao.login(dto);
	}
	
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
	public int memberRegister(MemberVo vo) throws Exception {
		
		return dao.memberRegister(vo);
	}

	@Override
	public MemberVo useridConfirm(String userid) {
		
		return dao.useridConfirm(userid);
	}

}
