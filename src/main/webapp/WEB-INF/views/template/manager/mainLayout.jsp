<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h1>어서오세요 관리자님 환영합니다.</h1>
		
		<table class="table">
			<colgroup>
				<col width="30%">
				<col width="70%">
			</colgroup>	
			<thead>
				<tr>
					<td>작업내용</td>
					<td>작업량</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>승인대기 프로젝트</td>
					<td><a href="/projectManager/projectManagerForm">${managerData.project_count}개의 프로젝트가 승인대기중입니다.</a></td>
				</tr>
				<tr>
					<td>답변대기 문의게시글</td>
					<td><a href="/cs_board/cs_boardList">${managerData.cs_board_count}개의 문의게시글이 답변을 기다립니다.</a></td>
				</tr>
				<tr>
					<td>금일 신규가입 회원수</td>
					<td><a href="/memberManager/memberManagerForm">${managerData.member_count}명의 신규가입자가 들어왔습니다.</a></td>
				</tr>
				<tr>
					<td>금일 홈페이지 사용 포인트</td>
					<td><a href="/ordersManager/ordersManagerView">${managerData.orders_sum_price}원의 포인트가 사용되었습니다.</a></td>
				</tr>
			</tbody>
		</table>
	</body>
</html>