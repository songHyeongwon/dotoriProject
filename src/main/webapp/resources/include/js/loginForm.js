/**
 * 
 */

$(function() {
	codeCheck();
	$("#m_id, #m_passwd").bind("keyup", function() {
		$(this).parents("div").find(".error").html("");
	})
	
	//로그인 버튼 클릭 시 처리 이벤트
	$("#loginBtn").click(function() {
		if(!formCheck($("#m_id"), $(".error:eq(0)"),"아이디를"))return;
		else if(!inputVerify(0,"#m_id",".error:eq(0)"))return;
		else if(!formCheck($("#m_passwd"),$(".error:eq(1)"),"비밀번호를"))return;
		else if(!inputVerify(1,"#m_passwd",".error:eq(1)"))return;
		else {
			$("#loginForm").attr({
				"method":"post",
				"action":"/siteProject/member/login.do"
			});
			$("#loginForm").submit();
		}
	});
	
	//회원가입 버튼 클릭시 처리 이벤트
	$("#joinBtn").click(function() {
		location.href="/siteProject/member/joinForm/do";
	});
	$("#logout").click(function() {
		location.href="/siteProject/member/logout.do";
	});
	
	$("#modifyForm").click(function() {
		$("#mode").val("modify");
		$("#loginAfterForm").attr({
			"method":"post",
			"action":"/siteProject/member/pwdConfirmForm.do"
		});
		$("#loginAfterForm").submit();
	});
	$("delete").click(function() {
		$("#mode").val("delete");
		$("loginAfterForm").attr({
			"method":"post",
			"action":"/siteProject/member/pwdConfirmForm.do"
		});
		$("#loginAfterForm").submit();
	});
})