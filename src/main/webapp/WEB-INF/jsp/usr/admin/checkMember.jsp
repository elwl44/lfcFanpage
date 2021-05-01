<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/checkMember.css">
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
	function showPopup() {
		var obj_length = document.getElementsByName("c1").length;
		if ($('input[name=c1]:checked').length == 0) {
			alert('유저를 선택해주세요.');
			return;
		}
		for (var i = 0; i < obj_length; i++) {
			if (document.getElementsByName("c1")[i].checked == true) {
				if (document.getElementsByName("authLevel")[i].value >= 7) {
					alert('관리자는 활동정지 할 수 없습니다. 스탭권한 해지 후 가능합니다.');
					return;
				}
			}
		}
		var myForm = document.popForm;
		var arr = [];
		var newForm = $('<form></form>');
		newForm.attr("name", "newForm");
		newForm.attr("method", "post");
		newForm.attr("action", "/usr/admin/banMember");
		newForm.attr("target", "popForm");
		for (var i = 0; i < obj_length; i++) {
			if (document.getElementsByName("c1")[i].checked == true) {
				arr.push(document.getElementsByName("c1")[i].value);
			}
		}

		newForm.append($('<input/>', {
			type : 'hidden',
			name : 'id',
			value : arr
		}));
		window
				.open(
						"/usr/admin/banMember",
						"popForm",
						"width=460, height=485, scrollbars=no, toolbar=no, scrollbars=no, location=no, status=yes, menubar=no, resizable=no");
		newForm.appendTo('body');
		newForm.submit();

	}
	function showkickPopup() {
		var obj_length = document.getElementsByName("c1").length;
		if ($('input[name=c1]:checked').length == 0) {
			alert('유저를 선택해주세요.');
			return;
		}
		for (var i = 0; i < obj_length; i++) {
			if (document.getElementsByName("c1")[i].checked == true) {
				if (document.getElementsByName("authLevel")[i].value >= 7) {
					alert('관리자는 강제탈퇴 할 수 없습니다. 스탭권한 해지 후 가능합니다.');
					return;
				}
			}
		}

		var myForm = document.popForm;
		var arr = [];
		var newForm = $('<form></form>');
		newForm.attr("name", "newForm");
		newForm.attr("method", "post");
		newForm.attr("action", "/usr/admin/kickMember");
		newForm.attr("target", "popForm");
		for (var i = 0; i < obj_length; i++) {
			if (document.getElementsByName("c1")[i].checked == true) {
				arr.push(document.getElementsByName("c1")[i].value);
			}
		}

		newForm.append($('<input/>', {
			type : 'hidden',
			name : 'id',
			value : arr
		}));
		window
				.open(
						"/usr/admin/kickMember",
						"popForm",
						"width=460, height=405, scrollbars=no, toolbar=no, scrollbars=no, location=no, status=yes, menubar=no, resizable=no");
		newForm.appendTo('body');
		newForm.submit();

	}
</script>
<body>
	<section class="section-title">
		<h1 class="con">회원 관리 페이지</h1>
		<ul class="season_list">
			<li class="cell selected" id="list_month8">
				<a href="/usr/admin/checkMember">전체멤버 관리</a>
			</li>
			<li class="" id="list_month9">
				<a href="/usr/admin/banMemberlist">활동정지 멤버 관리</a>
			</li>
			<li class="" id="list_month9">
				<a href="/usr/admin/kickMemberlist">강제탈퇴 멤버 관리</a>
			</li>
			<li class="" id="list_month9">
				<a href="/usr/admin/staffMemberlist">스탭 관리</a>
			</li>
		</ul>
		<span class="total">회원 수:${totalCount}</span>
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
					<span>등급</span>
				</div>
				<div class="cell">
					<span>아이디</span>
				</div>

				<div class="cell">
					<span>이름</span>
				</div>
				<div class="cell">
					<span>이메일</span>
				</div>
				<div class="cell">
					<span>가입일</span>
				</div>
				<div class="cell">
					<span>최종방문일</span>
				</div>
				<div class="cell">
					<span>방문수</span>
				</div>
				<div class="cell">
					<span>개시글 수</span>
				</div>
			</div>
			<div class="notice-list-box-body">
				<c:forEach items="${members}" var="member">
					<div class="notice-list-box-row">
						<div class="cell">
							<td class="tc">
								<input type="checkbox" name="c1" id="c1" title="선택"
									class="check _checkMember" value="${member.id }" manager="true"
									staff="false">
								<input type="hidden" name="authLevel" id="authLevel" title="선택"
									class="check _checkMember" value="${member.authLevel }">
							</td>
						</div>
						<div class="cell">
							<c:if test="${member.authLevel==1 }">
								<a href="${detailUrl}">회원</a>
							</c:if>
							<c:if test="${member.authLevel==7 }">
								<a href="${detailUrl}">관리자</a>
							</c:if>
						</div>
						<div class="cell">
							<a href="#">${member.loginId}</a>
						</div>
						<div class="cell">
							<span>${member.name}</span>
						</div>
						<div class="cell">
							<span>${member.email}</span>
						</div>
						<div class="cell">
							<span>${member.regDate}</span>
						</div>
						<div class="cell">
							<c:if test="${member.lastLogin!=null }">
								<span>${member.lastLogin}</span>
							</c:if>
							<c:if test="${member.lastLogin==null }">
								<span>접속 기록없음</span>
							</c:if>
						</div>
						<div class="cell">
							<span>${member.visitCount }</span>
						</div>
						<div class="cell">
							<span>${member.wrtieCount }</span>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="board_action">
				<div class="action_in">
					<input type="checkbox" name="check_all" id="check_all"
						class="check-all">
					<span>선택 멤버를&nbsp;</span>
					<span class="btn-write">
						<a class="btn_type _forceWithdrawal" onclick="showPopup()">활동
							정지</a>
						<a class="btn_type _forceWithdrawal" onclick="showkickPopup()">강제
							탈퇴</a>
					</span>
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
				<option value="id"
					<c:if test="${param.search_target == 'id'}">selected="selected"</c:if>>아이디
				</option>
				<option value="name"
					<c:if test="${param.search_target == 'name'}">selected="selected"</c:if>>이름
				</option>
				<option value="email"
					<c:if test="${param.search_target == 'email'}">selected="selected"</c:if>>이메일
				</option>
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