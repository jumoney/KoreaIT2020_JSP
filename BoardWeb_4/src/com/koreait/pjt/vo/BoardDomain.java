package com.koreait.pjt.vo;

public class BoardDomain extends BoardVO {
	private String nm;
	private int yn_like;
	private int eldx;
	private int sldx;
	private int record_cnt;

	public int getRecord_cnt() {
		return record_cnt;
	}

	public void setRecord_cnt(int record_cnt) {
		this.record_cnt = record_cnt;
	}

	public int getEldx() {
		return eldx;
	}

	public void setEldx(int eldx) {
		this.eldx = eldx;
	}

	public int getSldx() {
		return sldx;
	}

	public void setSldx(int sldx) {
		this.sldx = sldx;
	}

	public int getYn_like() {
		return yn_like;
	}

	public void setYn_like(int yn_like) {
		this.yn_like = yn_like;
	}

	public String getNm() {
		return nm;
	}

	public void setNm(String nm) {
		this.nm = nm;
	}
}
