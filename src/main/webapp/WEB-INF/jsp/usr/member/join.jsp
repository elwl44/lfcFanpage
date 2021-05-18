<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.controller.usr.MemberController"%>
<link rel="stylesheet" type="text/css" href="/resource/join.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<head>

</head>
<body>

	<section class="section-join row">
		<div class="join-title">
			<h1 class="con">회원가입</h1>
		</div>

		<script>
		
			var joinFormSubmitDone = false;
			function joinFormSubmit(form) {
				 if($("#check-btn").is(".active")) {
					 alert('아이디 중복체크 해주세요.');
					 $("#loginId").focus();
						return;
				 }
				 if($("#email-check-btn").is(".active")) {
					 alert('이메일 중복체크 해주세요.');
					 $("#email").focus();
						return;
				 }
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
				
				$("#loginId").attr('disabled', false);
				$("#email").attr('disabled', false);
				
				form.loginPw.value = sha256(form.loginPw.value);
				form.loginPwConfirm.value = '';
				
				form.submit();
				joinFormSubmitDone = true;
			}


			function fn_idCheck(form) {
				var loginId=form.loginId.value;
				
				if (loginId.length == 0) {
					alert('아이디를 입력해주세요.');
					$("#loginId").focus();
					return;
				}
				$.ajax({
					url : "${root}idCheck",
					type : "post",
					dataType : "json",
					data : { "loginId" : loginId},
					success : function(data) {
						if(data == false) {
							alert("중복된 아이디 입니다.");
							$("#loginId").focus();
						} else if(data == true) {
							var message = "사용가능한 아이디 입니다. 사용하시겠습니까?";
							result = window.confirm(message);
							if(result){		//수락버튼
								 $("#loginId").css('backgroundColor', '#E2E2E2');
								 $("#loginId").attr('disabled', true);
								 $("#check-btn").removeClass("active");
								 $("#check-btn").attr('disabled', true);
						    }else{								//취소버튼
						    	$("#loginId").focus();
						    	return;
						    }
						}
					}
				})
			}
			
			function fn_emailCheck(form) {
				var email=form.email.value;
				
				if (email.length == 0) {
					alert('이메일을 입력해주세요.');
					$("#email").focus();
					return;
				}
				$.ajax({
					url : "${root}emailCheck",
					type : "post",
					dataType : "json",
					data : { "email" : email},
					success : function(data) {
						if(data == 0) {
							alert("중복된 이메일 입니다.");
							$("#email").focus();
						} else if(data == 1) {
							var message = "사용가능한 이메일 입니다. 사용하시겠습니까?";
							result = window.confirm(message);
							if(result){		//수락버튼
								 $("#email").css('backgroundColor', '#E2E2E2');
								 $("#email").attr('disabled', true);
								 $("#email-check-btn").removeClass("active");
								 $("#email-check-btn").attr('disabled', true);
						    }else{								//취소버튼
						    	$("#email").focus();
						    	return;
						    }
						}else if(data == 2) {
							alert("사용 정지당한 이메일 입니다.");
							$("#email").focus();
						}
					}
				})
			}
		</script>

		<form action="doJoin" class="join-form"
			onsubmit="joinFormSubmit(this); return false;" id="loginform">
			<div class="join-bundle">
				<p class="join-name cell">아이디:</p>
				<input type="text" maxlength="30" placeholder="아이디 입력"
					name="loginId" class="join-data" id="loginId" />

				<input class="check-btn active" id="check-btn" type="button"
					value="중복체크" onclick="fn_idCheck(loginform)" >
			</div>
			<div class="join-bundle">
				<p class="join-name cell">비밀번호:</p>
				<input type="password" maxlength="30" placeholder="비밀번호 입력"
					name="loginPw" class="join-data cell" />
				<div class="empty-form cell"></div>
			</div>
			<div class="join-bundle">
				<p class="join-name cell">비밀번호 확인:</p>
				<input type="password" maxlength="30" placeholder="비밀번호 확인"
					name="loginPwConfirm" class="join-data" />
				<div class="empty-form cell"></div>
			</div>
			<div class="join-bundle">
				<p class="join-name cell">이름:</p>
				<input type="text" maxlength="30" placeholder="이름 입력" name="name"
					class="join-data" />
				<div class="empty-form cell"></div>
			</div>
			<div class="join-bundle">
				<p class="join-name cell">이메일:</p>
				<input type="text" maxlength="30" placeholder="이메일 주소 입력"
					name="email" class="join-data" id="email"/>
				<input class="email-check-btn active" id="email-check-btn" type="button" value="중복체크" onclick="fn_emailCheck(loginform)">
			</div>
			<div class="edit-btn">
				<div class="cell">
					<input class="join-btn" type="submit" value="가입" id="join">
				</div>
				<div class="cell">
					<input class="cancel-btn" type="button" value="취소" onclick="javascript:history.back(-1)">
				</div>
			</div>
		</form>
	</section>
</body>

<%@include file="../part/footer.jsp"%>