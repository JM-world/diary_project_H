package com.human.project_H.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

public class CalendarController {
	
	@GetMapping("/calendar")	// routing 정보,  localhost:8090/project_H/calendar
	public String calendar(Model model) {
		model.addAttribute("menu", "home");
		return "calendar";				// webapp/WEB-INF/view/calendar.jsp 를 렌더링해서 보여줌
	}

}
