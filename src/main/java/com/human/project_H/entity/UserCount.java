package com.human.project_H.entity;



public class UserCount {
	
	@Override
	public String toString() {
		return "UserCount [mainColor_name=" + mainColor_name + ", mainColor_code1=" + mainColor_code1 + ", color_Count="
				+ color_Count + "]";
	}



	public UserCount() {}
	

	public String getMainColor_name() {
		return mainColor_name;
	}



	public void setMainColor_name(String mainColor_name) {
		this.mainColor_name = mainColor_name;
	}



	public String getMainColor_code1() {
		return mainColor_code1;
	}



	public void setMainColor_code1(String mainColor_code1) {
		this.mainColor_code1 = mainColor_code1;
	}



	public int getColor_Count() {
		return color_Count;
	}



	public void setColor_Count(int color_Count) {
		this.color_Count = color_Count;
	}


	private String mainColor_name;
	private String mainColor_code1;
	private int color_Count;
	
	

	public UserCount(String mainColor_name, String mainColor_code1, int color_Count) {

		this.mainColor_name = mainColor_name;
		this.mainColor_code1 = mainColor_code1;
		this.color_Count = color_Count;
	}
	
	
	
}
