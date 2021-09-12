/**
 * 
 */
package domain;

import java.sql.Timestamp;

/**
 * @author baekd
 * @packageName: domain
 * @fileName: ReplyVo.java
 * @date: 2021. 9. 8.
 * description:
 */
public class ReplyVo {
	private int no;
	private int bno;
	private String contents;
	private String replyer;
	private Timestamp registerDate;
	private Timestamp modifyDate;
	private String isSecret;
	
	public ReplyVo(){
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

	public Timestamp getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Timestamp registerDate) {
		this.registerDate = registerDate;
	}

	public Timestamp getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Timestamp modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getIsSecret() {
		return isSecret;
	}

	public void setIsSecret(String isSecret) {
		this.isSecret = isSecret;
	}

	public ReplyVo(int no, int bno, String contents, String replyer, Timestamp registerDate, Timestamp modifyDate,
			String isSecret) {
		super();
		this.no = no;
		this.bno = bno;
		this.contents = contents;
		this.replyer = replyer;
		this.registerDate = registerDate;
		this.modifyDate = modifyDate;
		this.isSecret = isSecret;
	}

	@Override
	public String toString() {
		return "ReplyVo [no=" + no + ", bno=" + bno + ", contents=" + contents + ", replyer=" + replyer
				+ ", registerDate=" + registerDate + ", modifyDate=" + modifyDate + ", isSecret=" + isSecret + "]";
	}
	
	

}
