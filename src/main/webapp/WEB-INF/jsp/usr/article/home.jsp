<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>

<body>

	<!--스케줄 시작-->
	<section class="section-schedule">
		<c:forEach items="${matches}" var="article">
			<div class="match1 match cell" OnClick="location.href ='match?input_month=${article.month}'" style="cursor:pointer;">
				<div class="match-line">
					<div class="location1 location cell">${article.venue }</div>
					<div class="match-right cell">
						<div class="match-right-top row">
							<div class="match-team-name cell">${article.name }</div>
						</div>
						<div class="match-right-bot row">
							<div class="stadium cell">${article.stadium }</div>
							<div class="league cell">${article.league }</div>
							<div class="date cell">${article.date }</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</section>
	<!--스케줄 끝-->

	<!--뉴스 시작-->
	<section class="news-slider">
		<c:forEach items="${newsArticles}" var="article" varStatus="count">
			<li class="section-news section-news${count.index }">
				<c:set var="detailUrl"
					value="/usr/article-news/detail?id=${article.id}&listUrl=/usr/article-news/list" />
				<a href=${detailUrl }>
					<p style="background-image: url('${article.extra__thumbImg}');"
						class="news"></p>
					<div class="news-container">
						<strong> ${article.title } </strong>
					</div>
				</a>
			</li>
		</c:forEach>
	</section>
	<!--뉴스 끝-->

	<!--게시판 시작-->
	<section class="section-board">
		<div class="board-left article cell">
			<div class="board-name">
				<a href="/usr/article-notice/list" class="board-name-title">공지사항</a>
				<a href="/usr/article-notice/list" class="cell-right more">더보기></a>
			</div>
			<c:forEach items="${noticeArticles}" var="article">
				<c:set var="detailUrl"
					value="/usr/article-notice/detail?id=${article.id}&listUrl=/usr/article-notice/list" />
				<div class="board-notice1 board">
					<div class="board-title">
						<a href="${detailUrl }">${article.title}</a>
					</div>
					<div class="board-id cell">${article.extra.writer}
						<span>·</span>
					</div>
					<div class="board-date cell">${article.extra.time }</div>
				</div>
			</c:forEach>
		</div>

		<div class="board-mid1 article cell">
			<div class="board-name">
				<a href="/usr/article-soccer/list" class="board-name-title">축구 게시판</a>
				<a href="/usr/article-soccer/list" class="cell-right more">더보기></a>
			</div>
			<c:forEach items="${soccerArticles}" var="article">
				<c:set var="detailUrl"
					value="/usr/article-soccer/detail?id=${article.id}&listUrl=/usr/article-soccer/list" />
				<div class="board-soccer1 board">
					<div class="board-title">
						<a href="${detailUrl }">${article.title}</a>
					</div>
					<div class="board-id cell">${article.extra.writer}
						<span>·</span>
					</div>
					<div class="board-date cell">${article.extra.time }</div>
				</div>
			</c:forEach>
		</div>

		<div class="board-mid2 article cell">
			<div class="board-name">
				<a href="/usr/article-free/list" class="board-name-title">자유 게시판</a>
				<a href="/usr/article-free/list" class="cell-right more">더보기></a>
			</div>

			<c:forEach items="${freeArticles}" var="article">
				<c:set var="detailUrl"
					value="/usr/article-free/detail?id=${article.id}&listUrl=/usr/article-free/list" />
				<div class="board-free1 board">
					<div class="board-title">
						<a href="${detailUrl }">${article.title}</a>
					</div>
					<div class="board-id cell">${article.extra.writer}
						<span>·</span>
					</div>
					<div class="board-date cell">${article.extra.time }</div>
				</div>
			</c:forEach>

		</div>
		<div class="board-right article cell">
			<div class="board-name-t">
				<a href="/usr/article/leaguetable" class="board-name-title">순위표</a>
				<a href="/usr/article/leaguetable" class="cell-right more">더보기&gt;</a>
			</div>
			<div class="league-table">
				<table class="table">
					<thead>
						<td class="team-lanking">순위</td>
						<td class="team-name">팀명</td>
						<td class="team-game">경기</td>
						<td class="team-point">승점</td>
						<td class="team-win">승</td>
						<td class="team-draw">무</td>
						<td class="team-lose">패</td>
					</thead>
					<tbody class="table-set">
						<c:forEach items="${leaguetables}" var="League" varStatus="count">
							<tr class="top">
								<td>${count.index+1}</td>
								<td class="team-name">${League.name}</td>
								<td>${League.game}</td>
								<td>${League.point}</td>
								<td>${League.win}</td>
								<td>${League.draw}</td>
								<td>${League.lose}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<!--게시판 끝-->
	<!-- 모바일 게시판 -->
	<section class="section-board hidden-board">
		<div class="board-hidden-mid2 article cell">
			<div class="board-name">
				<a href="/usr/article-free/list" class="board-name-title">자유 게시판</a>
				<a href="/usr/article-free/list" class="cell-right more">더보기></a>
			</div>

			<c:forEach items="${freeArticles}" var="article">
				<c:set var="detailUrl"
					value="/usr/article-free/detail?id=${article.id}&listUrl=/usr/article-free/list" />
				<div class="board-free1 board">
					<div class="board-title">
						<a href="${detailUrl }">${article.title}</a>
					</div>
					<div class="board-id cell">${article.extra.writer}
						<span>·</span>
					</div>
					<div class="board-date cell">${article.extra.time }</div>
				</div>
			</c:forEach>

		</div>
		<div class="board-right2 article cell">
			<div class="board-name-t">
				<a href="/usr/article/leaguetable" class="board-name-title">순위표</a>
				<a href="/usr/article/leaguetable" class="cell-right more">더보기&gt;</a>
			</div>
			<div class="league-table">
				<table class="table">
					<thead>
						<td class="team-lanking">순위</td>
						<td class="team-name">팀명</td>
						<td class="team-game">경기</td>
						<td class="team-point">승점</td>
						<td class="team-win">승</td>
						<td class="team-draw">무</td>
						<td class="team-lose">패</td>
					</thead>
					<tbody class="table-set">
						<c:forEach items="${leaguetables}" var="League" varStatus="count">
							<tr class="top">
								<td>${count.index+1}</td>
								<td class="team-name">${League.name}</td>
								<td>${League.game}</td>
								<td>${League.point}</td>
								<td>${League.win}</td>
								<td>${League.draw}</td>
								<td>${League.lose}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<!--모바일게시판 끝  -->
	
	<!--타이틀  -->
	<div class="player-title row">
		<div class="group-1 cell"><a href="/usr/article/team">1군 선수단</a></div>
		<div class="coach cell">Head Coach</div>
		<a href="/usr/article/team" class="cell-right more-player">더보기></a>
	</div>

	<!--선수소개-->
	<section class="section-player row">
		<div class="player-outside cell">
			<div class="player-bundle cell">
				<c:forEach items="${players}" var="player">
					<a href="/usr/article-player/detail?id=${player.id}&listUrl=/usr/article/team" style="display: flex">
						<div class="player cell">
							<img src="${player.extra__thumbImg }" />
							<div class="player-info">
								<div class="player-number cell">${player.backNumber }</div>
								<div class="player-name cell">${player.firstName }</div>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>

		<div class="head-coach cell">
			<div class="coach-img">
				<img src="/resource/img/klop2.jpg" />
			</div>
			<div class="coach-info row">
				<div class="coach-number cell"></div>
				<div class="coach-name cell">Jurgen Klopp</div>
			</div>
		</div>
	</section>

</body>

<%@include file="../part/footer.jsp"%>