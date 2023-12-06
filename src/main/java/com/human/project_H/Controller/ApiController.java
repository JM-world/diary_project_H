package com.human.project_H.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api")
public class ApiController {
	
	@GetMapping("/local")	
	public String calendar(Model model) {
		model.addAttribute("menu", "home");
		return "api/localapi";			
	}

}
