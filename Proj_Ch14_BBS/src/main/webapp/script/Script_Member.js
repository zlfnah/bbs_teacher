$(function() {
    
/*///////////////////  로그인 페이지 시작 (Login.jsp)  ///////////////////// */
	function fnLogin() {

		let uId = $("#uId").val().trim();
		let uPw = $("#uPw").val().trim();

		if (uId == "") {     // 비밀번호 검사 시작
			alert("아이디를 입력하세요.");
			$("#uId").focus();
		} else if (uPw == "") {     // 비밀번호 검사 시작
			alert("비밀번호를 입력하세요.");
			$("#uPw").focus();
		} else {
			$("#loginFrm").submit();
		}

	}

	$("#loginBtn").click(function() {
		fnLogin();
	});

	// 엔터 이벤트 적용 시작
	$("input.loginInput").keyup(function(event) {
		let code = event.keyCode;
		if (code == 13) fnLogin();
	});
	// 엔터 이벤트 적용 끝


	$("#mainBtn").click(function() {   // 메인으로 이동				
		location.href = "../Index.jsp";
	});
	$("#joinBtn").click(function() {   // 회원가입으로 이동				
		location.href = "Member.jsp";
	});
/*///////////////////  로그인 페이지 끝 (Login.jsp)  ///////////////////// */



/*///////////////////  회원가입 페이지 시작 (Member.jsp)  ///////////////////// */

			
			//////////////  아이디 중복 검사 시작 //////////////////////			
			function idCheck() {
				
				//// 아이디 => 영어, 숫자, 특수기호(_), 5글자 이상 20글자 이하
				let uId = $("#uId").val();
				let uIdLen  = uId.length;
				let uIdReg = /[^a-z|A-Z|0-9|_]/;
				if (uIdLen < 5) {
					alert("ID는 영어, 숫자, 특수기호(_), 5글자 이상 20글자 이하");
					$("#uId").focus();
					return;
				} else if(uIdReg.test(uId)) {
					alert("ID는 영어, 숫자, 특수기호(_), 5글자 이상 20글자 이하");
					$("#uId").focus();
					return;
				}
				
				let url = "IdCheck.jsp?uId=" + uId;
				let w = screen.width;
				let popW = 400;
				let leftP = (w-popW)/2;
				let h = screen.height;
				let popH = 300;
				let topP = (h-popH)/2;
				//alert("w : " + w + "\nh : " + h);
				
				window.open(url, "IdCheck", "width="+popW+", height="+popH+", left="+leftP+", top="+topP);
				
			}
			
			
			$("#idChkBtn").click(function(){
				idCheck();
			});
			//////////////  아이디 중복 검사 끝 //////////////////////
			
			
			//////////////  우편번호 찾기 시작 //////////////////////
			function zipCheck() {
				let url = "ZipCheck.jsp?zipChk=y";

				let w = screen.width;
				let popW = 540;
				let leftP = (w-popW)/2;
				let h = screen.height;
				let popH = 400;
				let topP = (h-popH)/2;
				//alert("w : " + w + "\nh : " + h);
				
				window.open(url, "zipCodeSearch", "width="+popW+", height="+popH+", left="+leftP+", top="+topP);
				
				
			}
			
			$("#zipBtn").click(function(){
				zipCheck();
			});
			//////////////  우편번호 찾기 끝 //////////////////////
			
			
			////////////// 유효성 검사 시작 //////////////////////
			
			$("#joinBtn").click(function(){
				
								
				let uIdBtnClickChk = $("#uIdBtnClickChk").val();
				let uPw = $("#uPw").val();
				let uPw_Re = $("#uPw_Re").val();
				let uName = $("#uName").val();
				let uEmail = $("#uEmail").val();
				let uAddr1 = $("#uAddr1").val();
				let uAddr2 = $("#uAddr2").val();
				let uAddr = uAddr1 + " " + uAddr2;
				
				if(uIdBtnClickChk == 0) {    	// 아이디 검사 시작
					alert("ID중복확인 버튼을 클릭하세요.");
					$("#idChkBtn").focus();
					
					$("#idChkBtn").focus(function(){
						$(this).css({"outline": "1px solid #555"});	
					}).blur(function(){
						$(this).css({"outline": "none"});	
					});					
					// 아이디 검사 끝
				} else if (uPw == "") {     // 비밀번호 검사 시작
					alert("비밀번호를 입력하세요.");
					$("#uPw").focus();
				} else if (uPw != uPw_Re) {     // 비밀번호 동일검사 시작
					alert("비밀번호가 다릅니다. 확인 후 다시 입력하세요.");
					$("#uPw_Re").val("");
					$("#uPw").focus();
				} else if (uName == "") {     // 이름 검사 시작
					alert("이름을 입력하세요.");
					$("#uName").focus();
				} else if (uEmail == "") {     // 이메일 검사 시작
					alert("이메일을 입력하세요.");
					$("#uEmail").focus();
				} else if (uEmail.indexOf("@") < 0 || uEmail.indexOf(".") < 0) {     // 이메일 검사 시작
					alert("이메일주소를 확인하세요.");
					$("#uEmail").focus();
				} else {
					$("#uAddr").val(uAddr);
					
					$("#regFrm").submit();
				}
				
			});
			////////////// 유효성 검사 끝 //////////////////////
			

			///////////  로그인 페이지 이동 시작 ////////////////
			$("#loginBtnMove").click(function(){
				location.href = "Login.jsp";
			});

			///////////  메인 페이지 이동 시작 ////////////////
			$("#mainBtn").click(function(){
				location.href = "../Index.jsp";
			});

/*///////////////////  회원가입 페이지 끝 (Member.jsp)  ///////////////////// */




});

