<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" scope="page" />

<%
request.setCharacterEncoding("UTF-8");
String uId = (String) session.getAttribute("idKey");

String uName = mMgr.getMemberName(uId);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 페이지</title>
<link rel="stylesheet" href="/Proj_Ch14_BBS/style/Style.css">
<style>

main#main {
	width: 800px;
	text-align: center;
	margin: 0 auto;
}
table {
	width: 440px;
	border: 2px solid #ddd;
	margin: 0 auto;
}

th, td {
	padding: 10px 6px;
	/*		border: 1px solid #000;  */
}

table>caption {
	font-size: 24px;
	font-weight: bold;
	padding: 20px;
}

tr:last-child td {
	text-align: center;
}

td:first-child {
	width: 120px;
	text-align: right;
}

input {
	font-size: 15px;
	padding: 4px 10px;
}

button {
	font-size: 14px;
	font-weight: bold;
	padding: 4px 10px;
	cursor: pointer;
	transform: translateY(1px);
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/Proj_Ch14_BBS/script/Script_Member.js"></script>

</head>
<body>
	<div id="wrap">


		<!--  HTML 템플릿(Template, Templet)  헤더 시작 -->
		<h1>Community</h1>
		<header id="header">
			<nav>
				<ul class="flex-container">
					<li><a href="/Proj_Ch14_BBS/Index.jsp">메인으로</a></li>
					<li>
						<%if ( uId==null ) {  %>
						<a href="/Proj_Ch14_BBS/member/Login.jsp">로그인</a>
						<% } else { %>
						<a href="/Proj_Ch14_BBS/member/Logout.jsp">로그아웃</a>
						<% } %>
					</li>
					<li><a href="/Proj_Ch14_BBS/bbs/Post.jsp">글쓰기</a></li>
					<li><a href="/Proj_Ch14_BBS/bbs/List.jsp">자유게시판 보기</a></li>
				</ul>
			</nav>
		</header>
		<!--  HTML 템플릿(Template, Templet)  헤더 끝 -->


		<main id="main">
			<!-- 본문영역 html 템플릿 시작 -->


			<%
			if (uId != null) { // 현재 로그인 상태라면
			%>

			<h1><%=uName%>
				<span style="font-size: 14px;">님 환영합니다.</span>
			</h1>


			<div style="padding: 10px; margin: 10px;">
				<button onclick="location.href='Member_Mod.jsp'">회원정보수정</button> 
				<button onclick="location.href='Member_Del.jsp'">회원탈퇴</button>
			</div>

			<%
			} else {
			%>

			<form action="LoginProc.jsp" id="loginFrm" name="loginFrm">
				<table>
					<caption>로그인페이지</caption>
					<tbody>
						<tr>
							<td>아이디</td>
							<td><input type="text" class="loginInput" name="uId"
								id="uId"></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><input type="password" class="loginInput" name="uPw"
								id="uPw"></td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" id="loginBtn">로그인</button>
								<button type="button" id="joinBtn">회원가입</button>
							</td>
						</tr>
					</tbody>
				</table>

			</form>


			<%
			}
			%>


		</main>
		<!-- 본문영역 html 템플릿 끝 -->
	</div>
	<!-- div#wrap -->

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="script/script.js"></script>
</body>
</html>