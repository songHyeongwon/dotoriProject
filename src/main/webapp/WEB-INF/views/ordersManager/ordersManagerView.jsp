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
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
		$(function(){
			$("#excelDownBtn").click(function(){
				$("#f_search").attr({
					"method":"get",
					"action":"/ordersManager/ordersExcel"
				});
				$("#f_search").submit();
			});
		});
		</script>
		<title>Insert title here</title>
	</head>
	<body>
	<div class="well">
		<form class="form-inline" id="f_search">
			<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}"/>
			<input type="hidden" name="amount" value="${pageMaker.cvo.amount}"/>
		<select>
			<option id="projectName">프로젝트명</option>
			<option id="projectPattern">프로젝트 분류</option>
			<option id="memberId">후원자id</option>
		</select>
		<input type="text" name="search" id="search" placeholder="검색어를 입력해주세요."/>
		<button type="button" name="search" id="search">검색</button>
		<input type="radio" name="orderDate" id="orderDate"/>일자별 정렬
		<input type="radio" name="orderPrice" id="orderPrice"/>금액별	정렬	
		<button type="button" id="excelDownBtn">엑셀 다운로드</button>
		</form>
	</div>
		<table summary="게시판 리스트" class="table table-hover">
					<colgroup>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="50%"/>
						<col width="10%"/>
					</colgroup>
					<thead>
						<tr>
							<th data-value="order_num" class="order">후원번호</th>
							<th data-value="project_num" class="order">프로젝트 번호</th>
							<th data-value="order_date" class="order">후원일</th>
							<th data-value="member_id" class="order">후원자 id</th>
							<th data-value="order_content" class="order">리워드 내역</th>
							<th data-value="order_price" class="order">후원금액</th>
						</tr>
					</thead>
					<tbody id="list">
						<c:choose>
							<c:when test="${not empty ordersList}">
								<c:forEach var="orders" items="${ordersList}" varStatus="status">
									<tr class="tac" data-num="${orders.order_num}">
										<td>${orders.order_num}</td>
										<td>${orders.project_num}</td>
										<td>${orders.order_date}</td>
										<td class="name">${orders.member_id}</td>
										<td>${orders.order_content}</td>
										<td>${orders.order_price}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4" class="tac">등록된 후원내역이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>		
				</table>
				
				<div class="text-center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="pagination_button previous">
							<a href="${pageMaker.startPage-1}">previous</a>
						</li>
					</c:if>
					
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li 
						class="pagination_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					
					 
				</ul>
			</div>
	</body>
</html>