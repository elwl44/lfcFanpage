<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.controller.usr.MemberController"%>
<link rel="stylesheet" type="text/css"
	href="/resource/changeLoginPw.css">
<head>

</head>
<body>

	<section class="section-join row">
		<div class="change-title">
			<h1 class="con">비밀번호 변경</h1>
		</div>

		<script>
			var joinFormSubmitDone = false;
			function joinFormSubmit(form) {
				if ($("#check-btn").is(".active")) {
					alert('아이디 중복체크 해주세요.');
					$("#loginId").focus();
					return;
				}
				if ($("#check-btn").is(".active")) {
					alert('이메일 중복체크 해주세요.');
					$("#email").focus();
					return;
				}
				if (joinFormSubmitDone) {
					alert('처리중입니다.');
					return;
				}
				form.loginPw.value = form.loginPw.value.trim();
				if (form.loginPw.value.length == 0) {
					alert('비밀번호를 입력해주세요.');
					form.loginPw.focus();
					return;
				}
				form.newloginPw.value = form.newloginPw.value.trim();
				if (form.newloginPw.value.length == 0) {
					alert('새 비밀번호를 입력해주세요.');
					form.newloginPw.focus();
					return;
				}
				form.newloginPwConfirm.value = form.newloginPwConfirm.value.trim();
				if (form.newloginPwConfirm.value.length == 0) {
					alert('새 비밀번호 확인을 입력해주세요.');
					form.newloginPwConfirm.focus();
					return;
				}
				
				if (form.newloginPw.value != form.newloginPwConfirm.value) {
					alert('패스워드가 일치하지않습니다.');
					form.newloginPwConfirm.focus();
					return;
				}
				$("#loginId").attr('disabled', false);
				form.submit();
				joinFormSubmitDone = true;
			}
		</script>

		<form action="doChangeLoginPw" class="change-form"
			onsubmit="joinFormSubmit(this); return false;" id="loginform">
			<div class="edit">
				<p class="change-name cell">아이디:</p>
				<input type="text" maxlength="30" placeholder="아이디 입력"
					name="loginId" class="join-data" id="loginId" disabled="disabled" value="${requestScope.loginedMember.loginId }"/>
			</div>
			<div class="edit">
				<p class="change-name cell">현재 비밀번호:</p>
				<input type="password" maxlength="30" placeholder="비밀번호 입력"
					name="loginPw" class="join-data" />
			</div>
			<div class="edit">
				<p class="change-name cell">새 비밀번호:</p>
				<input type="password" maxlength="30" placeholder="비밀번호 입력"
					name="newloginPw" class="join-data" />
			</div>
			<div class="edit">
				<p class="change-name cell">새 비밀번호 확인:</p>
				<input type="password" maxlength="30" placeholder="비밀번호 확인"
					name="newloginPwConfirm" class="join-data" />
			</div>
			<div class="edit-btn">
				<div class="cell">
					<input class="change-btn" type="submit" value="변경" id="join">
				</div>
				<div class="cell">
					<input class="cancel-btn" type="button" value="취소"
						onclick="javascript:history.back(-1)">
				</div>
			</div>
		</form>
	</section>
</body>

<%@include file="../part/footer.jsp"%>