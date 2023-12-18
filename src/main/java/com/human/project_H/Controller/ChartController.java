package com.human.project_H.Controller;

import java.util.Iterator;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.project_H.entity.HitCount;
import com.human.project_H.entity.SelcColor;
import com.human.project_H.entity.Sentiment;
import com.human.project_H.service.ChartService;

@Controller
@RequestMapping("/chart")
public class ChartController {
	
	@Autowired private ChartService chartService;
	
	@GetMapping
	public String chart(Model model) {
		
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
		
		return "chart/chart";
	}

}
