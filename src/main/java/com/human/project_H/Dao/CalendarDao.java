package com.human.project_H.Dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.human.project_H.entity.ColorByDay;

@Mapper
public interface CalendarDao {
	
	@Select("select maincolor_name, maincolor_code1 from todaycolor"
			+ "    where cid = (select cid from usercolor"
			+ "    where custid like #{custId} and to_char(modTime, 'YYYY-MM-DD')=#{date})")
	Map<String, String> getColorCode(String custId, String date);
	
	@Select("select positive_score, neutral_score, negative_score from user_sentiment"
			+ "    where custid like #{custId} and to_char(modtime, 'YYYY-MM-DD')=#{date}")
	Map<String, Double> getEmotion(String custId, String date);
	
	@Select("select content from usercolor"
			+ "    where custid like #{custId} and to_char(modtime, 'YYYY-MM-DD')=#{date}")
	String getContent(String custId, String date);
	
	@Select("select tc.maincolor_name colorName, tc.maincolor_code1 colorCode, count(uc.cid) colorCount"
			+ "    from usercolor uc"
			+ "    join todaycolor tc on uc.cid = tc.cid"
			+ "    where to_char(modtime, 'YYYY-MM-DD')=#{date}"
			+ "    group by tc.maincolor_name, tc.maincolor_code1 order by colorCount desc")
	List<ColorByDay> getDayColor(String date);
}
