<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>

<link rel="stylesheet" href="/Proj_Ch14_BBS/style/Style.css">
<style>


form#regFrm {
	width: 660px;
	padding: 10px;
	/*border: 1px solid #000;*/
	margin: 10px auto;
}

table {
	width: 100%;
	/*border: 1px solid #000;*/
}

th, td {
	padding: 10px 6px;
	/*		border: 1px solid #000;  */
}

table>caption {
	font-size: 24px;
	font-weight: bold;
	padding: 20px;
	border-bottom: 2px solid #ddd;
}

tr:last-child td {
	text-align: center;
}

td:first-child {
	width: 120px;
	text-align: right;
}

input {
	font-size: 15px;
	padding: 4px 10px;
}

input.uAddr {
	border: none;
	border-bottom: 1px solid #ddd;
	outline: none;
}

td#hobbyArea span:hover {
	color: #555;
	cursor: pointer;
}

td.req::after { /* 입력 필수 */
	content: " *";
	color: #f80;
	font-size: 20px;
}

button {
	font-size: 14px;
	font-weight: bold;
	padding: 4px 10px;
	cursor: pointer;
	transform: translateY(1px);
}

select {
	font-size: 18px;
	transform: translateY(2px);
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/Proj_Ch14_BBS/script/Script_Member.js"></script>
</head>
<body>
	<div id="wrap">


		<!--  HTML 템플릿(Template, Templet)  헤더 시작 -->
		<h1>Join</h1>
		<header id="header">
			<nav>
				<ul class="flex-container">
					<li><a href="/Proj_Ch14_BBS/Index.jsp">메인으로</a></li>
					<li><a href="/Proj_Ch14_BBS/member/Login.jsp">로그인</a></li>
					<li><a href="/Proj_Ch14_BBS/bbs/Post.jsp">글쓰기</a></li>
					<li><a href="/Proj_Ch14_BBS/bbs/List.jsp">자유게시판 보기</a></li>
				</ul>
			</nav>
		</header>
		<!--  HTML 템플릿(Template, Templet)  헤더 끝 -->


		<main id="main">
			<!-- 본문영역 html 템플릿 시작 -->
			<form name="regFrm" id="regFrm" action="MemberProc.jsp" method="get">

				<table>
					<caption>회원가입</caption>
					<tbody>
						<tr>
							<td class="req">아이디</td>
							<td><input type="text" id="uId" name="uId" size="15"
								maxlength="20" autofocus>
								<button type="button" id="idChkBtn">ID중복확인</button> <input
								type="hidden" name="uIdBtnClickChk" id="uIdBtnClickChk"
								value="0"></td>
							<td>5~20글자, 영어/숫자/_</td>
						</tr>
						<tr>
							<td class="req">패스워드</td>
							<td><input type="password" name="uPw" id="uPw" size="15">
							</td>
							<td>패스워드를 적어주세요</td>
						</tr>
						<tr>
							<td>패스워드 확인</td>
							<td><input type="password" id="uPw_Re" size="15"></td>
							<td>패스워드를 확인합니다.</td>
						</tr>
						<tr>
							<td class="req">이름</td>
							<td><input type="text" name="uName" id="uName" size="15">
							</td>
							<td>이름을 적어주세요.</td>
						</tr>
						<tr>
							<td class="req">Email</td>
							<td><input type="text" name="uEmail" id="uEmail" size="26">
							</td>
							<td>이메일을 적어주세요.</td>
						</tr>
						<tr>
							<td colspan="3" style="border-bottom: 2px solid #ddd;"></td>
						</tr>
						<tr>
							<td>성별</td>
							<td><label>남 <input type="radio" name="uGender"
									value="1" checked></label> <label>여 <input type="radio"
									name="uGender" value="0"></label></td>
							<td>성별을 선택하세요.</td>
						</tr>
						<tr>
							<td>생년월일</td>
							<td><input type="text" name="uBirthday" id="uBirthday"
								size="6"> ex) 830815</td>
							<td>생년월일을 적어주세요.</td>
						</tr>
						<tr>
							<td>우편번호</td>
							<td><input type="text" name="uZip" id="uZip" size="7"
								class="uAddr" readonly>
								<button type="button" id="zipBtn">우편번호찾기</button></td>
							<td>우편번호를 검색하세요.</td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input type="text" class="uAddr" id="uAddr1"
								name="uAddr1" size="26"></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td><input type="text" id="uAddr2" name="uAddr2" size="26">
								<input type="hidden" id="uAddr" name="uAddr"></td>
							<td>나머지 주소 기재</td>
						</tr>
						<tr>
							<td>취미</td>
							<td id="hobbyArea"><label><span>인터넷</span><input
									type="checkbox" name="uHobby" value="인터넷"></label> <label><span>여행</span><input
									type="checkbox" name="uHobby" value="여행"></label> <label><span>게임</span><input
									type="checkbox" name="uHobby" value="게임"></label> <label><span>영화</span><input
									type="checkbox" name="uHobby" value="영화"></label> <label><span>운동</span><input
									type="checkbox" name="uHobby" value="운동"></label></td>
							<td>취미를 선택하세요.</td>
						</tr>
						<tr>
							<td>직업</td>
							<td><select name="uJob" id="uJob">
									<option value="0" selected>-선택하세요-</option>
									<option value="회사원">회사원</option>
									<option value="연구전문직">연구전문직</option>
									<option value="교수학생">교수학생</option>
									<option value="일반자영업">일반자영업</option>
									<option value="공무원">공무원</option>
									<option value="의료인">의료인</option>
									<option value="법조인">법조인</option>
									<option value="주부">주부</option>
									<option value="기타">기타</option>
							</select></td>
							<td>직업을 선택하세요.</td>
						</tr>
						<tr>
							<td colspan="3">
								<button type="button" id="joinBtn">회원가입</button>
								<button type="reset">다시쓰기</button>
								<button type="button" id="mainBtn">메인으로</button>
								<button type="button" id="loginBtnMove">로그인</button>
							</td>
						</tr>
					</tbody>
				</table>

			</form>
			<!-- document.regFrm -->

		</main>
	</div>
	<!-- div#wrap -->


	<script src="script/script.js"></script>
</body>
</html>