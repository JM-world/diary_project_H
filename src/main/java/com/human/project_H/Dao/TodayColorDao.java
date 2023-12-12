package com.human.project_H.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.human.project_H.entity.TodayColor;

@Mapper
public interface TodayColorDao {
	@Select("SELECT * FROM todaycolor")
    List<TodayColor> getAllColors();
	
	
	
	@Select("select * from (select * from todaycolor where maincolor_code1 = #{color} order by dbms_random.value ) where rownum <=1")
	TodayColor choiceTodayColor(String color);
	
	@Select("select * from todayColor where cid = #{cid}")
	TodayColor searchTodayColor(int cid);

	@Select("select * from todayColor where color_code2 = #{color_code2}")
	TodayColor getAllColorCode2(String color_code2);
}
