/**
 * 
 */
package persistence.security;

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
public interface SecurityDao {
	
	public int memberRegister(MemberVo vo);
	
	public MemberDetailsDto getMemberDetails(String userid);
}
