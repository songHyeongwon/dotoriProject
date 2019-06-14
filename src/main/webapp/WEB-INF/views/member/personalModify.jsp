<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>

		<!-- <link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery.form.min.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script> -->
		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		
		<script type="text/javascript">
			$(function(){
				
				var Pattern = /^[0-9a-zA-Z]{5,20}$/;	// 아이디 및 비밀번호 패턴 정규식
				var phonePattern = /^[0-9]{3,4}$/;		// 전화번호 정규식
				
				var phone = "${data.member_phone}";
				var email = "${data.member_eMail}";
				
				var phoneNum = phone.split('-');
				var emailAdd = email.split('@');
				var agree = ${data.member_evenAgree};
				var member_chPwd=0; 
				
				$("#phoneFirst").val(phoneNum[0]);
				$("#phoneMiddle").val(phoneNum[1]);
				$("#phoneLast").val(phoneNum[2]);
				$("#eMailFront").val(emailAdd[0]);
				$("#eMailBack").val(emailAdd[1]);  
				
				// session값인 ${data.member_evenAgree} (이메일,문자 이벤트 발송 처리 변수)값에 따른 id="member_evenAgree"에 check가 되냐 안되냐의 함수
				if(agree==1){
					$("#member_evenAgree").prop("checked");
				}else{
					$("#member_evenAgree").prop('checked', false);
				} 
				
				// 주소 찾기 클릭 시 처리 함수
				$("#searchAddr").click(function(){
					daumAddressPostCode();
				})
				
				// 취소 버튼 클릭 시 처리 함수
				$("#cancelBtn").click(function(){
					$("#joinForm").each(function(){
						this.reset();
					})
				})
				
				// 홈버튼 클릭 시 처리 함수
				$("#homeBtn").click(function(){
					location.href="/";
				})
				
				// 이메일 뒤 select문 선택 시 처리 함수
				$("#email").on("change",function(){
					$("#eMailBack").val($(this).val());
				})
				
				// 비밀번호 확인 버튼 클릭 시 처리 함수
				$("#confirmPwd").click(function(){
					$.ajax({
						url : "/member/confirmPwd",
						type : "post",
						data : "member_pwd="+$("#member_pwd").val()+"&member_id="+$("#member_id").val(),
						dataType : "text",
						error : function(){
							alert("비밀번호 확인 중 에러 발생. 관리자에게 문의 바랍니다.");
						},
						success : function(data){
							if(data=="성공"){
								member_chPwd = 1;
								alert("이 비밀번호는 사용 가능합니다.");
							}else if(data=="실패" && $("#member_pwd").val()!=""){
								member_chPwd = 0;
								alert("전 비밀번호와 같습니다. 다르게 적어주세요.");
								$("#member_pwd").val("");
							}else if($("#member_pwd").val()==""){
								alert("비밀번호를 입력해주세요.");
							}
						}
					
					})
				})
				
				// 수정하기 클릭 시 처리 함수
				$("#modifyBtn").click(function(){
					 if($("#member_evenAgree").prop("checked")){
						 $("#member_evenAgree").val('1');
					 }else{
						 $("#member_evenAgree").val('0');
					 }
					 
					 if(!checkForm("#member_pwd","비밀번호를 ")) return;
					 else if(!checkForm("#member_cofirmPwd","확인 비밀번호를")) return;
					 else if(!checkForm("#member_nickName","닉네임을 ")) return;
					 else if($("#eMailFront").val().replace(/\s/g,"")=="" || $("#eMailBack").val().replace(/\s/g,"")==""){
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
					 }else if(!checkForm("#member_address","주소를 ")) return;
					 else if($("#member_pwd").val()!=$("#member_cofirmPwd").val()){
						 alert("비밀번호가 같지 않습니다. 확인 부탁드립니다.");
						 $("#cofirmPwd").val("");
						 $("#cofirmPwd").focus();
						 return;
					 }else if($("#member_pwd").val().search(Pattern)<0){
						 alert("비밀번호를 올바르게 입력해주세요.");
						 $("#member_pwd").val("");
						 $("#member_pwd").focus();
						 return;
					 }else if($("#phoneFirst").val().search(phonePattern)<0 || $("#phoneMiddle").val().search(phonePattern)<0 || $("#phoneLast").val().search(phonePattern)<0 ){
						 alert("핸드폰 번호를 올바르게 입력해주세요.");
						 $("#phoneFirst").val("");
						 $("#phoneMiddle").val("");
						 $("#phoneLast").val("");
						 $("#phoneFirst").focus();
						 return;
					 }else if(member_chPwd==0){
						 alert("비밀번호 확인 버튼을 눌러서 확인해 주세요.");
					 }else{
						member_eMail=$("#eMailFront").val()+"@"+$("#eMailBack").val();
						member_phone=$("#phoneFirst").val()+"-"+$("#phoneMiddle").val()+"-"+$("#phoneLast").val();
						$("#member_eMail").val(member_eMail);
						$("#member_phone").val(member_phone);
						$("#member_chPwd").val(member_chPwd);
						$.ajax({
							url : "/member/memberUpdate",
							type : "post",
							data : $("#modifyForm").serialize(),
							dataType : "text",
							error : function(){
								alert("정보 수정 중 오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
							},
							success : function(data){
								if(data=="성공"){
									alert("정보 수정이 완료되었습니다.");
									location.href="/";
								}else{
									alert("정보 수정 중 오류가 발생하였습니다. 잠시 후 다시 시도해 주세요.");
								}
							}
						})
						$("#modifyForm").attr({
							"method" : "post",
						 	"action" : "/member/memberUpdate"
						 });
						 $("#joinForm").submit();
						 
					 }
				 })
				 
				 // 탈퇴하기 버튼 클릭 시 
				 $("#deleteBtn").click(function(){
					 if(confirm("탈퇴하시겠습니까?")){
						 $.ajax({
							url : "/member/deleteMember",
						 	type : "post",
						 	dataType : "text",
						 	error : function(){
						 		alert("탈퇴 중 시스템 오류가 발생하였습니다. 관리자에게 문의바랍니다.");
						 	},
						 	success : function(data){
						 		if(data=="성공"){
						 			alert("탈퇴가 완료되었습니다.");
						 			location.href = "/";
						 		}else{
						 			alert("탈퇴 중 오류가 발생했습니다. 잠시 후 다시 시도해 보세요.");
						 		}
						 	}
						 })
					 }
				 })
					
					
				})
				
				// 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법의 함수 구현
				 function daumAddressPostCode(){
					 new daum.Postcode({
						 oncomplete: function(data){
							 // 팝업에서 검색결과 항목을 클릭했을떄 실행할 코드를 작성하는 부분.
							 
							 // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							 var roadAddr = data.roadAddress;	//도로명 주소 변수
							 var extraRoadAddr = '';			// 참고 항목 변수
							 
							 // 법정동명이 있을 경우 추가한다.(법정리는 제외)
							 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							 if(data.bname !== '' &&/[동|로|가]$/g.test(data.bname)){
								 extraRoadAddr += data.bname;
							 }
							 
							 // 건물명이 있고, 공동주택일 경우 추가한다.
							 if(data.buildingName !== '' && data.apartment ==='Y'){
								 extraRoadAddr +=(extraRoadAddr !==''?',' +data.buildingName : data.buildingName);
							 }
							 
							 // 표시할 참고항목이 있을 경우,괄호까지 추가한 최종 문자열을 만든다.
							 if(extraRoadAddr !==''){
								 extraRoadAddr = '('+extraRoadAddr+')';
							 }
							 
							 var addr = roadAddr+" "+data.jibunAddress;
							 // 우편번호와 주소 정보를 해당 필드에 넣는다.
							 $("#member_address").val(addr);
							 
							 var guideTextBox = $("#guide").val();
							 // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							 /* if(data.autoRoadAddress){
								var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
							 	guideTextBox.innerHTML = '(예상 도로명 주소 : ' + exmpRoadAddr + ')';
							 	guideTextBox.style.display='block';
							 }else if(data.autoJibunAddress) {
				             	var expJibunAddr = data.autoJibunAddress;
				                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
				                guideTextBox.style.display = 'block';
				             } else {
				                guideTextBox.innerHTML = '';
				                guideTextBox.style.display = 'none';
				             }  */
						 }
					 
					 }).open();
					 
					 new daum.Postcode({
						 onclose: function(state) {
						        //state는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수 이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
						        if(state === 'FORCE_CLOSE'){
						            //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.

						        } else if(state === 'COMPLETE_CLOSE'){
						            //사용자가 검색결과를 선택하여 팝업창이 닫혔을 경우, 실행될 코드를 작성하는 부분입니다.
						            //oncomplete 콜백 함수가 실행 완료된 후에 실행됩니다.
						        }
						    }
					 
					})
				}
			
		</script>
	</head>
	<body>
		<div>
			<div class="form-group" id="memberClassify">
			</div>
			<div class="form-group">
				<form class="modifyForm" id="modifyForm">
					<table class="table .table-striped">
						<tr class="tb">
							<td class="tn">아이디</td>
							<td colspan="2">
								<input type="text" id="member_id" name="member_id" placeholder="Id 입력" maxlength="20" value="${sessionScope.data.member_id }" readonly="readonly"/>
							</td>
						</tr>
						<tr class="tb">
							<td class="tn">비밀번호</td>
							<td colspan="2"><input type="password" id="member_pwd" name="member_pwd" placeholder="비밀번호 입력" maxlength="20"/>&nbsp;&nbsp;<input type="button" id="confirmPwd" name="confirmPwd" value="비밀번호 확인"></td>
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
							<td class="tn">닉네임</td>
							<td colspan="2"><input type="text" id="member_nickName" name="member_nickName" value="${sessionScope.data.member_nickName }"/></td>
						</tr>
						<tr class="tb">
							<td class="tn">이메일</td>
							<td colspan="2">
								<input type="text" id="eMailFront" name="eMailFront"/>
								@
								<input type="text" id="eMailBack" name="eMailBack"/>
								<select id="email">
									<option value="">직접 입력</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hamail.net</option>
									<option value="google.co.kr">google.co.kr</option>
									<option value="nate.com">nate.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
								</select>
							</td>
						</tr>	
						<tr class="tb">
							<td class="tn">전화번호</td>
							<td colspan="2">
								<input type="text" class="phone" name="phoneFirst" id="phoneFirst" maxlength="3" />
								-
								<input type="text" class="phone" name="phoneMiddle" id="phoneMiddle" maxlength="4"/>
								-
								<input type="text" class="phone" name="phoneLast" id="phoneLast" maxlength="4"/>
							</td>
						</tr>
						<tr class="tb">
							<td class="tn">주소</td>
							<td colspan="2"><input type="text" name="member_address" id="member_address" value="${sessionScope.data.member_address}" maxlength="50"/>&nbsp;&nbsp;<input type="button" id="searchAddr" name="searchAddr" value="주소 찾기"/></td>	
						</tr>
						<tr class="tb">
							<td class="tn">주소 세부사항</td>
							<td colspan="2"><input type="text" name="member_detailAddress" id="member_detailAddress" value="${sessionScope.data.member_detailAddress} "/><span id="guide" style="color:#999;display:none"></span></td>
						</tr>
						<tr>
							<td><h3 class="plusInfo">추가 정보</h3></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="checkbox" id="member_evenAgree" name="member_evenAgree"/><label for="member_evenAgree">이메일/문자 수신 동의</label>&nbsp;<a href="#">수신 약관보기</a>
							</td>
						</tr>	
					</table>
					<input type="hidden" name="member_phone" id="member_phone" />
					<input type="hidden" id="member_chPwd" name="member_chPwd"/>
					<input type="hidden" name="member_eMail" id="member_eMail"/>
				</form>
				<div class="text-center">
					<input type="button" class="btn" id="modifyBtn" name="modifyBtn" value="수정하기"/>
					<input type="button" class="btn" id="cancelBtn" name="cancelBtn" value="취소"/>
					<input type="button" class="btn" id="deleteBtn" name="deleteBtn" value="탈퇴하기"/>
					<input type="button" class="btn" id="homeBtn" name="homeBtn" value="홈"/>
				</div>
			</div>
		</div>
	</body>
</html>