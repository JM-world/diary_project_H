package com.human.project_H.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.project_H.Dao.TodayColorDao;
import com.human.project_H.entity.TodayColor;

@Service
public class TodayColorServiceImpl implements TodayColorService {

    @Autowired
    private TodayColorDao todayColorDao;

    @Override
    public List<TodayColor> getTodayColorList(String maincolorName, String maincolorCode1, String colorCode2) {
        return todayColorDao.getTodayColorList(maincolorName, maincolorCode1, colorCode2);
    }
}
