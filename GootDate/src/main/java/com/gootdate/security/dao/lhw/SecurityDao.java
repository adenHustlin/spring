/**
 * 
 */
package com.gootdate.security.dao.lhw;

import java.util.List;
import java.util.Map;

import com.gootdate.domain.MemberDetailsDto;
import com.gootdate.domain.MemberVo;
import com.gootdate.domain.SocialRegisterVo;

/**
 * @author baekd
 * @packageName: persistence.member
 * @fileName: MemberDao.java
 * @date: 2021. 9. 8. description:
 */
public interface SecurityDao {

	public int memberRegister(MemberVo vo);

	public MemberDetailsDto getMemberDetails(String userid);

	public int updateFailureCount(String userid);

	public int checkFailureCount(String userid);

	public void updateDisabled(String userid);

	public void resetFailureCnt(String userid);

	public MemberVo getMemberVo(Map<String, String> map);

	public int SocialMemberRegister(SocialRegisterVo vo);

	public int confrimEmail(String email);

	public MemberVo emailExistance(String email);
}
