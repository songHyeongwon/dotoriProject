<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>		
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>
		
		<style type="text/css">
			.text{
				width : 180px;
			}
			
			.confirm{
				width: 130px;
			}
			
			.title{
				margin-top : 100px; 
			}
			
			.lastBtn{
				padding-bottom: 100px;
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
		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
	
		<script type="text/javascript">
			$(function(){
				$("#pwdConfirmBtn").click(function(){
					if(!checkForm("#member_pwd","비밀번호를")) return;
					else{
						$.ajax({
							url : "/member/passwordConfirm",
							type : "post",
							data : "member_pwd="+$("#member_pwd").val()+"&member_id="+$("#member_id").val(),
							dataType : "text",
							error : function(){
								alert("비밀번호 확인 중 오류 발생. 관리자에게 문의 바랍니다.");
							},
							success : function(data){
								console.log(data);
								if(data=="성공"){
									alert("비밀번호 확인되었습니다.");
									location.href = "/member/personalModify";
								}else{
									alert("비밀번호 확인 중 오류 발생. 잠시 후 다시 시도해 주세요.");
									$("#member_pwd").val("");
									$("#pwdConf").val("");
									$("#member_pwd").focus();
								}
							}
						})
					}
				});
			});
		</script>
	</head>
	<body>
		<div class="text-center thumbnail total">
			<div class="title">
				<h2>비밀번호 확인</h2>
			</div>
				<div>
					<form id="pwdConfirm">
						<input type="hidden" id="member_id" name="member_id" value="${data.member_id}"/>
						<div class="form-group">
							<input type="password" class="text" id="member_pwd" name="member_pwd" placeholder="비밀번호 입력"/>
						</div>
					</form>
				</div>
				
				<div class="form-group">
					<input type="button" class="btn btn-success confirm" name="pwdConfirmBtn" id="pwdConfirmBtn" value="확인"/>
				</div>
				<div class="form-group lastBtn">
					<input type="button" class="btn btn-primary confirm" name="cancelBtn" id="cancelBtn" value="취소"/>
				</div>
		</div>
	</body>
</html>