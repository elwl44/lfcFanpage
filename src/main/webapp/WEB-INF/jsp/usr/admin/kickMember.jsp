<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/resource/banMember.css">
<c:set var="memid" value="0" />

<script>
	var joinFormSubmitDone = false;
	function joinFormSubmit(form) {
		if (joinFormSubmitDone) {
			alert('처리중입니다.');
			return;
		}
		form.ban_memo.value = form.ban_memo.value.trim();
		if (form.ban_memo.value.length == 0) {
			alert('강제 탈퇴 사유를 입력해주세요.');
			form.ban_memo.focus();
			return;
		}
		var obj_length = document.getElementsByName("userId").length;
		var arr = [];
		for (var i = 0; i < obj_length; i++) {
			arr.push(document.getElementsByName("userId")[i].value);
		}
		document.getElementById('membersId').value = arr;
		form.submit();
		joinFormSubmitDone = false;
	}
</script>
<body>

	<!-- 전체 팝업사이즈 : 350x472 -->
	<div id="pop_wrap" class="pop_stop">
		<div id="pop_container">
			<div class="pop_content">
				<form name="frm" action="doKickMember" method="post" id="frm"
					onsubmit="joinFormSubmit(this); return false;">
					<dl class="lst_type">
						<dt>
							강제 탈퇴 대상 멤버<em>${members.size()}</em>
						</dt>
						<dd class="txt_cont tooltip_cont">
							<div class="bx_area">
								<div class="bx_inner">
									<ul class="lst_member pers_layer">
										<li>
											<div class="pers_nick_area">
												<div class="pers_nick_area" name="">
													<c:forEach items="${members}" var="member">
														<a href="#" class="nick row">${member.loginId }</a>
														<input type="hidden" name="userId" id="userId"
															value="${member.id}" />
													</c:forEach>
													<input type="hidden" name="membersId" id="membersId"
														class="membersId" />
												</div>
											</div>
										</li>

									</ul>
								</div>
							</div>
						</dd>
						<div class="j_chk">
							<input type="checkbox" name="notJoin" id="rejectchk"
								class="check" value="1">
							<label for="rejectchk">사용자가 재가입 불가하도록 합니다.</label>
						</div>
						<dt>강제 탈퇴 사유</dt>
						<div class="ban_memo">
							<textarea class="ban_memo" maxlength="2000"
								placeholder="내용을 입력해주세요." name="ban_memo" style="resize: none"></textarea>
						</div>
						<dd class="hr"></dd>

						<p class="dsc" style="padding-bottom: 17px">대상 멤버를 강제 탈퇴
							하시겠습니까?</p>
						<div id="pop_footer">

							<span class="btn-write">
								<input class="check-btn" type="submit" value="강제 탈퇴" id="check">
							</span>
							<span class="btn-write">
								<input class="check-btn" type="button" value="취소" id="check"
									onClick="self.close();">
							</span>
						</div>
				</form>
			</div>
		</div>
	</div>
</body>