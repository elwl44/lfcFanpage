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
	<div class="wrapper">
		<header id="site-header" class="site-header" role="banner">
			<div class="site-header-inner">
				<div class="masthead">
					<ul class="account-links logged-out-only">
						<c:if test="${sessionScope.loginedMemberId > 0}">
							<li class="subnav">
								<span>${loginedMember.loginId }님</span>
							</li>
							<li class="subnav">
								<a href="../admin/checkMember">회원 관리</a>
							</li>
							<li class="subnav">
								<a href="../member/checkLoginPw">내정보</a>
							</li>
							<li class="subnav">
								<a href="../member/doLogout">로그아웃</a>
							</li>
						</c:if>
						<c:if test="${not (sessionScope.loginedMemberId > 0)}">
							<li class="subnav">
								<a href="../member/login">로그인</a>
							</li>
							<li class="subnav">
								<a href="../member/join">회원가입</a>
							</li>
							<li class="subnav">
								<a href="../member/findLoginId">아이디 찾기</a>
							</li>
							<li class="subnav">
								<a href="../member/findLoginPw">비밀번호 찾기</a>
							</li>
						</c:if>
					</ul>
				</div>
				<div class="logo">
					<a class="logo-large" title="Home" href="/">
						<img
							src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/JE-617/lfc/images/logo.png"
							alt="Liverpool FC">
					</a>
					<a class="logo-medium" title="Home" href="/">
						<img
							src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/JE-617/lfc/images/logo.png"
							alt="Liverpool FC">
					</a>
					<a class="logo-small" title="Home" href="/">
						<img
							src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/JE-617/lfc/images/lfc-pl-logos-full@2x.png"
							alt="Liverpool FC">
					</a>
				</div>
				<div class="crest-side">
					<img
						src="https://d3j2s6hdd6a7rg.cloudfront.net/v2/JE-617/lfc/images/logo-pl-champs-desk-3@2x.png"
						alt="Premier League Champions 2019/20 logo">
				</div>
				<a href="//www.sc.com/en/" class="sponsor" target="main-sponsor">
					Main Club Sponsor: Standard Chartered </a>
				<div class="search"></div>

				<nav class="main-menu">
					<ul>
						<li class="active-news hasDropMenu">
							<a href="/usr/article/home">HOME</a>
						</li>
						<li class=" ">
							<a href="/usr/article-notice/list">공지사항</a>
						</li>
						<li class="hasDropMenu">
							<a href="/usr/article/team">TEAM</a>
						</li>
						<li class="hasDropMenu">
							<a href="/usr/article-news/list">NEWS</a>
						</li>
						<li class="hasDropMenu">
							<a href="/usr/article-soccer/list">커뮤니티</a>
							<ul>
								<li>
									<a href="/usr/article-soccer/list">축구게시판</a>
								</li>
								<li>
									<a href="/usr/article-free/list">자유게시판</a>
								</li>
							</ul>
						</li>
						<li class="bp-medium-more-min-large-primary  hasDropMenu">
							<a href="/usr/article/leaguetable">LEAGUE TABLE</a>
						</li>
						<li class="bp-medium-more-min-large-primary  hasDropMenu">
							<a href="/usr/article/match">Match</a>
						</li>
					</ul>
				</nav>
			</div>
		</header>
	</div>
	<nav class="mobile-main-menu">
		<ul>
			<li class=" ">
				<a href="/usr/article-notice/list">공지사항</a>
			</li>
			<li class="hasDropMenu">
				<a href="/usr/article/team">TEAM</a>
			</li>
			<li class="hasDropMenu">
				<a href="/usr/article-news/list">NEWS</a>
			</li>
			<li class="hasDropMenu">
				<a href="/usr/article-soccer/list">커뮤니티</a>
				<ul>
					<li>
						<a href="/usr/article-soccer/list">축구게시판</a>
					</li>
					<li>
						<a href="/usr/article-free/list">자유게시판</a>
					</li>
				</ul>
			</li>
			<li class="bp-medium-more-min-large-primary  hasDropMenu">
				<a href="/usr/article/leaguetable">LEAGUE TABLE</a>
			</li>
			<li class="bp-medium-more-min-large-primary  hasDropMenu">
				<a href="/usr/article/match">Match</a>
			</li>
		</ul>
	</nav>
</body>
</html>