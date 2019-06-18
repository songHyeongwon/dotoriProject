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

		<!--모바일 웹 페이지 설정-->
		<link rel="shortcut icon" href="image/icon.png"/>
		<link rel="apple-touch-icon" href="image/icon.png"/>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css">
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		
			
		<script type="text/javascript">	
			$(function () {
		        //뮨의 게시글 수정
				$("#cs_updateFormBtn").click(function(){
			        $("#cs_data").attr({
			           	action : "/cs_board/cs_updateForm",
			           	method : "get"				            	
			        });
			        //폼 submit
			        $("#cs_data").submit();
				});
		        
		        //문의 게시글 삭제
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
		        				
				//관리자 공지 삭제
		        $("#master_cs_boardDeleteBtn").click(function(){
		        	if(confirm("삭제하시겠습니까?")){
			        	$("#cs_data").attr({
				           	action : "/cs_board/master_cs_boardDelete",
				           	method : "get"				            	
				        });
			        	alert("삭제가 되었습니다.");
				           //폼 submit
						$("#cs_data").submit();
		        	}
				});
		        
				//문의 리스트로 이동
		        $("#cs_boardListBtn").click(function(){
			        var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					if($("input[name='update']").val()=="master_update"){
						location.href = "/cs_board/master_cs_boardAllList"+queryString;												
					} else {
						location.href = "/cs_board/cs_boardList"+queryString;						
					}
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
				if($("input[name='update']").val()=="master_update"){
					$("#cs_replys").hide();
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
		<input type="hidden" name="member_id" id="member_id" value="${sessionScope.data.member_id}"/>						
		<input type="hidden" name="member_name" id="member_name" value="${sessionScope.data.member_name}"/>						
		<div class="contentContainer container-fiuid">
			<div class="contentTit page-header">
				<h3 class="text-center">문의 게시판 상세보기</h3>
			</div>
			<form name="cs_data" id="cs_data">
				<input type="hidden" name="update" value="${update}" />
				<input type="hidden" name="cs_num" value="${cs_detail.cs_num}" />
				<input type="hidden" name="path" id="path" value="${boardData.path}"/>
				<input type="hidden" name="pageNum" id="pageNum" value="${boardData.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${boardData.amount}"/>
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
			<div id="cs_replys">
				<jsp:include page="cs_reply.jsp"></jsp:include>			
			</div>
		</div>		
	</body>
</html>