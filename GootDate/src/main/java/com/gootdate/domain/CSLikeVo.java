package com.gootdate.domain;

public class CSLikeVo {
	String userid;
	int bno;
	int likeordislike;
	int countlike;
	int countdislike;
	String columnName;
	int rno;
	
	

	public CSLikeVo(String userid, int bno, int likeordislike, int countlike, int countdislike, String columnName,
			int rno) {
		super();
		this.userid = userid;
		this.bno = bno;
		this.likeordislike = likeordislike;
		this.countlike = countlike;
		this.countdislike = countdislike;
		this.columnName = columnName;
		this.rno = rno;
	}



	@Override
	public String toString() {
		return "CSLikeVo [userid=" + userid + ", bno=" + bno + ", likeordislike=" + likeordislike + ", countlike="
				+ countlike + ", countdislike=" + countdislike + ", columnName=" + columnName + ", rno=" + rno + "]";
	}



	public String getUserid() {
		return userid;
	}



	public void setUserid(String userid) {
		this.userid = userid;
	}



	public int getBno() {
		return bno;
	}



	public void setBno(int bno) {
		this.bno = bno;
	}



	public int getLikeordislike() {
		return likeordislike;
	}



	public void setLikeordislike(int likeordislike) {
		this.likeordislike = likeordislike;
	}



	public int getCountlike() {
		return countlike;
	}



	public void setCountlike(int countlike) {
		this.countlike = countlike;
	}



	public int getCountdislike() {
		return countdislike;
	}



	public void setCountdislike(int countdislike) {
		this.countdislike = countdislike;
	}



	public String getColumnName() {
		return columnName;
	}



	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}



	public int getRno() {
		return rno;
	}



	public void setRno(int rno) {
		this.rno = rno;
	}



	public CSLikeVo() {
		
	}

}
