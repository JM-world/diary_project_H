package com.human.project_H.service;

import java.util.List;

import com.human.project_H.entity.TodayColor;

public interface TodayColorService {

    List<TodayColor> getTodayColorList(String maincolorName, String maincolorCode1, String colorCode2);
}
