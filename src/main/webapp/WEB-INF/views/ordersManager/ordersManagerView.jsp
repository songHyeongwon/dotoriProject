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
		
		<title>Insert title here</title>
	</head>
	<body>
		<select>
			<option id="projectName">프로젝트명</option>
			<option id="projectPattern">프로젝트 분류</option>
			<option id="memberId">구매자id</option>
		</select>
		<input type="text" name="search" id="search" placeholder="검색어를 입력해주세요."/>
		<button type="button" name="search" id="search">검색</button>
		<input type="radio" name="orderDate" id="orderDate"/>일자별 정렬
		<input type="radio" name="orderPrice" id="orderPrice"/>금액별	정렬	
		
		<table summary="게시판 리스트" class="table table-hover">
					<colgroup>
						<col width="10%"/>
						<col width="62%"/>
						<col width="15%"/>
						<col width="13%"/>
					</colgroup>
					<thead>
						<tr>
							<th data-value="orders_num" class="order">후원번호</th>
							<th data-value="project_num" class="order">프로젝트 번호</th>
							<th data-value="orders_date" class="order">후원일</th>
							<th data-value="member_id" class="order">후원자 id</th>
							<th data-value="orders_content" class="order">리워드 내역</th>
							<th data-value="orders_price" class="order">후원금액</th>
						</tr>
					</thead>
					<tbody id="list">
						<c:choose>
							<c:when test="${not empty ordersList}">
								<c:forEach var="orders" items="${orderList}" varStatus="status">
									<tr class="tac" data-num="${orders.orders_num}">
										<td>${orders.orders_num}</td>
										<td>${orders.project_num}</td>
										<td>${orders.orders_date}</td>
										<td class="name">${orders.orders_id}</td>
										<td>${orders.orders_content}</td>
										<td>${orders.orders_price}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4" class="tac">등록된 구매내역이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>		
				</table>
	</body>
</html>