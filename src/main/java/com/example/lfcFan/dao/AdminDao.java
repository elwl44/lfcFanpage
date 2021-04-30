package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.lfcFan.dto.BanMember;

@Mapper
public interface AdminDao {

	void addbanMemberById(Map<String, Object> param);

	List<BanMember> getForPrintBanMembers();

	void stopbanMemberById(Map<String, Object> param);

	void addkickMemberById(Map<String, Object> param);

	int getKickCheckByEmail(String email);

	void ableJoinById(Map<String, Object> param);

	void doUnAbleJoin(Map<String, Object> param);
	
}
