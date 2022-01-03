<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<jsp:useBean  id="mMgr"   class="pack_Member.MemberMgr"  scope="page" />

<%
request.setCharacterEncoding("UTF-8");
String uId = request.getParameter("uId");
boolean result = mMgr.checkId(uId);
%>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>ID 중복체크</title>
    <link rel="stylesheet" href="style/style.css">
    <script>
    function fnClose() {    	
    	opener.regFrm.uIdBtnClickChk.value = "1";    
    	opener.regFrm.uId.focus();
    	window.close();
    }
    
    </script>
</head>
<body>
	<div id="wrap">
		<h1><%=uId %></h1>
		<%
		if (result) {
			out.println("는 이미 존재하는 ID입니다.");
		} else {
			out.println("는 사용가능합니다.");
		}		
		%>
		
		<button type="button" onclick="fnClose()">
			닫기
		</button>

	</div>
	<!-- div#wrap -->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="script/script.js"></script>    
</body>
</html>