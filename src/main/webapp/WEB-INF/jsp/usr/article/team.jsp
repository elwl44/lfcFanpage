<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/team.css">

<section class="section-join row">
	<div class="join-title">
		<h1 class="con">FIRST TEAM</h1>
		${players }
	</div>
	<div class="GOALKEEPERS row">
		<div class="team-player-list">
			<h2>GOALKEEPERS</h2>
			<ul>
				<c:forEach items="${players}" var="player">
					<li class="team-player-list-item" onclick="#1">
						<a href="/team/first-team/player/alisson-becker">
							<div class="img-wrap">
								<c:if test="${player.extra__thumbImg != null}">
								<img src="${player.extra__thumbImg }" />
							</c:if>
							</div>
							<div class="number">1</div>
							<div class="about">
								<div class="name">
									<span>Alisson</span>
									<span>Becker</span>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>

		</div>
	</div>

	<div class="DEFENDERS row">
		<div class="team-player-list">
			<h2>DEFENDERS</h2>
			<ul>
				<c:forEach var="i" begin="0" end="9">
					<li class="team-player-list-item">
						<a href="/team/first-team/player/virgil-van-dijk">
							<div class="img-wrap">
								<img
									src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/uploads/media/misc/0002/14/thumb_113617_misc_general_500.jpeg"
									alt="Virgil van Dijk">
							</div>
							<div class="number">4</div>
							<div class="about">
								<div class="name">
									<span>Virgil</span>
									<span>van</span>
									<span>Dijk</span>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="MIDFIELDERS row">
		<div class="team-player-list">
			<h2>MIDFIELDERS</h2>
			<ul>
				<c:forEach var="i" begin="0" end="9">
					<li class="team-player-list-item">
						<a href="/team/first-team/player/virgil-van-dijk">
							<div class="img-wrap">
								<img
									src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/uploads/media/misc/0002/14/thumb_113617_misc_general_500.jpeg"
									alt="Virgil van Dijk">
							</div>
							<div class="number">4</div>
							<div class="about">
								<div class="name">
									<span>Virgil</span>
									<span>van</span>
									<span>Dijk</span>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="FORWARDS row">
		<div class="team-player-list">
			<h2>FORWARDS</h2>
			<ul>
				<c:forEach var="i" begin="0" end="9">
					<li class="team-player-list-item">
						<a href="/team/first-team/player/virgil-van-dijk">
							<div class="img-wrap">
								<img
									src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/uploads/media/misc/0002/14/thumb_113617_misc_general_500.jpeg"
									alt="Virgil van Dijk">
							</div>
							<div class="number">4</div>
							<div class="about">
								<div class="name">
									<span>Virgil</span>
									<span>van</span>
									<span>Dijk</span>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="ONLOAN row">
		<div class="team-player-list">
			<h2>ON LOAN</h2>
			<ul>
				<c:forEach var="i" begin="0" end="9">
					<li class="team-player-list-item">
						<a href="/team/first-team/player/virgil-van-dijk">
							<div class="img-wrap">
								<img
									src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/uploads/media/misc/0002/14/thumb_113617_misc_general_500.jpeg"
									alt="Virgil van Dijk">
							</div>
							<div class="number">4</div>
							<div class="about">
								<div class="name">
									<span>Virgil</span>
									<span>van</span>
									<span>Dijk</span>
								</div>
							</div>
						</a>
					</li>
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