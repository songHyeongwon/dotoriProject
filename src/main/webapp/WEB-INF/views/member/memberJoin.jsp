<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>	
		
		<style type="text/css">
			.phone{
				width: 100px;
			}
			.btn{
				width : 100px;
				border-radius: 20px; 
			}
		</style>
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>

		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery.form.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
	
		<script type="text/javascript">
		 $(function(){
			
			 $("#idChkBtn").click(function(){
				 $.ajax({
					 url : "/member/idCheck",
					 type : "post",
					 data : "member_id="+$("#member_id").val(),
					 dataType : "text",
					 error : function(){
				 		alert("아이디 중복체크 중 시스템 오류입니다. 관리자에게 문의바랍니다.");
				 	},
				 	success : function(data){
				 		if(data=="성공" && $("#member_id").val()!=""){
				 			alert("이 ID는 사용이 가능합니다.");
				 		}else if(data=="실패" && $("#member_id").val()!=""){
				 			alert("이 ID는 사용 중이라 사용이 불가능합니다. 다른 ID를 적어주세요.");
				 			$("#member_id").val("");
				 			return;
				 		}else if($("#member_id").val()==""){
				 			alert("ID를 입력해주세요.");
				 			return;
				 		}
				 	}
				 });
			 })
			 
			 $("#cancelBtn").click(function(){
				 $(".joinForm").each(function(){
					 this.reset();
				 });
			 });
			 
			 
			 $("#homeBtn").click(function(){
				 location.href="/";
			 })
			 
			 
			 $("#joinMemberBtn").click(function(){
				 if(!checkForm("#member_id","아이디를 ")) return;
				 else if(!checkForm("#member_pwd","비밀번호를 ")) return;
				 else if(!checkForm("#member_name","이름을 ")) return;
				 else if(!checkForm("#member_nickName","닉네임을 ")) return;
				 else if($("#frontSigNum").val().replace(/\s/g,"")=="" || $("#backSigNum").val().replace(/\s/g,"")==""){
				 	alert("주민번호를 입력해주세요.");
				 	$("#frontSigNum").val("");
				 	$("#backSigNum").val("");
				 	$("#frontSigNum").focus();
				 	return;
				 }else if($("#eMailFront").val().replace(/\s/g,"")=="" || $("#eMailBack").val().replace(/\s/g,"")==""){
					 	alert("이메일을 입력해주세요.");
					 	$("#eMailFront").val("");
					 	$("#eMailBack").val("");
					 	$("#eMailFront").focus();
					 	return;
				 }else if($("#phoneFirst").val().replace(/\s/g,"")=="" || $("#phoneMiddle").val().replace(/\s/g,"")=="" ||$("#phoneLast").val().replace(/\s/g,"")==""){
					 	alert("전화번호를 입력해주세요.");
					 	$("#phoneFirst").val("");
					 	$("#phoneMiddle").val("");
					 	$("#phoneLast").val("");
					 	$("#phoneFirst").focus();
					 	return;
				 }else if(!checkForm("#address","주소를 ")) return;
				 else if(!checkForm("#addressDetail","상세주소를 ")) return;
				 else if(!$("#member_infoAgree").prop("checked")){
					 alert("개인정보 처리동의 여부를 선택해주세요.");
					 return;
				 }else if($("#member_pwd").val()!=$("#member_cofirmPwd").val()){
					 alert("비밀번호가 같지 않습니다. 확인 부탁드립니다.");
					 $("#cofirmPwd").val("");
					 $("#cofirmPwd").focus();
					 
					 return;
				 }else{}
			 })
			 
		 })
		</script>
	</head>
	<body>
		<div>
			<h1>회원 가입</h1>
			<div class="form-group">
				<input type="button" id="personal" name="personal" value="개인 회원"/>
				<input type="button" id="company" name="company" value="법인 회원"/>
			</div>
			<div class="form-group">
				<form class="joinForm">
					<table class="table .table-striped">
						<tr class="tb">
							<td class="tn">아이디</td>
							<td colspan="2">
								<input type="text" id="member_id" name="member_id" placeholder="Id 입력" maxlength="20"/>
								<input type="button" id="idChkBtn" name="idChkBtn" value="아이디 중복 체크">
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2"><label>ID는 영문자와 숫자 포함 5자이상 20자이하</label></td>
						</tr>
						<tr class="tb">
							<td class="tn">비밀번호</td>
							<td colspan="2"><input type="password" id="member_pwd" name="member_pwd" placeholder="비밀번호 입력" maxlength="20"/></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2"><label>영문자와 숫자를 혼합하여 8자이상 20자이하</label></td>
						</tr>
						<tr class="tb">
							<td class="tn">비밀번호 확인</td>
							<td colspan="2"><input type="password" id="member_cofirmPwd" name="member_confirmPwd"/></td>
						</tr>
						<tr class="tb">
							<td class="tn">이름</td>
							<td colspan="2"><input type="text" id="member_name" name="member_name"/></td>
						</tr>
						<tr class="tb">	
							<td class="tn">닉네임</td>
							<td colspan="2"><input type="text" id="member_nickName" name="member_nickName"/></td>
						</tr>
						<tr class="tb">
							<td class="tn">주민등록번호(or 외국인번호)</td>
							<td colspan="2">
								<input type="text" id="frontSigNum" name="frontSigNum" maxlength="6"/> 
								- 
								<input type="password" id="backSigNum" name="backSigNum" maxlength="7"/>
							</td>
						</tr>
						<tr class="tb">
							<td class="tn">이메일</td>
							<td colspan="2">
								<input type="text" id="eMailFront" name="eMailFront"/>
								@
								<input type="text" id="eMailBack" name="eMailBack"/>
								<select>
									<option>naver.com</option>
									<option>hamail.net</option>
									<option>google.co.kr</option>
									<option>nate.com</option>
									<option>yahoo.co.kr</option>
								</select>
							</td>
						</tr>	
						<tr class="tb">
							<td class="tn">전화번호</td>
							<td colspan="2">
								<input type="text" class="phone" name="phoneFirst" id="phoneFirst" maxlength="3"/>
								-
								<input type="text" class="phone" name="phoneMiddle" id="phoneMiddle" maxlength="4"/>
								-
								<input type="text" class="phone" name="phoneLast" id="phoneLast" maxlength="4"/>
							</td>
						</tr>
						<tr class="tb">
							<td class="tn">주소</td>
							<td colspan="2"><input type="text" name="address" id="address" maxlength="50"/></td>
						</tr>
						<tr class="tb">
							<td class="tn">주소 세부사항</td>
							<td colspan="2"><input type="text" name="addressDetail" id="addressDetail"/></td>
						</tr>
						<tr>
							<td><h3 class="plusInfo">추가 정보</h3></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="checkbox" id="member_infoAgree" name="member_infoAgree"/><label for="member_infoAgree">개인정보 처리 동의</label>&nbsp;<a href="#">정보처리 약관보기</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="checkbox" id="Member_evenAgree" name="Member_evenAgree"/><label for="Member_evenAgree">이메일/문자 수신 동의</label>&nbsp;<a href="#">수신 약관보기</a>
							</td>
						</tr>	
					</table>
				</form>
				<div class="text-center">
					<input type="button" class="btn" id="joinMemberBtn" name="joinMemberBtn" value="가입하기"/>
					<input type="button" class="btn" id="cancelBtn" name="cancelBtn" value="취소"/>
					<input type="button" class="btn" id="homeBtn" name="homeBtn" value="홈"/>
				</div>
			</div>
		</div>
		
	</body>
</html>