<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" scope="page" />
    
<%
String uId = (String)session.getAttribute("idKey");
boolean res = mMgr.deleteMember(uId);

if (res) {
	session.invalidate();
}
%>

<script>
	alert("정상적으로 처리되었습니다.\n확인을 눌러주세요.");
	location.href="Member_Goodbye.jsp";
</script>
