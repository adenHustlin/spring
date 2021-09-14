/**
 * 
 */
package persistence.member;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.LoginDTO;
import domain.MemberVo;

/**
 * @author baekd
 * @packageName: persistence.member
 * @fileName: MemberDaoImpl.java
 * @date: 2021. 9. 8.
 * description:
 */
@Repository
public class MemberDaoImpl implements MemberDao {
	@Inject
	private SqlSession ses;
	private static String ns="com.miniProj.mapper.memberMapper";
	@Override
	public MemberVo login(LoginDTO dto) throws Exception {
		
		return ses.selectOne(ns+".login",dto);
	}
	@Override
	public void keepLogin(LoginDTO dto) throws Exception {
		ses.update(ns+".keepLogin",dto);
		
	}
	
	@Override
	public MemberVo checkUserWithSessionKey(String value) throws Exception {
		return ses.selectOne(ns+".checkUserWithSessionKey",value);
	}
	@Override
	public int memberRegister(MemberVo vo) {
		// TODO Auto-generated method stub
		return ses.insert(ns+".memberRegister",vo);
	}
	@Override
	public MemberVo useridConfirm(String userid) {
	
		return ses.selectOne(ns+".useridConfirm",userid);
	}

}
