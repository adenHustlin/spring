package com.gootdate.domain;

import java.sql.Timestamp;

public class CSVo {
	private int no;
	private String title;
	private String writer;
	private Timestamp postdate;
	private int readcount;
	private int likecount;
	private int dislikecount;
	private String content;
	private String ref;
	private int reforder;
	private String solved;
	private String issecret;
	private String searchwith;
	private String searchword;
	private String sortwith;
	private String userid;
	private int likeordislike;

	
	
	



	public CSVo(int no, String title, String writer, Timestamp postdate, int readcount, int likecount, int dislikecount,
			String content, String ref, int reforder, String solved, String issecret, String searchwith,
			String searchword, String sortwith, String userid, int likeordislike) {
		super();
		this.no = no;
		this.title = title;
		this.writer = writer;
		this.postdate = postdate;
		this.readcount = readcount;
		this.likecount = likecount;
		this.dislikecount = dislikecount;
		this.content = content;
		this.ref = ref;
		this.reforder = reforder;
		this.solved = solved;
		this.issecret = issecret;
		this.searchwith = searchwith;
		this.searchword = searchword;
		this.sortwith = sortwith;
		this.userid = userid;
		this.likeordislike = likeordislike;
	}




	@Override
	public String toString() {
		return "CSVo [no=" + no + ", title=" + title + ", writer=" + writer + ", postdate=" + postdate + ", readcount="
				+ readcount + ", likecount=" + likecount + ", dislikecount=" + dislikecount + ", content=" + content
				+ ", ref=" + ref + ", reforder=" + reforder + ", solved=" + solved + ", issecret=" + issecret
				+ ", searchwith=" + searchwith + ", searchword=" + searchword + ", sortwith=" + sortwith + ", userid="
				+ userid + ", likeordislike=" + likeordislike + "]";
	}




	public int getLikeordislike() {
		return likeordislike;
	}




	public void setLikeordislike(int likeordislike) {
		this.likeordislike = likeordislike;
	}




	public int getNo() {
		return no;
	}




	public void setNo(int no) {
		this.no = no;
	}




	public String getTitle() {
		return title;
	}




	public void setTitle(String title) {
		this.title = title;
	}




	public String getWriter() {
		return writer;
	}




	public void setWriter(String writer) {
		this.writer = writer;
	}




	public Timestamp getPostdate() {
		return postdate;
	}




	public void setPostdate(Timestamp postdate) {
		this.postdate = postdate;
	}




	public int getReadcount() {
		return readcount;
	}




	public void setReadcount(int readcount) {
		this.readcount = readcount;
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




	public String getContent() {
		return content;
	}




	public void setContent(String content) {
		this.content = content;
	}




	public String getRef() {
		return ref;
	}




	public void setRef(String ref) {
		this.ref = ref;
	}




	public int getReforder() {
		return reforder;
	}




	public void setReforder(int reforder) {
		this.reforder = reforder;
	}




	public String getSolved() {
		return solved;
	}




	public void setSolved(String solved) {
		this.solved = solved;
	}




	public String getIssecret() {
		return issecret;
	}




	public void setIssecret(String issecret) {
		this.issecret = issecret;
	}




	public String getSearchwith() {
		return searchwith;
	}




	public void setSearchwith(String searchwith) {
		this.searchwith = searchwith;
	}




	public String getSearchword() {
		return searchword;
	}




	public void setSearchword(String searchword) {
		this.searchword = searchword;
	}




	public String getSortwith() {
		return sortwith;
	}




	public void setSortwith(String sortwith) {
		this.sortwith = sortwith;
	}




	public String getUserid() {
		return userid;
	}




	public void setUserid(String userid) {
		this.userid = userid;
	}




	public CSVo() {

	}

}
