package com.example.lfcFan.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.lfcFan.dto.Member;
import com.example.lfcFan.service.MemberService;
import com.example.lfcFan.util.Util;

@Component("beforeActionInterceptor")
public class BeforeActionInterceptor implements HandlerInterceptor{
	@Autowired
	private MemberService memberService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		boolean isAjax = false;
		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;
		boolean isAdmin = false;
		
		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = memberService.getMemberById(loginedMemberId);
			isAdmin = memberService.isAdmin(loginedMember);
		}

		request.setAttribute("isAjax", isAjax);
		request.setAttribute("isLogined", isLogined);
		request.setAttribute("loginedMemberId", loginedMemberId);
		request.setAttribute("loginedMember", loginedMember);
		
		String currentUri = request.getRequestURI();

		if (request.getQueryString() != null) {
			currentUri += "?" + request.getQueryString();
		}

		String encodedCurrentUri = Util.getUriEncoded(currentUri);

		request.setAttribute("isAdmin", isAdmin);
		request.setAttribute("currentUri", currentUri);
		request.setAttribute("encodedCurrentUri", encodedCurrentUri);

		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
