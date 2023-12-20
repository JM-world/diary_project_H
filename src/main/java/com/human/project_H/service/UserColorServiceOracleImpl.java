package com.human.project_H.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.project_H.Dao.UserColorDaoOracle;
import com.human.project_H.entity.SelectCalendarTodayColor;
import com.human.project_H.entity.SelectContent;
import com.human.project_H.entity.UserColor;
import com.human.project_H.entity.UserSentiment;

@Service
public class UserColorServiceOracleImpl implements UserColorService {

	@Autowired
	private UserColorDaoOracle userColorDao;

	// 추가한 부분
	@Override
	public UserSentiment insertSentiment(String custId, String sentiment, double positive_score, double neutral_score,
			double negative_score) {
		userColorDao.insertSentiment(custId, sentiment, positive_score, neutral_score, negative_score);
		return null;
	}
	
	@Override
	public List<SelectContent> searchCONTENT(String sessCustId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserSentiment> searchUSER_SENTIMENT(String sessCustId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<SelectCalendarTodayColor> searchCalcolor(String sessCustId) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public UserColor searchUserColor(String custId, String modTime) {
		UserColor userColor = userColorDao.searchUserColor(custId, modTime);
		return userColor;
	}

	@Override
	public int getCommitFlag(UserColor userColor) {
		int commit = userColorDao.getCommitFlag(userColor);
		return commit;
	}

	@Override
	public List<UserColor> getUserColorList(int page) {
		int offset = (page - 1) * RECORDS_PER_PAGE;
		int limit = page * RECORDS_PER_PAGE;
		return userColorDao.getUserColorList(offset, limit);
	}

	@Override
	public void updateUserColor(UserColor userColor) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteUserColor(int ucid) {
		userColorDao.deleteUserColor(ucid);

	}

	@Override
	public void changeCommitFlag(int ucid, int value) {
		// TODO Auto-generated method stub

	}

	@Override
	public void changeShareFlag(int ucid, int value) {
		// TODO Auto-generated method stub

	}

	@Override
	public void insertUserColorSave(String custId, int cid, String buffer) {
		userColorDao.insertUserColorSave(custId, cid, buffer);

	}

	@Override
	public void updateUserColorSave(int ucid, String buffer, String modTime) {
		userColorDao.updateUserColorSave(ucid, buffer, modTime);

	}

	@Override
	public void updateUserColorCommit(int ucid, String content, boolean commit, boolean share) {
		userColorDao.updateUserColorCommit(ucid, content, commit, share);

	}

	@Override
	public List<UserColor> getSharedUserColors() {
		return userColorDao.getSharedUserColors();
	}

	@Override
	public int getPageCount() {
		return userColorDao.getPageCount();
	}

	@Override
	public UserColor getUserColor(int ucid) {
		return userColorDao.getUserColor(ucid);
	}

	@Override
	public void increaseViewCount(int ucid) {
		userColorDao.increaseViewCount(ucid);
	}

	@Override
	public List<UserColor> getUserColorListByCustId(String custId) {
		return userColorDao.getUserColorListByCustId(custId);
	}

	@Override
	public void updateUserColorContent(int ucid, String content) {
		userColorDao.updateUserColorContent(ucid, content);
	}

	@Override
	public int commitCount() {
		return userColorDao.commitCount();
	}

	@Override
	public int increaseHitCount(int ucid) {
		userColorDao.increaseHitCount(ucid);

		return userColorDao.getHitCount(ucid);
	}

	@Override
	public String getAuthorCustId(int ucid) {
		return userColorDao.getAuthorCustId(ucid);
	}
	
	@Override
	public List<UserColor> getHitRank() {
		
		return userColorDao.getHitRank();
	}
	
	
}