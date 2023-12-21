package com.human.project_H.Controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.project_H.entity.User;
import com.human.project_H.entity.UserByMonth;
import com.human.project_H.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;

	@ResponseBody
	@GetMapping(value = { "/update/{custId}", "update" })
	public String updateForm(@PathVariable(required = false) String custId) {
		if (custId == null)
			return "redirect:/user/login";
		User user = userService.getUser(custId);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("custId", user.getcustId());
		jsonObject.put("uname", user.getUname());
		jsonObject.put("email", user.getEmail());
		return jsonObject.toJSONString();
	}

	@PostMapping("/update")
	public String updateProc(String pwd, String pwd2, String uname, String email, HttpSession session, Model model) {
		String sessCustId = (String) session.getAttribute("sessCustId");
		if (sessCustId == null)
			return "redirect:/user/login";

		User user = userService.getUser(sessCustId);
		// System.out.println("pwd=" + pwd + ", pwd2=" + pwd2);
		if (pwd.length() >= 4 && pwd.equals(pwd2)) {
			String hashedPwd = BCrypt.hashpw(pwd, BCrypt.gensalt());
			user.setPwd(hashedPwd);
		} else if (pwd.equals("") && pwd2.equals("")) {
			; // 아무일도 하지 않는다
		} else {
			model.addAttribute("msg", "패스워드를 다시 입력하고 수정하세요.");
			model.addAttribute("url", "/project_H/user/list/" + session.getAttribute("currentUserPage"));
			return "common/alertMsg";
		}
		user.setUname(uname);
		user.setEmail(email);

		// 수정 업데이트
		userService.updateUser(user);

		if (sessCustId.equals("admin2")) {
			model.addAttribute("msg", "수정이 완료되었습니다.");
			model.addAttribute("url", "/project_H/user/list/" + session.getAttribute("currentUserPage"));
			return "common/alertMsg";
		} else {
			model.addAttribute("msg", "수정이 완료되었어요.");
			model.addAttribute("url", "/project_H/home");
			return "common/alertMsg";
		}

	}

	@GetMapping("/delete/{custId}")
	public String delete(@PathVariable String custId, HttpSession session) {
		String sessCustId = (String) session.getAttribute("sessCustId");
		if (sessCustId == null)
			return "redirect:/user/login";
		userService.deleteUser(custId);
		return "redirect:/user/list/" + session.getAttribute("currentUserPage");
	}

	@GetMapping("/list/{page}")
	public String list(@PathVariable int page,@RequestParam(name="q", defaultValue="") String query, HttpSession session, Model model) {
		List<User> list;

		String sessCustId = (String) session.getAttribute("sessCustId");

		if (sessCustId.equals("admin2")) {
			// admin으로 로그인한 경우
			list = userService.getSearchList(query, page);
			model.addAttribute("userList", list);
			model.addAttribute("menu", "user");

			int totalUsers = userService.getSearchCount(query);
			int totalPages = (int) Math.ceil((double) totalUsers / userService.RECORDS_PER_PAGE);
			List<String> pageList = new ArrayList<>();
			for (int i = 1; i <= totalPages; i++)
				pageList.add(String.valueOf(i));
			model.addAttribute("pageList", pageList);
			session.setAttribute("currentUserPage", page);
			
			// Admin page 통계용
			List<UserByMonth> monthList = userService.getNumberOfUser();
			JSONArray jsonArray = new JSONArray();
			
			Iterator<UserByMonth> it = monthList.iterator();
			while(it.hasNext()) {
				UserByMonth userMonth = it.next();
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("month", userMonth.getMonth());
				jsonObject.put("numberOfPerson", userMonth.getNumberOfPerson());
				
				jsonArray.add(jsonObject);
			}
			
			List<UserByMonth> leaveList= userService.leaveNumberOfUser();
			JSONArray lJsonArray = new JSONArray();
			
			
			Iterator<UserByMonth> lit = leaveList.iterator();
			while(lit.hasNext()) {
				UserByMonth lUserMonth = lit.next();
				JSONObject lJsonObject = new JSONObject();
				lJsonObject.put("lMonth", lUserMonth.getMonth());
				lJsonObject.put("lNumberOfPerson", lUserMonth.getNumberOfPerson());
				
				lJsonArray.add(lJsonObject);
			}
			
			model.addAttribute("aJson", jsonArray.toJSONString());
			model.addAttribute("lJson", lJsonArray.toJSONString());
			model.addAttribute("totalUsers", totalUsers);
			model.addAttribute("kakaoUsers", userService.getSocialCount()[0]);
			model.addAttribute("naverUsers", userService.getSocialCount()[1]);
			model.addAttribute("leaveUsers", userService.getSocialCount()[2]);

			return "admin/list";
		} else {
			// 그 외의 경우
			return "user/list2";
		}
	}

	@GetMapping("/login")
	public String homeForm() {
		return "user/login";
	}

	@PostMapping("/login")
	public String homeProc(String custId, String pwd, HttpSession session, Model model) {
		int result = userService.login(custId, pwd);

		// Check if the user is deleted
		if (result == userService.CORRECT_LOGIN && !userService.isUserDeleted(custId)) {
			session.setAttribute("sessCustId", custId);
			User user = userService.getUser(custId);
			session.setAttribute("sessUname", user.getUname());
			session.setAttribute("sessEmail", user.getEmail());

			// admin2로 로그인한 경우 리스트 페이지로 이동
			if ("admin2".equals(custId)) {
				return "redirect:/user/list/1";
			} else {

				// 환영 메세지
				model.addAttribute("msg", user.getUname() + "님 환영합니다.");
				model.addAttribute("url", "/project_H/home");
			}
		} else if (result == userService.WRONG_PASSWORD) {
			model.addAttribute("msg", "패스워드 입력이 잘못되었습니다.");
			model.addAttribute("url", "/project_H/user/login");
		} else if (result == userService.CUSTID_NOT_EXIST) {
			model.addAttribute("msg", "ID 입력이 잘못되었습니다.");
			model.addAttribute("url", "/project_H/user/login");
		}
		return "common/alertMsg";

	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home";
	}

	@GetMapping("/register")

	public String registerForm() {
		return "user/register";
	}

	@PostMapping("/register")
	public String registerProc(String custId, String pwd, String pwd2, String uname, String nickName, String email,
			Model model) {
		System.out.println(custId);
		if (userService.getUser(custId) != null) {
			model.addAttribute("msg", "사용자 ID가 중복되었습니다.");
			model.addAttribute("url", "/project_H/user/register");
		}
		if (pwd.equals(pwd2) && pwd.length() >= 4) { // pwd와 pwd2가 같고, 길이가 4이상이면
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
