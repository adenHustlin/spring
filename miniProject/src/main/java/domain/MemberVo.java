
package domain;

import java.sql.Date;

import com.google.protobuf.Timestamp;


public class MemberVo {
	private String userid;
	private String password;
	private String name;
	private String email;
	private String userimg;
	private String isadmin;
	private Timestamp registerDate;
	private String sessionid;
	private Timestamp sessionage;
	private String phone;
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	public String getUserimg() {
		return userimg;
	}
	public void setUserimg(String userimg) {
		this.userimg = userimg;
	}
	public String getIsadmin() {
		return isadmin;
	}
	public void setIsadmin(String isadmin) {
		this.isadmin = isadmin;
	}
	public Timestamp getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Timestamp registerDate) {
		this.registerDate = registerDate;
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
		return "MemberVo [userid=" + userid + ", password=" + password + ", name=" + name + ", email=" + email
				+ ", userimg=" + userimg + ", isadmin=" + isadmin + ", registerDate=" + registerDate + ", sessionid="
				+ sessionid + ", sessionage=" + sessionage + ", phone=" + phone + "]";
	}
	public MemberVo(String userid, String password, String name, String email, String userimg, String isadmin,
			Timestamp registerDate, String sessionid, Timestamp sessionage, String phone) {
		super();
		this.userid = userid;
		this.password = password;
		this.name = name;
		this.email = email;
		this.userimg = userimg;
		this.isadmin = isadmin;
		this.registerDate = registerDate;
		this.sessionid = sessionid;
		this.sessionage = sessionage;
		this.phone = phone;
	}
	public MemberVo() {
		super();
		
	}
	
}
