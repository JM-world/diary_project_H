package com.human.project_H.service;

import java.util.List;

import com.human.project_H.entity.Board;

public interface BoardService {

    public static final int CORRECT_LOGIN = 0;
    public static final int WRONG_PASSWORD = 1;
    public static final int UID_NOT_EXIST = 2;
    public static final int RECORDS_PER_PAGE = 15; // 한 페이지당 15개 레코드를 보여줌

    int getPageCount();

    List<Board> BoardList(int page);

    Board getBoard(int bid);

    void insertBoard(Board board);

    void updateBoard(Board board);

    void deleteBoard(int bid);

    void increaseViewCount(int bid);

    int increaseHitCount(int bid);
    
    // 사용자가 이미 공감을 눌렀는지 여부 확인
    boolean hasUserLiked(String custId, int bid);

    // 사용자가 공감을 눌렀음을 기록
    void addLikeRecord(String custId, int bid);
    
    String getAuthorCustId(int uid);

}
