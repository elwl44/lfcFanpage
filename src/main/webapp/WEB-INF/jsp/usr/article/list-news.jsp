<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/newslist.css">
<style>
.selected {
	color: #E31B23;
}
</style>

<body>
	<section class="section-title">
		<h1 class="con">${board.name}</h1>
		<span class="total">${totalCount}개의 글</span>
	</section>
	<section class="section-title row">
		<div class="box-list">
			<c:forEach items="${articles}" var="article">
				<c:set var="detailUrl"
					value="/usr/article-${board.code}/detail?id=${article.id}&listUrl=${encodedCurrentUri}" />
				<div class="news-box">
					<a href="${detailUrl}">
						<div class="new-picture">
							<c:if test="${article.extra__thumbImg == null}">
								<p style="background-image: url('/resource/img/noimage.png');"
									class="news-image"></p>
							</c:if>
							<c:if test="${article.extra__thumbImg != null}">
								<p style="background-image: url('${article.extra__thumbImg }');"
									class="news-image"></p>
							</c:if>
						</div>
						<div class="container">
							<div class="news-title">
								<strong>${article.title }</strong>
							</div>
							<span> ${article.extra.writer } · ${article.extra.time } </span>
							<p>${article.body }</p>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
	</section>
	<section class="section-boardNavigation">
		<c:if test="${isAdmin }">
			<div class="btnArea row">
				<span class="btn-write cell">
					<a
						href="/usr/article-${board.code}/write?listUrl=${encodedCurrentUri}">글쓰기</a>
				</span>
			</div>
		</c:if>
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