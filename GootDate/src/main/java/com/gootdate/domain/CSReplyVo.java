/**
 * 
 */
package com.gootdate.domain;

import java.sql.Timestamp;

/**
 * @author baekd
 * @packageName: domain
 * @fileName: ReplyVo.java
 * @date: 2021. 9. 8. description:
 */
public class CSReplyVo {
	private int no;
	private int bno;
	private String replyer;
	private String contents;
	private Timestamp date;
	private String isSecret;
	private int parentno;
	private int likeordislike;
	private int likecount;
	private int dislikecount;

	public CSReplyVo() {
		super();

	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getReplyer() {
		return replyer;
	}

	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getIsSecret() {
		return isSecret;
	}

	public void setIsSecret(String isSecret) {
		this.isSecret = isSecret;
	}

	public int getParentno() {
		return parentno;
	}

	public void setParentno(int parentno) {
		this.parentno = parentno;
	}

	public int getLikeordislike() {
		return likeordislike;
	}

	public void setLikeordislike(int likeordislike) {
		this.likeordislike = likeordislike;
	}

	public int getLikecount() {
		return likecount;
	}

	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}

	public int getDislikecount() {
		return dislikecount;
	}

	public void setDislikecount(int dislikecount) {
		this.dislikecount = dislikecount;
	}

	@Override
	public String toString() {
		return "CSReplyVo [no=" + no + ", bno=" + bno + ", replyer=" + replyer + ", contents=" + contents + ", date="
				+ date + ", isSecret=" + isSecret + ", parentno=" + parentno + ", likeordislike=" + likeordislike
				+ ", likecount=" + likecount + ", dislikecount=" + dislikecount + "]";
	}

	public CSReplyVo(int no, int bno, String replyer, String contents, Timestamp date, String isSecret, int parentno,
			int likeordislike, int likecount, int dislikecount) {
		super();
		this.no = no;
		this.bno = bno;
		this.replyer = replyer;
		this.contents = contents;
		this.date = date;
		this.isSecret = isSecret;
		this.parentno = parentno;
		this.likeordislike = likeordislike;
		this.likecount = likecount;
		this.dislikecount = dislikecount;
	}

}
