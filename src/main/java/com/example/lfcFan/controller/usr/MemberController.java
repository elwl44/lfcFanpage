package com.example.lfcFan.controller.usr;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.lfcFan.dto.Member;
import com.example.lfcFan.dto.ResultData;
import com.example.lfcFan.service.MemberService;
import com.example.lfcFan.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
		String loginId = Util.getAsStr(param.get("loginId"), "");

		if (loginId.length() == 0) {
			model.addAttribute("msg", String.format("로그인 아이디를 입력해주세요."));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		boolean isJoinAvailableLoginId = memberService.isJoinAvailableLoginId(loginId);
		
		if ( isJoinAvailableLoginId == false ) {
			model.addAttribute("msg", String.format("%s(은)는 이미 사용중인 아이디 입니다.", loginId));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		int id = memberService.join(param);

		model.addAttribute("msg", String.format("가입되었습니다."));
		model.addAttribute("replaceUri", "/usr/article/home");
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/idCheck")
	@ResponseBody
	public boolean idCheck(@RequestParam Map<String, Object> param) {
		String loginId = Util.getAsStr(param.get("loginId"), "");

		boolean isJoinAvailableLoginId = memberService.isJoinAvailableLoginId(loginId);
		
		return isJoinAvailableLoginId;
	}
	@RequestMapping("/usr/member/emailCheck")
	@ResponseBody
	public boolean emailCheck(@RequestParam Map<String, Object> param) {
		String email = Util.getAsStr(param.get("email"), "");

		boolean isJoinAvailableLoginId = memberService.isJoinAvailableEmail(email);
		
		return isJoinAvailableLoginId;
	}
	
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "usr/member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	public String doLogin(String loginId, String loginPw, HttpSession session, Model model) {
		if (loginId.length() == 0) {
			model.addAttribute("msg", String.format("로그인 아이디를 입력해주세요2."));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("msg", String.format("%s(은)는 존재하지 않는 로그인 아이디 입니다.", loginId));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("msg", String.format("비밀번호를 정확히 입력해주세요."));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		session.setAttribute("loginedMemberId", member.getId());
		session.setAttribute("loginedMemberName", member.getName());
		model.addAttribute("replaceUri", String.format("/usr/article/home"));
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/doLogout")
	public String doLogout(HttpSession session, Model model) {
		session.removeAttribute("loginedMemberId");
		session.removeAttribute("loginedMemberName");
		model.addAttribute("replaceUri", "/usr/article/home");
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/info")
	public String showinfo(Model model, HttpServletRequest req) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		model.addAttribute("member", member);
		return "usr/member/info";
	}
	
	@RequestMapping("/usr/member/modify")
	public String showModify(Model model, HttpServletRequest req) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		model.addAttribute("member", member);
		return "usr/member/info-modify";
	}

	@RequestMapping("/usr/member/doModify")
	public String doModify(Model model, HttpServletRequest req, @RequestParam Map<String, Object> param) {
		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
		param.put("id", loginedMemberId);

		// 해킹방지
		param.remove("loginId");
		param.remove("loginPw");

		memberService.modify(param);

		model.addAttribute("msg", String.format("수정되었습니다."));
		model.addAttribute("replaceUri", "/usr/article/home");
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/findLoginId")
	public String showFindLoginId() {
		return "usr/member/findLoginId";
	}
	
	@RequestMapping("/usr/member/doFindLoginId")
	public String doFindLoginId(Model model, String name, String email) {
		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			model.addAttribute("msg", String.format("해당회원은 존재하지 않습니다."));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		model.addAttribute("MemberId",  member.getLoginId());
		model.addAttribute("MemberRegDate", member.getRegDate());
		return "usr/member/findLoginId2";
	}
	
	@RequestMapping("/usr/member/findLoginPw")
	public String showFindLoginPw() {
		return "usr/member/findLoginPw";
	}

	@RequestMapping("/usr/member/doFindLoginPw")
	public String doFindLoginPw(Model model, String loginId, String email) {
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("msg", String.format("해당회원은 존재하지 않습니다."));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		if (member.getEmail().equals(email) == false) {
			model.addAttribute("msg", String.format("해당회원은 존재하지 않습니다."));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		ResultData setTempPasswordAndNotifyRsData = memberService.setTempPasswordAndNotify(member);

		model.addAttribute("msg", String.format(setTempPasswordAndNotifyRsData.getMsg()));
		model.addAttribute("replaceUri", "/usr/member/login");
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/changeLoginPw")
	public String showChangeLoginPw() {
		return "usr/member/changeLoginPw";
	}

	@RequestMapping("/usr/member/doChangeLoginPw")
	public String doChangeLoginPw(Model model, HttpServletRequest req, @RequestParam Map<String, Object> param) {
		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
		param.put("id", loginedMemberId);

		String loginId=(String) param.get("loginId");
		String loginPw=(String) param.get("loginPw");
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member.getLoginPw().equals(loginPw)==false) {
			model.addAttribute("msg", String.format("비밀번호가 일치하지 않습니다."));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		// 해킹방지
		param.remove("loginId");
		param.remove("loginPw");
		
		memberService.modifyPw(param);
		
		param.remove("newloginPw");
		
		model.addAttribute("msg", String.format("비밀번호가 변경되었습니다."));
		model.addAttribute("replaceUri", "/usr/article/home");
		return "common/redirect";
	}
}
