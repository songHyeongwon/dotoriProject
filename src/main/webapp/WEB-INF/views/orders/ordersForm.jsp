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
		<link rel="stylesheet" href= "/resources/include/css/ordersForm.css"/>
		<!-- <link type="stylesheet" href="/resources/include/css/ordersForm.css"/> -->
		<!-- IE8이하 브라우저에서 html5를 인식하기 위한 패스필터 -->
		<!-- [if lt IE 9]>
			<script src="../js/html5shiv.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<script type="text/javascript">
		$(function(){
			var point = ${data.member_point-orders.order_price};
			
			$("#f_address").hide();
			
			$("#addAddress").click(function(){
				$("#f_address").show();
				$("#searchPostCode").click(function(){
					new daum.Postcode({
			       		 oncomplete: function(data) {
			       		// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			                 var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			                 //alert(fullRoadAddr);
			                 var extraRoadAddr = ''; // 도로명 조합형 주소 변수

			                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			                 if (data.bname !== ''
			                         && /[동|로|가]$/g.test(data.bname)) {
			                     extraRoadAddr += data.bname;
			                 }
			                 // 건물명이 있고, 공동주택일 경우 추가한다.
			                 if (data.buildingName !== ''
			                         && data.apartment === 'Y') {
			                     extraRoadAddr += (extraRoadAddr !== '' ? ', '
			                             + data.buildingName : data.buildingName);
			                 }
			                 // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			                 if (extraRoadAddr !== '') {
			                     extraRoadAddr = ' (' + extraRoadAddr + ')';
			                 }
			                 // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			                 if (fullRoadAddr !== '') {
			                     fullRoadAddr += extraRoadAddr;
			                 }

			                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
			                 document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
			                 document.getElementById('roadAddress').value = fullRoadAddr;
			                
			                 /* // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
			                 if (data.autoRoadAddress) {
			                     //예상되는 도로명 주소에 조합형 주소를 추가한다.
			                     var expRoadAddr = data.autoRoadAddress
			                             + extraRoadAddr;
			                     document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
			                             + expRoadAddr + ')';

			                 } else if (data.autoJibunAddress) {
			                     var expJibunAddr = data.autoJibunAddress;
			                     document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
			                             + expJibunAddr + ')';

			                 } else {
			                     document.getElementById('guide').innerHTML = '';
			                 } */
			             }
			   		 }).open();
				});
				$("#addBtn").click(function(){
					if($("#postcode").val().replace(/\s/g,"")==""){
						alert("우편번호를 입력해주세요.");
						return;
					}else if($("#roadAddress").val().replace(/\s/g,"")==""){
						alert("도로명 주소를 입력해주세요.");
						return;
					}else if($("#detailAddress").val().replace(/\s/g,"")==""){
						alert("세부 주소를 입력해주세요.");
						return;
					}else {
						var address1=$("#roadAddress").val();
						var address2=$("#detailAddress").val();
						var address3=$("#postcode").val();
						
						//$("#newAddress").append(address1+"&nbsp;").append(address2).append(" ("+address3+")");
						$("#newAddress").html(address1+"&nbsp;"+address2+" ("+address3+")")
						$("#f_address").hide();
						
						$("#roadAddress").val("");
						$("#detailAddress").val("");
						$("#postcode").val("");	
					}
				});
				
			});
			
			$("#support").click(function(){
				var project_num=$("input[name='project_num']").val();
				$("#project_num").val(project_num);
				
				if(!$("input:checkbox[id='order_guideAgree']").is(":checked") == true){
					$("#order_guideAgree").val("0");
					alert("배송 관련 안내사항을 읽고 동의해주세요.");
				} else if(point<0){
					alert("잔액이 부족합니다.");
				} else {
					$("#f_orders").attr({
						"method":"post",
						"action":"/orders/ordersFinal"
					});
					//보내야하는 값들 설정
					var recaddress=$("#newAddress").html();
					var recphone=$("#phoneFirst").val()+"-"+$("#phoneMiddle").val()+"-"+$("#phoneLast").val();
					$("#order_guideAgree").val("1");
					$("#delivery_recname").val($("#recname").val());
					$("#delivery_recaddress").val($("#newAddress").html());
					$("#delivery_recphone").val(recphone);
					$("#delivery_send").val($("#send").val());
					
					/* console.log($("#delivery_recname").val());
					console.log($("#delivery_recaddress").val());
					console.log($("#delivery_recphone").val());
					console.log($("#delivery_send").val()); */
					$("#f_orders").submit();
				}
				
			});
		});  
		/* $(document).on("click","li",function(event){
			$(event.target).addClass("checked");
			var address=$(event.target).val();
			alert(address);
		}); */
		
		</script>
		<title>결제</title>
	</head>
	<body>
	
	<form id="f_orders">
		<input type='hidden' name="member_id" id="member_id" value="${data.member_id}"/>
		<input type='hidden' name="project_num" id="project_num" value="${orders.project_num}"/>
		<input type="hidden" name="order_content" id="order_content" value="${orders.order_content}"/>
		<input type="hidden" name="order_price" id="order_price" value="${orders.order_price}"/>
		<input type="hidden" name="order_guideAgree" id="order_guideAgree" value="${orders.order_guideAgree}"/>
		<input type="hidden" name="content_kind" id="content_kind" value="${orders.content_kind}"/>
		<%-- 4개의 인풋은 배송상품이 아니면 필요하지 않다. --%>
		<input type="hidden" name="delivery_recname" id="delivery_recname">
		<input type="hidden" name="delivery_recaddress" id="delivery_recaddress">
		<input type="hidden" name="delivery_recphone" id="delivery_recphone">
		<input type="hidden" name="delivery_send" id="delivery_send">
	</form>
	<div id="container">
	<header>
		<div class="detailOrders">
			<label>후원금액 : ${orders.order_price}</label><br/>
			<label>현재 포인트 : ${data.member_point}</label><br>
			<label>결제 후 잔액 : ${data.member_point-orders.order_price}</label><br>
			<label>리워드 세부내역 : ${orders.order_content}</label><br/>
		</div>
	</header>

		<c:choose>
			<c:when test="${orders.content_kind==1}">
				<hr />
				<div class="starter-template">
					<label>받는사람 이름</label><br>
					<input type="text" placeholder="받는사람 이름" id="recname"><hr>
					<label>받는사람 전화번호</label><br>
					<input type="text" class="phone" name="phoneFirst" id="phoneFirst" maxlength="3" />
					-
					<input type="text" class="phone" name="phoneMiddle" id="phoneMiddle" maxlength="4"/>
					-
					<input type="text" class="phone" name="phoneLast" id="phoneLast" maxlength="4"/><hr>
					<label>받는사람 주소</label>
					<ul id="addressList">
						<li id="newAddress">${data.member_address} ${data.member_detailAddress}</li>
					</ul>
					<button type="button" id="addAddress" class="btn btn-primary">다른 주소 입력</button>
					<div id="f_address">
						<input type="text" id="postcode" placeholder="우편번호" readonly="readonly" /> 
						<input type="button" id="searchPostCode" value="우편번호 찾기" /><br/> 
						<input type="text" id="roadAddress" placeholder="도로명주소" readonly="readonly" /> 
						<input type="text" id="detailAddress" placeholder="상세주소"> 
						<input type="button" id="addBtn" value="등록" class="btn btn-primary" /> 
						<span id="guide" style="color: #999"></span>
					</div>
					<br />
					<hr />
					
					<label>보내는사람 이름</label><br>
					<input type="text" placeholder="보내는사람 이름" id="send" value="${data.member_name}"><hr>
					<div class="annotation">
					
						<label>배송 안내사항</label> <br />
							<strong>배송정보 제 3자(프로젝트 진행자) 제공 동의</strong>
							<p>
								회원의 개인정보는 당사의 개인정보 취급방침에 따라 안전하게 보호됩니다. 
								'회사'는 이용자들의 개인정보를 개인정보 취급방침의 '제 2조 수집하는 개인정보의 항목, 수집방법 및 이용목적'에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 공개하지 않습니다.</p>
							<ul>
								<li>제공받는자:</li>
								<li>제공목적: 선물 전달/배송과 관련된 상담 및 민원처리</li>
								<li>제공정보: 수취인 성명, 휴대전화번호, 배송 주소 (구매자와 수취인이 다를 경우에는 수취인의 정보가 제공될 수 있습니다)</li>
								<li>보유 및 이용기간: 재화 또는 서비스의 제공이 완료된 즉시 파기 (단, 관계법령에 정해진 규정에 따라 법정기간 동안 보관)</li>
							</ul>
							<strong>※ 동의 거부권 등에 대한 고지</strong>
							<p>
							개인정보 제공은 서비스 이용을 위해 꼭 필요합니다. 개인정보 제공을 거부하실 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다.
							</p>
							
						<br /> <input type="checkbox" name="order_guideAgree"
							id="order_guideAgree" /> <label>약관을 모두 읽었으며 이에 동의합니다.</label> <br />
						<button type="button" name="support" id="support" class="btn btn-primary">후원하기</button>

					</div>
				</div>
			</c:when>
			<c:otherwise>
			<hr/>
				<br /> <input type="checkbox" name="order_guideAgree"
							id="order_guideAgree" /> <label>세부사항을 모두 확인하였습니다.</label> <br />
						<button type="button" name="support" id="support" class="btn btn-primary">후원하기</button>
			</c:otherwise>
		</c:choose>
	</div>
	</body>
</html>