<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="pack_BBS.BoardMgr" scope="page" />
<%
bMgr.insertBoard(request);
response.sendRedirect("List.jsp");
%>
    