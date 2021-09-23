package com.gootdate.domain;

import java.sql.Timestamp;

public class MemberPointVo {
	private String userid;
	private Timestamp dowhen;
	private int howmuch;
	private String why;
	
	
	public MemberPointVo() {
		super();
	}


	public MemberPointVo(String userid, Timestamp dowhen, int howmuch, String why) {
		super();
		this.userid = userid;
		this.dowhen = dowhen;
		this.howmuch = howmuch;
		this.why = why;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public Timestamp getDowhen() {
		return dowhen;
	}


	public void setDowhen(Timestamp dowhen) {
		this.dowhen = dowhen;
	}


	public int getHowmuch() {
		return howmuch;
	}


	public void setHowmuch(int howmuch) {
		this.howmuch = howmuch;
	}


	public String getWhy() {
		return why;
	}


	public void setWhy(String why) {
		this.why = why;
	}


	@Override
	public String toString() {
		return "MemberPointVo [userid=" + userid + ", dowhen=" + dowhen + ", howmuch=" + howmuch + ", why=" + why + "]";
	}
	
	
	
}
