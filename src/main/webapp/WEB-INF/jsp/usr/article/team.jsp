<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/team.css">

<section class="section-join row">
	<div class="join-title">
		<h1 class="con">FIRST TEAM</h1>
	</div>
	<div class="GOALKEEPERS row">
		<div class="team-player-list">
			<h2>GOALKEEPERS</h2>
			<ul>
				<c:forEach items="${players}" var="player">
					<c:if test="${player.position eq 'GOALKEEPERS'}">
						<li class="team-player-list-item"
							onclick="location.href='/usr/article-${board.code}/detail?id=${player.id}&listUrl=${encodedCurrentUri}'">
							<div class="img-wrap">
								<c:if test="${player.extra__thumbImg != null}">
									<img src="${player.extra__thumbImg }" />
								</c:if>
							</div>
							<div class="number">${player.backNumber }</div>
							<div class="about">
								<div class="name">
									<span>${player.firstName }</span>
									<span>${player.lastName }</span>
								</div>
							</div>
						</li>
					</c:if>
				</c:forEach>
			</ul>

		</div>
	</div>

	<div class="DEFENDERS row">
		<div class="team-player-list">
			<h2>DEFENDERS</h2>
			<ul>
				<c:forEach items="${players}" var="player">
					<c:if test="${player.position eq 'DEFENDERS'}">
						<li class="team-player-list-item"
							onclick="location.href='/usr/article-${board.code}/detail?id=${player.id}&listUrl=${encodedCurrentUri}'">
							<div class="img-wrap">
								<c:if test="${player.extra__thumbImg != null}">
									<img src="${player.extra__thumbImg }" />
								</c:if>
							</div>
							<div class="number">${player.backNumber }</div>
							<div class="about">
								<div class="name">
									<span>${player.firstName }</span>
									<span>${player.lastName }</span>
								</div>
							</div>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="MIDFIELDERS row">
		<div class="team-player-list">
			<h2>MIDFIELDERS</h2>
			<ul>
				<c:forEach items="${players}" var="player">
					<c:if test="${player.position eq 'MIDFIELDERS'}">
						<li class="team-player-list-item"
							onclick="location.href='/usr/article-${board.code}/detail?id=${player.id}&listUrl=${encodedCurrentUri}'">
							<div class="img-wrap">
								<c:if test="${player.extra__thumbImg != null}">
									<img src="${player.extra__thumbImg }" />
								</c:if>
							</div>
							<div class="number">${player.backNumber }</div>
							<div class="about">
								<div class="name">
									<span>${player.firstName }</span>
									<span>${player.lastName }</span>
								</div>
							</div>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="FORWARDS row">
		<div class="team-player-list">
			<h2>FORWARDS</h2>
			<ul>
				<c:forEach items="${players}" var="player">
					<c:if test="${player.position eq 'FORWARDS'}">
						<li class="team-player-list-item"
							onclick="location.href='/usr/article-${board.code}/detail?id=${player.id}&listUrl=${encodedCurrentUri}'">
							<div class="img-wrap">
								<c:if test="${player.extra__thumbImg != null}">
									<img src="${player.extra__thumbImg }" />
								</c:if>
							</div>
							<div class="number">${player.backNumber }</div>
							<div class="about">
								<div class="name">
									<span>${player.firstName }</span>
									<span>${player.lastName }</span>
								</div>
							</div>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="ONLOAN row">
		<div class="team-player-list">
			<h2>ON LOAN</h2>
			<ul>
				<c:forEach items="${players}" var="player">
					<c:if test="${player.position eq 'ONLOAN'}">
						<li class="team-player-list-item"
							onclick="location.href='/usr/article-${board.code}/detail?id=${player.id}&listUrl=${encodedCurrentUri}'">

							<div class="img-wrap">
								<c:if test="${player.extra__thumbImg != null}">
									<img src="${player.extra__thumbImg }" />
								</c:if>
							</div>
							<div class="number">${player.backNumber }</div>
							<div class="about">
								<div class="name">
									<span>${player.firstName }</span>
									<span>${player.lastName }</span>
								</div>
							</div>

						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	<div class="btnArea row">
		<span class="btn-write cell">
			<a href="/usr/article-player/write">글쓰기</a>
		</span>
	</div>
</section>


<%@include file="../part/footer.jsp"%>