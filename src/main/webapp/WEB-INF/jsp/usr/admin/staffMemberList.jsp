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
						$('#user_data').text(
								data.loginId + "(" + data.name + ")");
						$(".profile-img").css("background-image",
								"url('" + data.extra__thumbImg + "')");
						document.getElementById('membersId').value = data.id;
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
		var member_id = document.getElementById('membersId').value;
		if (confirm("해당 유저를 관리자로 설정 하시겠습니까?") == true) { //확인
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
						location.reload();
					} else {
						alert("이미 관리자 권한을 가지고 있습니다.");
					}
				},
				error : function(request, status, error) { // 오류가 발생했을 때 호출된다. 
					console.log("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			})
		} else {
			return false;
		}
	}
	
	function removeStaff(id) {
		var member_id = id;
		var loginedMemberId= ${loginedMemberId};
		if(id==loginedMemberId){
			alert('자기 자신은 선택할수 없습니다.');
			return;
		}
		if (confirm("관리자 권한을 삭제하시겠습니까?") == true) { //확인
			$.ajax({
				url : "${root}removeStaff",
				type : "post",
				dataType : "json",
				data : {
					"member_id" : member_id
				},
				success : function(data) {
					if (data == true) {
						alert("성공적으로 반영 되었습니다.");
						location.reload();
					} else {
						alert("이미 관리자 권한을 가지고 있습니다.");
					}
				},
				error : function(request, status, error) { // 오류가 발생했을 때 호출된다. 
					console.log("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			})
		} else {
			return false;
		}
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

	<section class="section-notice-list2 row">
		<div class="notice-list-box">
			<div class="notice-list-box-head">
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
					<span>최종방문일</span>
				</div>
				<div class="cell">
					<span>방문수</span>
				</div>
				<div class="cell">
					<span>개시글</span>
				</div>
				<div class="cell">
					<span>스탭삭제</span>
				</div>
			</div>
			<div class="notice-list-box-body">
				<input type="hidden" name="membersId" id="membersId"
					class="membersId" />
				<c:forEach items="${staffmembers}" var="member">
					<input type="hidden" name="userId" id="userId" value="${member.id}" />
					<div class="notice-list-box-row">
						<div class="cell">
							<span>${member.loginId }</span>
						</div>
						<div class="cell">
							<span>${member.name }</span>
						</div>
						<div class="cell">
							<span>${member.email }</span>
						</div>
						<div class="cell">
							<span>${member.lastLogin }</span>
						</div>
						<div class="cell">
							<span>${member.visitCount }</span>
						</div>
						<div class="cell">
							<span>${member.wrtieCount }</span>
						</div>
						<div class="cell">
							<span class="btn-write">
								<a class="btn_type _forceWithdrawal" onclick="removeStaff(${member.id})">해제</a>
							</span>
						</div>
					</div>
				</c:forEach>
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
</body>
<%@include file="../part/footer.jsp"%>