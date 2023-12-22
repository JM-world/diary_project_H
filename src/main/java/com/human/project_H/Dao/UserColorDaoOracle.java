package com.human.project_H.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.human.project_H.entity.SelectCalendarTodayColor;
import com.human.project_H.entity.SelectContent;
import com.human.project_H.entity.UserColor;
import com.human.project_H.entity.UserSentiment;

@Mapper
public interface UserColorDaoOracle {

	@Select("SELECT count(custId) FROM users WHERE isDeleted = 0")
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

	@Select("SELECT uc.*, u.nickname, tc.title, tc.maincolor_code1, tc.color_code2, uc.content, uc.viewCount, uc.hitCount, us.sentiment " +
	        "FROM USERS u " +
	        "JOIN USERCOLOR uc ON u.custId = uc.custId " +
	        "JOIN TODAYCOLOR tc ON uc.cid = tc.cid " +
	        "LEFT JOIN user_sentiment us ON uc.custId = us.custId " +
	        "AND to_char(uc.modTime, 'YYYY-MM-DD') = to_char(us.modTime, 'YYYY-MM-DD') " +
	        "WHERE uc.shareFlag = 1 AND uc.ucid = #{ucid}")
	UserColor getUserColor(@Param("ucid") int ucid);



	@Select("SELECT uc.*, u.nickname, tc.title, us.sentiment " +
	        "FROM USERCOLOR uc " +
	        "JOIN users u ON uc.custId = u.custId " +
	        "JOIN todaycolor tc ON uc.cid = tc.cid " +
	        "LEFT JOIN user_sentiment us ON uc.custId = us.custId " +
	        "WHERE uc.custId = #{custId} AND uc.isDeleted = 0 AND uc.commitFlag = 1 " +
	        "AND to_char(uc.modTime, 'YYYY-MM-DD') = to_char(us.modTime, 'YYYY-MM-DD') " +
	        "AND uc.cid = tc.cid")
	List<UserColor> getUserColorListByCustId(String custId);




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
    
    @Select("SELECT uc.custId " +
            "FROM USERCOLOR uc " +
            "WHERE uc.ucid = #{ucid}")
    String getAuthorCustId(int ucid);

  //감정점수
  	@Insert("insert into USER_SENTIMENT values (default, #{custId}, #{sentiment}, #{positive_score}, #{neutral_score}, #{negative_score}, SYSTIMESTAMP)")
  	public void insertSentiment(String custId, String sentiment, double positive_score, double neutral_score, double negative_score);
  	
  	@Select("select * from user_sentiment where custId = #{sessCustId}")
  	List<UserSentiment> searchUSER_SENTIMENT(String sessCustId);
  	
  	@Select("select * from usercolor where custid = #{sessCustId}")
  	List<SelectContent> searchCONTENT(String sessCustId);
  	

	@Select("SELECT tc.maincolor_name, tc.maincolor_code1, tc.color_code2, uc.modtime\n"
			+ "FROM todaycolor tc\n"
			+ "INNER JOIN usercolor uc ON tc.cid = uc.cid\n"
			+ "WHERE uc.custid = #{sessCustId}")
	List<SelectCalendarTodayColor> searchCalcolor(String sessCustId);
	
	
    @Select("select * from (select distinct u.nickname, sum(c.hitcount) hitCount from users u inner join userColor c on u.custid = c.custid group by u.nickname order by hitCount desc) where rownum <= 10")
 	List<UserColor> getHitRank();
}
