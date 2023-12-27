package com.human.project_H.entity;

public class Sentiment {
	
	private String sentiCat;
	private int sentiCnt;

	public Sentiment() { }

	public Sentiment(String sentiCat, int sentiCnt) {
		this.sentiCat = sentiCat;
		this.sentiCnt = sentiCnt;
	}

	public String getSentiCat() {
		return sentiCat;
	}

	public void setSentiCat(String sentiCat) {
		this.sentiCat = sentiCat;
	}

	public int getSentiCnt() {
		return sentiCnt;
	}

	public void setSentiCnt(int sentiCnt) {
		this.sentiCnt = sentiCnt;
	}

	@Override
	public String toString() {
		return "Sentiment [sentiCat=" + sentiCat + ", sentiCnt=" + sentiCnt + "]";
	}
	
}
