<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.util.Util"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/modify-player.css">
<body>
	<c:set var="fileInputMaxCount" value="2" />
	<script>
		ArticleModify__fileInputMaxCount = parseInt("${fileInputMaxCount}");
		const articleId = parseInt("${player.id}");
	</script>
	<script>
		ArticleModify__submited = false;
		function ArticleModify__checkAndSubmit(form) {
			if (ArticleModify__submited) {
				alert('처리중입니다.');
				return;
			}
			form.FirstName.value = form.FirstName.value.trim();
			if (form.FirstName.value.length == 0) {
				alert('이름을 입력해주세요.');
				form.FirstName.focus();
				return false;
			}
			form.LastName.value = form.LastName.value.trim();
			if (form.LastName.value.length == 0) {
				alert('성을 입력해주세요.');
				form.LastName.focus();
				return false;
			}
			form.BackNumber.value = form.BackNumber.value.trim();
			if (form.BackNumber.value.length == 0) {
				alert('등번호를 입력해주세요.');
				form.BackNumber.focus();
				return false;
			}
			form.Position.value = form.Position.value.trim();
			if (form.Position.value.length == 0) {
				alert('포지션을 입력해주세요.');
				form.Position.focus();
				return false;
			}
			form.Nationality.value = form.Nationality.value.trim();
			if (form.Nationality.value.length == 0) {
				alert('국적을 입력해주세요.');
				form.Nationality.focus();
				return false;
			}
			form.Height.value = form.Height.value.trim();
			if (form.Height.value.length == 0) {
				alert('키를 입력해주세요.');
				form.Height.focus();
				return false;
			}
			form.Weight.value = form.Weight.value.trim();
			if (form.Weight.value.length == 0) {
				alert('몸무게를 입력해주세요.');
				form.Weight.focus();
				return false;
			}
			form.dateofBirth.value = form.dateofBirth.value.trim();
			if (form.dateofBirth.value.length == 0) {
				alert('생년월일 입력해주세요.');
				form.dateofBirth.focus();
				return false;
			}
			
			var maxSizeMb = 50;
			var maxSize = maxSizeMb * 1024 * 1024;
			for (let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++) {
				const input = form["file__player__" + articleId
						+ "__common__attachment__" + inputNo];

				if (input.value) {
					if (input.files[0].size > maxSize) {
						alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
						input.focus();

						return;
					}
				}
			}
			const startSubmitForm = function(data) {
				if (data && data.body && data.body.genFileIdsStr) {
					form.genFileIdsStr.value = data.body.genFileIdsStr;
				}

				for (let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++) {
					const input = form["file__player__" + articleId
							+ "__common__attachment__" + inputNo];
					input.value = '';
				}

				for (let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++) {
					const input = form["deleteFile__player__" + articleId
							+ "__common__attachment__" + inputNo];
					if (input) {
						input.checked = false;
					}
				}

				form.submit();
			};
			const startUploadFiles = function(onSuccess) {
				var needToUpload = false;
				for (let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++) {
					const input = form["file__player__" + articleId
							+ "__common__attachment__" + inputNo];
					if (input.value.length > 0) {
						needToUpload = true;
						break;
					}
				}

				if (needToUpload == false) {
					for (let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++) {
						const input = form["deleteFile__player__" + articleId
								+ "__common__attachment__" + inputNo];
						if (input && input.checked) {
							needToUpload = true;
							break;
						}
					}
				}

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
			ArticleModify__submited = true;
			startUploadFiles(startSubmitForm);
		}
	</script>
	<section class="section-modify row">
		<div class="modify-title">
			<h1 class="con">선수 수정</h1>
		</div>
		<form onsubmit="ArticleModify__checkAndSubmit(this); return false;"
			action="doModify" enctype="multipart/form-data">
			<input type="hidden" name="genFileIdsStr" value="" />
			<input type="hidden" name="id" value="${player.id}" />
			<input type="hidden" name="redirectUrl" value="${redirectUrl}" />
			<div>
				<input type="text" name="FirstName" id="FirstName"
					placeholder="FirstName" class="subject"
					value="${player.firstName }">
				<input type="text" name="LastName" id="LastName"
					placeholder="LastName" class="add-file" value="${player.lastName }">
				<input type="number" name="BackNumber" id="BackNumber"
					placeholder="BackNumber" class="add-file"
					value="${player.backNumber }">
				<select name="Position" class="add-file">
					<option value="">Position</option>
					<option value="GOALKEEPERS"
						<c:if test="${player.position == 'GOALKEEPERS'}">selected="selected"</c:if>>GOALKEEPERS</option>
					<option value="DEFENDERS"
						<c:if test="${player.position == 'DEFENDERS'}">selected="selected"</c:if>>DEFENDERS</option>
					<option value="MIDFIELDERS"
						<c:if test="${player.position == 'MIDFIELDERS'}">selected="selected"</c:if>>MIDFIELDERS</option>
					<option value="FORWARDS"
						<c:if test="${player.position == 'FORWARDS'}">selected="selected"</c:if>>FORWARDS</option>
					<option value="ONLOAN"
						<c:if test="${player.position == 'ONLOAN'}">selected="selected"</c:if>>ON
						LOAN</option>
				</select>
				<input type="text" name="Nationality" id="Nationality"
					placeholder="Nationality" class="add-file"
					value="${player.nationality }">
				<input type="number" name="Height" id="Height" placeholder="Height"
					class="add-file" value="${player.height }">
				<input type="number" name="Weight" id="Weight" placeholder="Weight"
					class="add-file" value="${player.weight }">
				<input placeholder="Date of Birth" class="add-file" type="text"
					name="dateofBirth" onfocus="(this.type='date')"
					value="${player.dateofBirth }" onblur="(this.type='text')"
					id="date" />
			</div>
			<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
				<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
				<c:set var="file"
					value="${player.extra.file__common__attachment[fileNo]}" />
				<div class="form-row flex flex-col lg:flex-row">
					<div class="add-file">
						<div class="cell">
							<span>첨부파일 ${inputNo}</span>
						</div>
						<div class="cell">
							<input type="file"
								name="file__player__${player.id}__common__attachment__${inputNo}"
								class="add-file1" />
						</div>
					</div>
				</div>
			</c:forEach>

			<div>
				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
					<div class="detail-img row input-file-wrap">
						<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
						<c:set var="file"
							value="${player.extra.file__common__attachment[fileNo]}" />
						<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
							<span class="row">첨부파일${inputNo} </span>
							<a class="inline-block cell" href="${file.forPrintUrl}"
								target="_blank" title="자세히 보기">
								<img class="max-w-sm" src="${file.forPrintUrl}">
							</a>
							<span class="cell filename">${file.originFileName}<br>
								(${Util.numberFormat(file.fileSize)} Byte)
							</span>
							<label class="check-box cell">
								<input
									onclick="$(this).closest('.input-file-wrap').find(' > input[type=file]').val('')"
									type="checkbox"
									name="deleteFile__player__${player.id}__common__attachment__${fileNo}"
									value="Y" />
							</label>
							<span class="cell">삭제</span>
						</c:if>
					</div>
				</c:forEach>
			</div>
			<div class="edit-btn row">
				<div class="cell">
					<input class="modify-btn" type="submit" value="수정" accesskey="s">
				</div>
				<div class="cell">
					<input class="cancel-btn cell" type="button" value="취소"
						onclick="javascript:history.back(-1)">
				</div>
			</div>

		</form>
	</section>

</body>

<%@include file="../part/footer.jsp"%>