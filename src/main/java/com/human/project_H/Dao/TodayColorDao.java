package com.human.project_H.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.human.project_H.entity.TodayColor;

@Mapper
public interface TodayColorDao {
	@Select("SELECT * FROM todaycolor")
    List<TodayColor> getAllColors();
	
	@Select("SELECT * FROM todaycolor WHERE cid = #{cid}")
    TodayColor getTodayColorId(int cid);


}
