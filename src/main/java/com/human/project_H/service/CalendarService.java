package com.human.project_H.service;

import java.util.List;
import java.util.Map;

import com.human.project_H.entity.ColorByDay;

public interface CalendarService {

	Map<String, String> getColorCode(String custId, String date);
	
	Map<String, Double> getEmotion(String custId, String date);
	
	String getContent(String custId, String date);
	
	List<ColorByDay> getDayColor(String date);
}
