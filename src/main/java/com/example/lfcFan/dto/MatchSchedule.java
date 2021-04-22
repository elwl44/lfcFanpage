package com.example.lfcFan.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MatchSchedule {
	int id;
	String name;
	String date;
	String time;
	String month;
	String league;
	String venue;
	String stadium;
}
