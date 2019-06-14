<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
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
			@font-face { font-family: 'PurenJeonnam'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/PureunJeonnam.woff') format('woff'); font-weight: normal; font-style: normal; }
		   body{
		   	font-family: 'PurenJeonnam'; 
		   }
		   
		</style>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#searchData").click(function(){
					if($("#keyword").val().replace(/\s/g,"")==""){
						alert("검색어를 입력해주세요.");
						return;
					}
					goPage();
				});
				//'엑셀파일 내려받기' 처리 함수
				$("#excelDownBtn").click(function(){
					$("#f_search").attr({
						"method":"get",
						"action":"/ordersManager/ordersExcel"
					});
					$("#f_search").submit();
				});
				//페이징 처리 함수
				$(".paginate_button a").click(function(e) {
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
				
			});
			function goPage() {
				if ($("#search").val() == "all") {
					$("#keyword").val("");
				}
				$("#search").attr({
					"method" : "get",
					"action" : "/ordersManager/ordersManangerView"
				});
				$("#f_search").submit();
			}
			//google chart api
			google.charts.load('current', {'packages':['corechart']});
		    google.charts.setOnLoadCallback(drawChart);

		      function drawChart() {

		        var data = google.visualization.arrayToDataTable([
		          ['프로젝트 대분류', '매출'],
		          ['출판',0],
		          ['패션',548800],
		          ['게임',0],
		          ['공연',30100],
		          ['캠페인',345000]
		        ]);

		        var options = {
		          title: '프로젝트 대분류별 매출 현황',
		          sliceVisibilityThreshold:0
		        };

		        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

		        chart.draw(data, options);
		      }
		</script>
		<title>Insert title here</title>
	</head>
	<body>
	<h1>후원내역 관리</h1>
	<div id="boardSearch" class="well">
			<form id="f_search" name="f_search" class="form-inline">
				<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				<div class="form-group">
					<select id="search" name="search" class="form-control">
						<option value="all">전체</option>
						<option value="project_num">프로젝트 번호</option>
						<option value="orders_content">리워드 품목</option>
						<option value="member_id">후원자 id</option>
						<option value="orders_num">후원번호</option>
					</select> 
					<input type="text" placeholder="검색어를 입력해주세요" id="keyword"
						name="keyword" class="form-control"> 
					<input type="button" value="검색" id="searchData" class="btn btn-primary">
					<button type="button" id="excelDownBtn" class="btn btn-primary">엑셀파일로 내보내기</button>
				</div>
			</form>
		</div>
		<div id="piechart" class="text-center" style="width: 900px; height: 500px;"></div>
		<hr/>
		<h2>후원 목록</h2>
	<c:choose>
		<c:when test="${not empty ordersList}">
			<table class="table">
				<thead>
				<tr>
					<th>후원번호</th>
					<th data-value="project_num" class="order">프로젝트 번호</th>
					<th data-value="orders_date" class="order">후원일</th>
					<th>후원자 id</th>
					<th>리워드 내역</th>
					<th>후원금액</th>
				</tr>
				</thead>
				<c:forEach var="orders" items="${ordersList}" varStatus="status">
					<tbody>
						<tr>
							<td>${orders.orders_num}</td>
							<td>${orders.project_num}</td>
							<td>${orders.orders_date}</td>
							<td>${orders.member_id}</td>
							<td>${orders.orders_content}</td>
							<td>${orders.orders_price}</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</c:when>
		<c:otherwise>
			<td colspan="6">등록된 후원내역이 없습니다</td>
		</c:otherwise>
	</c:choose>
	<hr/>
	<div class="text-center" id="pagination">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous"><a
					href="${pageMaker.startPage-1}">Previous</a></li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li
					class="paginate_button ${pageMaker.cvo.pageNum==num? 'active': ''}">
					<a href="${num}">${num}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<li class="paginate_button next"><a
					href="${pageMaker.endPage +1}">Next</a></li>
			</c:if>
		</ul>
	</div>
	</body>
	<hr/>
</html>