<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<!--모바일 웹 페이지 설정 끝 -->
<script type="text/javascript">
	$('#myTab a').click(function(e) {
		e.preventDefault()
		$(this).tab('show')
	})
</script>
</head>
<body>
	<h1>프로젝트의 내용을 입력해주세요</h1>
	<form>
	<div role="tabpanel">

		<!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#home"
				aria-controls="home" role="tab" data-toggle="tab">프로젝트 개요</a></li>
			<li role="presentation"><a href="#profile"
				aria-controls="profile" role="tab" data-toggle="tab">펀딩 및 후원품 구성</a></li>
			<li role="presentation"><a href="#messages"
				aria-controls="messages" role="tab" data-toggle="tab">프로젝트 세부내용</a></li>
			<li role="presentation"><a href="#settings"
				aria-controls="settings" role="tab" data-toggle="tab">계좌설정</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="home">
				<table class="table table-bordered">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tr>
						<td class="text-center">프로젝트 명</td>
						<td><input type="text" id="Project_name" name="Project_name" class="form-control">
					</tr>
					<tr>
						<td class="text-center">프로젝트 소개</td>
						<td><textarea rows="7" cols="" id="Project_summary" name="Project_summary" class="form-control"></textarea>
					</tr>
					<tr>
						<td class="text-center">프로젝트 썸네일</td>
						<td><input type="file" id="Project_thumb" name="Project_thumb" class="form-control"> 
					</tr>
					<tr>
						<td class="text-center">프로젝트 구분</td>
						<td>대분류 <select id="Project_pattern1" name="Project_pattern1" class="form-control">
							<option value="g">게임</option>
							<option value="s">공연</option>
							<option value="p">출판</option>
							<option value="f">패션</option>
							<option value="c">캠페인</option>
						</select><br>소분류 <select id="Project_pattern2" name="Project_pattern2" class="form-control">
							<option value="g">게임</option>
							<option value="s">공연</option>
							<option value="p">출판</option>
							<option value="f">패션</option>
							<option value="c">캠페인</option>
						</select>
					</tr>
					<tr>
						<td class="text-center">프로젝트 목표금액</td>
						<td><input type="text" id="Project_targetMoney" name="Project_targetMoney" class="form-control" placeholder="금액입력"></td>
					</tr>
					<tr>
						<td class="text-center">프로젝트 종료일</td>
						<td><input type="date" id="Project_endDate" name="Project_endDate" class="form-control"></td>
					</tr>
					<tr>
						<td class="text-center">관련 사이트 URL</td>
						<td><input type="text" id="Project_URL" name="Project_URL" class="form-control"></td>
					</tr>
				</table>
			</div>
			<div role="tabpanel" class="tab-pane" id="profile">
				펀딩 및 후원품 구성 폼
			</div>
			<div role="tabpanel" class="tab-pane" id="messages">
				프로젝트 세부내용 폼
			</div>
			<div role="tabpanel" class="tab-pane" id="settings">
				계좌설정 폼
			</div>
		</div>
	</div>
	<button type="button">이전</button>
	<button type="button">다음</button>
	</form>
</body>
</html>