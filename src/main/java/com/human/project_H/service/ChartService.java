package com.human.project_H.service;

import java.util.List;

import com.human.project_H.entity.HitCount;
import com.human.project_H.entity.SelcColor;
import com.human.project_H.entity.Sentiment;

public interface ChartService {
	
	List<Sentiment> getSentiment();
	
	List<SelcColor> selctColor();
	
	List<HitCount> getHitCnt();
}
