<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resource/write.css">
<body>
	<c:set var="fileInputMaxCount" value="1" />
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
			var fileCheck = document.getElementById("file-input").value;
			console.log(fileCheck);
		    if(!fileCheck){
		        alert("선수 사진을 첨부해 주세요");
		        return false;
		    }
			var maxSizeMb = 50;
			var maxSize = maxSizeMb * 1024 * 1024;
			if (form.file__player__0__common__attachment__1.value) {
				if (form.file__player__0__common__attachment__1.files[0].size > maxSize) {
					alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
					form.file__player__0__common__attachment__1.focus();
					
					return;
				}
			}

			const startSubmitForm = function(data) {
				let genFileIdsStr = '';
				if (data && data.body && data.body.genFileIdsStr) {
					genFileIdsStr = data.body.genFileIdsStr;
				}
				
				form.genFileIdsStr.value = genFileIdsStr;
				
				form.file__player__0__common__attachment__1.value = '';
				
				form.submit();
			};
			const startUploadFiles = function(onSuccess) {
				var needToUpload = form.file__player__0__common__attachment__1.value.length > 0;
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
			<h1 class="con">선수정보 입력</h1>
		</div>
		<form action="doWritePlayer"
			onsubmit="ArticleAdd__checkAndSubmit(this); return false;"
			method="post" enctype="multipart/form-data">
			<div>
				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="text" name="FirstName" id="FirstName"
					placeholder="FirstName" class="subject" value="">
				<input type="text" name="LastName" id="LastName"
					placeholder="LastName" class="add-file" value="">
				<input type="number" name="BackNumber" id="BackNumber"
					placeholder="BackNumber" class="add-file">
				<select name="Position" class="add-file">
					<option value="">Position</option>
					<option value="GOALKEEPERS">GOALKEEPERS</option>
					<option value="DEFENDERS">DEFENDERS</option>
					<option value="MIDFIELDERS">MIDFIELDERS</option>
					<option value="FORWARDS">FORWARDS</option>
					<option value="ONLOAN">ON LOAN</option>
				</select>
				<input type="text" name="Nationality" id="Nationality"
					placeholder="Nationality" class="add-file" value="">
				<input type="number" name="Height" id="Height" placeholder="Height"
					class="add-file">
				<input type="number" name="Weight" id="Weight" placeholder="Weight"
					class="add-file">
				<input placeholder="Date of Birth" class="add-file" type="text" name="dateofBirth"
					onfocus="(this.type='date')" onblur="(this.type='text')" id="date" />
			</div>
			<div class="add-file">
					<div class="cell">
						<span>선수사진</span>
					</div>
					<div class="cell">
						<input type="file" id="file-input"
							name="file__player__0__common__attachment__1"
							class="add-file1" />
					</div>
				</div>
			<div>
				<input class="write-btn" type="submit" value="작성" accesskey="s">
			</div>
		</form>
	</section>
</body>
<%@include file="../part/footer.jsp"%>