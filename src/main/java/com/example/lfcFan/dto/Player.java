package com.example.lfcFan.dto;

import java.util.HashMap;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Player {
	private int id;
	private String regDate;
	private String updateDate;
	private String firstName;
	private String lastName;
	private int backNumber;
	private String position;
	private String nationality;
	private int height;
	private int weight;
	private String dateofBirth;
	
	private Map<String, Object> extra;
	private String extra__thumbImg;
	public Map<String, Object> getExtraNotNull() {
		if ( extra == null ) {
			extra = new HashMap<String, Object>();
		}

		return extra;
	}
}
