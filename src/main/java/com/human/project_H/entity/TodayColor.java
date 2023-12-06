package com.human.project_H.entity;

import java.math.BigDecimal;

public class TodayColor {
	
	private BigDecimal cid;
	private int mood;
	private String maincolor_name;
	private String maincolor_code1;
	private String color_code2;
	private String title;
	private String subtitle;
	private String explan;
	private String question;
	private String oneword;
	
	public TodayColor() {}
	
	

	public TodayColor(String maincolor_name, String maincolor_code1, String color_code2) {
		super();
		this.maincolor_name = maincolor_name;
		this.maincolor_code1 = maincolor_code1;
		this.color_code2 = color_code2;
	}



	public TodayColor(BigDecimal cid, String maincolor_name, String maincolor_code1, String color_code2, String title,
			String subtitle, String explan, String question, String oneword) {
		super();
		this.cid = cid;
		this.maincolor_name = maincolor_name;
		this.maincolor_code1 = maincolor_code1;
		this.color_code2 = color_code2;
		this.title = title;
		this.subtitle = subtitle;
		this.explan = explan;
		this.question = question;
		this.oneword = oneword;
	}



	public TodayColor(BigDecimal cid, int mood, String maincolor_name, String maincolor_code1, String color_code2,
			String title, String subtitle, String explan, String question, String oneword) {
		super();
		this.cid = cid;
		this.mood = mood;
		this.maincolor_name = maincolor_name;
		this.maincolor_code1 = maincolor_code1;
		this.color_code2 = color_code2;
		this.title = title;
		this.subtitle = subtitle;
		this.explan = explan;
		this.question = question;
		this.oneword = oneword;
	}



	public BigDecimal getCid() {
		return cid;
	}



	public void setCid(BigDecimal cid) {
		this.cid = cid;
	}



	public int getMood() {
		return mood;
	}



	public void setMood(int mood) {
		this.mood = mood;
	}



	public String getMaincolor_name() {
		return maincolor_name;
	}



	public void setMaincolor_name(String maincolor_name) {
		this.maincolor_name = maincolor_name;
	}



	public String getMaincolor_code1() {
		return maincolor_code1;
	}



	public void setMaincolor_code1(String maincolor_code1) {
		this.maincolor_code1 = maincolor_code1;
	}



	public String getColor_code2() {
		return color_code2;
	}



	public void setColor_code2(String color_code2) {
		this.color_code2 = color_code2;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getSubtitle() {
		return subtitle;
	}



	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}



	public String getExplan() {
		return explan;
	}



	public void setExplan(String explan) {
		this.explan = explan;
	}



	public String getQuestion() {
		return question;
	}



	public void setQuestion(String question) {
		this.question = question;
	}



	public String getOneword() {
		return oneword;
	}



	public void setOneword(String oneword) {
		this.oneword = oneword;
	}



	@Override
	public String toString() {
		return "TodayColor [cid=" + cid + ", mood=" + mood + ", maincolor_name=" + maincolor_name + ", maincolor_code1="
				+ maincolor_code1 + ", color_code2=" + color_code2 + ", title=" + title + ", subtitle=" + subtitle
				+ ", explan=" + explan + ", question=" + question + ", oneword=" + oneword + "]";
	}

	
	
	
}
