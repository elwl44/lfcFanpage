<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resource/write.css">

<c:set var="fileInputMaxCount" value="2" />
<script>
	ArticleAdd__fileInputMaxCount = parseInt("${fileInputMaxCount}");
</script>

<body>
	<script>
		ArticleAdd__fileInputMaxCount = parseInt("${fileInputMaxCount}");
	</script>
	<script>
		$(function() {
			//직접입력 인풋박스 기존에는 숨어있다가
			$("#selboxDirect").hide();
			$("#League").change(function() {
				//직접입력을 누를 때 나타남
				if ($("#League").val() == "direct") {
					$("#selboxDirect").show();
				} else {

					$("#selboxDirect").hide();
				}
			})

			$("#venue").change(function() {
				if ($("#venue").val() == "H") {
					 $('#stadium').val('Anfield');
				}
				else if($("#venue").val() == "A"){
					$('#stadium').val('');
					$('#stadium').focus();
				}
			})
		});

		var joinFormSubmitDone = false;
		function joinFormSubmit(form) {
			if (joinFormSubmitDone) {
				alert('처리중입니다.');
				return;
			}

			form.teamname.value = form.teamname.value.trim();
			if (form.teamname.value.length == 0) {
				alert('상대팀을 입력해주세요.');
				form.name.focus();
				return;
			}

			form.date.value = form.date.value.trim();
			if (form.date.value.length == 0) {
				alert('경기일을 입력해주세요.');
				form.date.focus();
				return;
			}

			form.League.value = form.League.value.trim();
			console.log(form.League.value.length);
			if (form.League.value.length == 0 && $("#League").val() != "direct") {
				alert('리그를 골라주세요.');
				form.League.focus();
				return;
			}

			form.other.value = form.other.value.trim();
			if (form.other.value.length == 0 && $("#League").val() == "direct") {
				alert('기타리그를 입력해주세요.');
				$("#selboxDirect").show();
				form.other.focus();
				return;
			}

			form.stadium.value = form.stadium.value.trim();
			if (form.stadium.value.length == 0) {
				alert('경기장을 입력해주세요.');
				form.stadium.focus();
				return;
			}
			form.submit();
			joinFormSubmitDone = true;
		}
	</script>
	<section class="section-write row">
		<div class="write-title">
			<h1 class="con">경기일정 추가</h1>
		</div>
		<form action="doWriteMatch" class="join-form"
			onsubmit="joinFormSubmit(this); return false;" id="loginform"
			enctype="multipart/form-data">
			<div>
				<input type="text" name="name" id="teamname" placeholder="상대팀"
					class="subject" value="">
				<input placeholder="경기일" class="add-file" type="text" name="date"
					onfocus="(this.type='date')" onblur="(this.type='text')" id="date" />
				<input type="time" name="time" placeholder="시작시간" value="21:00"
					class="add-file">
				<select name="League" class="add-file" id="League">
					<option value="">리그를 골라주세요</option>
					<option value="Premier League">Premier League</option>
					<option value="Champions League">Champions League</option>
					<option value="League Cup">League Cup</option>
					<option value="direct">직접입력</option>
				</select>
				<input type="text" id="selboxDirect" name="other" class="add-file"
					placeholder="기타 리그를 입력해주세요" />
				<select name="venue" class="add-file" id="venue">
					<option value="">장소</option>
					<option value="H">Home</option>
					<option value="A">Away</option>
				</select>
				<input type="text" name="stadium" id="stadium" placeholder="경기장"
					class="add-file" value="">
			</div>
			<div>
				<input class="write-btn" type="submit" value="작성" accesskey="s">
			</div>
		</form>
	</section>
</body>
<%@include file="../part/footer.jsp"%>