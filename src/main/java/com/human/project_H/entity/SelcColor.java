package com.human.project_H.entity;

public class SelcColor {
	
	private String colorName;
	private String colorCode;
	private int selectCnt;
	
	public SelcColor() { }

	public SelcColor(String colorName, String colorCode, int selectCnt) {
		this.colorName = colorName;
		this.colorCode = colorCode;
		this.selectCnt = selectCnt;
	}

	public String getColorName() {
		return colorName;
	}

	public void setColorName(String colorName) {
		this.colorName = colorName;
	}

	public String getColorCode() {
		return colorCode;
	}

	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}

	public int getSelectCnt() {
		return selectCnt;
	}

	public void setSelectCnt(int selectCnt) {
		this.selectCnt = selectCnt;
	}

	@Override
	public String toString() {
		return "SelcColor [colorName=" + colorName + ", colorCode=" + colorCode + ", selectCnt=" + selectCnt + "]";
	}
	
}
