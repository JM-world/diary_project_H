package com.human.project_H.entity;

import java.sql.Timestamp;

public class SentimentCount {
	
	 	private Long ucid;
	    private String custId;
	    private Long cid;
	    private int color_count;
	    private String content;
	    private Timestamp modTime;
	    private boolean commitFlag;
	    private boolean shareFlag;
	    private boolean isDeleted;
	    private String nickname; // USERS 테이블의 nickname 필드와 조인한 필드
	    private String title; // TODAYCOLOR 테이블의 title 필드와 조인한 필드
	    private String mainColorCode1; // TODAYCOLOR 테이블의 maincolor_code1 필드와 조인한 필드
	    private String colorCode2; // TODAYCOLOR 테이블의 color_code2 필드와 조인한 필드
	    private String sentiment; // USER_SENTIMENT 테이블의 sentiment 필드와 조인한 필드

	    
	    public SentimentCount () {}
	    
	    


	    
		public SentimentCount(String sentiment, int color_count) {
			this.color_count = color_count;
			this.sentiment = sentiment;
		}





		public int getColor_count() {
			return color_count;
		}



		public void setColor_count(int color_count) {
			this.color_count = color_count;
		}



		public Long getUcid() {
			return ucid;
		}


		public void setUcid(Long ucid) {
			this.ucid = ucid;
		}


		public String getCustId() {
			return custId;
		}


		public void setCustId(String custId) {
			this.custId = custId;
		}


		public Long getCid() {
			return cid;
		}


		public void setCid(Long cid) {
			this.cid = cid;
		}


		public String getContent() {
			return content;
		}


		public void setContent(String content) {
			this.content = content;
		}


		public Timestamp getModTime() {
			return modTime;
		}


		public void setModTime(Timestamp modTime) {
			this.modTime = modTime;
		}


		public boolean isCommitFlag() {
			return commitFlag;
		}


		public void setCommitFlag(boolean commitFlag) {
			this.commitFlag = commitFlag;
		}


		public boolean isShareFlag() {
			return shareFlag;
		}


		public void setShareFlag(boolean shareFlag) {
			this.shareFlag = shareFlag;
		}


		public boolean isDeleted() {
			return isDeleted;
		}


		public void setDeleted(boolean isDeleted) {
			this.isDeleted = isDeleted;
		}


		public String getNickname() {
			return nickname;
		}


		public void setNickname(String nickname) {
			this.nickname = nickname;
		}


		public String getTitle() {
			return title;
		}


		public void setTitle(String title) {
			this.title = title;
		}


		public String getMainColorCode1() {
			return mainColorCode1;
		}


		public void setMainColorCode1(String mainColorCode1) {
			this.mainColorCode1 = mainColorCode1;
		}


		public String getColorCode2() {
			return colorCode2;
		}


		public void setColorCode2(String colorCode2) {
			this.colorCode2 = colorCode2;
		}


		public String getSentiment() {
			return sentiment;
		}


		public void setSentiment(String sentiment) {
			this.sentiment = sentiment;
		}


		



		@Override
		public String toString() {
			return "SentimentCount [ucid=" + ucid + ", custId=" + custId + ", cid=" + cid + ", color_count="
					+ color_count + ", content=" + content + ", modTime=" + modTime + ", commitFlag=" + commitFlag
					+ ", shareFlag=" + shareFlag + ", isDeleted=" + isDeleted + ", nickname=" + nickname + ", title="
					+ title + ", mainColorCode1=" + mainColorCode1 + ", colorCode2=" + colorCode2 + ", sentiment="
					+ sentiment + "]";
		}



		public SentimentCount(Long ucid, String custId, Long cid, int color_count, String content, Timestamp modTime,
				boolean commitFlag, boolean shareFlag, boolean isDeleted, String nickname, String title,
				String mainColorCode1, String colorCode2, String sentiment) {
			this.ucid = ucid;
			this.custId = custId;
			this.cid = cid;
			this.color_count = color_count;
			this.content = content;
			this.modTime = modTime;
			this.commitFlag = commitFlag;
			this.shareFlag = shareFlag;
			this.isDeleted = isDeleted;
			this.nickname = nickname;
			this.title = title;
			this.mainColorCode1 = mainColorCode1;
			this.colorCode2 = colorCode2;
			this.sentiment = sentiment;
		}


	    
	    
}
