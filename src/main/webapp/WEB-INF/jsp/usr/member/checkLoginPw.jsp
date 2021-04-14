<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.controller.usr.MemberController"%>
<link rel="stylesheet" type="text/css" href="/resource/checkLoginPw.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	var checkLoginPwFormSubmitDone = false;
	function checkLoginPwFormSubmit(form) {
		if (checkLoginPwFormSubmitDone) {
			alert('처리중입니다.');
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('로그인 비번을 입력해주세요.');
			form.loginPw.focus();
			return;
		}
		form.loginPw.value = sha256(form.loginPw.value);
		form.submit();
		checkLoginPwFormSubmitDone = true;
	}
</script>
<section class="section-check row">
	<div class="check-title">
		<h1 class="con">본인 확인</h1>
	</div>
	<form action="doCheckLoginPw" method="POST" class="check-form"
		onsubmit="checkLoginPwFormSubmit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/member/info">
		<div class="edit">
			<p class="check-name cell">비밀번호:</p>
			<input type="password" maxlength="30" placeholder="비밀번호 입력"
				name="loginPw" class="check-data" />
		</div>
			<div class="edit-btn">
				<div class="cell">
					<input class="check-btn" type="submit" value="확인" id="check">
				</div>
			</div>
	</form>
</section>
<%@include file="../part/footer.jsp"%>