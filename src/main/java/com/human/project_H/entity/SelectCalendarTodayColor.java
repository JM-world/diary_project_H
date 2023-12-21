package com.human.project_H.entity;

import java.time.LocalDateTime;

public class SelectCalendarTodayColor {
	private String maincolor_name;
	private String maincolor_code1;
	private String color_code2;
	private LocalDateTime modTime;
	
	public SelectCalendarTodayColor() {}

	public SelectCalendarTodayColor(String maincolor_name, String maincolor_code1, String color_code2,
			LocalDateTime modTime) {
		super();
		this.maincolor_name = maincolor_name;
		this.maincolor_code1 = maincolor_code1;
		this.color_code2 = color_code2;
		this.modTime = modTime;
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

	public LocalDateTime getModTime() {
		return modTime;
	}

	public void setModTime(LocalDateTime modTime) {
		this.modTime = modTime;
	}

	@Override
	public String toString() {
		return "SelectCalendarTodayColor [maincolor_name=" + maincolor_name + ", maincolor_code1=" + maincolor_code1
				+ ", color_code2=" + color_code2 + ", modTime=" + modTime + "]";
	}

	
}
