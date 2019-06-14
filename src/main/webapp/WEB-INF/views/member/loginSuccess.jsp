<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>

		<!-- <link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery.form.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script> -->
		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		
		<script type="text/javascript">
			$(function(){
				
				$("#logoutBtn").click(function(){
					$.ajax({
						url : "/member/memberLogout",
						type : "post",
						data : "member_name="+$("#member_name"),
						dataType : "text",
						error : function(){
							alert("로그아웃 중 시스템 오류 발생 관리자에게 문의하세요.");
						},
						success : function(data){
							if(data=="성공"){
								alert("로그아웃 완료되었습니다.");
								location.href = "/";
							}else{
								alert("로그아웃 중 오류 발생하였습니다. 잠시 후 다시 시도애 주새요.");
							}
						}
					})
					
				})
				
				$("#myPageBtn").click(function(){
					location.href="/member/memberMyPage";
				})
				
			})
		</script>
	</head>
	<body>
		<form id="nameForm">
			<h4 id="name">${sessionScope.data.member_name}님 안녕하세요.</h4>
		</form>
		<input type="button" id="logoutBtn" name="logoutBtn" value="로그아웃"/>&nbsp;&nbsp;
		<input type="button" id="myPageBtn" name="myPageBtn" value="마이페이지"/>
	</body>
</html>