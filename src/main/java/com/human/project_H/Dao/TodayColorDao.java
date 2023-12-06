package com.human.project_H.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.human.project_H.entity.TodayColor;

@Mapper
public interface TodayColorDao {

	@Select("SELECT * FROM todaycolor WHERE maincolor_name = #{maincolorName} AND maincolor_code1 = #{maincolorCode1} AND color_code2 = #{colorCode2}")
	List<TodayColor> getTodayColorList(@Param("maincolorName") String maincolorName, 
	                                   @Param("maincolorCode1") String maincolorCode1,
	                                   @Param("colorCode2") String colorCode2);

}