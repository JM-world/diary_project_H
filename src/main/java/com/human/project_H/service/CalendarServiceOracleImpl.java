package com.human.project_H.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.project_H.Dao.CalendarDao;
import com.human.project_H.entity.ColorByDay;

@Service
public class CalendarServiceOracleImpl implements CalendarService{

	@Autowired CalendarDao calendarDao;
	
	@Override
	public Map<String, String> getColorCode(String custId, String date) {
		Map<String, String> mainColor = calendarDao.getColorCode(custId, date);
		return mainColor;
	}

	@Override
	public Map<String, Double> getEmotion(String custId, String date) {
		Map<String, Double> emotionScore = calendarDao.getEmotion(custId, date);
		return emotionScore;
	}

	@Override
	public String getContent(String custId, String date) {
		String content = calendarDao.getContent(custId, date);
		return content;
	}

	@Override
	public List<ColorByDay> getDayColor(String date) {
		List<ColorByDay> list = calendarDao.getDayColor(date);
		return list;
	}

}
