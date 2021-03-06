package com.example.lfcFan.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.lfcFan.dto.BanMember;
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

	int getTotalMemberCount(Map<String, Object> param);

	List<Member> getForPrintMembers(Map<String, Object> param);

	void setMemberLoginTime(int id);

	void banDateCheck();

	int getMemberBanCheck(int memberid);

	String getMemberBanDate(int memberid);

	List<BanMember> getForPrintBanMembers(Map<String, Object> param);

	int getTotalBanMemberCount(Map<String, Object> param);

	String getEmailById(String id);

	List<BanMember> getForPrintKickBanMembers(Map<String, Object> param);

	void appointStaff(int id);
	
	void removeStaff(int id);

	int getTotalStaffMemberCount(Map<String, Object> param);

	List<Member> getForPrintStaffMembers(Map<String, Object> param);

	BanMember getKickMemberById(int id);

}
