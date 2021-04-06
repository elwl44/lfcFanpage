<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
					<span>${article.writer}</span>
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
				<a href="">수정</a>
			</span>

			<span class="btn-delete cell">
				<a href="doDelete?id=${article.id}">삭제</a>
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
		</div>
	</section>
</body>