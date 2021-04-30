package com.example.lfcFan.dto;

import java.util.HashMap;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BanMember {
	int id;
	int memberid;
	String startDate;
	String updateDate;
	String finishDate;
	int status;
	String body;
	String staff;
	private Map<String, Object> extra;
	public Map<String, Object> getExtraNotNull() {
		if ( extra == null ) {
			extra = new HashMap<String, Object>();
		}

		return extra;
	}
}
