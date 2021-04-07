<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resource/join.css">
<body>

	<section class="section-join row">
		<div class="join-title">
			<h1 class="con">회원가입</h1>
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
				form.loginPw.value = form.loginPw.value.trim();
				if (form.loginPw.value.length == 0) {
					alert('비밀번호를 입력해주세요.');
					form.loginPw.focus();
					return;
				}
				form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
				if (form.loginPw.value != form.loginPwConfirm.value) {
					alert('패스워드가 일치하지않습니다.');
					form.loginPwConfirm.focus();
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
				joinFormSubmitDone = true;
			}
		</script>
		
		<form action="doJoin" enctype="multipart/form-data" class="join-form" onsubmit="joinFormSubmit(this); return false;">
		
			<div class="test">
				<p class="join-name cell">아이디:</p>
				<input type="text" maxlength="30" placeholder="아이디 입력"
					name="loginId" class="join-data" />
				<input class="check-btn" type="button" value="중복체크" accesskey="s">
			</div>
			<div>
				<p class="join-name cell">비밀번호:</p>
				<input type="password" maxlength="30" placeholder="비밀번호 입력"
					name="loginPw" class="join-data" />
			</div>
			<div>
				<p class="join-name cell">비밀번호 확인:</p>
				<input type="password" maxlength="30" placeholder="비밀번호 확인"
					name="loginPwConfirm" class="join-data" />
			</div>
			<div>
				<p class="join-name cell">이름:</p>
				<input type="text" maxlength="30" placeholder="이름 입력" name="name"
					class="join-data" />
			</div>
			<div>
				<p class="join-name cell">이메일:</p>
				<input type="text" maxlength="30" placeholder="이메일 주소 입력"
					name="email" class="join-data" />
				<input class="check-btn" type="button" value="중복체크" accesskey="s">
			</div>
			<div class="edit-btn">
				<div class="cell">
					<input class="join-btn" type="submit" value="가입" accesskey="s">
				</div>
				<div class="cell">
					<input class="cancel-btn" type="submit" value="취소" accesskey="s">
				</div>
			</div>
		</form>
	</section>
</body>

<%@include file="../part/footer.jsp"%>