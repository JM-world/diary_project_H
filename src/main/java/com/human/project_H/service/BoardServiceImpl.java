package com.human.project_H.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.project_H.Dao.BoardDao;
import com.human.project_H.entity.Board;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardDao boardDao;

    @Autowired
    private HttpSession session;

    @Override
    public int getPageCount() {
        return boardDao.getPageCount();
    }

    @Override
    public List<Board> BoardList(int page) {
        int offset = (page - 1) * RECORDS_PER_PAGE;
        int limit = page * RECORDS_PER_PAGE;
        return boardDao.getBoardList(offset, limit);
    }

    @Override
    public Board getBoard(int bid) {
        return boardDao.getBoard(bid);
    }

    @Override
    public void insertBoard(Board board) {
        // "custId" 값을 세션에서 가져와서 설정
        String custId = (String) session.getAttribute("sessCustId");
        board.setCustId(custId);
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

    @Override
    public void increaseViewCount(int bid) {
        boardDao.increaseViewCount(bid);
    }

    @Override
    public int increaseHitCount(String custId, int bid) {
        boolean userLiked = boardDao.hasUserLiked(custId, bid);

        if (!userLiked) {
            // 사용자가 공감을 누르지 않았다면 공감수 증가
            boardDao.increaseHitCount(bid);

            // 사용자가 공감을 눌렀음을 기록
            boardDao.addLikeRecord(custId, bid);

            // 증가된 공감수를 반환
            return boardDao.getHitCount(bid);
        } else {
            // 이미 공감을 눌렀다면 현재 공감수를 반환
            return boardDao.getHitCount(bid);
        }
    }

    @Override
    public boolean hasUserLiked(String custId, int bid) {
        return boardDao.hasUserLiked(custId, bid);
    }

    @Override
    public void addLikeRecord(String custId, int bid) {
        boardDao.addLikeRecord(custId, bid);
    }
}
