package com.example.lfcFan.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.MemberDao;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;

	public int join(Map<String, Object> param) {
		memberDao.join(param);

		int id = Util.getAsInt(param.get("id"));

		return id;
	}

	public boolean isJoinAvailableLoginId(String loginId) {
		Member member = memberDao.getMemberByLoginId(loginId);

		if ( member == null ) {
			return true;
		}

		return false;
	}
	
	public boolean isJoinAvailableEmail(String email) {
		Member member = memberDao.getMemberByLoginId(email);

		if ( member == null ) {
			return true;
		}

		return false;
	}
}
