
package com.gootdate.domain;

import java.sql.Date;

import com.google.protobuf.Timestamp;
import com.sun.mail.handlers.text_html;


public class MemberVo {
	private String userid;
	private String password;
	private String name;
	private String email;
	private String userimg;
	private String authority;
	private Timestamp registerDate;
	private String phone;
	private int enabled;
	private int failure_cnt;
	private String emailConfirm;
	private String birth;
	private String gender;
	
	


	@Override
	public String toString() {
		return "MemberVo [userid=" + userid + ", password=" + password + ", name=" + name + ", email=" + email
				+ ", userimg=" + userimg + ", authority=" + authority + ", registerDate=" + registerDate + ", phone="
				+ phone + ", enabled=" + enabled + ", failure_cnt=" + failure_cnt + ", emailConfirm=" + emailConfirm
				+ ", birth=" + birth + ", gender=" + gender + "]";
	}




	public MemberVo(String userid, String password, String name, String email, String userimg, String authority,
			Timestamp registerDate, String phone, int enabled, int failure_cnt, String emailConfirm, String birth,
			String gender) {
		super();
		this.userid = userid;
		this.password = password;
		this.name = name;
		this.email = email;
		this.userimg = userimg;
		this.authority = authority;
		this.registerDate = registerDate;
		this.phone = phone;
		this.enabled = enabled;
		this.failure_cnt = failure_cnt;
		this.emailConfirm = emailConfirm;
		this.birth = birth;
		this.gender = gender;
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




	public String getAuthority() {
		return authority;
	}




	public void setAuthority(String authority) {
		this.authority = authority;
	}




	public Timestamp getRegisterDate() {
		return registerDate;
	}




	public void setRegisterDate(Timestamp registerDate) {
		this.registerDate = registerDate;
	}




	public String getPhone() {
		return phone;
	}




	public void setPhone(String phone) {
		this.phone = phone;
	}




	public int getEnabled() {
		return enabled;
	}




	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}




	public int getFailure_cnt() {
		return failure_cnt;
	}




	public void setFailure_cnt(int failure_cnt) {
		this.failure_cnt = failure_cnt;
	}




	public String getEmailConfirm() {
		return emailConfirm;
	}




	public void setEmailConfirm(String emailConfirm) {
		this.emailConfirm = emailConfirm;
	}




	public String getBirth() {
		return birth;
	}




	public void setBirth(String birth) {
		this.birth = birth;
	}




	public String getGender() {
		return gender;
	}




	public void setGender(String gender) {
		this.gender = gender;
	}




	public MemberVo() {
		super();
		
	}
	
}
