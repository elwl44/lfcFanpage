package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.lfcFan.dto.BanMember;

@Mapper
public interface AdminDao {

	void addbanMemberById(Map<String, Object> param);

	List<BanMember> getForPrintBanMembers();
	
}
