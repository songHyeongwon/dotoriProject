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
	
		<!-- IE8이하 브라우저에서 html5를 인식하기 위한 패스필터 -->
		<!-- [if lt IE 9]>
			<script src="../js/html5shiv.js"></script>
		<![endif]-->
		<style type="text/css">
			#container{
				width:800px;
				margin:0px auto;
				text-align:center;
			}
		</style>
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#finalConfirm").click(function(){
					var project_num=$("input[name='project_num']").val();
					$("#project_num").val(project_num);
					if(!$("#order_infoAgree").prop("checked")){
						alert("후원 관련 안내사항을 읽고 동의한 후 후원을 진행해주세요.");
						$("#order_infoAgree").val("0");
					}else{
						$("#order_infoAgree").val("1");
						$("#f_orders").attr({
							"method":"post",
							"action":"/orders/ordersInsert"
						});
						$("#f_orders").submit();	
					}
				});
			});
		</script>
		<title>배송/결제 안내사항 확인 페이지</title>
	</head>
	<body>
	
	<form id="f_orders">
		<input type='hidden' name="member_id" id="member_id" value="testuser1"/>
		<input type='hidden' name="project_num" id="project_num" value="${orders.project_num}"/>
		<input type="hidden" name="order_content" id="order_content" value="${orders.order_content}"/>
		<input type="hidden" name="order_price" id="order_price" value="${orders.order_price}"/>
		<input type="hidden" name="content_kind" id="content_kind" value="${orders.content_kind}"/> 
		<input type="hidden" name="order_guideAgree" id="order_guideAgree" value="${orders.order_guideAgree}"/>
		<div id="container">
		<header></header>
	<hr/>
	<div id="rewardDetail">
		<h4>리워드 세부항목</h4>
		-후원금액:${orders.order_price}<br/>
		-리워드 세부내역:${orders.order_content}<br/>
		-주소:<span id="address"></span>
	</div>
	<hr/>
		<h2>마지막으로 확인해주세요</h2>
		<p>
		본 프로젝트에 대한 후원은 회원의 포인트에서 후원금액 만큼의 포인트가 즉시 차감되는 형식으로 진행되며, 
		프로젝트가 목표 금액을 정해진 기한 내에 달성하지 못한 경우 전액 환급됩니다. 
		또한 완제품의 상거래가 아니므로 선물의 전달이 예상일로부터 다소 지연되거나 세부사항이 변경될 수 있으니, 프로젝트 페이지 내 커뮤니티와 이메일 및 도토리 메시지를 꾸준히 확인해주세요.
		도토리 펀딩은 플랫폼을 제공하는 서비스로, 프로젝트 진행 및 선물 전달의 주체가 아닙니다. 
		프로젝트를 설계한 창작자의 완수 능력을 보증할 수 없습니다. 프로젝트에 게시된 모든 내용은 창작자가 작성한 사항이며 이를 약속대로 완수할 책임은 창작자에게 있는 점 안내드립니다.
		</p>
		<br/>
		<hr/>
		<input type="checkbox" name="order_infoAgree" id="order_infoAgree"/>
		<label>모두 읽었습니다.</label>
		<footer>
			<button type="button" name="finalConfirm" id="finalConfirm">이해하고 후원 완료하기</button>
		</footer>
	</div>
</form>
	</body>
</html>