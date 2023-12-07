package com.human.project_H.entity;



public class TodayColor {
	 private Long cid;
	 private int mood;
	 private String mainColor_name;
	 private String mainColor_code1;
	 private String color_code2;
	 private String title;
	 private String subTitle;
	 private String explan;
	 private String question;
	 private String oneWord;
	 
	 public TodayColor() {}
	 
	 public TodayColor(String mainColor_name,String mainColor_code1,String color_code2) {
     this.mainColor_name = mainColor_name;
     this.mainColor_code1 = mainColor_code1;
     this.color_code2 = color_code2;
     
	 }
	 public TodayColor(Long cid, int mood, String mainColor_name, String mainColor_code1, String color_code2,
			String title, String subTitle, String explan, String question, String oneWord) {
		this.cid = cid;
		this.mood = mood;
		this.mainColor_name = mainColor_name;
		this.mainColor_code1 = mainColor_code1;
		this.color_code2 = color_code2;
		this.title = title;
		this.subTitle = subTitle;
		this.explan = explan;
		this.question = question;
		this.oneWord = oneWord;
	}

	public Long getCid() {
		return cid;
	}

	public void setCid(Long cid) {
		this.cid = cid;
	}

	public int getMood() {
		return mood;
	}

	public void setMood(int mood) {
		this.mood = mood;
	}

	public String getMainColor_name() {
		return mainColor_name;
	}

	public void setMainColor_name(String mainColor_name) {
		this.mainColor_name = mainColor_name;
	}

	public String getMainColor_code1() {
		return mainColor_code1;
	}

	public void setMainColor_code1(String mainColor_code1) {
		this.mainColor_code1 = mainColor_code1;
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

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
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

	public String getOneWord() {
		return oneWord;
	}

	public void setOneWord(String oneWord) {
		this.oneWord = oneWord;
	}

	@Override
	public String toString() {
		return "TodayColor [cid=" + cid + ", mood=" + mood + ", mainColor_name=" + mainColor_name + ", mainColor_code1="
				+ mainColor_code1 + ", color_code2=" + color_code2 + ", title=" + title + ", subTitle=" + subTitle
				+ ", explan=" + explan + ", question=" + question + ", oneWord=" + oneWord + "]";
	}
	 
	 
	 
}

