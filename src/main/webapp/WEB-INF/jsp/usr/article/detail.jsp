<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/detail.css">
<style>
.selected {
	color: #E31B23;
}
</style>

<body>

	<script>
		var joinFormSubmitDone = false;
		function click_reComment(parent_id) {
			var body="#form_"+parent_id;
			$(body).show();
		}
		function close_reComment(parent_id) {
			var body="#form_"+parent_id;
			console.log(body);
			$(body).hide();
		}
		function checkComment(form){
			var parent_id=form.parent_id.value;
			var body=form.input_memo.value;
			var relTypeCode=form.relTypeCode.value;
			var relId=form.relId.value;
			console.log(parent_id);
			if (joinFormSubmitDone) {
				alert('처리중입니다.');
				return;
			}
			
			form.input_memo.value = form.input_memo.value.trim();
			if (form.input_memo.value.length == 0) {
				alert('댓글내용을 입력해주세요.');
				form.input_memo.focus();
				return;
			}
			console.log(parent_id);
			var fileUploadFormData = new FormData(form);
			$.ajax({
				url : "/usr/reply/doWrite",
				type : "post",
				dataType : "json",
				
				data : { "parent_id" : parent_id,"body":body, "relTypeCode":relTypeCode, "relId":relId},
				success : function(data) {
					if(data == false) {
						alert("중복된 아이디 입니다.");
					} else if(data == true) {
						var message = "사용가능한 아이디 입니다. 사용하시겠습니까?";
						result = window.confirm(message);
					}
				}
			})
			form.submit();
			joinFormSubmitDone = true;
		}
	</script>
	<section class="section-detail row">
		<div class="detail-title">
			<strong><a href="${listUrl}">${board.name }</a></strong>
			<h1>${article.title}</h1>
		</div>
		<div class="writer-info">
			<div class="writer-img cell">
				<c:if test="${article.extra__profileImg != null}">
					<img class="img2 cell" src="${article.extra__profileImg }" />
				</c:if>
				<c:if test="${article.extra__profileImg == null}">
					<img class="img2 cell" src="/resource/img/nonimg.jpg" />
				</c:if>
			</div>
			<div class="writer-profile cell">
				<div class="writer-nickname">
					<strong>${article.extra.writer}</strong>
				</div>
				<div>
					<div class="regdate cell">
						<span>${article.regDate}</span>
					</div>
					<div class="view cell">
						<span>조회 ${article.reading}</span>

					</div>
				</div>
			</div>
		</div>
		<div class="detail-img">
			<c:if test="${article.extra__thumbImg != null}">
				<img src="${article.extra__thumbImg}" alt="" />
			</c:if>
		</div>
		<div class="detail-body">${article.body}</div>
		<div class="detail-edit row">
			<span class="btn-modify cell">
				<c:if test="${article.extra.actorCanModify}">
					<a href="modify?id=${article.id}&redirectUrl=${encodedCurrentUri}">수정</a>
				</c:if>
			</span>

			<span class="btn-delete cell">
				<c:if test="${article.extra.actorCanDelete || isAdmin}">
					<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;"
						href="doDelete?id=${article.id}&listUrl=${listUrl}">삭제</a>
				</c:if>
			</span>
		</div>
	</section>

	<section class="section-comment">
		<div class="comttl">
			<h3>댓글 ${totalCount}개</h3>
		</div>
		<div class="comment-container">
			<c:forEach items="${replies}" var="reply" varStatus="count">
				<c:if test="${reply.redepth==0 }">
					<div class="comment-area row">
						<div class="comment-img cell">
							<c:if test="${reply.extra__profileImg != null}">
								<img class="img2 cell" src="${reply.extra__profileImg }" />
							</c:if>
							<c:if test="${reply.extra__profileImg == null}">
								<img class="img2 cell" src="/resource/img/nonimg.jpg" />
							</c:if>
						</div>
						<div class="comment-info cell">
							<div class="comment-user">
								<strong>${reply.extra.writer}</strong>
							</div>
							<div class="memo${count.index} cell" id="memo${count.index}">${reply.body}</div>
							<div class="row">
								<form action="/usr/reply/doModify" method="POST"
									class="doModify" name="doModify" id="doModify">
									<input type="hidden" name="redirectUrl" value="${currentUri}" />
									<input type="hidden" name="id" value="${reply.id}" />
									<textarea class="comment-modify cell" id="body${count.index}"
										name="body">${reply.body}</textarea>
									<input type="hidden" value="수정" class="comment-modify-btn cell"
										name="modify-btn" />
									<input type="hidden" value="취소" class="comment-cancel-btn cell"
										name="cancel-btn" onclick="fn_cancel(${count.index })" />
								</form>
							</div>
							<div class="row">
								<span class="comment-date cell">${reply.time} </span>
								<div class="button-comment cell">
									<a href="javascript:;" onclick="click_reComment(${reply.id})"
										class="btn">답글</a>
								</div>
							</div>

							<div id="form_${reply.id }" style="display: none">
								<form onsubmit="checkComment(this);return false;" method="post"
									name="write">
									<div class="skin-write-comment">
										<div class="name">
											<input type="hidden" value="${reply.id }" name="parent_id"
												id="parent_id">
											<input type="hidden" name="relTypeCode" value="article" />
											<input type="hidden" name="relId" value="${param.id}" />
										</div>
										<div class="input row">
											<textarea name="memo" placeholder="댓글 쓰기" rows="3" cols="43"
												name="input_memo" id="input_memo" class="input_memo"></textarea>
										</div>
										<div class="input_memo_btn row">
											<input type="submit" accesskey="s" value="입력" name=""
												class="cell">
											<input type="button" accesskey="s" value="취소" name=""
												class="cell can" onclick="close_reComment(${reply.id })">
										</div>
									</div>
								</form>
							</div>

							<div>
								<c:if test="${reply.extra.actorCanModify}">
									<a href="javascript:fn_modify(${count.index })"
										class="comment-edit">수정</a>
								</c:if>
								<c:if test="${reply.extra.actorCanDelete || isAdmin}">
									<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;"
										href="/usr/reply/doDelete?id=${reply.id}&redirectUrl=${encodedCurrentUri}"
										class="comment-edit">삭제</a>
								</c:if>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${reply.redepth>0 }">
					<div class="comment-area row"
						style="padding-left: ${reply.redepth*30}px">
						<div class="comment-img cell">
							<c:if test="${reply.extra__profileImg != null}">
								<img class="img2 cell" src="${reply.extra__profileImg }" />
							</c:if>
							<c:if test="${reply.extra__profileImg == null}">
								<img class="img2 cell" src="/resource/img/nonimg.jpg" />
							</c:if>
						</div>
						<div class="comment-info cell">
							<div class="comment-user">
								<strong>${reply.extra.writer}</strong>
							</div>
							<c:forEach items="${replies}" var="preply" varStatus="i">
								<div class="memo cell" id="memo${i.index}"
									style="margin-right: 1%">
									<c:if test="${reply.reparent == preply.id && reply.redepth>1}">
										<strong>${preply.extra.writer}</strong>
									</c:if>
								</div>
							</c:forEach>
							<div class="memo${count.index} cell" id="memo${count.index}">${reply.body}</div>
							<div class="row">
								<form action="/usr/reply/doModify" method="POST"
									class="doModify" name="doModify" id="doModify">
									<input type="hidden" name="redirectUrl" value="${currentUri}" />
									<input type="hidden" name="id" value="${reply.id}" />
									<textarea class="comment-modify cell" id="body${count.index}"
										name="body">${reply.body}</textarea>
									<input type="hidden" value="수정" class="comment-modify-btn cell"
										name="modify-btn" />
									<input type="hidden" value="취소" class="comment-cancel-btn cell"
										name="cancel-btn" onclick="fn_cancel(${count.index })" />
								</form>
							</div>
							<div class="row">
								<span class="comment-date cell">${reply.time} </span>
								<div class="button-comment cell">
									<a href="javascript:;" onclick="click_reComment(${reply.id})"
										class="btn">답글</a>
								</div>
							</div>

							<div id="form_${reply.id }" style="display: none">
								<form onsubmit="checkComment(this);return false;" method="post"
									name="write">
									<div class="skin-write-comment">
										<div class="name">
											<input type="hidden" value="${reply.id }" name="parent_id"
												id="parent_id">
											<input type="hidden" name="relTypeCode" value="article" />
											<input type="hidden" name="relId" value="${param.id}" />
										</div>
										<div class="input row">
											<textarea name="memo" placeholder="댓글 쓰기" rows="3" cols="43"
												name="input_memo" id="input_memo" class="input_memo"></textarea>
										</div>
										<div class="input_memo_btn row">
											<input type="submit" accesskey="s" value="입력" name=""
												class="cell">
											<input type="button" accesskey="s" value="취소" name=""
												class="cell can" onclick="close_reComment(${reply.id })">
										</div>
									</div>
								</form>
							</div>

							<div>
								<c:if test="${reply.extra.actorCanModify}">
									<a href="javascript:fn_modify(${count.index })"
										class="comment-edit">수정</a>
								</c:if>
								<c:if test="${reply.extra.actorCanDelete || isAdmin}">
									<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;"
										href="/usr/reply/doDelete?id=${reply.id}&redirectUrl=${encodedCurrentUri}"
										class="comment-edit">삭제</a>
								</c:if>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>

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
					<a href="?id=${article.id}&listUrl=${listUrl}&page=1" class="prevEnd">첫 페이지</a>
				</c:if>
				<c:forEach var="i" begin="${pageMenuStart}" end="${pageMenuEnd}">
					<c:set var="className" value="${i == page ? 'selected' : ''}" />
					<a class="${className}" href="?id=${article.id}&listUrl=${listUrl}&page=${i}">${i}</a>

					<!-- 방금 노출된 페이지 번호가 마지막 페이지의 번호였다면, 마지막으로 이동하는 버튼이 노출될 필요가 없다고 설정 -->
					<c:if test="${i == totalPage}">
						<c:set var="goLastBtnNeedToShow" value="false" />
					</c:if>
				</c:forEach>

				<c:if test="${0 == totalPage}">
					<c:set var="goLastBtnNeedToShow" value="false" />
				</c:if>
				<c:if test="${goLastBtnNeedToShow}">
					<a href="?id=${article.id}&listUrl=${listUrl}&page=${totalPage}" class="nextEnd">끝 페이지</a>
				</c:if>
			</div>

			<form action="/usr/reply/doWrite" method="POST" class="comment-write"
				name="comment-write" id="comment-write">

				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${param.id}" />
				<input type="hidden" name="redirectUrl" value="${currentUri}" />
				<input type="hidden" value="${reply.id }" name="parent_id"
					id="parent_id">
				<div>
					<textarea name="body" placeholder="댓글 쓰기" class="comment-body cell"
						style="resize: none" id="comment-body" name="comment-body"></textarea>
				</div>

				<div>
					<input type="submit" value="작성" class="comment-btn cell" />
				</div>
			</form>
		</div>
		<script>
			if(${isLogined}==false){
				$('#comment-write').css('display', 'none');
			}
			else if(${isLogined}==true){
				$('#comment-write').css('display', 'block');
			}

			function fn_modify(count) {
				var memo=".memo"+count;
				var body="#body"+count;
				$(memo).css('display','none');
				$(body).show();
				var test = document.getElementsByName("modify-btn")[count];
				test.setAttribute('type', 'submit');

				var test = document.getElementsByName("cancel-btn")[count];
				test.setAttribute('type', 'button');
			}

			function fn_cancel(count){
				var memo="#memo"+count;
				var body="#body"+count;
				$(memo).show();
				$(body).hide();
				var test = document.getElementsByName("modify-btn")[count];
				test.setAttribute('type', 'hidden');

				var test = document.getElementsByName("cancel-btn")[count];
				test.setAttribute('type', 'hidden');
			} 
		</script>
	</section>
</body>
<%@include file="../part/footer.jsp"%>