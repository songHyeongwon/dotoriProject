<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/include/dist/js/bootstrap.min.js"></script>
<link href="/resources/include/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/resources/include/dist/css/bootstrap-theme.min.css"
	rel="stylesheet">
<link href="/resources/include/css/sticky-footer-navbar.css"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/include/css/default.css">



<link href="/resources/include/dist/css/theme.css" rel="stylesheet">
<link href="/resources/include/dist/css/justified-nav.css"
	rel="stylesheet">
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
.hdpe {
	height: 400px;
	width: 32%;
	border: black 1px solid;
	margin: 5px;
}
.carousel-inner > .item > a > img {
	top: 0;
	left: 0;
	min-width: 100%;
	min-height: 400px;
	max-height: 400px;
}
.carousel-inner > .item > img {
	top: 0;
	left: 0;
	min-width: 100%;
	min-height: 400px;
	max-height: 400px;
}
</style>
</head>

<body>

	<!-- Fixed navbar -->
	<header >
		<tiles:insertAttribute name="header" />
	</header>

	<div class="container" style="padding-top: 0; margin-top: 0;">
		<tiles:insertAttribute name="nav" />
		<section>
			<!-- 호버 이미지 영역 -->
			<div id="carousel-example-generic" class="carousel slide"
				data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
					<li data-target="#carousel-example-generic" data-slide-to="1"></li>
					<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					<li data-target="#carousel-example-generic" data-slide-to="3"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox">
					<!-- <div class="item active">
						<img src="..." alt="...">
						<div class="carousel-caption">...</div>
					</div>
					<div class="item">
						<img src="..." alt="...">
						<div class="carousel-caption">...</div>
					</div>
					... -->
					<c:choose>
						<c:when test="${not empty viewList}">
								<div class="item active">
									<img src="">
									<div class="carousel-caption">도토리 펀딩즈에 어서오세요</div>
								</div>
							<c:forEach var="project" items="${viewList}" varStatus="status">
								<div class="item">
									<a href="/project/details/${project.project_num}">
										<img src="/uploadStorage/gallery/${project.project_thumb}">
										<!-- div class="carousel-caption">...</div> -->
									</a>
								</div>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#carousel-example-generic"
					role="button" data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#carousel-example-generic" 
					role="button" data-slide="next"> 
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
			<br>
			<!-- 호버 이미지 영역 끝-->

			<!-- Example row of columns -->
			<h1>가장 최근에 등록된 프로젝트입니다.</h1>
			<div id="boardList">
				<c:choose>
					<c:when test="${not empty mainList}">
						<c:forEach var="project" items="${mainList}" varStatus="status">
							<div
								class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter hdpe">
								<form name="deteilGo">
									<input type="hidden" name="project_num"
										value="${project.project_num}">
								</form>
								<div
									style="left: 15px; width: 450px; bottom: 200px; font-size: 1.8em; font-weight: bold; position: absolute; color: white;">
									<c:choose>
										<c:when test="${project.project_status==0}">
										관리자검수중
									</c:when>
										<c:when test="${project.project_status==1}">
										진행중
									</c:when>
										<c:when test="${project.project_status==2}">
										관리자거부
									</c:when>
										<c:when test="${project.project_status==3}">
										펀딩 성공
									</c:when>
										<c:when test="${project.project_status==4}">
										펀딩 실패
									</c:when>
									</c:choose>
								</div>
								<img src="/uploadStorage/gallery/${project.project_thumb}"
									class="img-responsive" style="height: 200px; width: 600px">

								<div>
									제목 : ${project.project_name}<br> 설명 :
									${project.project_summary}<br> 달성률 :
									${(project.project_sumMoney/project.project_targetMoney)*100}%<br>
									종료일 : ${project.project_endDate}<br> 제작자 :
									${project.member_id}<br> 대분류 : ${project.project_pattern1}<br>
									소분류 : ${project.project_pattern2}<br>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						등록된 게시물이 없습니다.
					</c:otherwise>
				</c:choose>
			</div>
			<h1>최고 후원액의 프로젝트입니다.</h1>
			<div>
				<c:choose>
					<c:when test="${not empty summoneyList}">
						<c:forEach var="project" items="${summoneyList}" varStatus="status">
							<div
								class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter hdpe">
								<form name="deteilGo">
									<input type="hidden" name="project_num"
										value="${project.project_num}">
								</form>
								<div
									style="left: 15px; width: 450px; bottom: 200px; font-size: 1.8em; font-weight: bold; position: absolute; color: white;">
									<c:choose>
										<c:when test="${project.project_status==0}">
										관리자검수중
									</c:when>
										<c:when test="${project.project_status==1}">
										진행중
									</c:when>
										<c:when test="${project.project_status==2}">
										관리자거부
									</c:when>
										<c:when test="${project.project_status==3}">
										펀딩 성공
									</c:when>
										<c:when test="${project.project_status==4}">
										펀딩 실패
									</c:when>
									</c:choose>
								</div>
								<img src="/uploadStorage/gallery/${project.project_thumb}"
									class="img-responsive" style="height: 200px; width: 600px">

								<div>
									제목 : ${project.project_name}<br> 설명 :
									${project.project_summary}<br> 달성률 :
									${(project.project_sumMoney/project.project_targetMoney)*100}%<br>
									종료일 : ${project.project_endDate}<br> 제작자 :
									${project.member_id}<br> 대분류 : ${project.project_pattern1}<br>
									소분류 : ${project.project_pattern2}<br>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						등록된 게시물이 없습니다.
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