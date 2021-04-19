package com.example.lfcFan.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class League {
	private int id;
	private int lanking;
	private String name;
	private int game;
	private int point;
	private int win;
	private int draw;
	private int lose;
	private int gainGoal;
	private int loseGoal;
	private int goalGap;
}
