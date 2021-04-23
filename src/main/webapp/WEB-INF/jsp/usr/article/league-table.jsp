<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/league.css">

<section class="section-join row">
	<div class="join-title">
		<h1 class="con">League Table</h1>
	</div>
	<div class="league-table">
		<table class="full-table">
			<thead>
				<td class="team-lanking">순위</td>
				<td class="team-name">팀명</td>
				<td class="team-game">경기</td>
				<td class="team-point">승점</td>
				<td class="team-win">승</td>
				<td class="team-draw">무</td>
				<td class="team-lose">패</td>
				<td class="team-win">득점</td>
				<td class="team-draw">실점</td>
				<td class="team-lose">득실차</td>
				<c:if test="${isAdmin}">
					<td class="team-lose2">수정</td>
				</c:if>
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
						<td>${League.gainGoal}</td>
						<td>${League.loseGoal}</td>
						<td>${League.goalGap}</td>
						<c:if test="${isAdmin}">
							<td>
								<a href="/usr/article/modify-league?id=${League.id }" >수정</a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</section>


<%@include file="../part/footer.jsp"%>