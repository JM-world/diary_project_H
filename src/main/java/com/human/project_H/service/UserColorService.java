package com.human.project_H.service;

import java.util.List;

import com.human.project_H.entity.SelectCalendarTodayColor;
import com.human.project_H.entity.SelectContent;
import com.human.project_H.entity.SentimentCount;
import com.human.project_H.entity.UserColor;
import com.human.project_H.entity.UserCount;
import com.human.project_H.entity.UserSentiment;

public interface UserColorService {
	int CORRECT_LOGIN = 0;
	int WRONG_PASSWORD = 1;
	int UID_NOT_EXIST = 2;
	int RECORDS_PER_PAGE = 10; // 한 페이지당 10개 레코드를 보여줌

	UserColor getUserColor(int ucid);

	UserColor searchUserColor(String custId, String modTime);

	int getCommitFlag(UserColor userColor);

	UserSentiment insertSentiment(String custId, String sentiment, double positive_score, double neutral_score,
			double negative_score);

	int getPageCount();

	List<UserColor> getUserColorList(int page);

	void updateUserColor(UserColor userColor);

	void deleteUserColor(int ucid);

	void changeCommitFlag(int ucid, int value);

	void changeShareFlag(int ucid, int value);

	void insertUserColorSave(String custId, int i, String buffer);

	void updateUserColorSave(int ucid, String buffer, String modTime);

	void updateUserColorCommit(int ucid, String content, boolean commit, boolean share);

	List<UserColor> getSharedUserColors();

	void increaseViewCount(int ucid);

	List<UserColor> getUserColorListByCustId(String custId);

	void updateUserColorContent(int ucid, String content);

	int commitCount();
	
	int commitCo(String sessCustId, String modTime);
	
	int shareCo(String sessCustId, String modTime);
	
	UserColor hitContent(String sessCustId, String modTime);
	
	UserSentiment poContent(String sessCustId, String modTime);
	
	UserSentiment neContent(String sessCustId, String modTime);

	int increaseHitCount(int ucid);

	String getAuthorCustId(int ucid);

	List<UserSentiment> searchUSER_SENTIMENT(String sessCustId);

	List<SelectContent> searchCONTENT(String sessCustId);
	
	
	List<UserColor> getHitRank();
	
	List<UserCount> getColorCount(String sessCustId);
	
	List<SelectCalendarTodayColor> searchCalcolor(String sessCustId);
	
	
	 List<SentimentCount> getUserColorWithSentimentByUserId(String custId, String modTime);
}