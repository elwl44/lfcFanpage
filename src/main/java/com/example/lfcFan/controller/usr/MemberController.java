package com.example.lfcFan.controller.usr;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.lfcFan.dto.Member;
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
	public boolean idCheck(@RequestParam Map<String, Object> param) {
		String loginId = Util.getAsStr(param.get("loginId"), "");

		boolean isJoinAvailableLoginId = memberService.isJoinAvailableLoginId(loginId);
		
		return isJoinAvailableLoginId;
	}
	@RequestMapping("/usr/member/emailCheck")
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
		int loginedMemberId = 0;

		if (session.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}

		if (loginedMemberId == 0) {
			model.addAttribute("msg", "로그인 후 이용해주세요.");
			model.addAttribute("replaceUri", "/usr/member/login");
			return "common/redirect";
		}
		
		session.removeAttribute("loginedMemberId");
		session.removeAttribute("loginedMemberName");
		model.addAttribute("replaceUri", "/usr/article/home");
		return "common/redirect";
	}

}
