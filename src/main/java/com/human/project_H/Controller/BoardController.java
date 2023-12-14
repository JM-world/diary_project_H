package com.human.project_H.Controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.project_H.entity.Board;
import com.human.project_H.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
    
    @Autowired
    private BoardService boardService;

    @GetMapping("/list/{page}")
    public String list(@PathVariable int page, HttpSession session, Model model) {
        List<Board> list = boardService.BoardList(page);
        model.addAttribute("boardList", list);
        list.forEach(x -> System.out.println(x));

        int totalboards = boardService.getPageCount();
        int totalPages = (int) Math.ceil((double) totalboards / boardService.RECORDS_PER_PAGE);
        List<String> pageList = new ArrayList<>();
        for (int i = 1; i <= totalPages; i++)
            pageList.add(String.valueOf(i));
        model.addAttribute("pageList", pageList);
        session.setAttribute("currentUserPage", page);

        return "board/boardList";
    }

    @GetMapping("/update/{bid}")
    public String updateForm(@PathVariable int bid, Model model) {
        Board board = boardService.getBoard(bid);
        model.addAttribute("board", board);
        return "board/updateBoard";
    }

    @PostMapping("/update")
    public String updateBoard(Board board) {
        boardService.updateBoard(board);
        return "redirect:/board/list/1";
    }

    @GetMapping("/write")
    public String WriteForm(Model model) {
        model.addAttribute("board", new Board());
        return "board/writeBoard";
    }

    @PostMapping("/write")
    public String insertBoard(@ModelAttribute Board board, HttpSession session, Model model) {
        String custId = (String) session.getAttribute("sessCustId");
        board.setCustId(custId);
        System.out.println(custId);
        boardService.insertBoard(board);
        int currentPage = (int) session.getAttribute("currentUserPage");
        return "redirect:/board/list/" + currentPage;
    }

    @GetMapping("/view/{bid}")
    public String viewBoard(@PathVariable int bid, Model model) {
    	   boardService.increaseViewCount(bid);

    	    // 게시글 정보를 가져와서 JSP에 전달
    	    Board board = boardService.getBoard(bid);
    	    model.addAttribute("board", board);
    	    return "board/detailBoard";
    }

    @GetMapping("/like/{bid}")
    public String likeBoard(@PathVariable int bid, HttpSession session) {
        String custId = (String) session.getAttribute("sessCustId");

        // 사용자가 현재 게시글에 대해 이미 공감을 눌렀는지 확인
        boolean hasLiked = boardService.hasUserLiked(custId, bid);

        if (!hasLiked) {
            // 사용자가 공감을 누르지 않은 경우에만 공감수 증가
            boardService.increaseHitCount(custId, bid);

            // 사용자가 현재 게시글에 대해 공감을 눌렀음을 기록
            boardService.addLikeRecord(custId, bid);
        }

        // 상세 페이지로 이동
        return "redirect:/board/view/" + bid;
    }

    
    @GetMapping("/delete/{bid}")
    public String deleteBoard(@PathVariable int bid) {
        boardService.deleteBoard(bid);
        return "redirect:/board/list/1";
    }
}
