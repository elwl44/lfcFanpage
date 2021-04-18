<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/detail-player.css">
<body>

	<section class="section-detail row">
		<div class="detail-title">
			<strong><a href="${listUrl}">FIRST TEAM</a></strong>
		</div>
		<div id="cover">
			<div class="player-profile-image  ">
				<img class="img2 cell" src="${player.extra__thumbImg }" />

				<div class="redBar">
					<img
						src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/JE-617/bundles/applicationsonatafrontend/images/redbar.png">
				</div>
				<div class="top">
					<span class="number smallNum"> ${player.backNumber } </span>
				</div>
				<div class="left">
					<span class="value firstName">${player.firstName }</span>

					<span class="value surName">${player.lastName }</span>

					<span class="value position">${player.position }</span>
				</div>
				<div class="right">
					<div class="dob">
						<span class="title">D.O.B</span>
						<span class="value">
							<strong>${player.dateofBirth }</strong>
						</span>
					</div>

					<div class="pob">
						<span class="title">Nation</span>
						<span class="value">
							<strong>${player.nationality }</strong>
						</span>
					</div>
				</div>
				<div class="bot">
					<span class="title">Body information</span>
					<span class="value">
						<strong>Height: ${player.height }cm</strong>
					</span>
					<span>
						<strong>Weight: ${player.weight }kg</strong>
					</span>
				</div>
			</div>
		</div>
	
	<div class="detail-edit row">
		<span class="btn-modify cell">
			<a href="modify?id=${article.id}&redirectUrl=${encodedCurrentUri}">수정</a>
		</span>

		<span class="btn-delete cell">
			<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;"
				href="doDelete?id=${article.id}&listUrl=${listUrl}">삭제</a>
		</span>
	</div>
	</section>
</body>
<%@include file="../part/footer.jsp"%>