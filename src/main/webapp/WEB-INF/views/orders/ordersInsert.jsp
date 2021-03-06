<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		<!-- 브라우저의 호환성 보기 모드 제한. 브라우저 내 최신 html로 화면 출력 -->
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0,
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/> 
		
		<link rel="shortcut icon" href="../image/icon.png"/>
		<link rel="apple-touch-icon" href="../image/icon.png"/>
		<link rel="stylesheet" href="/resources/include/css/ordersInsert.css"/>
		<!-- IE8이하 브라우저에서 html5를 인식하기 위한 패스필터 -->
		<!-- [if lt IE 9]>
			<script src="../js/html5shiv.js"></script>
		<![endif]-->
		
		<script type="text/javascript">
			$(function(){
				$("#backHome").click(function(){
					location.href="/";
				});
				$("#myPunding").click(function(){
					location.href="/member/memberMyPage";
				});
			});
		</script>
		<title>결제완료</title>
	</head>
	<body>
		<div id="container">
			<header>
				<h1>축하합니다!</h1>
				<p><span id="orders_num">${orders.order_num}</span>번째 후원자가 되셨습니다!</p>
					<div id="rewardDetail">
						<h4>리워드 세부항목</h4>
						-후원금액:${orders.order_price}<br/>
						-리워드 세부내역:${orders.order_content}<br/>
					</div>
				<hr/>
				프로젝트 목표액에 미달할 경우 진행된 모든 결제는 자동으로 취소됩니다.
			</header>
			<hr/>
			<button id="backHome" class="btn btn-primary">홈으로 돌아가기</button>
			<button id="myPunding" class="btn btn-primary">내 후원현황 보기</button>
		</div>
	</body>
</html>