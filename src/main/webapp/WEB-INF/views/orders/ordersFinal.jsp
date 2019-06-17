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
		<link rel="stylesheet" href="/resources/include/css/ordersFinal.css"/>
		<!-- IE8이하 브라우저에서 html5를 인식하기 위한 패스필터 -->
		<!-- [if lt IE 9]>
			<script src="../js/html5shiv.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#finalConfirm").click(function(){
					var project_num=$("input[name='project_num']").val();
					$("#project_num").val(project_num);
					
					if(!$("input:checkbox[id='order_infoAgree']").is(":checked") == true){
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
					if($("#member_point").val()<$("#order_point").val()){
						alert("포인트가 부족합니다. 포인트를 충전 후 다시 결제해주세요.");
					}
					else{
						alert("결제가 완료되었습니다.");
					}
				});
			});
		</script>
		<title>배송/결제 안내사항 확인 페이지</title>
	</head>
	<body>
	<form id="f_project">
		<input type="hidden" name="member_point" id="memeber_point" value="${data.member_point-orders.order_price}"/>
		<input type="hidden" name="support_count" id="support_count" value="${project.project_count+1}"/>
		<input type="hidden" name="project_sumMoney" id="project_sumMoney" value="${project.project_sumMoney+orders.order_price}"/>
	</form>
	<form id="f_orders">
		<input type='hidden' name="project_num" id="project_num" value="${orders.project_num}"/>
		<input type="hidden" name="order_content" id="order_content" value="${orders.order_content}"/>
		<input type="hidden" name="order_price" id="order_price" value="${orders.order_price}"/>
		<input type="hidden" name="order_guideAgree" id="order_guideAgree" value="${orders.order_guideAgree}"/>
		<input type='hidden' name="member_id" id="member_id" value="${data.member_id}"/>
		<%-- 4개의 인풋은 배송상품이 아니면 필요하지 않다. --%>
		<c:choose>
			<c:when test="${orders.content_kind==1}">
				<input type="hidden" name="delivery_recname" id="delivery_recname" value="${orders.delivery_recname}">
				<input type="hidden" name="delivery_recaddress" id="delivery_recaddress" value="${orders.delivery_recaddress}">
				<input type="hidden" name="delivery_recphone" id="delivery_recphone" value="${orders.delivery_recphone}">
				<input type="hidden" name="delivery_send" id="delivery_send" value="${orders.delivery_send}">
			</c:when>
		</c:choose>
		<div id="container">
		<header></header>
	<div id="rewardDetail">
		<h3>리워드 세부항목</h3>
		-후원금액:${orders.order_price}<br/>
		-리워드 세부내역:${orders.order_content}<br/>
		-주소:<span id="address">${orders.delivery_recaddress}</span>
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
			<button type="button" name="finalConfirm" id="finalConfirm" class="btn btn-primary">이해하고 후원 완료하기</button>
		</footer>
	</div>
</form>
	</body>
</html>