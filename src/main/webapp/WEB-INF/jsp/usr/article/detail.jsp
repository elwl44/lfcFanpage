<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/detail.css">
<body>

	<section class="section-detail row">
		<div class="detail-title">
			<strong><a href="${listUrl}">공지사항</a></strong>
			<h1>${article.title}</h1>
		</div>
		<div class="writer-info">
			<div class="writer-img cell">
				<img class="img2 cell" src="/resource/img/nonimg.jpg" />
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
		<div class="detail-body">${article.body}</div>
		<div class="detail-edit row">
			<span class="btn-modify cell">
				<c:if test="${loginedMemberId == article.memberId}">
					<a href="modify?id=${article.id}&redirectUrl=${encodedCurrentUri}">수정</a>
				</c:if>
			</span>

			<span class="btn-delete cell">
				<c:if test="${loginedMemberId == article.memberId}">
					<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;"
						href="doDelete?id=${article.id}">삭제</a>
				</c:if>
			</span>
		</div>
	</section>

	<section class="section-comment">
		<div class="comttl">
			<h3>댓글 ${replies.size()}개</h3>
		</div>
		<div class="comment-container">
			<c:forEach items="${replies}" var="reply" varStatus="count">
				<div class="comment-area row">
					<div class="comment-img cell">
						<img class="img2 cell" src="/resource/img/nonimg.jpg" />
					</div>
					<div class="comment-info cell">
						<div class="comment-user">
							<strong>${reply.extra.writer}</strong>
						</div>
						<div class="memo" id="memo${count.index}">${reply.body}</div>
						<div class="row">
							<form action="/usr/reply/doModify" method="POST" class="doModify"
								name="doModify" id="doModify">
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

						<span class="comment-date row">${reply.time} </span>
						<div>
							<c:if test="${loginedMemberId == reply.memberId}">
								<a href="javascript:fn_modify(${count.index })"
									class="comment-edit">수정</a>
							</c:if>
							<c:if test="${loginedMemberId == reply.memberId}">
								<a onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;"
									href="/usr/reply/doDelete?id=${reply.id}&redirectUrl=${encodedCurrentUri}"
									class="comment-edit">삭제</a>
							</c:if>
						</div>
					</div>
				</div>
			</c:forEach>
			<form action="/usr/reply/doWrite" method="POST" class="comment-write"
				name="comment-write" id="comment-write">

				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${param.id}" />
				<input type="hidden" name="redirectUrl" value="${currentUri}" />

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
				var memo="#memo"+count;
				var body="#body"+count;
				$(memo).hide();
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