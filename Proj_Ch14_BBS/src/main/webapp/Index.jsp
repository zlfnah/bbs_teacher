<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" scope="page" />
<%
String uId = (String) session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인페이지</title>
<link rel="stylesheet" href="/Proj_Ch14_BBS/style/Style.css">
</head>
<body>
	<div id="wrap">

		<!--  HTML 템플릿(Template, Templet)  헤더 시작 -->
		<h1>Community</h1>
		<header id="header" style="position: relative;">
			<%
			if (uId != null) {
			%>
			<button onclick="location.href='/Proj_Ch14_BBS/member/Member_Mod.jsp'"
			style="padding: 2px 16px; position: absolute; right: 30px; top:-30px">회원정보수정</button>
			<%
			} 
			%>
			
			<nav>
				<ul class="flex-container">
					<li><a href="/Proj_Ch14_BBS/Index.jsp">메인으로</a></li>
					<li>
						<% if (uId == null) { %> 
							<a href="/Proj_Ch14_BBS/member/Login.jsp">로그인</a>
						<%  } else { %> 
							<a href="/Proj_Ch14_BBS/member/Logout.jsp">로그아웃</a> 
						<% } %>
					</li>
					<li>
						<% if (uId == null) { %> 
							<a href="#" onclick="alert('로그인이 필요합니다.'); return false;">글쓰기</a>
						<%  } else { %> 
							<a href="/Proj_Ch14_BBS/bbs/Post.jsp">글쓰기</a>
						<% } %>
					</li>
					<li><a href="/Proj_Ch14_BBS/bbs/List.jsp">자유게시판 보기</a></li>
				</ul>
			</nav>
		</header>
		<!--  HTML 템플릿(Template, Templet)  헤더 끝 -->


		<main id="main">
			<!-- 본문영역 html 템플릿 시작 -->


			<h2>커뮤니티 사이트 메인입니다.</h2>


		</main>
		<!-- 본문영역 html 템플릿 끝 -->

	</div>
	<!-- div#wrap -->

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/Proj_Ch14_BBS/script/Script.js"></script>
</body>
</html>