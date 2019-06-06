<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		
		<meta charset="UTF-8">
		<title>로그인 창</title>
		
		<!-- <link type="text/css" rel="stylesheet" href="/resources/include/css/memberJoin.css">
		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery.form.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script> -->
		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		
		
		<script type="text/javascript">
			if("${success}"==1){
				alert("도토리 펀딩's 가입이 완료되었습니다. 많은 이용 부탁드립니다.");
			} 		
			
			/* if("${fail}"==0){
				alert("비밀번호 또는 ID가 일치하지 않습니다.\n다시 확인 부탁드립니다.");
			} */
			$(function(){
				// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감
				var userInputId = getCookie("userInputId");
				$("#member_id").val(userInputId);
				
				if($("#member_id").val()!=""){	// 그 전에 ID를 저장해서 처음 페이지 로딩 시,입력 칸에 저장된 ID가 표시된 상태라면,
					$("#saveId").attr("checked",true);	// ID 저장하기를 체크 상태로 두기.
				}
				
				$("#saveId").change(function(){	// 체크박스에 변화가 있다면,
					if($("#saveId").is(":checked")){	// ID 저장하기 체크했을 때,
						var userInputId = $("#member_id").val();
						setCookie("userInputId",userInputId,7);	// 7일 동안 쿠키 보관
					}else{	// ID 저장하기 체크 해제 시
						deleteCookie("userInputId");
					}
				});
				
				// ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장
				$("#member_id").keyup(function(){	// ID입력 칸에 ID를 입력할 때.
					if($("#saveId").is(":checked"))	{	// ID 저장하기를 체크한 상태라면,
						var userInputId=$("#member_id").val();
						setCookie("userInputId",userInputId,7);	// 7일 동안 쿠키 보관
					}
				})
				
				
				$("#loginBtn").click(function(){
					if(!checkForm("#member_id","ID를")) return;
					else if(!checkForm("#member_pwd","비밀번호를")) return;
					else{
						$("#loginForm").attr({
							"method" : "post",
							"action" : "/member/session"
						})
						
						$("#loginForm").submit();
					}
				})
			})
			
			function setCookie(cookieName,value,exdays){
				var exdate = new Date();
				exdate.setDate(exdate.getDate() + exdays);
				var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toGMTString());
				document.cookie = cookieName + "=" +cookieValue;
			}
			
			function deleteCookie(cookieName){
			    var expireDate = new Date();
			    expireDate.setDate(expireDate.getDate() - 1);
			    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
			}
			
			function getCookie(cookieName){
				cookieName = cookieName + "=";
				var cookieData = document.cookie;
				var start = cookieData.indexOf(cookieName);
				var cookieValue='';
				if(start!=-1){
					start+=cookieName.length;
					var end = cookieData.indexOf(';',start);
					if(end==-1)end = cookieData.length;
					cookieValue = cookieData.substring(start, end);
				}
				return unescape(cookieValue);
			}
		</script>
	</head>
	<body>
		<div class="text-center total">
			<h1 class="strong">로그인</h1>
			<div>
				<form name="loginForm" id="loginForm">
					<div class="form-group">
						<input type="text" class="text" id="member_id" name="member_id" placeholder="아이디 입력"/>
					</div>
					<div class="form-group">
						<input type="password" class="text" id="member_pwd" name="member_pwd" placeholder="비밀번호(영문자/숫자 혼용 8~20자 사이)"/>
					</div>
					<div class="form-group">
						<c:if test="${codeNumber==1}">
							<p class="error">비밀번호 또는 아이디가 일치하지 않습니다.</p>
							<p class="error">확인 부탁드립니다.</p>
						</c:if>
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
					아직 도토리's 계정이 없으신가요?<a href="/member/join" class="a">도토리's 회원가입</a>
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