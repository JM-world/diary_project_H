package com.human.project_H.entity;

public class ColorByDay {
	private String colorName;
	private String colorCode;
	private int colorCount;
	
	public ColorByDay() { }

	public ColorByDay(String colorName, String colorCode, int colorCount) {
		this.colorName = colorName;
		this.colorCode = colorCode;
		this.colorCount = colorCount;
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

	public int getColorCount() {
		return colorCount;
	}

	public void setColorCount(int colorCount) {
		this.colorCount = colorCount;
	}

	@Override
	public String toString() {
		return "ColorByDay [colorName=" + colorName + ", colorCode=" + colorCode + ", colorCount=" + colorCount + "]";
	}
	
}
