<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="pack_BBS.*"%>
    
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String nowPage = request.getParameter("nowPage");

//검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
//검색어 수신 끝

BoardBean bean = (BoardBean)session.getAttribute("bean");
String subject = bean.getSubject();
String uName = bean.getuName();
String content = bean.getContent();
%>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>게시글 수정페이지</title>
    <link rel="stylesheet" href="/Proj_Ch14_BBS/style/Style.css">
</head>
<body>
	<div id="wrap">

		<!--  HTML 템플릿(Template, Templet)  헤더 시작 -->
		<h1>게시글 수정페이지</h1>
		<header id="header">
			<nav>
				<ul class="flex-container">
					<li><a href="/Proj_Ch14_BBS/Index.jsp">메인으로</a></li>
					<li><a href="#">로그인</a></li>
					<li><a href="/Proj_Ch14_BBS/bbs/Post.jsp">글쓰기</a></li>
					<li><a href="/Proj_Ch14_BBS/bbs/List.jsp">자유게시판 보기</a></li>
				</ul>
			</nav>
		</header>
		<!--  HTML 템플릿(Template, Templet)  헤더 끝 -->
		
		
		<main id="main" class="mod">   <!-- 본문영역 html 템플릿 시작 -->
			<!--  뷰페이지 내용 출력 시작 -->
			
			
			<form name="updateFrm" action="UpdateProc.jsp"
					method="get" id="updateFrm">
		
				<h2><%=subject %></h2>
					
				<table id="modTbl">
					<tbody id="modTblBody">
						<tr>
							<td class="req">작성자</td>
							<td>
								<input type="text" id="uName"
								name="uName" value="<%=uName %>"
									size="50">
							</td>
						</tr>
						<tr>
							<td class="req">제목</td>
							<td>
								<input type="text" name="subject" value="<%=subject %>"
									size="50" id="subject">
							</td>
						</tr>
						<tr>
							<td style="vertical-align: top;">내용</td>
							<td>
								<textarea name="content" id="txtArea"  cols="89" wrap="hard"><%=content %></textarea>
							</td>
						</tr>	
						<tr>
							<td class="req">비밀번호</td>
							<td>
								<input type="password" name="uPw" id="uPw">
								<span style="font-size: 13px;">수정하시려면 동일한 비밀번호가 필요합니다.</span>
							</td>
						</tr>					
					</tbody>
					 
					<tfoot>	
						<tr>
							<td colspan="2" id="footTopSpace"></td>							
						</tr>	
						<tr>
							<td colspan="2" id="hrTd"><hr></td>							
						</tr>
						<tr>
							<td colspan="2" id="btnAreaTd" class="update">
								<button type="button" id="modBtn">수정하기</button>
								<button type="reset">다시쓰기</button>
								<button type="button" id="backBtn">뒤 로</button>							
							</td>
						</tr>
					</tfoot>
					 
				</table>
				<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
				<input type="hidden" name="num" value="<%=num%>" id="num">
				
				<!-- 검색어전송 시작 -->
				<input type="hidden" name="keyField" id="keyField" value="<%=keyField%>">
				<input type="hidden" name="keyWord" id="keyWord" value="<%=keyWord%>">
				<!-- 검색어전송 끝 -->
		
			</form>
			<!--  뷰페이지 내용 출력 끝 -->
			
			
		</main>  <!-- 본문영역 html 템플릿 끝 -->


	</div>
	<!-- div#wrap -->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/Proj_Ch14_BBS/script/Script.js"></script>    
</body>
</html>