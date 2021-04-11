<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" href="/resource/style.css">
<link rel="stylesheet" href="/resource/modify.css">
<body>
    <section class="section-modify row">
        <div class="modify-title">
            <h1 class="con">수정</h1>
        </div>
        <form action="doModify" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${article.id}"/>
        <input type="hidden" name="redirectUrl" value="${redirectUrl}"/>
            <div>
                <input type="text" name="title" id="title" placeholder="제목" class="subject" value="${article.title }">
            </div>

            <div>
                <textarea class="modify-body-form" maxlength="2000" placeholder="내용을 입력해주세요." name="body" style="resize: none">${article.body }</textarea>
            </div>

            <div class="edit-btn">
                <div class="cell">
                    <input class="modify-btn" type="submit" value="수정" accesskey="s">
                </div>
                <div class="cell">
                    <input class="cancel-btn cell" type="button" value="취소" onclick="javascript:history.back(-1)">
                </div>
            </div>

        </form>
    </section>

</body>

<%@include file="../part/footer.jsp"%>