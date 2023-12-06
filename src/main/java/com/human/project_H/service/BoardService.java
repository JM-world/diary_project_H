package com.human.project_H.service;

import java.util.List;


import com.human.project_H.entity.Board;

public interface BoardService {
	public static final int CORRECT_LOGIN = 0;
	public static final int WRONG_PASSWORD = 1;
	public static final int UID_NOT_EXIST = 2;
	public static final int RECORDS_PER_PAGE = 15; 	// 한 페이지당 5개 레코드를 보여줌
	
	
	
	
	int getPageCount();
	
    List<Board> BoardList(int page);
    
    Board getBoard(int bid);
    
    void insertBoard(Board board);
    
    void updateBoard(Board board);
    
    void deleteBoard(int bid);
    
    
}


