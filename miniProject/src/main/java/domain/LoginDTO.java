/**
 * 
 */
package domain;

import java.sql.Timestamp;

/**
 * @author baekd
 * @packageName: domain
 * @fileName: LoginDTO.java
 * @date: 2021. 9. 8.
 * description:
 */
public class LoginDTO {

	private String userid;
	private String password;
	private boolean loginCookie;
	private String sessionid;
	private Timestamp sessionage;
	public LoginDTO() {
		super();
	}
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
	public boolean isLoginCookie() {
		return loginCookie;
	}
	public void setLoginCookie(boolean loginCookie) {
		this.loginCookie = loginCookie;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	public Timestamp getSessionage() {
		return sessionage;
	}
	public void setSessionage(Timestamp sessionage) {
		this.sessionage = sessionage;
	}
	@Override
	public String toString() {
		return "LoginDTO [userid=" + userid + ", password=" + password + ", loginCookie=" + loginCookie + ", sessionid="
				+ sessionid + ", sessionage=" + sessionage + "]";
	}
	public LoginDTO(String userid, String password, boolean loginCookie, String sessionid, Timestamp sessionage) {
		super();
		this.userid = userid;
		this.password = password;
		this.loginCookie = loginCookie;
		this.sessionid = sessionid;
		this.sessionage = sessionage;
	}
	
	
}
