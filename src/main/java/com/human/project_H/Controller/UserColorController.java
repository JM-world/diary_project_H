package com.human.project_H.Controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		String sessCustId = (String) session.getAttribute("sessCustId");
		UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());
		
		String mainColor;
		String subColor;
		String title;
		String subTitle;
		String explan;
		String question;
		String oneWord;
		
		System.out.println(color+ " " + sessCustId + " " + userColor);
		if (userColor == null) {
			TodayColor todayColor = todayColorService.choiceTodayColor(color);
			userColorService.insertUserColorSave(sessCustId, todayColor.getCid() , " ");
			
			mainColor = todayColor.getMainColor_code1();
			subColor = todayColor.getColor_code2();
			title = todayColor.getTitle();
			subTitle = todayColor.getSubTitle();
			explan = todayColor.getExplan();
			question = todayColor.getQuestion();
			oneWord = todayColor.getOneWord();
			System.out.println(mainColor + subColor + title);
			
			model.addAttribute("mainColor", mainColor);
			model.addAttribute("subColor", subColor);
			model.addAttribute("title", title);
			model.addAttribute("subTitle", subTitle);
			model.addAttribute("explan", explan);
			model.addAttribute("question", question);
			model.addAttribute("oneWord", oneWord);
			model.addAttribute("Content", " ");
			model.addAttribute("todayColor", todayColor);
			
			model.addAttribute("url", "/project_H/diary/diaryWrite");
			
		} else if (userColor.getCommitFlag() == false ) {
			TodayColor todayColor = todayColorService.searchTodayColor(userColor.getCid());
			
			mainColor = todayColor.getMainColor_code1();
			subColor = todayColor.getColor_code2();
			title = todayColor.getTitle();
			subTitle = todayColor.getSubTitle();
			explan = todayColor.getExplan();
			question = todayColor.getQuestion();
			oneWord = todayColor.getOneWord();
			
			System.out.println(todayColor+ title);
			
			model.addAttribute("mainColor", mainColor);
			model.addAttribute("subColor", subColor);
			model.addAttribute("title", title);
			model.addAttribute("subTitle", subTitle);
			model.addAttribute("explan", explan);
			model.addAttribute("question", question);
			model.addAttribute("oneWord", oneWord);
			model.addAttribute("Content", userColor.getContent());
			model.addAttribute("msg", "저장된 일기를 불러옵니다.");
			model.addAttribute("url", "/project_H/diary/diaryWrite");
		} else {
			model.addAttribute("msg", "오늘은 일기를 더 적을 수 없어요.");
			model.addAttribute("url", "/project_H/calendar");
		}
		return "common/alertMsg";
	}
	
	// 임시저장 기능을 위해 선언된 변수
	private String buffer;
	
	@Autowired private UserColorService userColorService;
	
	// 일기 선택 화면
	@GetMapping("/home")
	public String diarySelect() {
		return "diary/selectColor";
	}
	
	
	@GetMapping("/diaryWrite")		// routing 정보, localhost:8090/project_H/diary/diaryWrite
	public String diaryWrite() {
		return "diary/diaryWrite";			// webapp/WEB-INF/view/diaryWrite.jsp 를 렌더링해서 보여줄 것
	}
	
	// 일기 쓰기 화면 POST
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
				model.addAttribute("url", "/project_H/home");
			
		}
		else {
			model.addAttribute("msg", "일기 내용이 충분하지 않아요.");
			model.addAttribute("url", "/project_H/diary/diaryWrite");
		}
			
			
		return "common/alertMsg";
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
	
}
