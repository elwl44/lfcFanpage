package com.example.lfcFan.dto;

import java.util.HashMap;
import java.util.Map;

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
	
	private Map<String, Object> extra;
	public Map<String, Object> getExtraNotNull() {
		if ( extra == null ) {
			extra = new HashMap<String, Object>();
		}

		return extra;
	}
}
