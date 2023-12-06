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
    @Autowired private BoardService boardService;
	//private BoardService boardService = null;

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
        // 게시글 정보를 가져와서 JSP에 전달
        Board board = boardService.getBoard(bid);
        model.addAttribute("board", board);
        return "updateBoard";
    }

    @PostMapping("/update")
    public String updateBoard(Board board) {
        // 게시글 업데이트
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
        // 기존 코드 유지
    	System.out.println(board);
        
        // "CUSTID" 값을 세션에서 가져와서 설정
        String custId = (String) session.getAttribute("custId");
        board.setCustId("admin");
        System.out.println(board);
        

        // 기존 코드 유지

        // BoardService를 통해 insertBoard 메서드 호출
        boardService.insertBoard(board);

        // 게시글 작성 후 목록 페이지로 리다이렉션
        return "redirect:/board/list/1";
    }


    @GetMapping("/view/{bid}")
    public String viewBoard(@PathVariable int bid, Model model) {
        // 게시글 정보를 가져와서 JSP에 전달
        Board board = boardService.getBoard(bid);
        model.addAttribute("board", board);
        return "board/detailBoard";
    }
    
    @GetMapping("/delete/{bid}")
    public String deleteBoard(@PathVariable int bid) {
        // 게시글 삭제
        boardService.deleteBoard(bid);
        return "redirect:/board/list/1";
    }
}
