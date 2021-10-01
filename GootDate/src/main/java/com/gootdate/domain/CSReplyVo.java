/**
 * 
 */
package com.gootdate.domain;

import java.sql.Timestamp;

/**
 * @author baekd
 * @packageName: domain
 * @fileName: ReplyVo.java
 * @date: 2021. 9. 8.
 * description:
 */
public class CSReplyVo {
	private int no;
	private int bno;
	private String replyer;
	private String contents;
	private Timestamp date;
	private String isSecret;
	
	public CSReplyVo(){
		super();
		
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
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

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getReplyer() {
		return replyer;
	}

	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}

	public String getIsSecret() {
		return isSecret;
	}

	public void setIsSecret(String isSecret) {
		this.isSecret = isSecret;
	}

	@Override
	public String toString() {
		return "CSReplyVo [no=" + no + ", bno=" + bno + ", replyer=" + replyer + ", contents=" + contents + ", date="
				+ date + ", isSecret=" + isSecret + "]";
	}

	public CSReplyVo(int no, int bno, String replyer, String contents, Timestamp date, String isSecret) {
		super();
		this.no = no;
		this.bno = bno;
		this.replyer = replyer;
		this.contents = contents;
		this.date = date;
		this.isSecret = isSecret;
	}

	

	
	

}