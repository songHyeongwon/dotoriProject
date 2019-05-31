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
				width:500px;
				margin:0px auto;
				text-align:center;
			}
		</style>
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#support").click(function(){
					if(!$("#agreement").prop("checked")){
						alert("배송/후원사항을 읽고 동의해주세요.");
					}
					else{
						location.href="/orders/ordersFinal";	
					}
					
				});
				$("#anotherAddress").click(function(){
					var input=$("<input>");
					input.attr({
						"type":"text",
						"name":"newAddress",
						"id":"newAddress",
						"placeholder":"서울특별시 성동구 무학로 2길 54(신방빌딩)",
						"style":"width:300px"
					});
					var btn=$("<input>");
					btn.attr({
						"type":"button",
						"id":"addAddress",
						"value":"등록"
					});
					$("#f_address").append(input).append(btn);
				});
			});
			$(document).on("click","input[type='button']",function(){
				if($("#newAddress").val().replace(/\s/g,"")==""){
					alert("새로운 주소지를 입력해주세요.");
				}
				else{
					$("#address").html($("#newAddress").val());
				}
				$("#newAddress").val("");
				$("#f_address").css("visibility","hide");
				
			});
		
		</script>		
		<title>Insert title here</title>
	</head>
	<body>
	<div id="container">
	<header>
		<h3>프로젝트명"${project.name}"</h3>
		<hr/>
		<div class="detailOrders">
			<label>후원금액:</label>
			<label>"${project.price}"</label><br/>
			
			<label>리워드 세부내역</label><br/>
			<label>"${project.content}"</label>
		</div>
	</header>
	
	<hr/>
      <div class="starter-template">
        <label>배송지</label>
		<ul>
			<li>"${member.address}"</li>
			<li>"${member.address}"</li>
			<li><span id="address"></span></li>
		</ul>
		<br/>
			<button type="button" id="anotherAddress">다른 주소 입력하기</button>
      <form id="f_address"></form>
      <hr/>
      <div class="annotation">
      	
		<label>배송/후원 안내사항</label>
		<br/>
		<textarea rows="5" cols="50" readonly="readonly">
		배송정보 제 3자(프로젝트 진행자) 제공 동의
		회원의 개인정보는 당사의 개인정보 취급방침에 따라 안전하게 보호됩니다. '회사'는 이용자들의 개인정보를 개인정보 취급방침의 '제 2조 수집하는 개인정보의 항목, 수집방법 및 이용목적'에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 공개하지 않습니다.

		제공받는자:"${project.id}"
		제공목적: 선물 전달/배송과 관련된 상담 및 민원처리
		제공정보: 수취인 성명, 휴대전화번호, 배송 주소 (구매자와 수취인이 다를 경우에는 수취인의 정보가 제공될 수 있습니다)
		보유 및 이용기간: 재화 또는 서비스의 제공이 완료된 즉시 파기 (단, 관계법령에 정해진 규정에 따라 법정기간 동안 보관)
		
		※ 동의 거부권 등에 대한 고지
		개인정보 제공은 서비스 이용을 위해 꼭 필요합니다. 개인정보 제공을 거부하실 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다.
		</textarea>
		
		<br/>
		<input type="checkbox" name="agreement" id="agreement"/>
		<label>약관을 모두 읽었으며 이에 동의합니다.</label>
		<br/>
		<button type="button" name="support" id="support">후원하기</button>
	
      </div>
   </div>
   </div>
   <!-- /.container -->
	
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="../../dist/js/bootstrap.min.js"></script>
    IE10 viewport hack for Surface/desktop Windows 8 bug
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script> -->
	</body>
</html>