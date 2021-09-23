/**
 * 
 */
package com.gootdate.security.dao.lhw;

import java.io.IOException;
import java.lang.reflect.Member;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gootdate.domain.MemberDetailsDto;
import com.gootdate.domain.MemberVo;
import com.gootdate.domain.SocialRegisterVo;

/**
 * @author baekd
 * @packageName: persistence.member
 * @fileName: MemberDaoImpl.java
 * @date: 2021. 9. 8. description:
 */
@Repository("SecurityDaoImpl")
public class SecurityDaoImpl implements SecurityDao {
	@Inject
	private SqlSession ses;
	private static String ns = "com.gootdate.mapper.securityMapper";

	@Override
	public int memberRegister(MemberVo vo) {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".memberRegister", vo);
	}

	@Override
	public MemberDetailsDto getMemberDetails(String userid) {

		return ses.selectOne(ns + ".getMemberDetails", userid);
	}

	// 실패횟수 초기화
	@Override
	public int updateFailureCount(String userid) {
		return ses.update(ns + ".updateFailureCount", userid);

	}

	// 실패횟수 가져오기
	@Override
	public int checkFailureCount(String userid) {
		if (ses.selectOne(ns + ".checkFailureCount", userid) != null) {
			return ses.selectOne(ns + ".checkFailureCount", userid);
		} else {
			return -1;
		}

	}

	// 유저 계정잠구기
	@Override
	public void updateDisabled(String userid) {
		ses.update(ns + ".updateDisabled", userid);
	}

	// 실패횟수 초기화
	@Override
	public void resetFailureCnt(String userid) {
		// TODO Auto-generated method stub
		ses.update(ns + ".resetresetFailureCnt", userid);
	}

	// 그냥 userid로 멤버vo 얻어올떄 쓰는거 (많이쓰임)
	@Override
	public MemberVo getMemberVo(Map map) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".getMemberVo", map);
	}

	// 소셜회원가입
	@Override
	public int SocialMemberRegister(SocialRegisterVo vo) {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".memberRegister", vo);
	}

	// 일반회원가입 이메일인증 enable 로 바꿈
	@Override
	public int confrimEmail(String email) {
		// TODO Auto-generated method stub
		return ses.update(ns + ".emailConfirm", email);
	}

	// 아이디,비밀번호 잊어버림
	@Override
	public String getUseridWithEmail(String email) {

		return ses.selectOne(ns + ".getUseridWithEmail", email);
	}

	// 있는이메일인지 확인
	@Override
	public MemberVo emailExistance(String email) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".emailExistance", email);
	}
}
