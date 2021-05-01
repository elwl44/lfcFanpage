<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/staffMemberList.css">
<style>
.selected {
	color: #E31B23;
}
</style>
<script>
	function fn_idCheck(form) {
		var search_value = $('#mem_srch').val();
		var obj_length = $('#mem_srch').val().trim().length;
		if (obj_length == 0) {
			alert('검색 아이디를 입력하세요.');
			return;
		}

		$.ajax({
			url : "${root}searchMember",
			type : "post",
			dataType : "json",
			data : {
				"search_id" : search_value
			},
			success : function(data) {
				if (data != null) {
					if (data.name != null) {
						$(".profile-img").css("display", "block");
						$(".user_check").css("display", "block");
						$(".save_txt").css("display", "flex");
						$(".btn-save").css("display", "block");
						$("#memberInfoList").show();
						$('#user_data').text(data.loginId + "(" + data.name + ")");
						$(".profile-img").css("background-image","url('" + data.extra__thumbImg + "')");
						document.getElementById('membersId').value=data.id;
						if (data.extra__thumbImg == null) {
							$(".profile-img").css("background-image",
									"url('/resource/img/none-profile.jpg')");
						}
					} else {
						$("#memberInfoList").show();
						$('#user_data').text(data.loginId + "님은 카페 멤버가 아닙니다.");
						$(".profile-img").css("display", "none");
						$(".user_check").css("display", "none");
						$(".save_txt").css("display", "none");
						$(".btn-save").css("display", "none");
					}
				}
			},
			error : function(request, status, error) { // 오류가 발생했을 때 호출된다. 
				console.log("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);

			}
		})
	}
	function save_click(form) {
		if ($('input[name=user_check]:checked').length == 0) {
			alert('유저를 선택해주세요.');
			return;
		}
		var member_id=document.getElementById('membersId').value;
		$.ajax({
			url : "${root}appointStaff",
			type : "post",
			dataType : "json",
			data : {
				"member_id" : member_id
			},
			success : function(data) {
				if (data == true) {
					alert("성공적으로 반영 되었습니다.");
				}
				else{
					alert("이미 관리자 권한을 가지고 있습니다.");
				}
			},
			error : function(request, status, error) { // 오류가 발생했을 때 호출된다. 
				console.log("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
</script>
<body>
	<section class="section-title">
		<h1 class="con">스탭 관리</h1>
		<ul class="season_list">
			<li class="cell" id="list_month8">
				<a href="/usr/admin/checkMember">전체멤버 관리</a>
			</li>
			<li class="" id="list_month9">
				<a href="/usr/admin/banMemberlist">활동정지 멤버 관리</a>
			</li>
			<li class="" id="list_month9">
				<a href="/usr/admin/kickMemberlist">강제탈퇴 멤버 관리</a>
			</li>
			<li class="selected" id="list_month9">
				<a href="/usr/admin/staffMemberlist">스탭 관리</a>
			</li>
		</ul>
	</section>
	<section class="section-notice-list row">
		<tr class="last">
			<th>
				<strong>스탭 추가</strong>
			</th>
			<td>
				<div class="group_input_frm">
					<div class="srch_in">
						<select id="searchType" style="width: 86px; height: 19px">
							<option value="id">아이디</option>
						</select>
						<input type="text" id="mem_srch" class="mem_srch"
							style="width: 248px; padding-left: 7px">
						<span class="btn-search">
							<a class="btn_type _forceWithdrawal" onclick="fn_idCheck()">검색</a>
						</span>
					</div>
					<div id="memberInfoList" name="memberInfoList"
						class="memberInfoList" style="display: none;">
						<ul id="search_result" class="mem_choice row">
							<li id="memberInfo" name="memberInfo">
								<div class="info">
									<input type="radio" id="user_check" name="user_check"
										class="user_check  cell">
									<p id="profile-img" class="profile-img cell"
										style="width: 20px; height: 20px" class="profile-img"></p>
									<label for="r1" id="user_data" class="user_data cell">astra클랜홍보2(pbk1908)</label>									
								</div>
							</li>
						</ul>
						<ul id="save_txt" class="save_txt row">
							<li>선택한 멤버를 스탭으로 선정하시려면 '임명'을 눌러주세요.</li>
						</ul>
						<span class="btn-save row">
							<a class="btn_type _forceWithdrawal" onclick="save_click()">임명</a>
						</span>
					</div>
				</div>
			</td>
		</tr>
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
					<span>이메일</span>
				</div>
				<div class="cell">
					<span>사유</span>
				</div>
				<div class="cell">
					<span>처리일</span>
				</div>
				<div class="cell">
					<span>처리자</span>
				</div>
				<div class="cell">
					<span>가입불가 여부</span>
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
							<a href="#">${member.memberEmail}</a>
						</div>
						<div class="cell">
							<a href="#">${member.body}</a>
						</div>
						<div class="cell">
							<a href="#">${member.startDate}</a>
						</div>
						<div class="cell">
							<a href="#">${member.staff}</a>
						</div>
						<div class="cell">
							<c:if test="${member.notJoin==0 }">
								<a href="#">가입가능</a>
							</c:if>
							<c:if test="${member.notJoin==1 }">
								<a href="#">가입불가능</a>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="board_action">
				<div class="action_in">
					<form action="doAbleJoin" method="post" name="doAbleJoin">
						<input type="hidden" name="membersId" id="membersId"
							class="membersId" />
						<input type="checkbox" name="check_all" id="check_all"
							class="check-all">
						<span>선택 멤버를&nbsp;</span>
						<span class="btn-write">
							<a class="btn_type _forceWithdrawal" onclick="removeCheck()">가입불가
								해제</a>
							<a class="btn_type unAbleJoin" name="unAbleJoin" id="unAbleJoin"
								onclick="unAbleJoinClick()">가입불가</a>
						</span>
					</form>
					<form action="doUnAbleJoin" method="post" name="doUnAbleJoin">
						<input type="hidden" name="memberId" id="memberId"
							class="memberId" />
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
				<option value="email"
					<c:if test="${param.search_target == 'email'}">selected="selected"</c:if>>이메일</option>
				<option value="staff"
					<c:if test="${param.search_target == 'staff'}">selected="selected"</c:if>>처리자</option>
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