<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>
		
		<style type="text/css">
			#member_eMail{
				width: 230px;
			}
		</style>

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
				$("#chkPwdBtn").click(function(){
					location.href="/member/passwordSearch";
				})
				
				$("#cancleBtn").click(function(){
					location.href="/member/login";
				})
				
				$("#chkBtn").click(function(){
					$.ajax({
						url : "/member/emailCheck",
						data : "member_eMail="+$("#member_eMail").val(),
						dataType : "text",
						type : "post",
						error : function(){
							alert("이메일 확인 중 오류 발생 관리자에게 문의 바랍니다.");
						},
						success : function(data){
							if(data=="성공"){
								alert("이메일 확인에 성공하였습니다.");
								/* $("#idChkForm").attr({
									"method" : "get",
									"action" : "/member/logIdCheck"
								})
								
								$("#idChkForm").submit(); */
								
								$.ajax({
									url : "/member/logIdCheck",
									type : "get",
									data : "member_eMail="+$("#member_eMail").val(),
									dataType : "text",
									error : function(){
										alert("이메일 전송 중 시스템 오류 발생. 관리자에게 문의 바랍니다.")
									},
									success : function(data){
										if(data=="성공"){
											alert("이메일 전송이 완료되었습니다. 확인해 주세요.");
											location.href="/member/login"
										}else{
											alert("이메일 전송 중 오류 발생. 잠시 후 다시 확인 부탁드립니다.");
										}
									}
								}) 
							}else{
								alert("이메일 확인 중 오류 발생. 잠시 후 다시 시도해 주세요.");
							}
						}
					})
				})
			})
		</script>
	</head>
	<body>
		<div class="text-center">
			<form id="idChkForm">
					<div class="form-group">
							<h2>아이디 찾기</h2>
					</div>
					<div class="form-group">
					등록한 이메일 주소 : 
						<input type="email" id="member_eMail" name="member_eMail" placeholder="예) dotoriFundings@naver.com"/>&nbsp;
					</div>
					<div class="form-group">
						<input type="button" class="btn btn-success" id="chkBtn" name="chkBtn" value="확인"/>
						<input type="button" class="btn btn-primary" id="chkPwdBtn" name="chkPwdBtn" value="비밀번호 찾기"/>
						<input type="button" class="btn btn-danger" id="cancleBtn" name="cancleBtn" value="취소"/>
					</div>
			</form>
		</div>
	</body>
</html>