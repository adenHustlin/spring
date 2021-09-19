/**
 * 
 */
package persistence.member;

import domain.LoginDTO;
import domain.MemberDetailsDto;
import domain.MemberVo;

/**
 * @author baekd
 * @packageName: persistence.member
 * @fileName: MemberDao.java
 * @date: 2021. 9. 8.
 * description:
 */
public interface MemberDao {
	//로그인처리
	public MemberDetailsDto login(String userid)throws Exception;
	//자동로그인
	void keepLogin(LoginDTO dto)throws Exception;
	MemberVo checkUserWithSessionKey(String value) throws Exception;
	
	public int memberRegister(MemberDetailsDto dto);
	
	public MemberDetailsDto getMemberDetails(String userid);
}
