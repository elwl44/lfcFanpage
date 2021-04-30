package com.example.lfcFan.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.lfcFan.dao.MemberDao;
import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.BanMember;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.dto.ResultData;
import com.example.lfcFan.util.Util;

@Service
public class MemberService {
	@Value("${custom.siteName}")
	private String siteName;

	@Value("${custom.siteMainUri}")
	private String siteMainUri;

	@Value("${custom.siteUrl}")
	private String siteUrl;

	@Value("${custom.siteLoginUri}")
	private String siteLoginUri;

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MailService mailService;

	@Autowired
	private AttrService attrService;

	@Autowired
	private GenFileService genFileService;

	@Autowired
	private ArticleService articleService;

	@Autowired
	private ReplyService replyeService;

	public int join(Map<String, Object> param) {
		memberDao.join(param);

		int id = Util.getAsInt(param.get("id"));

		String authCode = genEmailAuthCode(id);

		sendJoinCompleteMail(id, (String) param.get("email"), authCode);

		return id;
	}

	private String genEmailAuthCode(int actorId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + actorId + "__extra__emailAuthCode", authCode);

		return authCode;
	}

	private void sendJoinCompleteMail(int actorId, String email, String authCode) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다. 이메일인증을 진행해주세요.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append("<div>아래 인증코드를 클릭하여 이메일인증을 마무리 해주세요.</div>");

		String doAuthEmailUrl = siteUrl + "/usr/member/doAuthEmail?authCode=" + authCode + "&email=" + email
				+ "&actorId=" + actorId;
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">인증하기</a></p>", doAuthEmailUrl));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}

	public boolean isJoinAvailableLoginId(String loginId) {
		Member member = memberDao.getMemberByLoginId(loginId);

		if (member == null) {
			return true;
		}

		return false;
	}

	public boolean isJoinAvailableEmail(String email) {
		Member member = memberDao.getMemberByEmail(email);

		if (member == null) {
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
		int id = Util.getAsInt(param.get("id"));
		changeInputFileRelIds(param, id);
		if (Util.getAsInt(param.get("del_picture"), 0) == 1) {
			genFileService.deleteGenFiles("profile", id);
		}
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}

	public ResultData setTempPasswordAndNotify(Member member) {
		Random r = new Random();
		String tempLoginPw = (10000 + r.nextInt(90000)) + "";

		String mailTitle = String.format("[%s] 임시 비밀번호가 발송되었습니다.", siteName);
		String mailBody = "";

		mailBody += String.format("로그인아이디 : %s<br>", member.getLoginId());
		mailBody += String.format("임시 비밀번호 : %s", tempLoginPw);
		mailBody += "<br>";
		mailBody += String.format("<a href=\"%s\" target=\"_blank\">로그인 하러가기</a>", siteLoginUri);

		ResultData sendResultData = mailService.send(member.getEmail(), mailTitle, mailBody);

		if (sendResultData.isFail()) {
			return new ResultData("F-1", "메일발송에 실패했습니다.");
		}

		Map<String, Object> modifyParam = new HashMap<>();
		modifyParam.put("loginPw", Util.sha256(tempLoginPw));
		modifyParam.put("id", member.getId());
		memberDao.modify(modifyParam);

		return new ResultData("S-1", "임시 패스워드를 메일로 발송하였습니다.");
	}

	public void modifyPw(Map<String, Object> param) {
		memberDao.modifyPw(param);
	}

	public String genCheckLoginPwAuthCode(int actorId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + actorId + "__extra__modifyPrivateAuthCode", authCode,
				Util.getDateStrLater(60 * 60));

		return authCode;
	}

	public ResultData checkValidCheckLoginPwAuthCode(int actorId, String checkLoginPwAuthCode) {
		if (attrService.getValue("member__" + actorId + "__extra__modifyPrivateAuthCode")
				.equals(checkLoginPwAuthCode)) {
			return new ResultData("S-1", "유효한 키 입니다.");
		}

		return new ResultData("F-1", "유효하지 않은 키 입니다.");
	}

	public String getEmailAuthCode(int actorId) {
		return attrService.getValue("member__" + actorId + "__extra__emailAuthCode");
	}

	public void saveAuthedEmail(int actorId, String email) {
		attrService.setValue("member__" + actorId + "__extra__authedEmail", email);
	}

	public String getAuthedEmail(int actorId) {
		return attrService.getValue("member__" + actorId + "__extra__authedEmail");
	}

	private void changeInputFileRelIds(Map<String, Object> param, int id) {
		String genFileIdsStr = Util.ifEmpty((String) param.get("genFileIdsStr"), null);

		if (genFileIdsStr != null) {
			List<Integer> genFileIds = Util.getListDividedBy(genFileIdsStr, ",");

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int genFileId : genFileIds) {
				genFileService.changeRelId(genFileId, id);
			}
		}
	}

	public boolean isAdmin(Member actor) {
		return actor.getAuthLevel() == 7;
	}

	public void secessionById(HttpSession session, int memberid, List<Article> articles) {
		genFileService.deleteGenFiles("profile", memberid);
		for (Article article : articles) {
			genFileService.deleteGenFiles("article", article.getId());
		}
		articleService.deleteArticlesByMemberId(memberid);
		replyeService.deleteReplysByMemberId(memberid);

		session.removeAttribute("loginedMemberId");
		session.removeAttribute("loginedMemberName");
		session.removeAttribute("isAdmin");

		memberDao.secessionById(memberid);
	}

	public int getTotalCount(Map<String, Object> param) {
		return memberDao.getTotalMemberCount(param);
	}

	public List<Member> getForPrintMembers(Map<String, Object> param) {
		int page = Util.getAsInt(param.get("page"), 1);

		// 한 리스트에 나올 수 있는 게시물 게수
		int itemsCountInAPage = Util.getAsInt(param.get("itemsCountInAPage"), 10);

		if (itemsCountInAPage > 100) {
			itemsCountInAPage = 100;
		} else if (itemsCountInAPage < 1) {
			itemsCountInAPage = 1;
		}

		int limitFrom = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage;

		param.put("limitFrom", limitFrom);
		param.put("limitTake", limitTake);
		return memberDao.getForPrintMembers(param);
	}

	public void setMemberLoginTime(int id) {
		memberDao.setMemberLoginTime(id);
	}

	public void banDateCheck() {
		memberDao.banDateCheck();
	}

	public int getMemberBanCheck(int memberid) {
		return memberDao.getMemberBanCheck(memberid);
	}

	public void getMemberBanDate(int memberid, Member member) {
		String banDate=memberDao.getMemberBanDate(memberid);
		member.setBanDate(banDate);
	}

	public List<BanMember> getForPrintBanMembers(Map<String, Object> param) {
		int page = Util.getAsInt(param.get("page"), 1);

		// 한 리스트에 나올 수 있는 게시물 게수
		int itemsCountInAPage = Util.getAsInt(param.get("itemsCountInAPage"), 10);

		if (itemsCountInAPage > 100) {
			itemsCountInAPage = 100;
		} else if (itemsCountInAPage < 1) {
			itemsCountInAPage = 1;
		}

		int limitFrom = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage;

		param.put("limitFrom", limitFrom);
		param.put("limitTake", limitTake);
		return memberDao.getForPrintBanMembers(param);
	}

	public int getTotalBanMemberCount(Map<String, Object> param) {
		return memberDao.getTotalBanMemberCount(param);
	}
}
