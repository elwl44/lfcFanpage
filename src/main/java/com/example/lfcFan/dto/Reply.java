package com.example.lfcFan.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	private String relTypeCode;
	private int relId;
	private int memberId;
	private String body;
	private String time;
	
	private Map<String, Object> extra;
	private String extra__profileImg;
}
