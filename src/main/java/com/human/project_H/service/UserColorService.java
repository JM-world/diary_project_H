package com.human.project_H.service;

import java.util.List;

import com.human.project_H.entity.UserColor;

public interface UserColorService {
	
	UserColor getUserColor(int ucid);
	
	UserColor searchUserColor(String custId, String modTime);
	
	int getCommitFlag(UserColor userColor);
	
	
	List<UserColor> getUserColorList();
	
	void updateUserColor(UserColor userColor);
	
	void deleteUserColor(int ucid);
	
	void changeCommitFlag(int ucid, int value);
	
	void changeShareFlag(int ucid, int value);

	void insertUserColorSave(String custId, int cid, String buffer);

	void updateUserColorSave(int ucid, String buffer, String modTime);

	void updateUserColorCommit(int ucid, String content, boolean commit, boolean share);
}
