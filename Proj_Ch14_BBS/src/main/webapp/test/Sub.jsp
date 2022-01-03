<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">      <!-- test/Sub.jsp -->
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
    <link rel="stylesheet" href="/Proj_Ch14_BBS/style/Style.css">
</head>
<body>
	<div id="wrap">
	
		<h1>test/Sub.jsp</h1>
		<br><br>
		<h2>상대경로 적용</h2>
		<br><br>
		<a href="../TestMain.jsp">TestMain.jsp로 이동</a>
		<br><br>
		<h2>절대경로 적용</h2>
		<br><br>
		<a href="/Proj_Ch14_BBS/TestMain.jsp">TestMain.jsp로 이동</a>
		

	</div>
	<!-- div#wrap -->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="script/Script.js"></script>    
</body>
</html>