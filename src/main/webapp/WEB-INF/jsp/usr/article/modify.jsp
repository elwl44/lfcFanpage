<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.util.Util" %>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/modify.css">
<body>
	<c:set var="fileInputMaxCount" value="2" />
	<script>
		ArticleModify__fileInputMaxCount = parseInt("${fileInputMaxCount}");
	</script>
	<script>
		ArticleModify__submited = false;
		function ArticleModify__checkAndSubmit(form) {
			if (ArticleModify__submited) {
				alert('처리중입니다.');
				return;
			}

			form.title.value = form.title.value.trim();
			if (form.title.value.length == 0) {
				alert('제목을 입력해주세요.');
				form.title.focus();
				return false;
			}
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('내용을 입력해주세요.');
				form.body.focus();
				return false;
			}
			var maxSizeMb = 50;
			var maxSize = maxSizeMb * 1024 * 1024;
			for (let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++) {
				const input = form["file__article__0__common__attachment__"
						+ inputNo];

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
					const input = form["file__article__0__common__attachment__"
							+ inputNo];
					input.value = '';
				}

				form.submit();
			};
			const startUploadFiles = function(onSuccess) {
				var needToUpload = false;
				for (let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++) {
					const input = form["file__article__0__common__attachment__"
							+ inputNo];
					if (input.value.length > 0) {
						needToUpload = true;
						break;
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
			<h1 class="con">${board.name }글 수정</h1>
		</div>
		<form onsubmit="ArticleModify__checkAndSubmit(this); return false;"
			action="doModify" enctype="multipart/form-data">
			<input type="hidden" name="genFileIdsStr" value="" />
			<input type="hidden" name="id" value="${article.id}" />
			<input type="hidden" name="redirectUrl" value="${redirectUrl}" />
			<div>
				<input type="text" name="title" id="title" placeholder="제목"
					class="subject" value="${article.title }">
			</div>

			<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
				<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
				<c:set var="file"
					value="${article.extra.file__common__attachment[fileNo]}" />
				<div class="form-row flex flex-col lg:flex-row">
					<div class="add-file">
						<div class="cell">
							<span>첨부파일 ${inputNo}</span>
						</div>
						<div class="cell">
							<input type="file"
								name="file__article__0__common__attachment__${inputNo}"
								class="add-file1" />
						</div>
					</div>
				</div>
			</c:forEach>

			<div>
				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
					<div class="detail-img row" >
						<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
						<c:set var="file"	value="${article.extra.file__common__attachment[fileNo]}" />
						<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
							<span class="row">첨부파일${inputNo} </span>
							<a class="inline-block cell" href="${file.forPrintUrl}" target="_blank" title="자세히 보기">
	                            <img class="max-w-sm" src="${file.forPrintUrl}">
	                         </a>
							<span class="cell">${file.originFileName}(${Util.numberFormat(file.fileSize)} Byte)</span>
							<label class="check-box cell">
								<input class="cell check" type="checkbox" name="deleteFile__article__${article.id}__common__attachment__${fileNo}" value="Y" />
							</label>
							<span class="cell">삭제</span>
						</c:if>
					</div>
				</c:forEach>

				<textarea class="modify-body-form" maxlength="2000"
					placeholder="내용을 입력해주세요." name="body" style="resize: none">${article.body }</textarea>
			</div>

			<div class="edit-btn">
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