package com.human.project_H.Controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import com.human.project_H.entity.UserColor;
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
    public String viewBoard(@PathVariable int bid, HttpSession session, Model model) {
        String sessCustId = (String) session.getAttribute("sessCustId");

        // 게시글 정보를 가져와서 JSP에 전달
        Board board = boardService.getBoard(bid);
        model.addAttribute("board", board);

        // 로그인한 사용자와 게시글 작성자를 비교하여 자신의 게시물인지 확인
        if (sessCustId != null && sessCustId.equals(board.getCustId())) {
            return "board/detailBoard";
        }

        // 자신의 게시물이 아닌 경우에만 조회수 및 공감수 증가
        boardService.increaseViewCount(bid);
        // boardService.increaseLikeCount(bid);  // 공감수를 증가시키는 메서드를 추가해야 함

        return "board/detailBoard";
    }

    	 

    @GetMapping("/like/{bid}")
    public String likeBoard(@PathVariable int bid, HttpSession session) {
        String custId = (String) session.getAttribute("sessCustId");

        // 세션에서 현재 사용자가 이미 공감한 게시물 ID 목록을 가져옴
        Set<Integer> likedPosts = (Set<Integer>) session.getAttribute("likedPosts");
        if (likedPosts == null) {
            likedPosts = new HashSet<>();
        }

        // 게시글 정보를 가져와서 작성자와 현재 사용자를 비교하여 자신의 게시물인지 확인
        Board board = boardService.getBoard(bid);
        if (board != null && custId != null && custId.equals(board.getCustId())) {
            // 자신의 게시물인 경우에는 공감 처리를 하지 않고 상세 페이지로 이동
            return "redirect:/board/view/" + bid;
        }

        // 이미 공감한 게시물인지 확인
        if (!likedPosts.contains(bid)) {
            // 사용자가 공감하지 않은 경우에만 공감 처리
            boardService.increaseHitCount(bid);

            // 세션에 공감한 게시물 ID 추가
            likedPosts.add(bid);
            session.setAttribute("likedPosts", likedPosts);
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
