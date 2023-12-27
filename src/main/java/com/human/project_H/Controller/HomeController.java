package com.human.project_H.Controller;

import java.time.LocalDate;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.human.project_H.entity.HitCount;
import com.human.project_H.entity.HomeColor;
import com.human.project_H.entity.SelcColor;
import com.human.project_H.entity.Sentiment;
import com.human.project_H.entity.TodayColor;
import com.human.project_H.entity.User;
import com.human.project_H.entity.UserColor;
import com.human.project_H.service.ChartService;
import com.human.project_H.service.TodayColorService;
import com.human.project_H.service.UserColorService;
import com.human.project_H.service.UserService;

@Controller
public class HomeController {
	
	LocalDate today = LocalDate.now();
	
	@Autowired
	private TodayColorService todayColorService;
	@Autowired
	private UserColorService userColorService;
	@Autowired
	private UserService userService;
	
	@Autowired
	private ChartService chartService;
	
	@GetMapping("/home")	// routing 정보, localhost:8090/project_H/home
	public String home(HttpSession session, Model model) {
		
		String sessCustId = (String) session.getAttribute("sessCustId");
		if (sessCustId != null) {
			User user = userService.getUser(sessCustId);
			session.setAttribute("user", user);
		}
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
		
		List<UserColor> userColor = userColorService.getHitRank();
		System.out.println(userColor);
		session.setAttribute("userColor", userColor);
				
		
		List<Sentiment> list = chartService.getSentiment();
		JSONArray jsonArray = new JSONArray();
		
		Iterator<Sentiment> it = list.iterator();
		while(it.hasNext()) {
			Sentiment sentiment = it.next();
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("sentiCat", sentiment.getSentiCat());
			jsonObject.put("sentiCnt", sentiment.getSentiCnt());
			
			jsonArray.add(jsonObject);
		}
		
		List<SelcColor> slist = chartService.selctColor();
		JSONArray sjsonArray = new JSONArray();
		
		Iterator<SelcColor> sit = slist.iterator();
		while(sit.hasNext()) {
			SelcColor selcColor = sit.next();
			JSONObject sjsonObject = new JSONObject();
			sjsonObject.put("colorName", selcColor.getColorName());
			sjsonObject.put("colorCode", selcColor.getColorCode());
			sjsonObject.put("selctCnt", selcColor.getSelectCnt());
			
			sjsonArray.add(sjsonObject);
		}
		
		List<HitCount> hlist = chartService.getHitCnt();
		JSONArray hjsonArray = new JSONArray();
		
		Iterator<HitCount> hit = hlist.iterator();
		while(hit.hasNext()) {
			HitCount hitCount = hit.next();
			JSONObject hjsonObject = new JSONObject();
			hjsonObject.put("chitId", hitCount.getChitId());
			hjsonObject.put("shit", hitCount.getShit());
			
			hjsonArray.add(hjsonObject);
		}
		
		
		model.addAttribute("sentiCatJson", jsonArray.toJSONString());
		model.addAttribute("selcColorJson", sjsonArray.toJSONString());
		model.addAttribute("hitJson", hjsonArray.toJSONString());
		
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
