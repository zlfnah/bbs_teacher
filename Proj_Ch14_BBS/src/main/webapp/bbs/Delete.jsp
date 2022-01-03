<%@page import="pack_BBS.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="pack_BBS.BoardMgr" scope="page" />
<%
String nowPage = request.getParameter("nowPage");
String s = request.getParameter("num");
int numParam = Integer.parseInt(s);


//검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
//검색어 수신 끝


if (request.getParameter("uPwParam") != null) {
	String uPwParam = request.getParameter("uPwParam");
	// 사용자가 현재 페이지에서 입력한 확인용 비번
	BoardBean bean = (BoardBean)session.getAttribute("bean");
	String uPw = bean.getuPw();    // DB 에 저장되어 있는 실제 비번
	
	if (uPwParam.equals(uPw)) {    // 중첩 IF 시작
		int exeCnt = bMgr.deleteBoard(numParam);
	
		String url = "List.jsp?nowPage="+nowPage;
				 url += "&keyField="+keyField;
				 url += "&keyWord="+keyWord;
%>	
		<script>
			alert("삭제되었습니다!");
			location.href = "<%=url%>";
		</script>
<%	
		//String url = "List.jsp";
		//response.sendRedirect(url);
	} else {
%>		
	<script>
		alert("입력하신 비밀번호가 다릅니다.");
		history.back();
	</script>	
<%		
	} // 중첩 IF 끝
	
} else {  // 외부 IF의 else
%>

 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>게시글 삭제</title>
    <link rel="stylesheet" href="/Proj_Ch14_BBS/style/Style.css">
</head>
<body>
	<div id="wrap">

		<!--  HTML 템플릿(Template, Templet)  헤더 시작 -->
		<h1>BBS 게시글 삭제 비번입력페이지</h1>
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
		
		
		<main id="main" class="delete">   <!-- 본문영역 html 템플릿 시작 -->
				
			<h2>게시글 삭제페이지(비밀번호 입력)</h2>
				
			<form name="delFrm" id="delFrm">	
				<table id="delTbl">
					<tbody>
						<tr>
							<td>
								<input type="password" name="uPwParam" id="uPw"
								   maxlength="20">
							</td>
						</tr>					
					</tbody>
					 
					<tfoot id="readTblFoot">
						<tr>
							<td id="hrTd"><hr></td>							
						</tr>
						<tr>
							<td id="btnAreaTd">
								<button type="button" id="delSbmBtn">삭제하기</button>
								<button type="reset">다시쓰기</button>
								<button type="button" id="backBtn">돌아가기</button>								
							</td>
						</tr>
					</tfoot>
					 
				</table>
				
				<input type="hidden" name="num" value="<%=numParam%>">
				<input type="hidden" name="nowPage" value="<%=nowPage%>">
				
				
				<!-- 검색어전송 시작 -->
				<input type="hidden" name="keyField" id="keyField" value="<%=keyField%>">
				<input type="hidden" name="keyWord" id="keyWord" value="<%=keyWord%>">
				<!-- 검색어전송 끝 -->
				
		  	</form>
			
		
		
		
		
		</main>  <!-- 본문영역 html 템플릿 끝 -->


	</div>
	<!-- div#wrap -->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/Proj_Ch14_BBS/script/Script.js"></script>    
</body>
</html>

<%	
}   // 외부 IF 끝
%>   