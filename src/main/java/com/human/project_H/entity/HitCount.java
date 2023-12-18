package com.human.project_H.entity;

public class HitCount {
	private String chitId;
	private int shit;
	
	public HitCount() {	}

	public HitCount(String chitId, int shit) {
		this.chitId = chitId;
		this.shit = shit;
	}

	public String getChitId() {
		return chitId;
	}

	public void setChitId(String chitId) {
		this.chitId = chitId;
	}

	public int getShit() {
		return shit;
	}

	public void setShit(int shit) {
		this.shit = shit;
	}

	@Override
	public String toString() {
		return "HitCount [chitId=" + chitId + ", shit=" + shit + "]";
	}
	
}
