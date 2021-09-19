/**
 * 
 */
package persistence.security;

import java.io.IOException;
import java.lang.reflect.Member;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.LoginDTO;
import domain.MemberDetailsDto;
import domain.MemberVo;
import domain.SocialRegisterVo;

/**
 * @author baekd
 * @packageName: persistence.member
 * @fileName: MemberDaoImpl.java
 * @date: 2021. 9. 8.
 * description:
 */
@Repository("SecurityDaoImpl")
public class SecurityDaoImpl implements SecurityDao {
	@Inject
	private SqlSession ses;
	private static String ns="securityMapper";
	
	@Override
	public int memberRegister(MemberVo vo) {
		// TODO Auto-generated method stub
		return ses.insert(ns+".memberRegister",vo);
	}
	@Override
	public MemberDetailsDto getMemberDetails(String userid) {
	
		return ses.selectOne(ns+".getMemberDetails",userid);
	}
	
	public int updateFailureCount(String userid) {
		return ses.update(ns+".updateFailureCount",userid);
		
	}
	
	public int checkFailureCount(String userid) {
		if(ses.selectOne(ns+".checkFailureCount",userid)!=null) {
			return ses.selectOne(ns+".checkFailureCount",userid);
		}else {
			return -1;
		}
	
	}
	
	public void updateDisabled(String userid) {
		ses.update(ns+".updateDisabled",userid);
	}
	
	public void resetFailureCnt(String userid) {
		// TODO Auto-generated method stub
		ses.update(ns+".resetresetFailureCnt",userid);
	}
	/**
	 * @date:2021. 9. 17.
	 * @param userid
	 * @return
	 * return value:
	 */
	public MemberVo getMemberVoForSession(String userid) {
		// TODO Auto-generated method stub
		return  ses.selectOne(ns+".getMemberVoForSession",userid);
	}
	/**
	 * @date:2021. 9. 19.
	 * @param vo
	 * @return
	 * return value:
	 */
	public int SocialMemberRegister(SocialRegisterVo vo) {
		// TODO Auto-generated method stub
		return ses.insert(ns+".memberRegister",vo);
	}
}
