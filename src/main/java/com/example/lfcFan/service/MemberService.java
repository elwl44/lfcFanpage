package com.example.lfcFan.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.MemberDao;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.util.Util;

@Service
public class MemberService {
	@Value("${custom.siteName}")
	private String siteName;

	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MailService mailService;

	public int join(Map<String, Object> param) {
		memberDao.join(param);

		int id = Util.getAsInt(param.get("id"));
		
		sendJoinCompleteMail((String) param.get("email"));

		return id;
	}

	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}
	
	public boolean isJoinAvailableLoginId(String loginId) {
		Member member = memberDao.getMemberByLoginId(loginId);

		if ( member == null ) {
			return true;
		}

		return false;
	}
	
	public boolean isJoinAvailableEmail(String email) {
		Member member = memberDao.getMemberByEmail(email);

		if ( member == null ) {
			return true;
		}

		return false;
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public void modify(Map<String, Object> param) {
		memberDao.modify(param);
	}
	
	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}
}
