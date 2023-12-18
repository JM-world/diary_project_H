package com.human.project_H.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.project_H.Dao.ChartDao;
import com.human.project_H.entity.HitCount;
import com.human.project_H.entity.SelcColor;
import com.human.project_H.entity.Sentiment;

@Service
public class ChartServiceOracleImpl implements ChartService {
	
	@Autowired private ChartDao chartDao; 

	@Override
	public List<Sentiment> getSentiment() {
		List<Sentiment> list = chartDao.getSentiment();
		return list;
	}

	@Override
	public List<SelcColor> selctColor() {
		List<SelcColor> list = chartDao.selctColor();
		return list;
	}

	@Override
	public List<HitCount> getHitCnt() {
		List<HitCount> list = chartDao.getHitCnt();
		return list;
	}
	
}
