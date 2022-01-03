<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" scope="page" />
<%
String uId = (String)session.getAttribute("idKey");

String uName = mMgr.getMemberName(uId);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글쓰기 페이지(Post)</title>
    <link rel="stylesheet" href="/Proj_Ch14_BBS/style/Style.css">
</head>
<body>
	<div id="wrap">

		<!--  HTML 템플릿(Template, Templet)  헤더 시작 -->
		<h1>글쓰기 페이지(Post)</h1>
		<header id="header" style="position: relative;">
		<% if (uId != null) { %>
			<button onclick="location.href='/Proj_Ch14_BBS/member/Member_Mod.jsp'"
			style="padding: 2px 16px; position: absolute; right: 30px; top:-30px">회원정보수정</button>
		<% } %>
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
		
		
		<main id="main" class="post">   <!-- 본문영역 html 템플릿 시작 -->
		
			<h2>글쓰기</h2>
			
			<form name="postFrm" action="PostProc.jsp"
			enctype="multipart/form-data" method="post" id="postFrm">
			
				<table>
					<tbody>
						<tr>
							<td class="req">성명</td>  <!-- td.req 필수입력 -->
							<td>
								<%=uName%>
								<input type="hidden" name="uName" id="uName" value="<%=uName%>">
							</td>
						</tr>
						<tr>
							<td class="req">제목</td> <!-- td.req 필수입력 -->
							<td>
								<input type="text" name="subject"
								maxlength="50" id="subject">
							</td>
						</tr>
						<tr>
							<td class="contentTD">내용</td>
							<td>
								<textarea name="content" id="content" cols="60" wrap="hard"></textarea>
							</td>
						</tr>
						<tr>
							<td>파일첨부</td>
							<td>
								<span class="spanFile">
									<input type="file" name="fileName"
									 id="fileName">
								</span>	
							</td>
						</tr>
						<tr>
							<td>내용타입</td>
							<td>
								<label>
									<input type="radio" name="contentType"
										value="HTML">									
									<span>HTML</span>	
								</label>
								<label>
									<input type="radio" name="contentType"
										value="TEXT" checked>
									<span>TEXT</span>
								</label>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2"><hr>	</td>							
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" id="regBtn">등록</button>
								<button type="reset">다시쓰기</button>
								<button type="button" id="listBtn">리스트</button>
							</td>
						</tr>
					</tfoot>
				</table>
				<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			    <!--  
			    IP주소를 IPv4 형식으로 설정함.(IPv6 형식이 기본으로 설정되어 있음)
			    프로젝트 => Run Configuration => Tomcat 클릭
			    => (x)Argument => VM arguments 입력란 =>
			    -Djava.net.preferIPv4Stack=true  
			     -->
			
			
			
			</form>
		
		
		
		
		</main>  <!-- 본문영역 html 템플릿 끝 -->


	</div>
	<!-- div#wrap -->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/Proj_Ch14_BBS/script/Script.js"></script>    
</body>
</html>