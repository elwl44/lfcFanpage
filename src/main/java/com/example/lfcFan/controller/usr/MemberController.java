package com.example.lfcFan.controller.usr;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	@ResponseBody
	public String doJoin(@RequestParam Map<String, Object> param) {
		String loginId = Util.getAsStr(param.get("loginId"), "");

		if (loginId.length() == 0) {
			return String.format("<script> alert('로그인 아이디를 입력해주세요.'); history.back(); </script>");
		}
		
		boolean isJoinAvailableLoginId = memberService.isJoinAvailableLoginId(loginId);
		
		if ( isJoinAvailableLoginId == false ) {
			return String.format("<script> alert('%s(은)는 이미 사용중인 아이디 입니다.'); history.back(); </script>", loginId);
		}

		int id = memberService.join(param);

		return String.format("<script> alert('%d번 회원이 생성되였습니다.'); location.replace('/usr/article/home'); </script>",
				id);
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
	@ResponseBody
	public String doLogin(String loginId, String loginPw, HttpSession session) {
		if (loginId.length() == 0) {
			return String.format("<script> alert('로그인 아이디를 입력해주세요.'); history.back(); </script>");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return String.format("<script> alert('%s은(는) 존재하지 않는 로그인 아이디 입니다.'); history.back(); </script>", loginId);
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return String.format("<script> alert('비밀번호를 정확히 입력해주세요.'); history.back(); </script>");
		}

		session.setAttribute("loginedMemberId", member.getId());

		return String.format("<script>location.replace('/usr/article/home'); </script>",
				member.getName());
	}
}
