<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="title" value="회원 로그인비번 찾기" />
<%@ include file="../part/head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resource/findLoginPw.css">
<script>
	$(document).ready(function() {
	    $('#loginId').val('${select_id}');
	});
	
	var findLoginPwFormSubmitDone = false;
	function findLoginPwFormSubmit(form) {
		if (findLoginPwFormSubmitDone) {
			alert('처리중입니다.');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('로그인 아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요. 입력해주세요.');
			form.email.focus();
			return;
		}
		form.submit();
		findLoginPwFormSubmitDone = true;
	}
</script>
<section class="section-findLoginPw row">
	<div class="find-title">
		<h1 class="con">비밀번호 찾기</h1>
	</div>
	<form action="doFindLoginPw" method="POST" class="find-form"
		onsubmit="findLoginPwFormSubmit(this); return false;">
		<div class="edit">
			<p class="find-name cell">아이디:</p>
			<input type="text" maxlength="30" placeholder="아이디 입력" name="loginId"
				class="find-data" id="loginId" />
		</div>
		<div class="edit">
			<p class="find-name cell">이메일:</p>
			<input type="text" maxlength="30" placeholder="이메일 주소 입력"
				name="email" class="find-data" id="email" />
		</div>
		<div class="edit-btn">
			<div class="cell">
				<input class="find-btn" type="submit" value="찾기" id="find">
			</div>
			<div class="cell">
				<input class="cancel-btn" type="button" value="취소"
					onclick="javascript:history.back(-1)">
			</div>
		</div>
	</form>
</section>

<%@ include file="../part/footer.jsp"%>