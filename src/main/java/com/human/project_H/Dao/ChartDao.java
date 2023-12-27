package com.human.project_H.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.human.project_H.entity.HitCount;
import com.human.project_H.entity.SelcColor;
import com.human.project_H.entity.Sentiment;

@Mapper
public interface ChartDao {
	
	@Select("select sentiment as senticat, count(*) senticnt from user_sentiment group by sentiment")
	public List<Sentiment> getSentiment();
	
	@Select("select tc.maincolor_name colorName, tc.maincolor_code1 colorCode, count(*) selectCnt "
			+ "from usercolor uc "
			+ "join todaycolor tc on uc.cid = tc.cid "
			+ "group by tc.maincolor_name, tc.maincolor_code1")
	public List<SelcColor> selctColor();
	
	@Select("select chitId, shit "
			+ "from (select custid as chitId, sum(hitcount) shit "
			+ "from board group by custid order by shit desc) "
			+ "where rownum < 11")
	public List<HitCount> getHitCnt();
}
