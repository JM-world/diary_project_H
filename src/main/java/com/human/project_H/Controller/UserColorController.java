package com.human.project_H.Controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.project_H.entity.Board;
import com.human.project_H.entity.TodayColor;
import com.human.project_H.entity.UserColor;
import com.human.project_H.service.TodayColorService;
import com.human.project_H.service.UserColorService;




@Controller
@RequestMapping("/diary")
public class UserColorController {
	

	@Autowired
	private TodayColorService todayColorService;
	


	
	// 오늘 날짜 변수
	LocalDate today = LocalDate.now();
	
	@GetMapping("/color")
	public String getAllColors(Model model) {
		List<TodayColor> todayColors = todayColorService.getAllColors();
		model.addAttribute("todayColors", todayColors);
		return "diary/selectColor"; 
	}
	
	@PostMapping("/color")
	public String getAllColors(String color, HttpSession session, Model model) {
//		String sessCustId = (String) session.getAttribute("sessCustId");
		String sessCustId = (String) session.getAttribute("sessCustId");
		System.out.println(sessCustId);
		UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());
		
		if (userColor == null) {
			TodayColor todayColor = todayColorService.choiceTodayColor(color);
			userColorService.insertUserColorSave(sessCustId, todayColor.getCid() , " ");
			
			session.setAttribute("todayColor", new TodayColor(todayColor.getMainColor_code1(), 
					todayColor.getColor_code2(), todayColor.getTitle(), todayColor.getSubTitle(), todayColor.getExplan(),
					todayColor.getQuestion(), todayColor.getOneWord()));
			session.setAttribute("content", " ");
			
			model.addAttribute("msg", "오늘의 색은 " + todayColor.getTitle() + "이에요 :)");
			
			return "diary/diaryWrite";
			
		} else if (userColor.getCommitFlag() == false ) {
			TodayColor todayColor = todayColorService.searchTodayColor(userColor.getCid());
			
			session.setAttribute("todayColor", new TodayColor(todayColor.getMainColor_code1(), 
					todayColor.getColor_code2(), todayColor.getTitle(), todayColor.getSubTitle(), todayColor.getExplan(),
					todayColor.getQuestion(), todayColor.getOneWord()));
			
			session.setAttribute("content", userColor.getContent());
			model.addAttribute("msg", "저장된 일기를 불러올게요.");
			
			return "diary/diaryWrite";
			
		} else {
			model.addAttribute("msg", "오늘은 일기를 더 적을 수 없어요.");
			model.addAttribute("url", "/project_H/calendar");
			return "common/alertMsg";
		}
	}
	
	// 임시저장 기능을 위해 선언된 변수
	private String buffer;
	
	@Autowired private UserColorService userColorService;
	
	 @GetMapping("/list/{page}")
	    public String list(@PathVariable int page, HttpSession session, Model model) {
		 	String sessCustId = (String)session.getAttribute("sessCustId");
		 	System.out.println(sessCustId);
	        List<UserColor> list = userColorService.getUserColorList(page);
	        model.addAttribute("userColorList", list);
	        list.forEach(x -> System.out.println(x));

	        int totalusers = userColorService.getPageCount();
	        int totalPages = (int) Math.ceil((double) totalusers / userColorService.RECORDS_PER_PAGE);
	        List<String> pageList = new ArrayList<>();
	        for (int i = 1; i <= totalPages; i++)
	            pageList.add(String.valueOf(i));
	        model.addAttribute("pageList", pageList);
	        session.setAttribute("currentUserPage", page);

	        return "diary/diaryboard";
	    }
	
	
	
	
	// 일기 선택 화면
	@GetMapping("/home")
	public String diarySelect() {
		return "ho";
	}
	
	
	@GetMapping("/diaryWrite")		// routing 정보, localhost:8090/project_H/diary/diaryWrite
	public String diaryWrite() {
		return "diary/diaryWrite";			// webapp/WEB-INF/view/diaryWrite.jsp 를 렌더링해서 보여줄 것
	}
	
	@PostMapping("/diaryWrite")
	public String boardWriteProc(String content, boolean commit, boolean share, HttpSession session, Model model) {
		
		// 공백제외 30자가 넘어갔을 때 제출 가능
		if (content.replaceAll("\\s", "").length() >= 30) {
				commit = true;
				content = content.trim();
				String sessCustId = (String) session.getAttribute("sessCustId");
				UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());
				userColorService.updateUserColorCommit(userColor.getUcid(), content, commit, share);
				model.addAttribute("msg", "작성 완료되었어요.");
				
				return "calendar/calendar";
		}
		
//		else {
//			String sessCustId = (String) session.getAttribute("sessCustId");
//			UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());		
//			session.setAttribute("content", userColor.getContent());
//			model.addAttribute("msg", "일기 내용이 충분하지 않아요.");
//			
//			return "redirect:/diary/diaryWrite";
//		}
			
		return "";
		
	}
	
	// 임시 저장 기능
	// 10글자 마다 해당 UCID content 컬럼에 update됨
	@ResponseBody
	@GetMapping("/write_in")
	public String writeIn(String contentIn, HttpSession session) {
		buffer = contentIn;
		System.out.println(buffer);
		String sessCustId = (String) session.getAttribute("sessCustId");
		UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());
		try {
			 
			if (buffer.isEmpty()) {
				userColorService.updateUserColorSave(userColor.getUcid(), " ", today.toString());
			} else {
			userColorService.updateUserColorSave(userColor.getUcid(), buffer, today.toString());
			}
		} catch (Exception e) {
			
		}
		return "";
	}
	
	

	    @GetMapping("/sharedBoard")
	    public String getSharedBoardList(Model model) {
	        List<UserColor> list = userColorService.getSharedUserColors();
	        model.addAttribute("sharelist", list);
	        // 뷰 이름을 반환해야 합니다.
	        return "diary/diaryboard";
	   
	    
	    }
	 // 일기 쓰기 화면 POST
	    @PostMapping("/sharedBoard")
	    public String boarddiaryshareProc(String content, boolean commit, boolean share, HttpSession session, Model model) { 
	    	if (content.replaceAll("\\s", "").length() >= 30) {
	            commit = true;
	            content = content.trim();
	            String sessCustId = (String) session.getAttribute("sessCustId");
	            UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());
	            userColorService.updateUserColorCommit(userColor.getUcid(), content, commit, share);
	            model.addAttribute("msg", "작성 완료되었어요.");
	            if (share) {
	                // 공유 여부가 true일 때 공유 게시판으로 이동
	                return  "redirect:/diary/list/1";
	            } else {
	                // 공유하지 않는 경우에는 다른 경로로 이동하도록 수정 (원하는 경로로 변경)
	                return "calendar/calendar";
	                
	            }
	        }

	        return "diary/diaryboard";
	    }
	    
	    @GetMapping("/view/{ucid}")
	    public String viewBoard(@PathVariable int ucid, HttpSession session, Model model) {
	    	String sessCustId = (String)session.getAttribute("sessCustId");
		 	System.out.println(sessCustId);
	    	userColorService.increaseViewCount(ucid);

	    	    // 게시글 정보를 가져와서 JSP에 전달
	    		UserColor usercolor = userColorService.getUserColor(ucid);
	    		
	    	    model.addAttribute("userColor", usercolor);
	    	    
	 
	    	    return "diary/detaildiary";
	    }

}









	

