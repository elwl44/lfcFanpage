<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.controller.usr.MemberController"%>
<link rel="stylesheet" type="text/css" href="/resource/info-modify.css">
<head>

</head>
<body>
	<section class="section-join row">
		<div class="join-title">
			<h1 class="con">회원 정보 수정</h1>
		</div>

		<script>
		
			var joinFormSubmitDone = false;
			function joinFormSubmit(form) {
				if (joinFormSubmitDone) {
					alert('처리중입니다.');
					return;
				}
				
				form.loginId.value = form.loginId.value.trim();
				if (form.loginId.value.length == 0) {
					alert('아이디를 입력해주세요.');
					form.loginId.focus();
					return;
				}
				form.name.value = form.name.value.trim();
				if (form.name.value.length == 0) {
					alert('이름을 입력해주세요.');
					form.name.focus();
					return;
				}
				form.email.value = form.email.value.trim();
				if (form.email.value.length == 0) {
					alert('이메일을 입력해주세요.');
					form.email.focus();
					return;
				}
				
				$("#email").attr('disabled', false);
				form.submit();
				joinFormSubmitDone = true;
			}			

		</script>
		<form action="doModify" enctype="multipart/form-data" class="modify-form" onsubmit="joinFormSubmit(this); return false;">
		<input type="text" name="checkLoginPwAuthCode"
		value="${param.checkLoginPwAuthCode}" />
			<div class="test">
				<p class="modify-name cell">아이디:</p>
				<input type="text" maxlength="30" name="loginId" class="login-data"
					disabled="true" value="${member.loginId }" />
			</div>
			<div>
				<p class="modify-name cell">이름:</p>
				<input type="text" maxlength="30" name="name" class="modify-data" value="${member.name }"/>
			</div>
			<div>
				<p class="modify-name cell">이메일:</p>
				<input type="text" maxlength="30" name="email" class="modify-data" value="${member.email }" />
			</div>
			<div class="edit-btn">
				<div class="cell">
					<input class="modify-btn" type="submit" value="수정">
				</div>
				<div class="cell">
					<input class="cancel-btn" type="button" value="취소" onclick="javascript:history.back(-1)">
				</div>
			</div>

		</form>

	</section>
	</body>

<%@include file="../part/footer.jsp"%>