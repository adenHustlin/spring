package com.webshjin.domain;

import java.sql.Timestamp;

public class Member {
	private String userid;
	private String password;
	private String name;
	private String email;
	private String userimg;
	private String isadmin;
	private Timestamp registerDate;
	
	
	// Spring 컨테이너는 기본 생성자로 객체를 만들고 setter를 호출하여 값을 setting 한다. 그러므로, 
    // 생성자를 프로그래머가 오버로딩 했다면, 기본 생성자도 별도로 만들어 줘야 한다.
	public Member() {
		
	}



	public Member(String userid, String password, String name, String email, String userimg, String isadmin,
			Timestamp registerDate) {
		super();
		this.userid = userid;
		this.password = password;
		this.name = name;
		this.email = email;
		this.userimg = userimg;
		this.isadmin = isadmin;
		this.registerDate = registerDate;
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



	@Override
	public String toString() {
		return "Member [userid=" + userid + ", password=" + password + ", name=" + name + ", email=" + email
				+ ", userimg=" + userimg + ", isadmin=" + isadmin + ", registerDate=" + registerDate + "]";
	}
	
	
	
	
	
	
}
