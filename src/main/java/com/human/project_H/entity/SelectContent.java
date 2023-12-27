package com.human.project_H.entity;

import java.time.LocalDateTime;

public class SelectContent {
    private String content;
	private LocalDateTime modTime;
	public SelectContent() {}
	public SelectContent(String content, LocalDateTime modTime) {
		super();
		this.content = content;
		this.modTime = modTime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getModTime() {
		return modTime;
	}
	public void setModTime(LocalDateTime modTime) {
		this.modTime = modTime;
	}
	@Override
	public String toString() {
		return "SelectContent [content=" + content + ", modTime=" + modTime + "]";
	}
	
}
