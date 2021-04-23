package com.example.lfcFan.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.lfcFan.dto.Member;

@Mapper
public interface MemberDao {
	void join(Map<String, Object> param);

	Member getMemberByLoginId(@Param("loginId") String loginId);
	
	Member getMemberByEmail(@Param("email") String email);

	Member getMemberByNameAndEmail(@Param("name") String name, @Param("email") String email);
	
	Member getMemberById(@Param("id") int id);

	void modify(Map<String, Object> param);

	void modifyPw(Map<String, Object> param);

	void secessionById(@Param("id") int id);
}
