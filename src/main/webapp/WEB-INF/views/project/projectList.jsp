<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	$(function() {
		$(".hdpe").click(function() {
			var form = $(this).find("form[name='deteilGo']");
			form.attr({
				"action" : "/project/detail",
				"method" : "post"
			});
			form.submit();
		});
		
		
	})
</script>
<!--모바일 웹 페이지 설정 끝 -->
</head>
<body>
	<div class="contentContainer">
		<div class="contentTit text-center">
			<h1>프로젝트리스트</h1>
		</div>
		<form id="boardList">
			<input type="hidden" id="b_num" name="b_num" /> <input type="hidden"
				name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
			<input type="hidden" name="amount" id="amount"
				value="${pageMaker.cvo.amount }">
		</form>
		<%--============리스트 시작=========== --%>
		<div id="boardList">
			<c:choose>
				<c:when test="${not empty listProject}">
					<c:forEach var="project" items="${listProject}" varStatus="status">
						<div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter hdpe">
							<form name="deteilGo">
								<input type="hidden" name="project_num" value="${project.project_num}">
							</form>
			                <img src="/uploadStorage/gallery/${project.project_thumb}" class="img-responsive">
			                <div>
								제목 : ${project.project_name}<br>
								설명 : ${project.project_summary}<br>
								목표금 : ${project.project_targetMoney}<br>
								현재금 : ${project.project_sumMoney}<br>
								종료일 : ${project.project_endDate}<br>
								제작자 : ${project.member_id}<br>
								대분류 : ${project.project_pattern1}<br>
								소분류 : ${project.project_pattern2}<br>
							</div>
			            </div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4" class="tac">등록된 게시물이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<%--============================리스트 종료========================== --%>

	<%--=========================페이징 처리 시작=========================== --%>
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
	<%--==========================페이징 처리 종료============================--%>
</body>
</html>