<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resource/style.css">

<link rel="stylesheet" type="text/css" href="/resource/slick/slick.css">
<link rel="stylesheet" type="text/css"
	href="/resource/slick/slick-theme.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/resource/slick/slick.min.js"></script>
<script type="text/javascript" src="/resource/js/slick.js"></script>
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.4.0/animate.min.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
	integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc"
	crossorigin="anonymous">

</head>

<body>
	<div class="site-header">
		<div class="head1 row">
			<ul class="row cell-right">
				<c:if test="${sessionScope.loginedMemberId > 0}">
					<li class="cell">
						<span>${loginedMember.loginId }님</span>
					</li>
					<li class="cell">
						<a href="../member/checkLoginPw">내정보</a>
					</li>
					<li class="cell">
						<a href="../member/doLogout">로그아웃</a>
					</li>
				</c:if>
				<c:if test="${not (sessionScope.loginedMemberId > 0)}">
					<li class="cell">
						<a href="../member/login">로그인</a>
					</li>
					<li class="cell">
						<a href="../member/join">회원가입</a>
					</li>
					<li class="cell">
						<a href="../member/findLoginId">아이디 찾기</a>
					</li>
					<li class="cell">
						<a href="../member/findLoginPw">비밀번호 찾기</a>
					</li>
				</c:if>

			</ul>
		</div>
		<div class="head-info">
			<div class="head-info-left cell">
				<div class="logo-top">
					<div class="logo-box">
						<img src="/resource/img/logo.png" />
					</div>
				</div>
				<div class="logo-down"></div>
			</div>

			<div class="head-info-right cell">
				<div class="team-info row">
					<div class="team-info-img1 cell">
						<img class="img1 cell"
							src="/resource/img/logo-pl-champs-desk-3@2x.png" />
					</div>
					<div class="team-info-img2 cell-right">
						<img class="img2 cell"
							src="/resource/img/sponsor-header-xlarge-2.png" />
					</div>
				</div>
				<div class="menu">
					<ul class="top_menu row">
						<li class="cell">
							<a href="/usr/article/home">HOME</a>
						</li>
						<li class="cell">
							<a href="/usr/article-notice/list">공지</a>
						</li>
						<li class="cell">
							<a href="#team">TEAM</a>
						</li>
						<li class="cell">
							<a href="#news">NEWS</a>
						</li>
						<li class="cell">
							<a href="#comunity">커뮤니티</a>
							<ul>
								<li>
									<a href="/usr/article-soccer/list">축구게시판</a>
								</li>
								<li>
									<a href="/usr/article-free/list">자유게시판</a>
								</li>
							</ul>
						</li>
						<li class="cell">
							<a href="#">LEAGUE TABLE</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>

</html>