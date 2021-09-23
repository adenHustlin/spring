/**
 * 
 */
package com.gootdate.domain;

/**
 * @author baekd
 * @packageName: domain
 * @fileName: SocialRegisterVo.java
 * @date: 2021. 9. 19. description:
 */
public class SocialRegisterVo {
	private String userid;
	private String password;
	private String name;
	private String email;
	private String phone;
	private int enabled;
	private String gender;
	private String birth;
	private String emailConfirm;

	public String getEmailConfirm() {
		return emailConfirm;
	}

	public void setEmailConfirm(String emailConfirm) {
		this.emailConfirm = emailConfirm;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}

	public SocialRegisterVo(String userid, String password, String name, String email, String phone, int enabled,
			String gender, String birth, String emailConfirm) {
		super();
		this.userid = userid;
		this.password = password;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.enabled = enabled;
		this.gender = gender;
		this.birth = birth;
		this.emailConfirm = emailConfirm;
	}

	@Override
	public String toString() {
		return "SocialRegisterVo [userid=" + userid + ", password=" + password + ", name=" + name + ", email=" + email
				+ ", phone=" + phone + ", enabled=" + enabled + ", gender=" + gender + ", birth=" + birth
				+ ", emailConfirm=" + emailConfirm + "]";
	}

	public SocialRegisterVo() {

	}
}
