<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../part/head.jsp"%>
<%@ page import="com.example.lfcFan.controller.usr.MemberController"%>
<link rel="stylesheet" type="text/css" href="/resource/info.css">
<head>

</head>
<body>
<section class="section-info row">
        <div class="info-title">
            <h1 class="con">내정보</h1>
        </div>
        <div class="ctable even row">
            <table>
                <tbody>
                    <tr>
                        <th scope="row">아이디</th>
                        <td class="text"><span>${member.loginId} </span></td>
                    </tr>
                    <tr>
                        <th scope="row">이름</th>
                        <td class="text"><span>${member.name}</span></td>
                    </tr>
                    <tr>
                        <th scope="row">이메일 주소</th>
                        <td class="text"><span>${member.email }</span></td>
                    </tr>
                    <tr>
                        <th>가입일</th>
                        <td class="text"><span>${member.regDate }</span></td>
                    </tr>
                    <tr>
                        <th>최근 정보변경</th>
                        <td class="text"><span>${member.updateDate }</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="btnArea row row">
            <span class="btn-write cell-right">
                <a href="write">탈퇴</a>
            </span>

            <span class="btn-write cell-right">
                <a href="write">비밀번호 변경</a>
            </span>
            <span class="btn-write cell-right">
                <a href="modify">회원정보 변경</a>
            </span>
        </div>
    </section>

</body>

<%@include file="../part/footer.jsp"%>