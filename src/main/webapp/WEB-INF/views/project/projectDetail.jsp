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
		<meta name="viewport" content="width=device-width initial-scale=1.0,
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
		<!-- viewport : 화면에 보이는 영역을 제어하는 기술.
		width는 device-width로 설정. initial-scale는 초기비율 -->
		<!-- IE8이하 브라우저에서 HTML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다. -->
		<!-- 만약 lt IE 9보다 낮다면 script html5shiv.js를 읽어와 적용하라 -->
		<!-- [if lt IE 9]>
			<script src="../js/html5shiv.js"></script>
		<![endif] -->
		<link rel="shortcut icon" href="../image/icon.png"/>
		<link rel="apple-touch-icon" href="../image/icon.png"/>
		<!--모바일 웹 페이지 설정 끝 -->
	</head>
	<body>
		<c:choose>
			<c:when test="${not empty project}">
				<c:forEach var="content" items="${project.list}">
					${content.content_num}<br>
					${content.content_name}<br>
					${content.content_MinPrice}<br>
					${content.content_Kind}<br>
					${content.content_recdate}<br>
					<c:forEach var="options" items="${content.listOption}">
						${options.content_num}<br>
						${options.option_value}<br>
						${options.option_name}<br>
						${options.option_kind}<br>
					</c:forEach>
				</c:forEach>
			</c:when>
		</c:choose>
	</body>
</html>