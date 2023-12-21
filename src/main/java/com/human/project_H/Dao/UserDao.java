package com.human.project_H.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.human.project_H.entity.User;
import com.human.project_H.entity.UserByMonth;

@Mapper
public interface UserDao {

	@Select("select count(uname) from users where isDeleted=0")
	public int getUserCount();
	
	@Select("select * from users where custId=#{custId} and isDeleted=0")
	public User getUser(String custId);
	
	// #{CUSTID} --> user.getcustId()
	@Insert("insert into users values (#{custId}, #{uname}, #{nickName}, #{pwd}, #{email}, default, default)")
	public void insertUser(User user);

	@Select("select * from (select rownum rnum, a.* from"
			+ "    (select * from users where isDeleted=0) a"
			+ "    where rownum <= #{limit}) where rnum > #{offset}")
	public List<User> getUserList(int offset, int limit);
	
	@Update("update users set pwd=#{pwd}, uname=#{uname}, nickName=#{nickName}, email=#{email}, regDate=#{regDate} where custId=#{custId}")
	void updateUser(User user);				// 인터페이스이기 때문에 public 생략 가능
	
	@Update("update users set isDeleted=1 where custId=#{custId}")
	void deleteUser(String custId);			// 인터페이스이기 때문에 public 생략 가능
	
	// Admin page 통계용
	@Select("select to_number(to_char(regdate, 'mm')) as month, count(*) as cnt from users "
			+ "group by to_char(regdate, 'mm') order by month")
	public List<UserByMonth> getNumberOfUser();
	
	@Select("select to_number(to_char(regdate, 'mm')) as month, count(*) as cnt from users where isDeleted=1 "
			+ "group by to_char(regdate, 'mm') order by month")
	public List<UserByMonth> leaveNumberOfUser();
	
	@Select("select count(*) from users where isDeleted=#{isDeleted} and custId like #{custId}")
	public int getSocialCount(int isDeleted, String custId);
	
	@Select("select count(uname) from users where isDeleted=0 and "
			+ "(custId like #{query} or uname like #{query} or email like #{query})")
	public int getSearchCount(String query);
	
	@Select("select * from (select rownum rnum, a.* from "
			+ "    (select * from users "
			+ "    where isDeleted=0 and (custId like #{query} or uname like #{query} or email like #{query})) a "
			+ "    where rownum <= #{limit}) where rnum > #{offset}")
	public List<User> getSearchList(int offset, int limit, String query);
	
}