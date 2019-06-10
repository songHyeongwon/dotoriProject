<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.dotori.client.project.vo.ProjectVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 브라우저의 호환성 보기 모드를 막고, 해당 브라우저에서 지원하는 가장 최신 버전의 방식으로  html을 보여주도록 설정 -->
<meta name="viewport"
	content="width=device-width initial-scale=1.0,
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<!-- viewport : 화면에 보이는 영역을 제어하는 기술.
		width는 device-width로 설정. initial-scale는 초기비율 -->
<!-- IE8이하 브라우저에서 HTML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다. -->
<!-- 만약 lt IE 9보다 낮다면 script html5shiv.js를 읽어와 적용하라 -->
<!-- [if lt IE 9]>
			<script src="../js/html5shiv.js"></script>
		<![endif] -->
<link rel="shortcut icon" href="../image/icon.png" />
<link rel="apple-touch-icon" href="../image/icon.png" />
<script type="text/javascript">
//비교대상
var fristName ="";
var optionCnt =0;
//처음 셀렉트
	$(function() {
		//모달 선택시
		$(document).on("click","button[name='content']", function() {
			if($("#project_status").val()==0){
				alert("승인되지 않은 프로젝트의 물품을 구매할수 없습니다.");
			}else if($("#project_status").val()==2){
				alert("관리자가 게시를 거부한 프로젝트의 물품을 구매할수 없습니다.");
			}else if($("#project_status").val()==3){
				alert("후원이 종료된 프로젝트의 물품을 구매할수 없습니다.")
			}else if($("#project_status").val()==4){
				alert("후원이 종료된 프로젝트의 물품을 구매할수 없습니다.")
			}else{
				//모달 초기화
				$("#ordersForm").children("input[name='option']").remove();
				$("#ordersForm").children("select[name='option']").remove();
				fristName = "";
				optionCnt =0;
				
				//값 찾아서 입력
				var content_num = $(this).prev().prev().prev().prev().prev().prev("input[name='content_num']").val();
				var content_name = $(this).prev().prev().prev().prev().prev("input[name='content_name']").val();
				var content_MinPrice = $(this).prev().prev().prev().prev("input[name='content_MinPrice']").val();
				var content_Kind = $(this).prev().prev().prev("input[name='content_Kind']").val();
				var option_table_name = $(this).prev("input[name='option_table_name']").val();
				
				//버튼의 값 입력하기
				$("#content_num").val(content_num);
				$("#content_name").val(content_name);
				$("#content_MinPrice").val(content_MinPrice);
				$("#content_Kind").val(content_Kind);
				$("#content_num").val(content_num);
				$("#content_MinPriceView").html(content_MinPrice+"원");
				
				var data = ({
						"content_num" : content_num,
						"option_table_name" : option_table_name })
				//ajax로 옵션 값 가져오기
				$.ajax({
					url: "/project/getOptionValue/",
					type : "post",
					dataType: 'json',
					data: data,
					success: function(data) {
						var select ="";
						$(data).each(function() {
							var option_kind = this.option_kind;
							var option_name = this.option_name;
							var option_value = this.option_value;
							if(option_kind==1){
								if(option_name!=fristName){
									//이번에 들어온 옵션의 이름이 이전것과 다를 경우
									select = $("<select>");
									select.attr("name","option");
									select.addClass("form-control");
									
									//옵션에 첫번째 값 입력
									var option = $("<option>");
									option.html(option_value);
									option.attr("value",option_value);
									select.append(option);
									
									$("#ordersForm").append(select);
									
									fristName=option_name;
									optionCnt++;
								}else{
									//옵션명이 같음으로 <option>태그만 생성
									var option = $("<option>");
									option.html(option_value);
									option.attr("value",option_value);
									select.append(option);
								}
							}else{
								//직접입력 인풋을 생성합니다.
								var inputOption = $("<input>");
								inputOption.attr("type","text");
								inputOption.attr("name","option");
								inputOption.addClass("form-control");
								inputOption.attr("placeholder",option_name+" 을/를 입력해주세요");
								$("#ordersForm").append(inputOption);
								optionCnt++;
							}
						});
						//data 반복문 종결
					}
				});
				//ajax 종료
				$('#myModal').modal();
			}
		});
		
		//옵션값 선택시
		$(document).on("click","select[name='option']", function() {
			var value = $(this).val();
		});
		//결재버튼 누를시
		$("#orderBtn").click(function() {
			
			var det = $("#content_name").next();
			var order_content = $("#content_name").val();
			for(var i=0; i<optionCnt; i++){
				order_content = order_content+" "+det.val();
				det = det.next();
			}
			$("#order_content").val(order_content);
			console.log($("#order_content").val());
			$("#ordersForm").attr({
				"method":"post",
				"action":"/orders/ordersForm"
			});
			if($("#member_id").val()!=""){
				//폼의 내용을 보내줌
				$("#ordersForm").submit();
			}else{
				alert("로그인 후 이용가능합니다.");
			}
		});
	});
