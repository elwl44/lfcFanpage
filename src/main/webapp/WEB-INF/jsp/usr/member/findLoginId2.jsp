<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.controller.usr.MemberController"%>
<link rel="stylesheet" type="text/css" href="/resource/findLoginId2.css">
<head>

</head>
<body>

	<section class="section-join row">
		<div class="join-title">
			<h1 class="con">아이디 찾기</h1>
		</div>

		<script>
			var findFormSubmitDone = false;
			function FindIdFormSubmit(form) {
				if (findFormSubmitDone) {
					alert('처리중입니다.');
					return;
				}
				if ($("#select0").prop("checked") == false) {
					alert('아이디를 선택해주세요.');
					$("#select0").focus();
					return;
				}

				form.submit();
				findFormSubmitDone = true;
			}
		</script>

		<form action="login" onsubmit="FindIdFormSubmit(this); return false;" id="loginform">
			<div class="section section_find">
				<div class="box6" style="text-align: center">
					<ul class="list_id">
						<li>
							<strong> <input type="radio" name="select" id="select0"
									value=""> <label for="select0" class="label_rd">${MemberId }</label>
							</strong>
							<span>가입 : ${MemberRegDate}</span>
							<input type="hidden" name="nv_id0" value="elwl45">
						</li>
					</ul>
				</div>
				<!-- 버튼 영역 -->
				<div class="btn_area">
					<div class="cell">
						<input class="join-btn" type="submit" value="로그인하기" id="join">
					</div>
					<div class="cell">
						<input class="cancel-btn" type="button" value="비밀번호 찾기"
							onclick="location.href='findLoginPw'">
					</div>
				</div>
			</div>
		</form>
	</section>
</body>

<%@include file="../part/footer.jsp"%>