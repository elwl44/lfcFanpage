<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resource/write.css">
<body>
	<c:set var="fileInputMaxCount" value="2" />
	<script>
		ArticleAdd__fileInputMaxCount = parseInt("${fileInputMaxCount}");
	</script>
	<script>
		ArticleAdd__submited = false;
		function ArticleAdd__checkAndSubmit(form) {
			if (ArticleAdd__submited) {
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
			for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
				const input = form["file__article__0__common__attachment__" + inputNo];
				
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

				for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
					const input = form["file__article__0__common__attachment__" + inputNo];
					input.value = '';
				}
				
				form.submit();
			};
			const startUploadFiles = function(onSuccess) {
				var needToUpload = false;
				for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
					const input = form["file__article__0__common__attachment__" + inputNo];
					if ( input.value.length > 0 ) {
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
			ArticleAdd__submited = true;
			startUploadFiles(startSubmitForm);
		}
	</script>
	<section class="section-write row">
		<div class="write-title">
			<h1 class="con">${board.name }글쓰기</h1>
		</div>
		<form action="doWrite"
			onsubmit="ArticleAdd__checkAndSubmit(this); return false;"
			method="post" enctype="multipart/form-data">
			<div>
				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="text" name="title" id="title" placeholder="제목"
					class="subject" value="">
			</div>
			<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
				<div class="add-file">
					<div class="cell">
						<span>첨부파일  ${inputNo}</span>
					</div>
					<div class="cell">
						<input type="file" name="file__article__0__common__attachment__${inputNo}"
							class="add-file1" />
					</div>
				</div>
			</c:forEach>
			<div>
				<textarea class="write-body-form" maxlength="2000"
					placeholder="내용을 입력해주세요." name="body" style="resize: none"></textarea>
			</div>

			<div>
				<input class="write-btn" type="submit" value="작성" accesskey="s">
			</div>
		</form>
	</section>
</body>
<%@include file="../part/footer.jsp"%>