package com.example.lfcFan.dto;

import java.util.HashMap;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String lastLogin;
	private int visitCount;
	private int wrtieCount;
	private String loginId;
	private String loginPw;
	private int authLevel;
	private String name;
	private String email;
	private Map<String, Object> extra;
	public Map<String, Object> getExtraNotNull() {
		if ( extra == null ) {
			extra = new HashMap<String, Object>();
		}

		return extra;
	}
	private String extra__thumbImg;
}
