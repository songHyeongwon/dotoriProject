<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>			
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<!-- 브라우저의 호환성 보기 모드를 막고, 해당 브라우저에서 지원하는 가장 최신버전의 방식으로 HTML보여주도록 설정하는법 -->
		<meta name="viewport" content="width=device-width initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
		<!-- viewport: 화면에 보이는 영역을 제어하는 기술. \
			width는 device-width로 설정. initial-scale은 초기비율 -->
			
		<!--모바일 웹 페이지 설정-->
		<link rel="shortcut icon" href="image/icon.png"/>
		<link rel="apple-touch-icon" href="image/icon.png"/>
		
		
		<!--모바일 웹 페이지 설정 끝-->
		<!--<link rel="stylesheet" type="text/css" href=""/>-->	
		<!--<link rel="stylesheet" type="text/css" href="css/styles.css"/>-->
		<!-- 인터넷익스8 이하 브라우저에서 TML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다. -->
		<!-- [if it IE 9] > <script src="js/html5shiv.js"></script><![endif] -->
		<!-- <link rel="stylesheet" type="text/css" href="../js/jquery-1.12.4.min.js">
		<link rel="stylesheet" type="text/css" href="../js/jquery-3.3.1.min.js"> -->
		<!--<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> -->
			
		<!-- <script src="../js/jquery-3.3.1.min.js"></script> -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
			
		<script type="text/javascript">	
			$(function () {
		        $("#cs_updateFormBtn").click(function(){
			            $("#cs_data").attr({
			            	action : "/cs_board/cs_updateForm",
			            	method : "get"				            	
			            });
			            //폼 submit
			            $("#cs_data").submit();
				});
		        $("#cs_boardDeleteBtn").click(function(){
		        		if(confirm("삭제하시겠습니까?")){
			        		$("#cs_data").attr({
				            	action : "/cs_board/cs_boardDelete",
				            	method : "get"				            	
				            });
			        		alert("삭제가 되었습니다.");
				            //폼 submit
							$("#cs_data").submit();
		        		}
				});
		        
		        $("#cs_boardListBtn").click(function(){
					var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href = "/cs_board/cs_boardList"+queryString;
				});
		        //관리페이지로 이동
		        $("#faq_masterBoardListBtn").click(function(){
		        	if($("#path").val()==""||$("#path").val()==null){
		        		$("#path").val("cs_numDesc");
		        	}
					var queryString = "?path="+$("#path").val()+"&pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href = "/faq_board/faq_masterBoardList"+queryString;
				});
				if ($("#cs_boardId").val() != $("#member_id").val()){					
					$("#cs_updateFormBtn").hide();
					$("#cs_boardDeleteBtn").hide();
				}			
				if($("#member_id").val()!="master") {
					$("#faq_masterBoardListBtn").hide();
				}							
				if($("#member_id").val()=="master") {
					$("#cs_boardDeleteBtn").show();
				}							
			});
		</script>
		<style type="text/css">
			.table {
				border: none;
			}
			
			.table > tbody > tr:nth-child(1) {
				border-top: 2px solid #D5D5D5;			
			}
			.table > tbody > tr > td {			
				border: 1px solid #EAEAEA;
			}
			.table > tbody > tr:nth-child(3) > td {			
				border: none;
			}
			.table > tbody > tr:nth-child(3) {			
				border : none;
				height: 300px;
			}
			
			.cs_detailBtn {
				border: 1px solid #EAEAEA;
				border-radius : 5px;
				width: 60px;
				height: 35px;
			}
			.cs_detailBtn:hover {
				color: rgba(30, 22, 54, 0.6);
				box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px ;			
			}
			.cs_detailBtn:focus {
				outline: none;
			}
			.btnArea {
				border-top: 1px solid #EAEAEA;
				padding-top: 15px;
				padding-bottom: 15px;
				margin-bottom: 15px;
			}			
		</style>
	</head>
	<body>
		<input type="hidden" name="member_id" id="member_id" value="master"/>						
		<div class="contentContainer container-fiuid">
			<div class="contentTit page-header">
				<h3 class="text-center">문의 게시판 상세보기</h3>
			</div>
			<form name="cs_data" id="cs_data">
				<input type="hidden" name="cs_num" value="${cs_detail.cs_num}" />
				<input type="hidden" name="path" id="path" value="${data.path}"/>
				<input type="hidden" name="pageNum" id="pageNum" value="${data.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${data.amount}"/>
			</form>
	
			<%--상세 정보 보여주기 시작 --%>
			<div class="contentTB text-center">
				<input type="hidden" id="cs_boardId" name="cs_boardId" value="${cs_detail.member_id}">			
				<table class="table">
					<colgroup>
						<col width="20%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tbody>
						<tr>
							<td>작성자</td>
							<td>${cs_detail.cs_name}</td>
							<td>작성일</td>
							<td>${cs_detail.cs_regDate}</td>
							<td>수정일</td>
							<td>${cs_detail.cs_mDate}</td>
						</tr>
						<tr>
							<td>제 목</td>
							<td colspan="5">${cs_detail.cs_title}</td>
						</tr>
						<tr>
							<td colspan="6">${cs_detail.editor}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<%--============================상세 정보 보여주기 종료============================== --%>
			<div class="btnArea text-right">
				<input type="button" value="수정" id="cs_updateFormBtn"	class="cs_detailBtn" /> 
				<input type="button" value="삭제" id="cs_boardDeleteBtn" class="cs_detailBtn" /> 
				<input type="button" value="목록" id="cs_boardListBtn" class="cs_detailBtn" />
				<input type="button" value="관리" id="faq_masterBoardListBtn" class="cs_detailBtn" />
			</div>
			<c:set var="member_id" value="$('member_id').val()" scope="request"></c:set>			
			<jsp:include page="cs_reply.jsp"></jsp:include>			
		</div>		
	</body>
</html>