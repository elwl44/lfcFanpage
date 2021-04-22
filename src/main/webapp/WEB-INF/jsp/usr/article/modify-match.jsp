<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/modify-match.css">

<body>
	<script>
		$(function () {
			$("#selboxDirect").hide();
			if($("#League option:selected").val()=="direct")
			{
				$("#selboxDirect").show();
			}
			//직접입력 인풋박스 기존에는 숨어있다가
			$("#League").change(function() {
				//직접입력을 누를 때 나타남
				$("#selboxDirect").hide();
				if ($("#League").val() == "direct") {
					$("#selboxDirect").show();
				} else {
					$("#selboxDirect").hide();
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
			if (form.League.value.length == 0 && $("#League").val() != "direct"){
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
			
			form.venue.value = form.venue.value.trim();
			if (form.venue.value.length == 0) {
				alert('장소를 입력해주세요.');
				form.venue.focus();
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
			<h1 class="con">경기일정 수정${matchschedule }</h1>
		</div>

		<form action="doModifyMatch" class="join-form"
			onsubmit="joinFormSubmit(this); return false;" id="loginform">
			<input type="hidden" name="id" value="${matchschedule.id}" />
			<div>
				<input type="text" name="name" id="teamname" placeholder="상대팀"
					class="subject" value="${matchschedule.name }">
				<input placeholder="경기일" class="add-file" type="text" name="date"
					onfocus="(this.type='date')" onblur="(this.type='text')" id="date"
					value="${matchschedule.date }" />
				<input type="time" name="time" placeholder="시작시간"
					value="${matchschedule.time }" class="add-file">
				<select name="League" class="add-file" id="League">
					<option value="">리그를 골라주세요</option>
					<option value="Premier League"
						<c:if test="${matchschedule.league == 'Premier League'}">selected="selected"</c:if>>Premier
						League</option>
					<option value="Champions League"
						<c:if test="${matchschedule.league == 'Champions League'}">selected="selected"</c:if>>Champions
						League</option>
					<option value="League Cup"
						<c:if test="${matchschedule.league == 'League Cup'}">selected="selected"</c:if>>League
						Cup</option>
					<option value="direct"
						<c:if test="${matchschedule.extra.other == 'direct'}">selected="selected"</c:if>>직접입력</option>
				</select>
				<input type="text" id="selboxDirect" name="other"
					class="add-file" placeholder="기타 리그를 입력해주세요" value="${matchschedule.league }">
				<select name="venue" class="add-file" id="venue">
					<option value="">장소</option>
					<option value="H"
						<c:if test="${matchschedule.venue == 'H'}">selected="selected"</c:if>>Home</option>
					<option value="A"
						<c:if test="${matchschedule.venue == 'A'}">selected="selected"</c:if>>Away</option>
				</select>
				<input type="text" name="stadium" id="stadium" placeholder="경기장"
					class="add-file" value="${matchschedule.stadium }">
			</div>
			<div class="edit-btn">
				<div class="cell">
					<input class="join-btn" type="submit" value="수정" id="join">
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