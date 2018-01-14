package com.hk.dto;

import java.io.Serializable;

public class Dto implements Serializable {
	
	
	
	private static final long serialVersionUID = 5903539886514020570L;
	
	private int seq;
	private String id;
	private String title;
	private String content;
	private String mDate;
	private String regDate;
	
	
	public Dto() {
		
	}
	
	
	
	public Dto(String id, String title, String content, String mDate) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.mDate = mDate;
	}



	public Dto(int seq, String id, String title, String content, String mDate, String regDate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.mDate = mDate;
		this.regDate = regDate;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getmDate() {
		return mDate;
	}
	public void setmDate(String mDate) {
		this.mDate = mDate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Dto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", mDate=" + mDate
				+ ", regDate=" + regDate + "]";
	}
	
	
	
	
	

}
