<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.dotori.client.project.vo.ProjectVO" %>
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
<style type="text/css">
	.content{
		width: 100%;
		height: auto;
		margin-bottom: 10px;
		}
	#totalDiv{
		width: 70%;
		float: left;
		overflow: scroll;
		margin-top: 30px;}
	#floatMenu{
		width: 28%;
		float: right;
		margin-top: 30px;
		/* position: fixed;
		right: 100px;
		top: 400px; */
		}
	#projectInfo1{
		width: 68%;
		display: inline-block;}
	#projectInfo2{
		width: 30%;
		float: right;}
	#project_thumb{
		width: 98%;
		height: auto;}
</style>
<!--모바일 웹 페이지 설정 끝 -->
</head>
<body>
	<c:choose>
		<c:when test="${not empty project}">
			<%--헤더 시작 --%>
			<div>
				<div id="projectInfo1">
					<H4>${project.project_name}</H4>
					<p>${project.member_id}님의 아이디어입니다.</p>
					<img src="/uploadStorage/gallery/${project.project_thumb}" id="project_thumb">
					<p>${project.project_summary}</p>
					<a href="${project.project_URL}">${project.project_URL}로 이동</a>
				</div>
				<div id="projectInfo2">
					<h1>목표금액 : ${project.project_targetMoney}</h1>
					<h1>현재까지 모음 : ${project.project_sumMoney}</h1>
					<h1>이 아이디어를 ${project.project_count}명이 후원해주셨습니다.</h1>
				</div>
			</div>
			<%--헤더 종료 --%>
			
				
			<div role="tabpanel" id="totalDiv">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#home"
						aria-controls="home" role="tab" data-toggle="tab">프로젝트 소개</a></li>
					<li role="presentation"><a href="#profile"
						aria-controls="profile" role="tab" data-toggle="tab">문의사항</a></li>
					<li role="presentation"><a href="#settings"
						aria-controls="settings" role="tab" data-toggle="tab">리뷰</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
					<%--프로젝트 소개 폼 시작 --%>
					<div role="tabpanel" class="tab-pane active" id="home">
					${project.project_content}
					</div>
					<%--프로젝트 소개 폼 종료 --%>
					
					<%--문의사항 폼 시작 --%>
					<div role="tabpanel" class="tab-pane" id="profile">
					
					</div>
					<%--문의사항 폼 종료 --%>
					
					<%--리뷰 폼 시작--%>
					<div role="tabpanel" class="tab-pane" id="settings">
					
					</div>
					<%--리뷰 폼 종료--%>
				</div>			
			</div>
			<div id="floatMenu" class="floating">
				<c:forEach var="content" items="${project.list}">
					<form name="content">
						<input type="hidden" name="content_num" value="${content.content_num}">
						<input type="hidden" name="content_name" value="${content.content_name}">
						<input type="hidden" name="content_MinPrice" value="${content.content_MinPrice}">
						<input type="hidden" name="content_Kind" value="${content.content_Kind}">
						<input type="hidden" name="content_recdate" value="${content.content_recdate}">
						<input type="hidden" name="option_table_name" value="${content.option_table_name}">
						<button type="button" name="content" class="content btn btn-info" >
							상품명 : ${content.content_name}<br>
							최소후원액 : ${content.content_MinPrice}원<br>
							<h3>프로젝트 후원하기</h3>
						</button>
					</form>
				</c:forEach>
			</div>
		</c:when>
	</c:choose>
</body>
</html>