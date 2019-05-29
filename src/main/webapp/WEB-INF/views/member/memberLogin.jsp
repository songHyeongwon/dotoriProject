<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	
		
		<meta charset="UTF-8">
		<title>로그인 창</title>
		
		<link type="text/css" rel="stylesheet" href="/resources/include/css/memberJoin.css">
		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery.form.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
	
	</head>
	<body>
		<div class="text-center total">
			<h1 class="strong">로그인</h1>
			<div>
				<form name="loginForm" id="loginForm">
					<div class="form-group">
						<input type="text" class="text" id="id" name="id" placeholder="아이디 입력"/>
					</div>
					<div class="form-group">
						<input type="text" class="text" id="pwd" name="pwd" placeholder="비밀번호(영문자/숫자 혼용 8~20자 사이)"/>
					</div>
					<div class="form-group">
						<p class="error"></p>
					</div>
				</form>
				<div class="form-group">	
					<input type="checkbox" id="saveId" name="saveId"/>&nbsp;<label for="saveId">아이디 저장</label>
					<a href="#" class="idPwdLink">아이디/비밀번호 찾기</a>
				</div>
				<div class="form-group">	
					<input type="button" class="btn btn-warning" id="loginBtn" name="loginBtn" value="로그인"/>
				</div>
				<div class="form-group join">
					아직 도토리's 계정이 없으신가요?<a href="/member/memberJoin" class="a">도토리's 회원가입</a>
				</div>
				<div class="form-group">
					<input type="button" class="btn btn-success" id="naver" name="naver" value="Naver"/>
					<input type="button" class="btn btn-primary" id="facebook" name="facebook" value="FaceBook"/>
				</div>
				<div class="form-group">
					<input type="button" class="btn btn-default" id="google" name="google" value="Google"/>
					<input type="button" class="btn btn-info" id="twitter" name="twitter" value="twitter"/>
				</div>
			</div>
		</div>
	</body>
</html>