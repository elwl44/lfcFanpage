<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/match-list.css">
<style>
.selected {
	color: #E31B23;
}
</style>

<body>
	<section class="section-title">
		<h1 class="con">${board.name}</h1>
	</section>
	<section class="section-notice-list row">
		<ul class="season_list">
			<li class="selected cell">
				<a href="18-19.php">8월</a>
			</li>
			<li class="">
				<a href="17-18.php">9월</a>
			</li>
			<li class="">
				<a href="16-17.php">10월</a>
			</li>
			<li class="">
				<a href="15-16.php">11월</a>
			</li>
			<li class="">
				<a href="14-15.php">12월</a>
			</li>
			<li class="">
				<a href="13-14.php">1월</a>
			</li>
			<li class="">
				<a href="12-13.php">2월</a>
			</li>
			<li class="">
				<a href="11-12.php">3월</a>
			</li>
			<li class="">
				<a href="10-11.php">4월</a>
			</li>
			<li class="">
				<a href="09-10.php">5월</a>
			</li>
			<li class="">
				<a href="08-09.php">6월</a>
			</li>
		</ul>
		</section>
		<section id="match_list_section">
			<h2>20-21 시즌</h2>
			<table>
				<tbody>
					<tr class="laliga">
						<td class="team_home draw">Getafe</td>
						<td class="score draw">vs</td>
						<td class="team_away draw">
							<b>Real Madrid</b>
						</td>
						<td class="category">La Liga 33R</td>
						<td class="description">Coliseum Alfonso Pérez · 2021.04.18</td>
					</tr>
					<tr class="champions">
						<td class="team_home draw">Liverpool</td>
						<td class="score draw">vs</td>
						<td class="team_away draw">
							<b>Real Madrid</b>
						</td>
						<td class="category">Champions League QF 2L</td>
						<td class="description">Estadio Alfredo Di Stéfano ·
							2021.04.15</td>
					</tr>
					<tr class="laliga">
						<td class="team_home home">
							<b>Real Madrid</b>
						</td>
						<td class="score home">vs</td>
						<td class="team_away home">Barcelona</td>
						<td class="category">La Liga 30R</td>
						<td class="description">Alfredo di Stéfano · 2021.04.10</td>
					</tr>
				</tbody>
			</table>
		</section>
</body>

<%@include file="../part/footer.jsp"%>