package com.example.lfcFan.dto;

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
}
