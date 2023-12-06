package com.human.project_H.service;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.project_H.Dao.UserDao;
import com.human.project_H.entity.User;

@Service
public class UserServiceOracleImpl implements UserService {
	@Autowired private UserDao userDao;

	@Override
	public int getUserCount() {
		int count = userDao.getUserCount();
		return count;
	}

	@Override
	public User getUser(String custId) {
		User user = userDao.getUser(custId);
		return user;
	}

	@Override
	public List<User> getUserList(int page) {
		int offset = (page - 1) * RECORDS_PER_PAGE;
		int limit = page * RECORDS_PER_PAGE;
		List<User> list = userDao.getUserList(offset, limit);
		return list;
	}

	@Override
	public void insertUser(User user) {
		userDao.insertUser(user);
	}

	@Override
	public void updateUser(User user) {
		userDao.updateUser(user);
	}

	@Override
	public void deleteUser(String custId) {
		userDao.deleteUser(custId);
	}

	@Override
	public int login(String custId, String pwd) {
		User user = userDao.getUser(custId);
		if (user == null)
			return CUSTID_NOT_EXIST;
		if (BCrypt.checkpw(pwd, user.getPwd()))
			return CORRECT_LOGIN;
		else
			return WRONG_PASSWORD;
	}

}