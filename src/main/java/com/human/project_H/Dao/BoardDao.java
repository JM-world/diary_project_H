package com.human.project_H.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.human.project_H.entity.Board;

@Mapper
public interface BoardDao {

    @Select("select count(custId) from board where isDeleted=0")
    public int getPageCount();

    @Select("SELECT * " +
            "FROM (SELECT ROWNUM rnum, a.* " +
            "      FROM (SELECT u.nickname, board.* " +
            "            FROM USERS u " +
            "            JOIN BOARD board ON u.custId = board.custId " +
            "            WHERE board.isDeleted = 0) a " +
            "      WHERE ROWNUM <= #{limit}) b " +
            "WHERE b.rnum > #{offset}")
    List<Board> getBoardList(int offset, int limit);

    @Select("SELECT * FROM board WHERE bid = #{bid}")
    Board getBoard(int bid);

    
    @Insert("INSERT INTO board" +
            " VALUES (default, #{custId}, #{title}, #{content},default,default,default,default)")
    void insertBoard(Board board);

    @Update("UPDATE board SET title = #{title}, content = #{content} WHERE bid = #{bid}")
    void updateBoard(Board board);

    @Update("DELETE FROM board WHERE bid = #{bid}")
    void deleteBoard(int bid);
}
