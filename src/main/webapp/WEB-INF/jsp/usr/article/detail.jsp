<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.8.2.js"></script>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/detail.css">
<body>

	<section class="section-detail row">
		<div class="detail-title">
			<strong><a href="./">공지사항</a></strong>
			<h1>${article.title}</h1>
		</div>
		<div class="writer-info">
			<div class="writer-img cell">
				<img class="img2 cell" src="/resource/img/nonimg.jpg" />
			</div>
			<div class="writer-profile cell">
				<div class="writer-nickname">
					<strong>${article.extra.writer}</strong>
				</div>
				<div>
					<div class="regdate cell">
						<span>${article.regDate}</span>
					</div>
					<div class="view cell">
						<span>조회 ${article.reading}</span>
					</div>
				</div>
			</div>
		</div>
		<div class="detail-body">${article.body}</div>

		<div class="detail-edit row">
			<span class="btn-modify cell">
				<a href="modify?id=${article.id}">수정</a>
			</span>

			<span class="btn-delete cell">
				<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;"
					href="doDelete?id=${article.id}">삭제</a>
			</span>
		</div>
	</section>

	<section class="section-comment">
		<div class="comttl">
			<h3>댓글 1개</h3>
		</div>
		<div class="comment-container">
			<div class="comment-area row">
				<div class="comment-img cell">
					<img class="img2 cell" src="/resource/img/nonimg.jpg" />
				</div>
				<div class="comment-info cell">
					<div class="comment-user">
						<strong>로얄이</strong>
					</div>
					<div class="memo">안녕하세요</div>
					<span class="comment-date">5시간 전</span>
				</div>
			</div>
			<form action="/usr/reply/doWrite" method="POST" class="comment-write"
				name="comment-write" id="comment-write">

				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${param.id}" />

				<div>
					<textarea name="body" placeholder="댓글 쓰기" class="comment-body cell"
						style="resize: none" id="comment-body" name="comment-body"></textarea>
				</div>

				<div>
					<input type="submit" value="작성" class="comment-btn cell" />
				</div>
			</form>
		</div>
		<script>
			if(${isLogined}==false){
				$('#comment-write').css('display', 'none');
			}
			else if(${isLogined}==true){
				$('#comment-write').css('display', 'block');
			}
		</script>
	</section>
</body>