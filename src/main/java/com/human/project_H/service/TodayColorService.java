package com.human.project_H.service;

import java.util.List;

import com.human.project_H.entity.TodayColor;



public interface TodayColorService {

	List<TodayColor> getAllColors();
	
	
	TodayColor getTodayColorId(int cid);
}
