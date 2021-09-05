package domain;

import java.sql.Timestamp;

public class BoardVo {
	private int no;
	private String title;
	private String writer;
	private Timestamp postdate;
	private int readcount;
	private int likecount;
	private String pwd;
	private String content;
	private String image;
	
	public BoardVo() {
		super();
	}
	
	public BoardVo(int no, String title, String writer, Timestamp postdate, int readcount, int likecount, String pwd,
			String content, String image) {
		super();
		this.no = no;
		this.title = title;
		this.writer = writer;
		this.postdate = postdate;
		this.readcount = readcount;
		this.likecount = likecount;
		this.pwd = pwd;
		this.content = content;
		this.image = image;
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

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "BoardVo [no=" + no + ", title=" + title + ", writer=" + writer + ", postdate=" + postdate
				+ ", readcount=" + readcount + ", likecount=" + likecount + ", pwd=" + pwd + ", content=" + content
				+ ", image=" + image + "]";
	}
	
	
	
}
