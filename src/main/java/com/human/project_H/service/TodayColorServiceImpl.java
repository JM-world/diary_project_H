package com.human.project_H.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.human.project_H.Dao.TodayColorDao;
import com.human.project_H.entity.TodayColor;

public class TodayColorServiceImpl implements TodayColorService{
	@Autowired private TodayColorDao todayColorDao;
	
	@Override
	public List<TodayColor> getAllColors() {
		return todayColorDao.getAllColors();
		
	}

}
