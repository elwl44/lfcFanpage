package com.example.lfcFan.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminDao {

	void addbanMemberById(Map<String, Object> param);
	
}
