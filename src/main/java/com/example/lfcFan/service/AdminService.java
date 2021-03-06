package com.example.lfcFan.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.AdminDao;
import com.example.lfcFan.dao.ArticleDao;
import com.example.lfcFan.dto.BanMember;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.util.Util;

@Service
public class AdminService {
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private MemberService memberService;
	
	public void addbanMemberById(List<String> _members, Map<String, Object> param) {
		for (String id : _members) {
			param.put("id", id);
			String email=memberService.getEmailById(id);
			param.put("email", email);
			adminDao.addbanMemberById(param);
		}
	}

	public List<BanMember> getForPrintBanMembers() {
		return adminDao.getForPrintBanMembers();
	}

	public void stopbanMemberById(List<String> membersId, Map<String, Object> param) {
		for (String id : membersId) {
			param.put("id", id);
			adminDao.stopbanMemberById(param);
		}
	}

	public void addkickMemberById(List<String> membersId, Map<String, Object> param) {
		for (String id : membersId) {
			param.put("id", id);
			String email=memberService.getEmailById(id);
			param.put("email", email);
			adminDao.addkickMemberById(param);
		}
	}
	
	public void ableJoinById(List<String> membersId, Map<String, Object> param) {
		for (String id : membersId) {
			param.put("id", id);
			adminDao.ableJoinById(param);
		}
	}

	public void doUnAbleJoin(List<String> memberId, Map<String, Object> param) {
		for (String id : memberId) {
			param.put("id", id);
			adminDao.doUnAbleJoin(param);
		}
	}

}
