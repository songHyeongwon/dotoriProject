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
					$("#nameForm").attr({
						"method" : "post",
						"action" : "/member/memberLogout"
					})
					
					$("#nameForm").submit();
					
				})
				
				$("#myPageBtn").click(function(){
					location.href="/member/memberMyPage";
				})
				
			})
		</script>
	</head>
	<body>
		<form id="nameForm">
			<h4 id="name">${data.member_name }님 안녕하세요.</h4>
		</form>
		<input type="button" id="logoutBtn" name="logoutBtn" value="로그아웃"/>&nbsp;&nbsp;
		<input type="button" id="myPageBtn" name="myPageBtn" value="마이페이지"/>
	</body>
</html>