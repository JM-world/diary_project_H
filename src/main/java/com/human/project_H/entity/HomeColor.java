package com.human.project_H.entity;

import java.security.Timestamp;

public class HomeColor {
	private String mainColor;
	private String mainColor_code;
	private String todayWord;
	private Timestamp modTime;
	
	
	public HomeColor() {
		
	}
	
	public HomeColor(String mainColor, String mainColor_code, String todayWord) {
		this.mainColor = mainColor;
		this.mainColor_code = mainColor_code;
		this.todayWord = todayWord;
	}
	
	public HomeColor(String mainColor, String mainColor_code, String todayWord, Timestamp modTime) {
		this.mainColor = mainColor;
		this.mainColor_code = mainColor_code;
		this.todayWord = todayWord;
		this.modTime = modTime;
	}

	public String getMainColor() {
		return mainColor;
	}

	public void setMainColor(String mainColor) {
		this.mainColor = mainColor;
	}

	public String getMainColor_code() {
		return mainColor_code;
	}

	public void setMainColor_code(String mainColor_code) {
		this.mainColor_code = mainColor_code;
	}

	public String getTodayWord() {
		return todayWord;
	}

	public void setTodayWord(String todayWord) {
		this.todayWord = todayWord;
	}

	public Timestamp getModTime() {
		return modTime;
	}

	public void setModTime(Timestamp modTime) {
		this.modTime = modTime;
	}

	@Override
	public String toString() {
		return "HomeColor [mainColor=" + mainColor + ", mainColor_code=" + mainColor_code + ", todayWord=" + todayWord
				+ ", modTime=" + modTime + "]";
	}
	
	
	
	
}

