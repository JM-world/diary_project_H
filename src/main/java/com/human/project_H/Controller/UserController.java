package com.human.project_H.Controller;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.project_H.entity.User;
import com.human.project_H.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired private UserService userService;

	
	
	
	@GetMapping("/login")
	public String homeForm() {
		return "user/login";
	}
	
	@PostMapping("/login")
	public String homeProc(String custId, String pwd, HttpSession session, Model model) {
		int result = userService.login(custId, pwd);
		if (result == userService.CORRECT_LOGIN) {
			session.setAttribute("sesscustId", custId);
			User user = userService.getUser(custId);
			session.setAttribute("sessUname", user.getUname());
			session.setAttribute("sessEmail", user.getEmail());
			
			
			// 환영 메세지
			model.addAttribute("msg", user.getUname() + "님 환영합니다.");
			model.addAttribute("url", "/project_H/home");
		} else if (result == userService.WRONG_PASSWORD) {
			model.addAttribute("msg", "패스워드 입력이 잘못되었습니다.");
			model.addAttribute("url", "/project_H/user/login");
		} else {		// custId_NOT_EXIST
			model.addAttribute("msg", "ID 입력이 잘못되었습니다.");
			model.addAttribute("url", "/project_H/user/login");
		}
		return "common/alertMsg";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/user/login";
	}
	
	@GetMapping("/register")
	
	public String registerForm() {
		return "user/register";
	}
	
	@PostMapping("/register")
	public String registerProc(String custId, String pwd, String pwd2, String uname, 
								 String nickName, String email, Model model) {
		System.out.println(custId);
		if (userService.getUser(custId) != null) {
			model.addAttribute("msg", "사용자 ID가 중복되었습니다.");
			model.addAttribute("url", "/project_H/user/register");
		}
		if (pwd.equals(pwd2) && pwd.length() >= 4) {	// pwd와 pwd2가 같고, 길이가 4이상이면
			String hashedPwd = BCrypt.hashpw(pwd, BCrypt.gensalt());
			User user = new User(custId, hashedPwd, uname, nickName, email);
			userService.insertUser(user);
			model.addAttribute("msg", "등록을 마쳤습니다. 로그인 하세요.");
			model.addAttribute("url", "/project_H/user/login");
		} else {
			model.addAttribute("msg", "패스워드 입력이 잘못되었습니다.");
			model.addAttribute("url", "/project_H/user/login");
		}
		return "common/alertMsg";
	}
	
}