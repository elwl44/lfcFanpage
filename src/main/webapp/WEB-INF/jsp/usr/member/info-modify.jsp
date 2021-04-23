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
	<c:set var="fileInputMaxCount" value="1" />
	<script>
		ArticleAdd__fileInputMaxCount = parseInt("${fileInputMaxCount}");
	</script>
	<section class="section-join row">
		<div class="join-title">
			<h1 class="con">회원 정보 수정</h1>
		</div>
		<script type="text/javascript">
			function readURL(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();

					reader.onload = function(e) {
						$('#profile_picture').css(
								'background',
								'transparent url(' + e.target.result
										+ ') no-repeat');
					}
					reader.readAsDataURL(input.files[0]);
				}
			}
		</script>
		<script>
			ArticleAdd__submited = false;
			function ArticleAdd__checkAndSubmit(form) {
				if (ArticleAdd__submited) {
					alert('처리중입니다.');
					return;
				}

				var maxSizeMb = 50;
				var maxSize = maxSizeMb * 1024 * 1024;
				const input = form["file__profile__0__common__attachment__1"];

				if (input.value) {
					if (input.files[0].size > maxSize) {
						alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
						input.focus();

						return;
					}
				}

				const startSubmitForm = function(data) {
					if (data && data.body && data.body.genFileIdsStr) {
						form.genFileIdsStr.value = data.body.genFileIdsStr;
					}

					const input = form["file__profile__0__common__attachment__1"];
					input.value = '';
					form.submit();
				};
				const startUploadFiles = function(onSuccess) {
					var needToUpload = false;

					needToUpload = true;
					if (needToUpload == false) {
						onSuccess();
						return;
					}

					var fileUploadFormData = new FormData(form);

					$.ajax({
						url : '/common/genFile/doUpload',
						data : fileUploadFormData,
						processData : false,
						contentType : false,
						dataType : "json",
						type : 'POST',
						success : onSuccess
					});
				}
				ArticleAdd__submited = true;
				startUploadFiles(startSubmitForm);
			}
		</script>

		<form action="doModify" enctype="multipart/form-data"
			class="modify-form"
			onsubmit="ArticleAdd__checkAndSubmit(this); return false;"
			method="POST">
			<input type="hidden" name="checkLoginPwAuthCode"
				value="${param.checkLoginPwAuthCode}" />
			<input type="hidden" name="genFileIdsStr" value="" />
			<div class="profile-form">
				<p id="profile_picture" class="profile_picture"
					style="background-image: url(/bbs/wc1765118.jpg)"></p>
				<h3>프로필 사진 변경</h3>
				<input type="file" name="file__profile__0__common__attachment__1"
					class="picture" accept="image/gif, image/jpeg" maxlength="255"
					onchange="readURL(this);">
			</div>
			<div class="test">
				<p class="modify-name cell">아이디:</p>
				<input type="text" maxlength="30" name="loginId" class="login-data"
					disabled="true" value="${member.loginId }" />
			</div>
			<div class="test">
				<p class="modify-name cell">이름:</p>
				<input type="text" maxlength="30" name="name" class="modify-data"
					value="${member.name }" />
			</div>
			<div class="test">
				<p class="modify-name cell">이메일:</p>
				<input type="text" maxlength="30" name="email" class="modify-data"
					value="${member.email }" />
			</div>
			<div class="edit-btn">
				<div class="cell">
					<input class="modify-btn" type="submit" value="수정">
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