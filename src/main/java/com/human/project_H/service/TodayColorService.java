package com.human.project_H.service;

import java.util.List;

import com.human.project_H.entity.TodayColor;



public interface TodayColorService {
	
	List<TodayColor> getAllColors();
	


	TodayColor choiceTodayColor(String color);


	TodayColor searchTodayColor(int cid);
	
	
	TodayColor getAllColorCode2(String color_code2);
	
}