</script>
<style type="text/css">
	.content{
		width: 100%;
		height: auto;
		margin-bottom: 10px;
		}
	#totalDiv{
		width: 70%;
		float: left;
		overflow: scroll;
		margin-top: 30px;}
	#floatMenu{
		width: 28%;
		float: right;
		margin-top: 30px;
		/* position: fixed;
		right: 100px;
		top: 400px; */
		}
	#projectInfo1{
		width: 68%;
		display: inline-block;}
	#projectInfo2{
		width: 30%;
		float: right;}
	#project_thumb{
		width: 98%;
		height: auto;}
</style>
<!--모바일 웹 페이지 설정 끝 -->
</head>
<body>
	<!-- 로그인 세션내용을 받는 값 -->
	<c:choose>
		<c:when test="${not empty data}">
			<input type="hidden" id="member_id" value="${data.member_id}">
		</c:when>
		<c:otherwise>
			<input type="hidden" id="member_id">
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${not empty project}">
			<%--헤더 시작 --%>
			<div>
				<div id="projectInfo1">
					<input type="hidden" id="project_status" value="${project.project_status}">
					<H4>${project.project_name}</H4>
					<p>${project.member_id}님의 아이디어입니다.</p>
					<img src="/uploadStorage/gallery/${project.project_thumb}" id="project_thumb">
					<p>${project.project_summary}</p>
					<a href="${project.project_URL}">${project.project_URL}로 이동</a>
				</div>
				<div id="projectInfo2">
					<c:choose>
						<c:when test="${project.project_status==0}">
							<h1>관리자의 승인을 기다리고 있습니다.</h1>
						</c:when>
						<c:when test="${project.project_status==1}">
							<h1>현재 진행중인 프로젝트</h1>
						</c:when>
						<c:when test="${project.project_status==2}">
							<h1>부적절한 내용으로 관리자가 게시를 거부한 프로젝트입니다.</h1>
						</c:when>
						<c:when test="${project.project_status==3}">
							<h1>여러분에 성원에 성공한 프로젝트입니다.</h1>
						</c:when>
						<c:when test="${project.project_status==4}">
							<h1>아쉽게도 달성되지 못한 프로젝트입니다.</h1>
						</c:when>
					</c:choose>
					<h1>목표금액 : ${project.project_targetMoney}</h1>
					<h1>현재까지 모음 : ${project.project_sumMoney}</h1>
					<h1>이 아이디어를 ${project.project_count}명이 후원해주셨습니다.</h1>
				</div>
			</div>
			<%--헤더 종료 --%>
			
				
			<div role="tabpanel" id="totalDiv">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#home"
						aria-controls="home" role="tab" data-toggle="tab">프로젝트 소개</a></li>
					<li role="presentation"><a href="#profile"
						aria-controls="profile" role="tab" data-toggle="tab">문의사항</a></li>
					<li role="presentation"><a href="#settings"
						aria-controls="settings" role="tab" data-toggle="tab">리뷰</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
					<%--프로젝트 소개 폼 시작 --%>
					<div role="tabpanel" class="tab-pane active" id="home">
					${project.project_content}
					</div>
					<%--프로젝트 소개 폼 종료 --%>
					
					<%--문의사항 폼 시작 --%>
					<div role="tabpanel" class="tab-pane" id="profile">
					
					</div>
					<%--문의사항 폼 종료 --%>
					
					<%--리뷰 폼 시작--%>
					<div role="tabpanel" class="tab-pane" id="settings">
					
					</div>
					<%--리뷰 폼 종료--%>
				</div>			
			</div>
			<div id="floatMenu" class="floating">
				<c:forEach var="content" items="${project.list}">
					<form name="content">
						<input type="hidden" name="content_num" value="${content.content_num}">
						<input type="hidden" name="content_name" value="${content.content_name}">
						<input type="hidden" name="content_MinPrice" value="${content.content_MinPrice}">
						<input type="hidden" name="content_Kind" value="${content.content_Kind}">
						<input type="hidden" name="content_recdate" value="${content.content_recdate}">
						<input type="hidden" name="option_table_name" value="${content.option_table_name}">
						<button type="button" name="content" class="content btn btn-info">
						<!-- data-toggle="modal" data-target="#myModal" -->
							상품명 : ${content.content_name}<br>
							최소후원액 : ${content.content_MinPrice}원<br>
							<h3>프로젝트 후원하기</h3>
						</button>
					</form>
				</c:forEach>
			</div>
			
			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title" id="myModalLabel">상품후원을 위한 옵션을 선택합니다.</h4>
						</div>
						<div class="modal-body">
							<form id="ordersForm">
								<input type="hidden" name="order_content" id="order_content">
								<input type="hidden" name="project_num" id="project_num" value="${project.project_num}" >
								<input type="hidden" name="content_num" id="content_num">
								<input type="hidden" name="content_kind" id="content_Kind">
								<input type="hidden" name="order_price" id="content_MinPrice">
								<input type="text" readonly="readonly" name="content_name" id="content_name" class="form-control">
							</form>
						</div>
						<div class="modal-footer">
							<p id="content_MinPriceView" class="text-right"></p>
							<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="orderBtn">결제화면으로</button>
						</div>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose>
</body>
</html>