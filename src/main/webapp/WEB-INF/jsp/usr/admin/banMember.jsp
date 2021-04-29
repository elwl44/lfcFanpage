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
			alert('정지 사유를 입력해주세요.');
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
				<form name="frm" action="doBanMember" method="post" id="frm"
					onsubmit="joinFormSubmit(this); return false;">
					<dl class="lst_type">
						<dt>
							활동 정지 대상 멤버<em>${members.size()}</em>
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
						<dt>활동 정지 사유</dt>
						<div class="ban_memo">
							<textarea class="ban_memo" maxlength="2000"
								placeholder="내용을 입력해주세요." name="ban_memo" style="resize: none"></textarea>
						</div>
						<dd class="hr"></dd>
						<dt class="hrn">활동 정지 기간</dt>
						<dd class="txt_cont">
							<select name="duration" class="ls t_period" style="width: 100%;">

								<option value="1">1일</option>

								<option value="2">2일</option>

								<option value="3">3일</option>

								<option value="4">4일</option>

								<option value="5">5일</option>

								<option value="6">6일</option>

								<option value="7" selected="">7일</option>

								<option value="8">8일</option>

								<option value="9">9일</option>

								<option value="10">10일</option>

								<option value="11">11일</option>

								<option value="12">12일</option>

								<option value="13">13일</option>

								<option value="14">14일</option>

								<option value="15">15일</option>

								<option value="16">16일</option>

								<option value="17">17일</option>

								<option value="18">18일</option>

								<option value="19">19일</option>

								<option value="20">20일</option>

								<option value="21">21일</option>

								<option value="22">22일</option>

								<option value="23">23일</option>

								<option value="24">24일</option>

								<option value="25">25일</option>

								<option value="26">26일</option>

								<option value="27">27일</option>

								<option value="28">28일</option>

								<option value="29">29일</option>

								<option value="30">30일</option>

								<option value="0">무기한</option>
							</select>
						</dd>
					</dl>
					<p class="dsc" style="padding-bottom: 17px">대상 멤버를 활동 정지
						하시겠습니까?</p>
					<div id="pop_footer">

						<span class="btn-write">
							<input class="check-btn" type="submit" value="활동정지" id="check">
						</span>
						<span class="btn-write">
							<input class="check-btn" type="button" value="취소" id="check" onClick="self.close();">
						</span>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>