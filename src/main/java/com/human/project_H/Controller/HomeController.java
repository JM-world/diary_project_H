package com.human.project_H.Controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.project_H.entity.HomeColor;
import com.human.project_H.entity.TodayColor;
import com.human.project_H.entity.UserColor;
import com.human.project_H.service.TodayColorService;
import com.human.project_H.service.UserColorService;

@Controller
public class HomeController {
	
	LocalDate today = LocalDate.now();
	
	@Autowired
	private TodayColorService todayColorService;
	@Autowired
	private UserColorService userColorService;
	
	@GetMapping("/home")	// routing 정보, localhost:8090/project_H/home
	public String home(HttpSession session) {
		
		HomeColor homeColor = todayColorService.homeColor(today.toString());
		int count = userColorService.commitCount(); 
		if (homeColor == null) {
			TodayColor todayColor = todayColorService.choiceHomeColor();
			todayColorService.insertHomeColor(todayColor.getMainColor_name(), todayColor.getMainColor_code1(),
					todayColor.getOneWord());
			homeColor = todayColorService.homeColor(today.toString());
		}
		System.out.println(count);
		session.setAttribute("count", count);
		session.setAttribute("homeColor", homeColor);
		return "home";				// webapp/WEB-INF/view/home.jsp 를 렌더링해서 보여줌
	}

	@PostMapping("/home")
	public String homeProc() {
		return "home";
	}



	@GetMapping("/diary")	
	public String diary(Model model) {
		model.addAttribute("menu", "home");
		return "diary/diary";				
	}
	
	

}
