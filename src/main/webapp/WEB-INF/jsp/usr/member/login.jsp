<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.controller.usr.MemberController"%>
<link rel="stylesheet" type="text/css" href="/resource/login.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="section-login row">
		<div class="login-title">
			<h1 class="con">로그인</h1>
		</div>
		<script>
		var loginFormSubmitDone = false;
		function loginFormSubmit(form) {
			if (loginFormSubmitDone) {
				alert('처리중입니다.');
				return;
			}
			form.loginId.value = form.loginId.value.trim();
			if (form.loginId.value.length == 0) {
				alert('로그인 아이디를 입력해주세요.');
				form.loginId.focus();
				return;
			}
			form.loginPw.value = form.loginPw.value.trim();
			if (form.loginPw.value.length == 0) {
				alert('로그인 비번을 입력해주세요.');
				form.loginPw.focus();
				return;
			}
			form.submit();
			loginFormSubmitDone = true;
		}
	</script>
		<form action="doLogin" class="login-form" method="POST"
			onsubmit="loginFormSubmit(this); return false;">
			<div>
				<input type="text" maxlength="30" placeholder="아이디 입력"
					name="loginId" class="login-data" id="loginId" />
			</div>
			<div>
				<input type="password" maxlength="30" placeholder="비밀번호 입력"
					name="loginPw" class="login-data" />
			</div>
			<div class="edit-btn">
					<input class="login-btn" type="submit" value="로그인" id="login">
		
			</div>
		</form>
	</section>
</body>
<%@include file="../part/footer.jsp"%>