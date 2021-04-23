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
		<h1 class="con">리버풀 경기일정</h1>
	</section>
	<section class="section-notice-list row">
		<script>
			$(document).ready(function() {
				$("#list_month${month}").addClass("selected");
			});
		</script>
		<ul class="season_list">
			<li class="cell" id="list_month8">
				<a href="match?input_month=8">8월</a>
			</li>
			<li class="" id="list_month9">
				<a href="match?input_month=9">9월</a>
			</li>
			<li class="" id="list_month10">
				<a href="match?input_month=10">10월</a>
			</li>
			<li class="" id="list_month11">
				<a href="match?input_month=11">11월</a>
			</li>
			<li class="" id="list_month12">
				<a href="match?input_month=12">12월</a>
			</li>
			<li class="" id="list_month1">
				<a href="match?input_month=1">1월</a>
			</li>
			<li class="" id="list_month2">
				<a href="match?input_month=2">2월</a>
			</li>
			<li class="" id="list_month3">
				<a href="match?input_month=3">3월</a>
			</li>
			<li class="" id="list_month4">
				<a href="match?input_month=4">4월</a>
			</li>
			<li class="" id="list_month5">
				<a href="match?input_month=5">5월</a>
			</li>
			<li class="" id="list_month6">
				<a href="match?input_month=6">6월</a>
			</li>
		</ul>
	</section>
	<section id="match_list_section">
		<h2>${month }월</h2>
		<table>
			<tbody>
				<c:forEach items="${matchschedule}" var="article">
					<tr class="laliga">
						<td class="result">
							<span>${article.venue}</span>
						</td>
						<td class="team_home draw">
							<c:choose>
								<c:when test="${article.venue eq 'H'}">
									<b>LiverPool</b>
								</c:when>
								<c:otherwise>
							        ${article.name }
							    </c:otherwise>
							</c:choose>
						</td>
						<td class="score draw">vs</td>
						<td class="team_away draw">
							<c:choose>
								<c:when test="${article.venue eq 'H'}">
							        ${article.name }
							    </c:when>
								<c:otherwise>
									<b> LiverPool</b>
								</c:otherwise>
							</c:choose>
						</td>
						<td class="category">${article.league }</td>
						<td class="description">${article.stadium }·${article.date }
							${article.time }</td>
						<c:if test="${loginedMember.id ==1}">
							<td>
								<a href="/usr/article/modify-match?id=${article.id }">수정</a>
							</td>
							<td>
								<a href="/usr/article-match/doDelete?id=${article.id }&listUrl=${encodedCurrentUri}">삭제</a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${isAdmin }">
			<div class="btnArea row">
				<span class="btn-write cell">
					<a href="/usr/article-match/write">일정 추가</a>
				</span>
			</div>
		</c:if>
	</section>
</body>

<%@include file="../part/footer.jsp"%>