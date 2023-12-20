package com.human.project_H.entity;

import java.time.LocalDateTime;

public class SelectCalendarTodayColor {
	private String maincolor_name;
	private String title;
	private LocalDateTime modTime;
	
	public SelectCalendarTodayColor() {}

	public SelectCalendarTodayColor(String maincolor_name, String title, LocalDateTime modTime) {
		super();
		this.maincolor_name = maincolor_name;
		this.title = title;
		this.modTime = modTime;
	}

	public String getMaincolor_name() {
		return maincolor_name;
	}

	public void setMaincolor_name(String maincolor_name) {
		this.maincolor_name = maincolor_name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDateTime getModTime() {
		return modTime;
	}

	public void setModTime(LocalDateTime modTime) {
		this.modTime = modTime;
	}

	@Override
	public String toString() {
		return "SelectCalendarTodayColor [maincolor_name=" + maincolor_name + ", title=" + title + ", modTime="
				+ modTime + "]";
	}
	
}
