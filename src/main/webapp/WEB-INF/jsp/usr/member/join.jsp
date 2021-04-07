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

		<form action="doJoin" enctype="multipart/form-data" class="join-form">
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
					name="loginPw" class="join-data" />
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