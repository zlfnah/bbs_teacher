<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/ErrorProc.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="pack_BBS.BoardMgr" scope="page" />
<%
bMgr.downLoad(request, response, out, pageContext);
String[] str = {};
bMgr.main(str);
%>    
    