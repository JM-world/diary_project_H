package com.human.project_H.Dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

import com.human.project_H.entity.Board;

@Mapper
public interface BoardDao {

    @Select("SELECT count(custId) FROM board WHERE isDeleted = 0")
    int getPageCount();

    @Select("SELECT * " +
            "FROM (SELECT ROWNUM rnum, a.* " +
            "      FROM (SELECT u.nickname, board.* " +
            "            FROM users u " +
            "            JOIN board ON u.custId = board.custId " +
            "            WHERE board.isDeleted = 0) a " +
            "      WHERE ROWNUM <= #{limit}) b " +
            "WHERE b.rnum > #{offset}")
    List<Board> getBoardList(int offset, int limit);

    @Select("SELECT b.*, u.nickname " +
            "FROM board b " +
            "JOIN users u ON b.custId = u.custId " +
            "WHERE b.bid = #{bid}")
    Board getBoard(int bid);
    
    @Insert("INSERT INTO board (custId, title, content) " +
            "VALUES (#{board.custId}, #{board.title}, #{board.content})")
    void insertBoard(@Param("board") Board board);

    @Update("UPDATE board SET title = #{title}, content = #{content} WHERE bid = #{bid}")
    void updateBoard(Board board);

    @Update("UPDATE board SET isDeleted = 1 WHERE bid = #{bid}")
    void deleteBoard(int bid);

    @Update("UPDATE board SET viewCount = viewCount + 1 WHERE bid = #{bid}")
    void increaseViewCount(int bid);

    @Update("UPDATE board SET hitCount = hitCount + 1 WHERE bid = #{bid}")
    void increaseHitCount(int bid);
    
    @Select("SELECT hitCount FROM board WHERE bid = #{bid}")
    int getHitCount(int bid);
    
    
    @Select("SELECT COUNT(*) FROM board WHERE custId = #{custId} AND bid = #{bid}")
    boolean hasUserLiked(@Param("custId") String custId, @Param("bid") int bid);

    @Insert("INSERT INTO board (custId, bid, title) VALUES (#{custId}, #{bid}, 'Like Record')")
    void addLikeRecord(@Param("custId") String custId, @Param("bid") int bid);
    
    
    @Select("SELECT b.custId " +
            "FROM boadr b " +
            "WHERE b.uid = #{uid}")
    String getAuthorCustId(int uid);



}
