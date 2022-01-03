<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/ErrorProc.jsp"%>
    
<%@ page import="pack_BBS.BoardBean" %>
<jsp:useBean id="bMgr" class="pack_BBS.BoardMgr"  scope="page" />
<%
request.setCharacterEncoding("UTF-8");

int numParam = Integer.parseInt(request.getParameter("num"));

// 검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
// 검색어 수신 끝

// 현재 페이지 돌아가기 소스 시작
String nowPage = request.getParameter("nowPage");
// 현재 페이지 돌아가기 소스 끝

bMgr.upCount(numParam);    // 조회수 증가
BoardBean bean = bMgr.getBoard(numParam);   
     //  List.jsp에서 클릭한 게시글의 매개변수로 전달된 글번호의 데이터 가져오기
     
int num =  bean.getNum();
String uName	=	bean.getuName();
String subject	= bean.getSubject();
String content	= bean.getContent();
//content.replace("cr", "<br>");

int pos	= bean.getPos();
int ref	= bean.getRef();
int depth	= bean.getDepth();
String regDate	= bean.getRegDate();
String uPw	= bean.getuPw();
int count 	= bean.getCount();
String fileName	= bean.getFileName();
double fileSize 	= bean.getFileSize();
String fUnit = "Bytes";
if(fileSize > 1024) {
	fileSize /= 1024;	
	fUnit = "KBytes";
} 

String ip	= bean.getIp();

session.setAttribute("bean", bean);
%>   	
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글내용 보기</title>
    <link rel="stylesheet" href="/Proj_Ch14_BBS/style/Style.css">
</head>
<body>
	<div id="wrap">

		<!--  HTML 템플릿(Template, Templet)  헤더 시작 -->
		<h1>BBS 내용보기(=뷰 페이지)</h1>
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
		
		
		<main id="main" class="read">   <!-- 본문영역 html 템플릿 시작 -->
			<!--  뷰페이지 내용 출력 시작 -->
		
			<h2><%=subject %></h2>
				
			<table id="readTbl">
				<tbody id="readTblBody">
					<tr>
						<td>작성자</td>  <!-- td.req 필수입력 -->
						<td><%=uName %></td>
						<td>등록일</td>  <!-- td.req 필수입력 -->
						<td><%=regDate %></td>
					</tr>
					<tr>
						<td>첨부파일</td> <!-- td.req 필수입력 -->
						<td colspan="3">
							<input type="hidden" name="fileName" value="<%=fileName%>" 
										id="hiddenFname">
						<% if (fileName != null && !fileName.equals("")) { %>						
							<span id="downloadFile"><%=fileName %></span>							
							(<span><%=(int)fileSize + " " + fUnit%></span>)
						<% } else { %>
							등록된 파일이 없습니다.
						<% } %>
						</td>
					</tr>
					<tr>
						<td colspan="4" id="readContentTd"><pre><%=content %></pre></td>
					</tr>					
				</tbody>
				 
				<tfoot id="readTblFoot">	
					<tr>
						<td colspan="4" id="footTopSpace"></td>							
					</tr>			     
					<tr>
						<td colspan="4" id="articleInfoTd">
							<span><%="조회수 : " + count %></span>
							<span>(<%="IP : " + ip %>)</span>							
						</td>							
					</tr>
					<tr>
						<td colspan="4" id="hrTd"><hr></td>							
					</tr>
					<tr>
						<%
						String listBtnLabel = "";
						if(keyWord.equals("null") || keyWord.equals("")) {
							listBtnLabel = "리스트";
						} else {
							listBtnLabel = "검색목록";
						}
						%>
					
						<td colspan="4" id="btnAreaTd" class="read">
							<button type="button" id="listBtn"><%=listBtnLabel %></button>
							<button type="button" id="modBtn">수 정</button>
							<button type="button" id="replyBtn">답 변</button>
							<button type="button" id="delBtn">삭 제</button>
						</td>
					</tr>
				</tfoot>
				 
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
			<input type="hidden" name="num" value="<%=num%>" id="num">
			
			<!-- 검색어전송 시작 -->
			<input type="hidden" id="pKeyField" value="<%=keyField%>">
			<input type="hidden" id="pKeyWord" value="<%=keyWord%>">
			<!-- 검색어전송 끝 -->
		  
			
		
			<!--  뷰페이지 내용 출력 끝 -->
		</main>  <!-- 본문영역 html 템플릿 끝 -->


	</div>
	<!-- div#wrap -->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/Proj_Ch14_BBS/script/Script.js"></script>    
</body>
</html>