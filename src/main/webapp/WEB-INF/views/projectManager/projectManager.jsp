<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<meta name="viewport" content="width=device-width initial-scale=1.0,
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
		<link rel="shortcut icon" href="../image/icon.png"/>
		<link rel="apple-touch-icon" href="../image/icon.png"/>
	</head>
	<body>
		<h1 class="text-center">프로젝트 관리</h1>
		<c:choose>
			<c:when test="${not empty list}">
				<table class="table">
					<thead>
						<tr>
							<td>번호</td>
							<td>프로젝트명</td>
							<td>대분류</td>
							<td>소분류</td>
							<td>후원금액</td>
							<td>모집금액</td>
							<td>종료일</td>
							<td>후원자</td>
							<td>상황</td>
							<td>게시자</td>
						</tr>
					</thead>
					<c:forEach var="project" items="${list}" varStatus="status">
						<tbody>
							<tr>
								<td>${project.project_num}</td>
								<td><a href="#">${project.project_name}</a></td>
								<td>${project.project_pattern1}</td>
								<td>${project.project_pattern2}</td>
								<td>${project.project_targetMoney}</td>
								<td>${project.project_sumMoney}</td>
								<td>${project.project_endDate}</td>
								<td>${project.project_count}</td>
								<td>${project.project_status}</td>
								<td>${project.member_id}</td>
							</tr>
						</tbody>
					</c:forEach>
				</table>
			</c:when>
			<c:otherwise>
				<h1>관련내용을 찾을수 없습니다.</h1>
			</c:otherwise>
		</c:choose>
		<div class="text-center">
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
</html>