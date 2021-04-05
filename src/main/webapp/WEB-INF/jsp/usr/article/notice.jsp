<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/notice.css">
<body>
    <section class="section-title">
        <h1 class="con">공지사항</h1>
    </section>
    <section class="section-notice-list row">
        <div class="notice-list-box">
            <div class="notice-list-box-head">
                <div class="cell">
                    <span>번호</span>
                </div>
                <div class="cell">
                    <span>제목</span>
                </div>
                <div class="cell">
                    <span>글쓴이</span>
                </div>
                <div class="cell">
                    <span>날짜</span>
                </div>
                <div class="cell">
                    <span>조회수</span>
                </div>
            </div>
            <div class="notice-list-box-body">
            <c:forEach items="${articles}" var="article">
                <div class="notice-list-box-row">
                    <div class="cell">
                        <a href="/usr/article-notice/detail?id=5&amp;listUrl=%2Fusr%2Farticle-notice%2Flist">${article.id}</a>
                    </div>
                    <div class="cell">
                        <a href="/usr/article-notice/detail?id=5&amp;listUrl=%2Fusr%2Farticle-notice%2Flist">${article.title}</a>
                    </div>
                    <div class="cell">
                        <span>${article.writer}</span>
                    </div>
                    <div class="cell">
                        <span>${article.regDate}</span>
                    </div>

                    <div class="cell">
                        <span>${article.reading}</span>
                    </div>
                </div>
            </c:forEach>
            </div>
        </div>
    </section>
    <section class="section-boardNavigation">


        <div class="btnArea row">
            <span class="btn cell">
                <a href="write">글쓰기</a>
            </span>

            <span class="etc cell">
                <a href="#">목록</a>
            </span>
        </div>
        <div class="pagination">
            <a href="#" class="prevEnd">첫 페이지</a>
            <strong>1</strong>
            <a href="#" class="nextEnd">끝 페이지</a>
        </div>
    </section>
    <section class="section-search">
        <form>
            <select name="search_target" class="select-bar cell">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="title_content">제목+내용</option>
                <option value="user_name">이름</option>
                <option value="nick_name">닉네임</option>
                <option value="user_id">아이디</option>
            </select>
            <input type="text" name="search_keyword" value="" class="iText cell" title="검색">
            <span class="search cell">
                <input class="search-btn" type="submit" value="검색">
            </span>
        </form>
    </section>
</body>

<%@include file="../part/footer.jsp"%>