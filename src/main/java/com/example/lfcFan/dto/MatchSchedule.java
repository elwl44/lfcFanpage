package com.example.lfcFan.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MatchSchedule {
	String name;
	String date;
	String month;
	String round;
	String venue;
	String stadium;
}
