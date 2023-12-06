package com.human.project_H.Controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.project_H.entity.UserColor;
import com.human.project_H.service.UserColorService;



@Controller
@RequestMapping("/diary")
public class UserColorController {
	
	// custId와 cid를 고정값으로 둔 상태.
	// 연결이 완료되면 지울 것!!!
	private String custId = "maria";
	private int cid = 33;
	
	
	LocalDate today = LocalDate.now();
	
	// 임시저장 기능을 위해 선언된 변수
	private String buffer;
	
	@Autowired private UserColorService userColorService;
	
	// 일기 선택 화면
	@GetMapping("/home")
	public String diarySelect() {
		return "ho";
	}
	
	
	@GetMapping("/diaryWrite")		// routing 정보, localhost:8090/project_H/diary/diaryWrite
	public String diaryWrite() {
		return "diaryWrite";			// webapp/WEB-INF/view/diaryWrite.jsp 를 렌더링해서 보여줄 것
	}
	
	// 일기 쓰기 화면 POST
	@PostMapping("/diaryWrite")
	public String boardWriteProc(String content, boolean commit, boolean share, Model model) {
		
		// 공백제외 30자가 넘어갔을 때 제출 가능
		if (content.replaceAll("\\s", "").length() >= 30) {
				commit = true;
				content = content.trim();
				UserColor userColor = userColorService.searchUserColor(custId, today.toString());
				userColorService.updateUserColorCommit(userColor.getUcid(), content, commit, share);
				model.addAttribute("msg", "작성 완료되었어요.");
				model.addAttribute("url", "/project_H/home");
			
		}
		else {
			model.addAttribute("msg", "일기 내용이 충분하지 않아요.");
			model.addAttribute("url", "/sample/diary/diaryWrite");
		}
			
			
		return "common/alertMsg";
	}
	
	// 임시 저장 기능
	// 10글자 마다 해당 UCID content 컬럼에 update됨
	@ResponseBody
	@GetMapping("/write_in")
	public String writeIn(String contentIn) {
		buffer = contentIn;
		System.out.println(buffer);
		 
		UserColor userColor = userColorService.searchUserColor(custId, today.toString());
		try {
		if (userColor == null) {
			userColorService.insertUserColorSave(custId, cid, buffer);
		} else {
			if (buffer.isEmpty()) {
				userColorService.updateUserColorSave(userColor.getUcid(), " ", today.toString());
			} else {
			userColorService.updateUserColorSave(userColor.getUcid(), buffer, today.toString());
			}
		}
		} catch (Exception e) {
			if (userColor == null) 
				userColorService.insertUserColorSave(custId, cid, " ");
		}
		return "";
	}
	
}
