/**
 * 
 */
package domain;

/**
 * @author baekd
 * @packageName: domain
 * @fileName: MemberInfoVo.java
 * @date: 2021. 9. 13.
 * description:
 */
public class MemberInfoVo {

	private String userid;
	private String password;
	private String name;
	private String email;
	private String phone;
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public MemberInfoVo(String userid, String password, String name, String email, String phone) {
		super();
		this.userid = userid;
		this.password = password;
		this.name = name;
		this.email = email;
		this.phone = phone;
	}
	
	public MemberInfoVo() {
		super();
		
	}
	
	
	
}
