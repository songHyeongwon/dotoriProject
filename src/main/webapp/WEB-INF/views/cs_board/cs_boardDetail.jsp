<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
/* 							$.ajax({
								url : "/cs_board/cs_replyCnt",
								type : "post",
								data : "cs_num="+$("#cs_num").val()+"",
								dataType : "text",
								error : function() {
									alert("시스템 오류 입니다. 관리자에게 문의 하세요.")
								},
								success : function(resultData) {
									alert("삭제")	;
								}
							});
 */			        		alert("삭제가 되었습니다.");
				            //폼 submit
							$("#cs_data").submit();
		        		}
				});
		        $("#cs_boardListBtn").click(function(){
					var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href = "/cs_board/cs_boardList"+queryString;
				});
			});
		</script>
	</head>
	<body>
		<div class="contentContainer container-fiuid">
			<div class="contentTit page-header">
				<h3 class="text-center">문의 게시판 상세보기</h3>
			</div>
			<form name="cs_data" id="cs_data">
				<input type="hidden" name="cs_num" value="${cs_detail.cs_num}" />
				<input type="hidden" name="pageNum" id="pageNum" value="${data.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${data.amount}"/>
			</form>
	
			<%--상세 정보 보여주기 시작 --%>
			<div class="contentTB text-center">
				<table class="table table-bordered">
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
							<td class="text-left">${cs_detail.cs_name}</td>
							<td>작성일</td>
							<td class="text-left">${cs_detail.cs_regDate}</td>
							<td>수정일</td>
							<td class="text-left">${cs_detail.cs_mDate}</td>
						</tr>
						<tr>
							<td>제 목</td>
							<td class="text-left" colspan="5">${cs_detail.cs_title}</td>
						</tr>
						<tr class="table-height">
							<td>내 용</td>
							<td colspan="5" class="text-left">${cs_detail.editor}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<%--============================상세 정보 보여주기 종료============================== --%>
			<div class="btnArea text-right">
				<input type="button" value="수정" id="cs_updateFormBtn"	class="btn btn-success" /> 
				<input type="button" value="삭제" id="cs_boardDeleteBtn" class="btn btn-success" /> 
				<input type="button" value="목록" id="cs_boardListBtn" class="btn btn-success" />
			</div>
			<jsp:include page="cs_reply.jsp"></jsp:include>
			
		</div>		
	</body>
</html>