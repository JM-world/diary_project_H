package com.human.project_H.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.human.project_H.entity.UserColor;

@Mapper
public interface UserColorDaoOracle {

	@Select("SELECT count(custId) FROM usercolor WHERE isDeleted = 0")
	int getPageCount();

	@Select("select commitFlag from USERCOLOR where custId = #{custId}")
	public int getCommitFlag(UserColor userColor);

	@Select("select * from USERCOLOR where custId = #{custId} and to_char(modTime,'YYYY-MM-DD') = #{modTime}")
	public UserColor searchUserColor(String custId, String modTime);

	@Insert("insert into USERCOLOR values (default, #{custId}, #{cid}, #{buffer}, default, default, default, default, default, default,default)")
	public void insertUserColorSave(String custId, int cid, String buffer);

	@Update("update usercolor set content = #{buffer} where ucid = #{ucid} and to_char(modTime,'YYYY-MM-DD') = #{modTime}")
	public void updateUserColorSave(int ucid, String buffer, String modTime);

	@Update("update USERCOLOR set content = #{content}, modTime = current_timestamp, commitFlag=#{commit}, shareFlag=#{share} where UCID=#{ucid}")
	public void updateUserColorCommit(int ucid, String content, boolean commit, boolean share);

	@Select("SELECT * FROM " + "(SELECT uc.*, u.nickname, tc.title, ROWNUM AS rnum " + "FROM USERCOLOR uc "
			+ "JOIN USERS u ON uc.custId = u.custId " + "JOIN TODAYCOLOR tc ON uc.cid = tc.cid "
			+ "WHERE uc.shareFlag = 1 AND ROWNUM <= #{limit}) b " + "WHERE b.rnum > #{offset}")
	List<UserColor> getUserColorList(int offset, int limit);

	@Select("SELECT uc.*, u.nickname, tc.title " + "FROM USERCOLOR uc " + "JOIN USERS u ON uc.custId = u.custId "
			+ "JOIN TODAYCOLOR tc ON uc.cid = tc.cid " + "WHERE uc.shareFlag = 1")
	public List<UserColor> getSharedUserColors();

	@Select("SELECT uc.*, u.nickname, tc.title, uc.content, uc.viewCount, uc.hitCount " + "FROM USERS u "
			+ "JOIN USERCOLOR uc ON u.custId = uc.custId " + "JOIN TODAYCOLOR tc ON uc.cid = tc.cid "
			+ "WHERE uc.shareFlag = 1 AND uc.ucid = #{ucid}")
	UserColor getUserColor(int ucid);

	@Select("SELECT uc.*, u.nickname, tc.title, us.sentiment, uc.modTime " + "FROM USERCOLOR uc "
			+ "JOIN users u ON uc.custId = u.custId " + "JOIN todaycolor tc ON uc.cid = tc.cid "
			+ "LEFT JOIN user_sentiment us ON uc.custId = us.custId "
			+ "WHERE uc.custId = #{custId} AND uc.isDeleted = 0")
	List<UserColor> getUserColorListByCustId(String custId);

	@Insert("insert into USER_SENTIMENT values (default, #{custId}, #{sentiment}, #{positive_score}, #{neutral_score}, #{negative_score}, SYSTIMESTAMP)")
	public void insertSentiment(String custId, String sentiment, double positive_score, double neutral_score,
			double negative_score);

	@Update("UPDATE usercolor SET content = #{content}, modTime = SYSDATE WHERE ucid = #{ucid}")
	void updateUserColorContent(int ucid, String content);

	@Select("select count(*) from userColor where commitFlag = 1")
	int commitCount();

	@Update("UPDATE usercolor SET viewCount = viewCount + 1 WHERE ucid = #{ucid}")
	void increaseViewCount(int ucid);

	@Delete("DELETE FROM USERCOLOR WHERE UCID = #{ucid}")
	void deleteUserColor(int ucid);
	
	@Update("UPDATE usercolor SET hitCount = hitCount + 1 WHERE ucid = #{ucid}")
	void increaseHitCount(int ucid);
	
    @Select("SELECT hitCount FROM usercolor WHERE ucid = #{ucid}")
    int getHitCount(int ucid);
}
