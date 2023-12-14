package com.human.project_H.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	
	@GetMapping("/home")	// routing 정보, localhost:8090/project_H/home
	public String home() {
		return "home";				// webapp/WEB-INF/view/home.jsp 를 렌더링해서 보여줌
	}

	@PostMapping("/home")
	public String homeProc() {
		return "";
	}
	
	
	@GetMapping("/index")
	@ResponseBody
	public String index() {
		return "<h1>Welcome to SpringBoot World!!!</h1>";
	}



	@GetMapping("/diary")	
	public String diary(Model model) {
		model.addAttribute("menu", "home");
		return "diary/diary";				
	}
	
	

}
