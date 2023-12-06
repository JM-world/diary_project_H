package com.human.project_H.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.project_H.Dao.BoardDao;
import com.human.project_H.entity.Board;


@Service
public class BoardServiceImpl implements BoardService {
	@Autowired private BoardDao boardDao;

	@Override
	public int getPageCount() {
		int count = boardDao.getPageCount();
		return count;
	}
	
	@Override
	public Board getBoard(int bid) {
		Board board = boardDao.getBoard(bid);
		return board;
	}

	@Override
	public List<Board> BoardList(int page) {
		int offset = (page - 1) * RECORDS_PER_PAGE;
		int limit = page * RECORDS_PER_PAGE;
		List<Board> list = boardDao.getBoardList(offset, limit);
		return list;
	}

	@Override
	public void insertBoard(Board board) {
	 
	     boardDao.insertBoard(board);
	}


	@Override
	public void updateBoard(Board board) {
		boardDao.updateBoard(board);
	}

	@Override
	public void deleteBoard(int bid) {
		boardDao.deleteBoard(bid);
	}
	
	
	
	
}