package com.human.project_H.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; // Service 어노테이션 추가

import com.human.project_H.Dao.TodayColorDao;
import com.human.project_H.entity.TodayColor;

@Service // Service 어노테이션 추가
public class TodayColorServiceImpl implements TodayColorService {
    @Autowired
    private TodayColorDao todayColorDao;

    @Override
    public List<TodayColor> getAllColors() {
        return todayColorDao.getAllColors();
    }

    // 수정된 메소드명: getTodayColorById
    @Override
    public TodayColor getTodayColorId(int cid) {
        return todayColorDao.getTodayColorId(cid);
    }
    

}
