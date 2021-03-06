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
		<link rel="shortcut icon" href="/resources/image/icon.png" />
		<link rel="apple-touch-icon" href="/resources/image/icon.png" />
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css">
		<!--모바일 웹 페이지 설정 끝 -->
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
			
		<script type="text/javascript">	
			$(function () {
		        $("#faq_updateFormBtn").click(function(){
			            $("#faq_data").attr({
			            	action : "/faq_board/faq_updateForm",
			            	method : "get"				            	
			            });
			            //폼 submit
			            $("#faq_data").submit();
				});
		        $("#faq_boardDeleteBtn").click(function(){
		        		if(confirm("삭제하시겠습니까?")){
			        		$("#faq_data").attr({
				            	action : "/faq_board/faq_boardDelete",
				            	method : "get"				            	
				            });
			        		alert("삭제가 되었습니다.");
				            //폼 submit
							$("#faq_data").submit();
		        		}
				});
		        $("#faq_boardListBtn").click(function(){
					var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href = "/faq_board/faq_boardList"+queryString;
				});
		        $("#faq_masterBoardListBtn").click(function(){
					window.open("/faq_board/faq_masterBoardList", "_blank")
		        });

		        //------관리자용-------
		        if ($("#member_id").val() != "master"){					
					$("#faq_updateFormBtn").hide();
					$("#faq_boardDeleteBtn").hide();
					$("#faq_masterBoardListBtn").hide();
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
			.table > tbody > tr:nth-child(3) > td img {	
				max-width: 1000px;		
				border: none;
			}
			.table > tbody > tr:nth-child(3) {			
				border : none;
				height: 300px;
			}
			
			.faq_detailBtn {
				border: 1px solid #EAEAEA;
				border-radius : 5px;
				width: 60px;
				height: 35px;
			}
			.faq_detailBtn:hover {
				color: rgba(30, 22, 54, 0.6);
				box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px ;			
			}
			.faq_detailBtn:focus {
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
		<div class="contentContainer container-fiuid">
			<div class="contentTit page-header">
				<h3 class="text-center">자주 묻는 게시판 상세보기</h3>
			</div>
			<form name="faq_data" id="faq_data">
				<input type="hidden" name="faq_num" value="${faq_detail.faq_num}" />
				<input type="hidden" name="pageNum" id="pageNum" value="${boardData.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${boardData.amount}"/>
			</form>
	
			<%--상세 정보 보여주기 시작 --%>
			<div class="contentTB text-center">
				<input type="hidden" id="faq_boardId" name="faq_boardId" value="${faq_detail.member_id}">			
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
						<td>작성일</td>
							<td>${faq_detail.faq_regDate}</td>
							<td>수정일</td>
							<td>${faq_detail.faq_mDate}</td>
						</tr>
						<tr>
							<td>제 목</td>
							<td colspan="3">${faq_detail.faq_title}</td>
						</tr>
						<tr>
							<td colspan="4">${faq_detail.editor}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<%--============================상세 정보 보여주기 종료============================== --%>
			<div class="btnArea text-right">
				<input type="button" value="수정" id="faq_updateFormBtn"	class="faq_detailBtn" /> 
				<input type="button" value="삭제" id="faq_boardDeleteBtn" class="faq_detailBtn" /> 
				<input type="button" value="목록" id="faq_boardListBtn" class="faq_detailBtn" />
				<input type="button" value="관리" id="faq_masterBoardListBtn" class="faq_detailBtn" />
			</div>
		</div>		
	</body>
</html>