<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- <link rel="icon" href="../../favicon.ico"> -->

<title><tiles:getAsString name="title" /></title>
<!-- Bootstrap core CSS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/include/dist/js/bootstrap.min.js"></script>
<link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/include/dist/css/bootstrap-theme.min.css" rel="stylesheet">
<link href="/resources/include/css/sticky-footer-navbar.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/include/css/default.css">



<link href="/resources/include/dist/css/theme.css" rel="stylesheet">
<link href="/resources/include/dist/css/justified-nav.css" rel="stylesheet">
<script src="/resources/include/dist/js/docs.min.js"></script>
<script src="/resources/include/dist/js/ie10-viewport-bug-workaround.js"></script>
<script src="/resources/include/dist/js/ie-emulation-modes-warning.js"></script>
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
<style type="text/css">
	.hdpe{height: 400px;
		width: 32%;
		border: black 1px solid;
		margin: 5px;}
</style>
</head>

<body>

	<!-- Fixed navbar -->
	<header>
		<tiles:insertAttribute name="header"/>
	</header>

	<div class="container">
		<tiles:insertAttribute name="nav" />
		<section>

			<!-- Example row of columns -->
			<h1>관리자 페이지에 어서 오세요</h1>
			<h1>승인을 기다리고 있는 프로젝트입니다.</h1>
			<div id="boardList">
			<c:choose>
				<c:when test="${not empty mainList}">
					<c:forEach var="project" items="${mainList}" varStatus="status">
						<div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter hdpe">
							<form name="deteilGo">
								<input type="hidden" name="project_num" value="${project.project_num}">
							</form>
			                <img src="/uploadStorage/gallery/${project.project_thumb}" class="img-responsive" style="height: 200px; width: 600px">
			                <div>
								제목 : ${project.project_name}<br>
								설명 : ${project.project_summary}<br>
								달성률 : ${(project.project_sumMoney/project.project_targetMoney)*100}%<br>
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
		</section>
	</div>
	<footer>
		<tiles:insertAttribute name="footer" />
	</footer>
</body>
</html>