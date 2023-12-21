package com.human.project_H.service;

import java.util.List;

import com.human.project_H.entity.User;
import com.human.project_H.entity.UserByMonth;

public interface UserService {
	public static final int ISDELETED = 4; 
	public static final int CORRECT_LOGIN = 0;
	public static final int WRONG_PASSWORD = 1;
	public static final int CUSTID_NOT_EXIST = 2;
	public static final int RECORDS_PER_PAGE = 10;	// 한 페이지당 10개 레코드를 보여줌
	
	int getUserCount();		// pagination을 위해 사용됨
	
	User getUser(String custId);
	
	List<User> getUserList(int page);
	
	void insertUser(User user);
	
	void updateUser(User user);
	
	void deleteUser(String custId);
	
	boolean isUserDeleted(String custId); 
	
	int login(String custId, String pwd);
	 
	List<Integer> getPageList();
	
	// Admin Page 통계용 
	
	List<UserByMonth> getNumberOfUser();
	
	List<UserByMonth> leaveNumberOfUser();
	
	int[] getSocialCount();
	
	int getSearchCount(String query);
	
	List<User> getSearchList(String query, int page);
	
}