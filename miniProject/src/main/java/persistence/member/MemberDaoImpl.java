/**
 * 
 */
package persistence.member;

import java.lang.reflect.Member;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.LoginDTO;
import domain.MemberDetailsDto;
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
	public MemberDetailsDto login(String userid) throws Exception {
		
		return ses.selectOne(ns+".login",userid);
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
	public int memberRegister(MemberDetailsDto dto) {
		// TODO Auto-generated method stub
		return ses.insert(ns+".memberRegister",dto);
	}
	@Override
	public MemberDetailsDto getMemberDetails(String userid) {
	
		return ses.selectOne(ns+".getMemberDetails",userid);
	}

}
