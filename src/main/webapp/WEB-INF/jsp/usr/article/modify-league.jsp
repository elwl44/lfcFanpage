<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/modify-league.css">

<body>
	<script>
		var joinFormSubmitDone = false;
		function joinFormSubmit(form) {
			if (joinFormSubmitDone) {
				alert('처리중입니다.');
				return;
			}

			form.win.value = form.win.value.trim();
			if (form.win.value.length == 0) {
				alert('이긴횟수를 입력해주세요.');
				form.win.focus();
				return;
			}
			form.draw.value = form.draw.value.trim();
			if (form.draw.value.length == 0) {
				alert('비긴횟수를 입력해주세요.');
				form.draw.focus();
				return;
			}
			form.lose.value = form.lose.value.trim();
			if (form.lose.value.length == 0) {
				alert('진횟수를 입력해주세요.');
				form.lose.focus();
				return;
			}
			form.gainGoal.value = form.gainGoal.value.trim();
			if (form.gainGoal.value.length == 0) {
				alert('득점을 입력해주세요.');
				form.gainGoal.focus();
				return;
			}

			form.loseGoal.value = form.loseGoal.value.trim();
			if (form.loseGoal.value.length == 0) {
				alert('실점을 입력해주세요.');
				form.loseGoal.focus();
				return;
			}

			$("#name").attr('disabled', false);

			form.submit();
			joinFormSubmitDone = true;
		}
	</script>
	<section class="section-join row">
		<div class="join-title">
			<h1 class="con">리그테이블 수정</h1>
		</div>

		<form action="doModifyLeague" class="join-form"
			onsubmit="joinFormSubmit(this); return false;" id="loginform">
			<input type="hidden" name="id" value="${leaguetable.id}" />
			<div>
				<p class="join-name cell">팀명:</p>
				<input type="text" maxlength="30" name="name" class="join-data"
					id="name" value="${leaguetable.name }" disabled="disabled" />
			</div>
			<div>
				<p class="join-name cell">승:</p>
				<input type="number" maxlength="30" name="win" class="join-data"
					id="win" value="${leaguetable.win }" min="0" />
			</div>
			<div>
				<p class="join-name cell">무:</p>
				<input type="number" maxlength="30" name="draw" class="join-data"
					id="draw" value="${leaguetable.draw }" min="0" />
			</div>
			<div>
				<p class="join-name cell">패:</p>
				<input type="number" maxlength="30" name="lose" class="join-data"
					id="lose" value="${leaguetable.lose }" min="0" />
			</div>
			<div>
				<p class="join-name cell">득점:</p>
				<input type="number" maxlength="30" name="gainGoal" class="join-data"
					id="gainGoal" value="${leaguetable.gainGoal }" min="0" />
			</div>
			<div>
				<p class="join-name cell">실점:</p>
				<input type="number" maxlength="30" name="loseGoal" class="join-data"
					id="loseGoal" value="${leaguetable.loseGoal }" min="0" />
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