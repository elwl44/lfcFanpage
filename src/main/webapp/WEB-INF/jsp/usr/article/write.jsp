<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resource/write.css">
<body>
    <section class="section-write row">
        <div class="write-title">
            <h1 class="con">${board.name } 글쓰기</h1>
        </div>
        <form action="doWrite" method="post" enctype="multipart/form-data">
            <div>
                <input type="text" name="title" id="title" placeholder="제목" class="subject" value="">
            </div>
			<div class="add-file">
				<div class="cell">
					<span>첨부파일 1</span>
				</div>
				<div class="cell">
					<input type="file" name="file__article__0__common__attachment__1"
						class="add-file1" />
				</div>
			</div>
			<div class="add-file">
				<div class="cell">
					<span>첨부파일 2</span>
				</div>
				<div class="cell">
					<input type="file" name="file__article__0__common__attachment__2"
						class="add-file1" />
				</div>
			</div>
            <div>
                <textarea class="write-body-form" maxlength="2000" placeholder="내용을 입력해주세요." name="body" style="resize: none"></textarea>
            </div>
            
            <div>
                <input class="write-btn" type="submit" value="작성" accesskey="s">
            </div>
        </form>
    </section>
</body>
<%@include file="../part/footer.jsp"%>