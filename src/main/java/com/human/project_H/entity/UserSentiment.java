package com.human.project_H.entity;

import java.time.LocalDateTime;

public class UserSentiment {
	private String custId;
	private String sentiment;
	private double positive_score;
	private double neutral_score;
	private double negative_score;
	private LocalDateTime modTime;
	
	public UserSentiment() { }

	public UserSentiment(String custId, String sentiment, double positive_score, double neutral_score,
			double negative_score, LocalDateTime modTime) {
		super();
		this.custId = custId;
		this.sentiment = sentiment;
		this.positive_score = positive_score;
		this.neutral_score = neutral_score;
		this.negative_score = negative_score;
		this.modTime = modTime;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getSentiment() {
		return sentiment;
	}

	public void setSentiment(String sentiment) {
		this.sentiment = sentiment;
	}

	public double getPositive_score() {
		return positive_score;
	}

	public void setPositive_score(double positive_score) {
		this.positive_score = positive_score;
	}

	public double getNeutral_score() {
		return neutral_score;
	}

	public void setNeutral_score(double neutral_score) {
		this.neutral_score = neutral_score;
	}

	public double getNegative_score() {
		return negative_score;
	}

	public void setNegative_score(double negative_score) {
		this.negative_score = negative_score;
	}

	public LocalDateTime getModTime() {
		return modTime;
	}

	public void setModTime(LocalDateTime modTime) {
		this.modTime = modTime;
	}

	@Override
	public String toString() {
		return "UserSentiment [custId=" + custId + ", sentiment=" + sentiment + ", positive_score=" + positive_score
				+ ", neutral_score=" + neutral_score + ", negative_score=" + negative_score + ", modTime=" + modTime
				+ "]";
	}

	
	

}
