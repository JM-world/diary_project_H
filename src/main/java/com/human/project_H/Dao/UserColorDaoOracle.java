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
import com.human.project_H.entity.SentimentCount;
import com.human.project_H.entity.UserColor;
import com.human.project_H.entity.UserCount;
import com.human.project_H.entity.UserSentiment;

@Mapper
public interface UserColorDaoOracle {

	@Select("SELECT COUNT(uc.custId) " + "FROM USERCOLOR uc " + "JOIN users u ON uc.custId = u.custId "
			+ "JOIN todaycolor tc ON uc.cid = tc.cid " + "LEFT JOIN user_sentiment us ON uc.custId = us.custId "
			+ "WHERE uc.isDeleted = 0 " + "  AND uc.commitFlag = 1 " + "  AND uc.shareFlag = 1 "
			+ "  AND to_char(uc.modTime, 'YYYY-MM-DD') = to_char(us.modTime, 'YYYY-MM-DD') " + "  AND uc.cid = tc.cid")
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

	@Select("SELECT * FROM " + "(SELECT ROWNUM AS rnum, a.*, u.nickname, tc.title, us.sentiment "
			+ "FROM (SELECT * FROM USERCOLOR WHERE shareFlag = 1 AND commitFlag = 1 ORDER BY modTime DESC) a "
			+ "JOIN USERS u ON a.custId = u.custId " + "JOIN TODAYCOLOR tc ON a.cid = tc.cid "
			+ "LEFT JOIN USER_SENTIMENT us ON a.custId = us.custId "
			+ "WHERE TO_CHAR(a.modTime, 'YYYY-MM-DD') = TO_CHAR(us.modTime, 'YYYY-MM-DD') "
			+ "AND ROWNUM <= #{offset} + #{limit}) " + "WHERE rnum > #{offset}")
	List<UserColor> getUserColorList(@Param("offset") int offset, @Param("limit") int limit);

	@Select("SELECT uc.*, u.nickname, tc.title " + "FROM USERCOLOR uc " + "JOIN USERS u ON uc.custId = u.custId "
			+ "JOIN TODAYCOLOR tc ON uc.cid = tc.cid " + "WHERE uc.shareFlag = 1")
	public List<UserColor> getSharedUserColors();

	@Select("SELECT uc.*, u.nickname, tc.title, tc.maincolor_code1, tc.color_code2, uc.content, uc.viewCount, uc.hitCount, us.sentiment "
			+ "FROM USERS u " + "JOIN USERCOLOR uc ON u.custId = uc.custId " + "JOIN TODAYCOLOR tc ON uc.cid = tc.cid "
			+ "LEFT JOIN user_sentiment us ON uc.custId = us.custId "
			+ "AND to_char(uc.modTime, 'YYYY-MM-DD') = to_char(us.modTime, 'YYYY-MM-DD') "
			+ "WHERE uc.shareFlag = 1 AND uc.ucid = #{ucid}")
	UserColor getUserColor(@Param("ucid") int ucid);

	@Select("SELECT uc.*, u.nickname, tc.title, us.sentiment " + "FROM USERCOLOR uc "
			+ "JOIN users u ON uc.custId = u.custId " + "JOIN todaycolor tc ON uc.cid = tc.cid "
			+ "LEFT JOIN user_sentiment us ON uc.custId = us.custId "
			+ "WHERE uc.custId = #{custId} AND uc.isDeleted = 0 AND uc.commitFlag = 1 "
			+ "AND to_char(uc.modTime, 'YYYY-MM-DD') = to_char(us.modTime, 'YYYY-MM-DD') " + "AND uc.cid = tc.cid")
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

	@Select("SELECT uc.custId " + "FROM USERCOLOR uc " + "WHERE uc.ucid = #{ucid}")
	String getAuthorCustId(int ucid);

	// 감정점수
	@Insert("insert into USER_SENTIMENT values (default, #{custId}, #{sentiment}, #{positive_score}, #{neutral_score}, #{negative_score}, SYSTIMESTAMP)")
	public void insertSentiment(String custId, String sentiment, double positive_score, double neutral_score,
			double negative_score);

	@Select("select * from user_sentiment where custId = #{sessCustId}")
	List<UserSentiment> searchUSER_SENTIMENT(String sessCustId);

	@Select("select * from usercolor where custid = #{sessCustId}")
	List<SelectContent> searchCONTENT(String sessCustId);

	@Select("SELECT tc.maincolor_name, tc.maincolor_code1, tc.color_code2, uc.modtime\n" + "FROM todaycolor tc\n"
			+ "INNER JOIN usercolor uc ON tc.cid = uc.cid\n" + "WHERE uc.custid = #{sessCustId}")
	List<SelectCalendarTodayColor> searchCalcolor(String sessCustId);

	@Select("select * from (select distinct u.nickname, sum(c.hitcount) hitCount from users u inner join userColor c on u.custid = c.custid group by u.nickname order by hitCount desc) where rownum <= 10")
	List<UserColor> getHitRank();

	@Select("select count(commitFlag) commitCo from usercolor where custid = #{sessCustId} and commitFlag= 1 and to_char(modTime, 'YYYY-MM') = #{modTime}")
	int commitCo(String sessCustId, String modTime);

	@Select("select count(shareFlag) shareCo from usercolor where custid = #{sessCustId} and shareFlag= 1 and to_char(modTime, 'YYYY-MM') = #{modTime}")
	int shareCo(String sessCustId, String modTime);

	@Select("select ucid, substr(content, 1, 15) hitContent, hitcount from (select * from userColor where custid = #{sessCustId} and to_char(modTime, 'YYYY-MM') = #{modTime} order by hitCount desc) where rownum <=1")
	UserColor hitContent(String sessCustId, String modTime);

	@Select("select ucid, substr(content, 1, 15) poContent, positive_score from (select * from userColor uc left join user_sentiment us on uc.custid = us.custid and to_char(uc.modTime, 'YYYY-MM-DD') = to_char(us.modTime, 'YYYY-MM-DD') where us.custid= #{sessCustId} and to_char(us.modTime, 'YYYY-MM') = #{modTime} order by positive_score desc) where rownum <=1")
	UserSentiment poContent(String sessCustId, String modTime);

	@Select("select ucid, substr(content, 1, 15) neContent, negative_score from (select * from userColor uc left join user_sentiment us on uc.custid = us.custid and to_char(uc.modTime, 'YYYY-MM-DD') = to_char(us.modTime, 'YYYY-MM-DD') where us.custid= #{sessCustId} and to_char(us.modTime, 'YYYY-MM') = #{modTime} order by negative_score desc) where rownum <=1")
	UserSentiment neContent(String sessCustId, String modTime);

	@Select("SELECT tc.mainColor_name, tc.mainColor_code1, COUNT(*) AS color_count " +
	        "FROM users u " +
	        "JOIN userColor uc ON u.custId = uc.custId " +
	        "LEFT JOIN todayColor tc ON uc.cid = tc.cid " +
	        "WHERE u.custId = #{sessCustId} " +
	        "GROUP BY tc.mainColor_name, tc.mainColor_code1")
	List<UserCount> getColorCount(@Param("sessCustId") String sessCustId);

	
	@Select("SELECT sentiment, COUNT(sentiment) AS color_count " +
	        "FROM USER_SENTIMENT " +
	        "WHERE custId = #{sessCustId} " +
	        "AND TO_CHAR(modTime, 'YYYY-MM') = #{modTime} " +
	        "GROUP BY sentiment")
	List<SentimentCount> getUserColorWithSentimentByUserId(@Param("sessCustId") String custId, @Param("modTime") String modTime);



}