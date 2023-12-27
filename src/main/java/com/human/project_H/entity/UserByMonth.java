package com.human.project_H.entity;

public class UserByMonth {

	private int month;
	private int numberOfPerson;
	
	public UserByMonth(int month, int numberOfPerson) {
		this.month = month;
		this.numberOfPerson = numberOfPerson;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getNumberOfPerson() {
		return numberOfPerson;
	}

	public void setNumberOfPerson(int numberOfPerson) {
		this.numberOfPerson = numberOfPerson;
	}

	@Override
	public String toString() {
		return "UserByMonth [month=" + month + ", numberOfPerson=" + numberOfPerson + "]";
	}
	
}
