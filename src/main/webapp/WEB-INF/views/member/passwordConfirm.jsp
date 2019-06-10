<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>		
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>

		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery.form.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
	
		<script type="text/javascript">
			$(function(){
				$("#pwdConfirmBtn").click(function(){
					if(!checkForm("#member_pwd","비밀번호를")) return;
					else if(!checkForm("#pwdConf","재확인 비밀번호를")) return;
					else if($("#member_pwd").val()!=$("#pwdConf").val()){
						alert("비밀번호가 일치하지 않습니다. 확인 부탁드립니다.");
						$("#member_pwd").val("");
						$("#pwdConf").val("");
						$("#member_pwd").focus();
					}else{
						$("#pwdConfirm").attr({
							"method" : "post",
							"action" : "/member/passwordConfirm"
						})
						
						$("#pwdConfirm").submit();
					}
				});
				
				if("${fail}"==1){
					alert("비밀번호 확인 중 시스템 오류 발생. 관리자에게 문의 바랍니다.");
				}
			});
		</script>
	</head>
	<body>
		<div class="text-center">
			<h2>비밀번호 확인</h2>
			<div>
				<form id="pwdConfirm">
					<input type="hidden" id="member_id" name="member_id" value="${data.member_id}"/>
					<div class="form-group">
						<input type="password" class="text" id="member_pwd" name="member_pwd" placeholder="비밀번호 입력"/>
					</div>
					<div class="form-group">
						<input type="password" class="text" id="pwdConf" name="pwdConf" placeholder="재확인 비밀번호 입력"/>
					</div>
				</form>
			</div>
			
			<div class="form-group">
				<input type="button" name="pwdConfirmBtn" id="pwdConfirmBtn" value="확인"/>
			</div>
			<div class="form-group">
				
				<input type="button" name="cancelBtn" id="cancelBtn" value="취소"/>
			</div>
		</div>
	</body>
</html>