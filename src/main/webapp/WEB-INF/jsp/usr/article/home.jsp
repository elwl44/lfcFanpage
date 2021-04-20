<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>

<body>

	<!--스케줄 시작-->
	<section class="section-schedule">
		<div class="match1 match cell">
			<div class="match-line">
				<div class="location1 location cell">H</div>
				<div class="match-right cell">
					<div class="match-right-top row">
						<div class="match-team-name cell">Manchester Utd</div>
					</div>
					<div class="match-right-bot row">
						<div class="stadium cell">Anfiled</div>
						<div class="league cell">EPL</div>
						<div class="round cell">3R</div>
						<div class="date cell">3.3 23:30</div>
					</div>
				</div>

			</div>
		</div>
		<div class="match2 match cell">
			<div class="match-line">
				<div class="location2 location cell">H</div>
				<div class="match-right cell">
					<div class="match-right-top row">
						<div class="match-team-name cell">Barcelona</div>
					</div>
					<div class="match-right-bot row">
						<div class="stadium cell">Anfiled</div>
						<div class="league cell">EPL</div>
						<div class="round cell">3R</div>
						<div class="date cell">3.3 23:30</div>
					</div>
				</div>
			</div>
		</div>
		<div class="match3 match cell">
			<div class="match-line">
				<div class="location3 location cell">H</div>
				<div class="match-right cell">
					<div class="match-right-top row">
						<div class="match-team-name cell">Chelsea</div>
					</div>
					<div class="match-right-bot row">
						<div class="stadium cell">Anfiled</div>
						<div class="league cell">EPL</div>
						<div class="round cell">3R</div>
						<div class="date cell">3.3 23:30</div>
					</div>
				</div>
			</div>
		</div>
		<div class="match4 match cell">
			<div class="match-line">
				<div class="location4 location cell">H</div>
				<div class="match-right cell">
					<div class="match-right-top row">
						<div class="match-team-name cell">Real Madrid</div>
					</div>
					<div class="match-right-bot row">
						<div class="stadium cell">Anfiled</div>
						<div class="league cell">UCL</div>
						<div class="round cell">3R</div>
						<div class="date cell">3.3 23:30</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--스케줄 끝-->

	<!--뉴스 시작-->
	<section class="news-slider">
		<c:forEach items="${newsArticles}" var="article">
			<li style="width: 325px; float: left; display: block;"
				class="section-news">
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
				<a href="/usr/article-notice/list">공지사항</a>
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
				<a href="/usr/article-soccer/list">축구 게시판</a>
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
				<a href="/usr/article-free/list">자유 게시판</a>
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
			<div class="board-name">
				<a href="#board-table">순위표</a>
			</div>
			<div class="league-table">
				<table class="table">
					<thead>
						<td class="team-lanking">순위</td>
						<td class="team-name">팀명</td>
						<td class="team-game">경기</td>
						<td class="team-win">승</td>
						<td class="team-draw">무</td>
						<td class="team-lose">패</td>
						<td class="team-point">승점</td>
					</thead>
					<tbody>
						<tr class="top">
							<td>1</td>
							<td class="team-name">맨시티</td>
							<td>7</td>
							<td>6</td>
							<td>1</td>
							<td>0</td>
							<td>19</td>
						</tr>
						<tr class="top">
							<td>2</td>
							<td class="team-name">리버풀</td>
							<td>7</td>
							<td>6</td>
							<td>1</td>
							<td>0</td>
							<td>19</td>
						</tr>
						<tr class="top">
							<td>3</td>
							<td class="team-name">첼시</td>
							<td>7</td>
							<td>5</td>
							<td>2</td>
							<td>0</td>
							<td>17</td>
						</tr>
						<tr class="top">
							<td>4</td>
							<td class="team-name">토트넘</td>
							<td>7</td>
							<td>5</td>
							<td>0</td>
							<td>2</td>
							<td>15</td>
						</tr>
						<tr>
							<td>5</td>
							<td class="team-name">아스날</td>
							<td>7</td>
							<td>5</td>
							<td>0</td>
							<td>2</td>
							<td>15</td>
						</tr>
						<tr>
							<td>6</td>
							<td class="team-name">왓포드</td>
							<td>7</td>
							<td>4</td>
							<td>1</td>
							<td>2</td>
							<td>13</td>
						</tr>
						<tr>
							<td>7</td>
							<td class="team-name">본머스</td>
							<td>7</td>
							<td>4</td>
							<td>1</td>
							<td>2</td>
							<td>13</td>
						</tr>
						<tr>
							<td>8</td>
							<td class="team-name">레스터시티</td>
							<td>7</td>
							<td>4</td>
							<td>0</td>
							<td>3</td>
							<td>12</td>
						</tr>
						<tr>
							<td>9</td>
							<td class="team-name">울버햄튼</td>
							<td>7</td>
							<td>3</td>
							<td>3</td>
							<td>1</td>
							<td>12</td>
						</tr>
						<tr>
							<td>10</td>
							<td class="team-name">에버턴</td>
							<td>7</td>
							<td>3</td>
							<td>3</td>
							<td>1</td>
							<td>12</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<!--게시판 끝-->
	<div class="player-title row">
		<div class="group-1 cell">1군 선수단</div>
		<div class="coach cell">Head Coach</div>
	</div>

	<!--선수소개-->
	<section class="section-player row">
		<div class="player-outside cell">
			<div class="player-bundle cell">
				<div class="player cell">
					<img src="/resource/img/alisson.jpeg" />
					<div class="player-info">
						<div class="player-number cell">1</div>
						<div class="player-name cell">Alisson</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/fabinho.jpeg" />
					<div class="player-info">
						<div class="player-number cell">3</div>
						<div class="player-name cell">Fabinho</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/van.jpeg" />
					<div class="player-info">
						<div class="player-number cell">4</div>
						<div class="player-name cell">Van Dijk</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/wijnal.jpeg" />
					<div class="player-info">
						<div class="player-number cell">5</div>
						<div class="player-name cell">Wijnaldum</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/thiago.jpeg" />
					<div class="player-info">
						<div class="player-number cell">6</div>
						<div class="player-name cell">Thiago</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/milner.jpeg" />
					<div class="player-info">
						<div class="player-number cell">7</div>
						<div class="player-name cell">Milner</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/keita.jpeg" />
					<div class="player-info">
						<div class="player-number cell">8</div>
						<div class="player-name cell">Keita</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/filmino.jpeg" />
					<div class="player-info">
						<div class="player-number cell">9</div>
						<div class="player-name cell">Firmino</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/mane.jpeg" />
					<div class="player-info">
						<div class="player-number cell">10</div>
						<div class="player-name cell">Mane</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/salah.jpeg" />
					<div class="player-info">
						<div class="player-number cell">11</div>
						<div class="player-name cell">Salah</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/gomez.jpeg" />
					<div class="player-info">
						<div class="player-number cell">12</div>
						<div class="player-name cell">Gomez</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/adrian.jpeg" />
					<div class="player-info">
						<div class="player-number cell">13</div>
						<div class="player-name cell">Adrian</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/henderson.jpeg" />
					<div class="player-info">
						<div class="player-number cell">14</div>
						<div class="player-name cell">Henderson</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/chambo.jpeg" />
					<div class="player-info">
						<div class="player-number cell">15</div>
						<div class="player-name cell">Oxlade-Chamberlain</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/jones.jpeg" />
					<div class="player-info">
						<div class="player-number cell">17</div>
						<div class="player-name cell">Jones</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/Kabak.jpeg" />
					<div class="player-info">
						<div class="player-number cell">19</div>
						<div class="player-name cell">Kabak</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/jota.jpeg" />
					<div class="player-info">
						<div class="player-number cell">20</div>
						<div class="player-name cell">Jota</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/Tsimikas.jpeg" />
					<div class="player-info">
						<div class="player-number cell">21</div>
						<div class="player-name cell">Tsimikas</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/shaqiri.jpeg" />
					<div class="player-info">
						<div class="player-number cell">23</div>
						<div class="player-name cell">Shaqiri</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/Robertson.jpeg" />
					<div class="player-info">
						<div class="player-number cell">26</div>
						<div class="player-name cell">Robertson</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/origi.jpeg" />
					<div class="player-info">
						<div class="player-number cell">27</div>
						<div class="player-name cell">Origi</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/davies.jpeg" />
					<div class="player-info">
						<div class="player-number cell">28</div>
						<div class="player-name cell">Davies</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/matip.jpeg" />
					<div class="player-info">
						<div class="player-number cell">32</div>
						<div class="player-name cell">Matip</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/williams.jpeg" />
					<div class="player-info">
						<div class="player-number cell">46</div>
						<div class="player-name cell">Williams</div>
					</div>
				</div>

				<div class="player cell">
					<img src="/resource/img/phillips.jpeg" />
					<div class="player-info">
						<div class="player-number cell">47</div>
						<div class="player-name cell">Phillips</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/woodburn.jpeg" />
					<div class="player-info">
						<div class="player-number cell">58</div>
						<div class="player-name cell">Woodburn</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/kelleher.jpeg" />
					<div class="player-info">
						<div class="player-number cell">65</div>
						<div class="player-name cell">Kelleher</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/arnold.jpeg" />
					<div class="player-info">
						<div class="player-number cell">66</div>
						<div class="player-name cell">Alexander-Arnold</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/neco.jpeg" />
					<div class="player-info">
						<div class="player-number cell">76</div>
						<div class="player-name cell">Neco-Williams</div>
					</div>
				</div>
				<div class="player cell">
					<img src="/resource/img/pitaluga.jpeg" />
					<div class="player-info">
						<div class="player-number cell"></div>
						<div class="player-name cell">Pitaluga</div>
					</div>
				</div>

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