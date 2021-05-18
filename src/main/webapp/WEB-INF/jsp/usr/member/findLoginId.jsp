<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.controller.usr.MemberController"%>
<link rel="stylesheet" type="text/css" href="/resource/join.css?after1">
<head>

</head>
<body>

	<section class="section-join row">
		<div class="join-title">
			<h1 class="con">아이디 찾기</h1>
		</div>

		<script>
			var findFormSubmitDone = false;
			function FindFormSubmit(form) {
				if (findFormSubmitDone) {
					alert('처리중입니다.');
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
				
				form.submit();
				findFormSubmitDone = true;
			}
		</script>

		<form action="doFindLoginId" class="join-form"
			onsubmit="FindFormSubmit(this); return false;" id="loginform">
			<div class="join-bundle">
				<p class="join-name cell">이름:</p>
				<input type="text" maxlength="30" placeholder="이름 입력" name="name"
					class="join-data" />
			</div>
			<div class="join-bundle">
				<p class="join-name cell">이메일:</p>
				<input type="text" maxlength="30" placeholder="이메일 주소 입력"
					name="email" class="join-data" id="email"/>
			</div>
			<div class="edit-btn">
				<div class="cell">
					<input class="join-btn" type="submit" value="찾기" id="join">
				</div>
				<div class="cell">
					<input class="cancel-btn" type="button" value="취소" onclick="javascript:history.back(-1)">
				</div>
			</div>
		</form>
	</section>
</body>

<%@include file="../part/footer.jsp"%>