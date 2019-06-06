<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport"
	content="width=device-width initial-scale=1.0,
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<link rel="shortcut icon" href="../image/icon.png" />
<link rel="apple-touch-icon" href="../image/icon.png" />
<script type="text/javascript">
	$(function() {
		$(".names").click(function() {
			var form = $(this).next();
			form.attr({
				"action" : "/projectManager/detail",
				"method" : "post"
			});
			form.submit();
		});
		$(".paginate_button a").click(
				function(e) {
					//event.preventDefault() 이벤트를 보내지 않고 취소합니다.
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val(
							$(this).attr("href"));
					goPage();
				});
	})
	function goPage() {
		if ($("#search").val() == "all") {
			$("#keyword").val("");
		}
		$("#search").attr({
			"method" : "get",
			"action" : "/board/boardList"
		});
		$("#f_search").submit();
	}
</script>
</head>
<body>
	<h1 class="text-center">프로젝트 관리</h1>
	<div id="boardSearch" class="text-right">
			<form id="f_search" name="f_search" class="form-inline">
				<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				<div class="form-group">
					<label>검색조건 : </label>
					<select id="search" name="search" class="form-control">
						<option value="all">전체</option>
						<option value="b_title">제목</option>
						<option value="b_content">내용</option>
						<option value="b_name">작성자</option>
					</select> 
					<input type="text" placeholder="검색어를 입력해주세요" id="keyword"
						name="keyword" class="form-control"> 
					<input type="button"
						value="검색" class="btn btn-primary" id="searchData">
				</div>
			</form>
		</div>
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
						<td>선택(전체)<input type="checkbox" id="allChekc"></td>
					</tr>
				</thead>
				<c:forEach var="project" items="${list}" varStatus="status">
					<tbody>
						<tr>
							<td>${project.project_num}</td>
							
							<td>
								<a href="#" class="names">${project.project_name}</a>
								<form><input type="hidden" name="project_num" value="${project.project_num}"></form>
							</td>
							
							<td>${project.project_pattern1}</td>
							<td>${project.project_pattern2}</td>
							<td>${project.project_targetMoney}</td>
							<td>${project.project_sumMoney}</td>
							<td>${project.project_endDate}</td>
							<td>${project.project_count}</td>
							<td>${project.project_status}</td>
							<td>${project.member_id}</td>
							<td><input type="checkbox" name="check"></td>
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