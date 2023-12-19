package com.human.project_H.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; // Service 어노테이션 추가

import com.human.project_H.Dao.TodayColorDao;
import com.human.project_H.entity.HomeColor;
import com.human.project_H.entity.TodayColor;

@Service // Service 어노테이션 추가
public class TodayColorServiceImpl implements TodayColorService {
    @Autowired
    private TodayColorDao todayColorDao;

    @Override
    public List<TodayColor> getAllColors() {
        return todayColorDao.getAllColors();
    }
    
    @Override
    public TodayColor getAllColorCode2(String color_Code2) {
        // colorCode2에 해당하는 TodayColor를 가져오는 로직을 추가
        return todayColorDao.getAllColorCode2(color_Code2);
    }
    

	@Override
	public TodayColor choiceTodayColor(String color) {
		return todayColorDao.choiceTodayColor(color);
	}

	@Override
	public TodayColor searchTodayColor(int cid) {
		return todayColorDao.searchTodayColor(cid);
	}
	
	@Override
	public HomeColor homeColor(String modTime) {
		return todayColorDao.homeColor(modTime);
	}

	@Override
	public TodayColor choiceHomeColor() {
		return todayColorDao.choiceHomeColor();
	}

	@Override
	public void insertHomeColor(String mainColor, String mainColor_code, String todayWord) {
		todayColorDao.insertHomeColor(mainColor, mainColor_code, todayWord);
	}
    
	

}