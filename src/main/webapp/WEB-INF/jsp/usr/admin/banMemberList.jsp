<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/banMemberList.css">
<style>
.selected {
	color: #E31B23;
}
</style>
<script>
	$(document).ready(function() {
		$('.check-all').click(function() {
			$('._checkMember').prop('checked', this.checked);
			$('.check-all').prop('checked', this.checked);
		});
	});
	function removeCheck() {
		if ($('input[name=c1]:checked').length == 0) {
			alert('유저를 선택해주세요.');
			return;
		}
		if (confirm("활동이 가능하도록 처리하시겠습니까?") == true) { //확인
			var obj_length = document.getElementsByName("userId").length;
			var arr = [];
			for (var i = 0; i < obj_length; i++) {
				if (document.getElementsByName("c1")[i].checked == true) {
					arr.push(document.getElementsByName("userId")[i].value);
				}
			}
			document.getElementById('membersId').value = arr;
			document.doStopBan.submit();
		} else { //취소
			return false;

		}
	}
</script>
<body>
	<section class="section-title">
		<h1 class="con">활동정지 멤버 관리</h1>
		<ul class="season_list">
			<li class="cell" id="list_month8">
				<a href="/usr/admin/checkMember">전체멤버 관리</a>
			</li>
			<li class="selected" id="list_month9">
				<a href="/usr/admin/banMemberlist">활동정지 멤버 관리</a>
			</li>
		</ul>
		<span class="total">활동정지 멤버:${totalCount}</span>
	</section>
	<section class="section-notice-list row">
		<div class="notice-list-box">
			<div class="notice-list-box-head">
				<div class="cell">
					<td class="tc">
						<input type="checkbox" name="check_all" id="check_all"
							class="check-all">
					</td>
				</div>
				<div class="cell">
					<span>아이디</span>
				</div>
				<div class="cell">
					<span>이름</span>
				</div>
				<div class="cell">
					<span>사유</span>
				</div>
				<div class="cell">
					<span>처리일</span>
				</div>
				<div class="cell">
					<span>종료일</span>
				</div>
				<div class="cell">
					<span>처리자</span>
				</div>
			</div>
			<div class="notice-list-box-body">
				<c:forEach items="${banmembers}" var="member">
					<input type="hidden" name="userId" id="userId"
						value="${member.memberid}" />
					<div class="notice-list-box-row">
						<div class="cell">
							<td class="tc">
								<input type="checkbox" name="c1" id="c1" title="선택"
									class="check _checkMember" value="${member.id }" manager="true"
									staff="false">
							</td>
						</div>
						<div class="cell">
							<a href="#">${member.extra.nickname}</a>
						</div>
						<div class="cell">
							<a href="#">${member.extra.name}</a>
						</div>
						<div class="cell">
							<a href="#">${member.body}</a>
						</div>
						<div class="cell">
							<a href="#">${member.startDate}</a>
						</div>
						<div class="cell">
							<a href="#">${member.finishDate}</a>
						</div>
						<div class="cell">
							<a href="#">${member.staff}</a>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="board_action">
				<div class="action_in">
					<form action="doStopBan" method="post" name="doStopBan">
						<input type="hidden" name="membersId" id="membersId"
							class="membersId" />
						<input type="checkbox" name="check_all" id="check_all"
							class="check-all">
						<span>선택 멤버를&nbsp;</span>
						<span class="btn-write">
							<a class="btn_type _forceWithdrawal" onclick="removeCheck()">활동
								정지 해제</a>
						</span>
					</form>
				</div>
			</div>
		</div>
	</section>
	<section class="section-boardNavigation">
		<div class="pagination">
			<!-- 첫 페이지로 이동버튼이 노출될 필요가 있는지 여부 -->
			<c:set var="goFirstBtnNeedToShow"
				value="${page > pageMenuArmSize + 1}" />

			<!-- 마지막 페이지로 이동버튼이 노출될 필요가 있는지 여부 -->
			<c:set var="goLastBtnNeedToShow" value="true" />

			<c:if test="${0 == totalPage}">
				<c:set var="goFirstBtnNeedToShow" value="false" />
			</c:if>

			<!-- 첫 페이지로 이동버튼이 노출될 필요가 있다면 노출 -->
			<c:if test="${goFirstBtnNeedToShow}">
				<a
					href="?page=1&search_target=${search_target }&searchKeyword=${param.searchKeyword}"
					class="prevEnd">첫 페이지</a>
			</c:if>

			<c:forEach var="i" begin="${pageMenuStart}" end="${pageMenuEnd}">
				<c:set var="className" value="${i == page ? 'selected' : ''}" />
				<a class="${className}"
					href="?page=${i}&search_target=${search_target}&searchKeyword=${param.searchKeyword}">${i}</a>

				<!-- 방금 노출된 페이지 번호가 마지막 페이지의 번호였다면, 마지막으로 이동하는 버튼이 노출될 필요가 없다고 설정 -->
				<c:if test="${i == totalPage}">
					<c:set var="goLastBtnNeedToShow" value="false" />
				</c:if>
			</c:forEach>

			<c:if test="${0 == totalPage}">
				<c:set var="goLastBtnNeedToShow" value="false" />
			</c:if>
			<c:if test="${goLastBtnNeedToShow}">
				<a
					href="?page=${totalPage}&search_target=${search_target}&searchKeyword=${param.searchKeyword}"
					class="nextEnd">끝 페이지</a>
			</c:if>

		</div>
	</section>
	<section class="section-search">
		<form>
			<select name="search_target" class="select-bar cell">
				<option value="title"
					<c:if test="${search_target == 'title'}">selected="selected"</c:if>>제목</option>
				<option value="body"
					<c:if test="${search_target == 'body'}">selected="selected"</c:if>>내용</option>
				<option value="title_content"
					<c:if test="${search_target == 'title_content'}">selected="selected"</c:if>>제목+내용</option>
				<option value="name"
					<c:if test="${search_target == 'name'}">selected="selected"</c:if>>이름</option>
				<option value="loginId"
					<c:if test="${search_target == 'loginId'}">selected="selected"</c:if>>아이디</option>
			</select>
			<input type="text" name="searchKeyword"
				value="${param.searchKeyword }" class="iText cell" title="검색">
			<span class="search cell">
				<input class="search-btn" type="submit" value="검색">
			</span>
		</form>
	</section>
</body>
<%@include file="../part/footer.jsp"%>