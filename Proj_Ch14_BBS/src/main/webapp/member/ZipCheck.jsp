<%@page import="java.util.Vector, pack_Member.ZipCodeBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean  id="mMgr" class="pack_Member.MemberMgr"  scope="page" />
<%
request.setCharacterEncoding("UTF-8");
String zipChk = request.getParameter("zipChk");
String area3Param = null;

Vector<ZipCodeBean> vList = null;

if (zipChk.equals("n")) {
	area3Param = request.getParameter("area3");
	vList = 	mMgr.zipCodeRead(area3Param);
}
%>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>우편번호 찾기</title>
	<style>
	* {
		box-sizing: border-box;
	}
	div#wrap {
		width: 500px;
		padding: 10px;
		/* border: 1px solid #f00; */
		margin: 10px auto;
		
	}
	
	span#closeWindow {
		width: 40px;
		height: 40px;
		font-size: 30px;
		font-weight: bold;
		text-align: center;
		line-height: 30px;
	    border: 1px solid #ccc;
	    cursor: pointer;
	    display: inline-block;	    
		position: fixed;
		right: 20px;
		bottom: 20px;
	}
	span#closeWindow:hover {
	    border: 2px solid #ccc;
	}
	
	table {
		width: 100%;
	}
	table>caption {
		width: 100%;
		font-size: 26px;
		font-weight: bold;
		padding: 20px;
		border-bottom: 2px solid #ddd;
		margin-bottom: 20px;
	}
	td, input {
		font-size: 18px;
		padding: 6px;
	}
	
	button {
		font-size: 18px;
		font-weight: bold;
		padding: 3px 14px;
		cursor: pointer;
		transform: translateY(2px);
	}
	td.addrList {
		border-bottom: 1px solid #f3f3f3;
		cursor: pointer;
	}
	td.addrList:hover {
		background-color: rgba(128, 128, 128, 0.1);
	}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$(function(){   // 제이쿼리 시작
			//////////////////////// 우편번호 찾기 시작 ///////////////////////////
			function dongChk() {
				
				let area3Val = $("#area3").val();
				if (area3Val == "") {
					alert("동이름을 입력하세요.");
					$("#area3").focus();
					return;
				}
				
				$("#zipFrm").submit();
			}
			$("#findAreaBtn").click(function(){
				dongChk();
			});
			//////////////////////// 우편번호 찾기 끝 ///////////////////////////
			
		});   // 제이쿼리 끝
		
		////////////////////////우편번호 피드백 시작 ///////////////////////////
		function sendAddr(zipCode, area) {
			//alert("zipCode : " + zipCode + "\narea : " + area);
			opener.regFrm.uZip.value = zipCode;
			opener.regFrm.uAddr1.value = area;
			opener.regFrm.uAddr2.focus();
			window.close();
		}
		////////////////////////우편번호 피드백 끝 ///////////////////////////
	</script>
</head>
<body>
	<div id="wrap">
	
		<form name="zipFrm" id="zipFrm">
		
			<table>
				<caption>검색결과</caption>
					<tbody>
						<tr>
							<td>
								동이름 입력
								<input type="text" name="area3" id="area3"
								maxlength="20">
								<button type="button" id="findAreaBtn">검색</button>
							</td>
						</tr>
						
<!-- /////////////////////////// 검색결과 시작 /////////////////////////// -->			
<%
	if (zipChk.equals("n")) {  // outer If
		
		if (vList.isEmpty()) {   // inner If
			%> 
			
						<tr>
							<th>검색된 결과가 없습니다.</th>
						</tr>
			
		<% }  else { 	%> 
			
						<tr>
							<th>※조회 결과의 우편번호를 클릭하세요.</th>
						</tr>
						
		<%
				for(int i=0; i<vList.size(); i++) {
					ZipCodeBean zipBean = vList.get(i);
					String zipCode = zipBean.getZipCode();
					String area1 = zipBean.getArea1();
					String area2 = zipBean.getArea2();
					String area3 = zipBean.getArea3();
					String area4 = zipBean.getArea4();
					
					String area = area1+" "+area2+" "+area3+" "+area4;
		%>         
						<tr>
							<td class="addrList" onclick="sendAddr('<%=zipCode%>', '<%=area%>')">
							<%=zipCode + " " + area%>
							</td>
						</tr>     
		<%								
				}   // for
		%>

<%
			} // inner If
			
		}  // outer If
%>
			
<!-- /////////////////////////// 검색결과 끝 /////////////////////////// -->
						
					</tbody>
			</table>
			
			<input type="hidden" name="zipChk" value="n">
		
		</form>

		<span id="closeWindow" onclick="window.close()">&times;</span>
	</div>
	<!-- div#wrap -->
	
	
	<script src="script/script.js"></script>    
</body>
</html>