<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>	
		
		<style type="text/css">
			#inform{
				color: red;
			}
			
			#dotori{
				color : green;
				font-weight: bold;
			}
			
			.phone{
				width : 50px;
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
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		
		<script type="text/javascript">

		var member_kind=0;
		 $(function(){
			var member_eMail="";
			var member_phone="";
			var sigNum="";
			var sigNumPersonalPattern = /^[0-9]{6,7}$/;	// 주민번호 정규식
			var sigNumCompanyPattern = /^[0-9]{2,5}$/;	// 사업자 등록번호 정규식
			var Pattern = /^[0-9a-zA-Z]{5,20}$/;	// 아이디 및 비밀번호 패턴 정규식
			var phonePattern = /^[0-9]{3,4}$/;		// 전화번호 정규식
			var idchk = 0;							// 아이디 중복확인 버튼 클릭 변수
			var eMailChk							// 이메일 중복 확인 버튼 클릭 변수
			var firstSigNum;						// 구분번호 동적 생성 맨앞 변수
			var middleSigNum;						// 구분번호 동적 생성 중간 변수
			var lastSigNum;							// 구분번호 동적 생성 마지막 변수
			var siglang;
			var slide;
			var aClick=0;
			
			$('#myCollapsible').collapse({
				  toggle: false
			})
			
			$("#searchAddr").click(function(){
				daumAddressPostCode();
			})
			
			
			// 개인 회원 버튼 클릭시 동적으로 만드는 함수
			$("#personal").click(function(){
				member_kind=0;
				$("#sig").html("");
				$("#sigNum").html("");
				
				firstSigNum=$("<input>");
				firstSigNum.attr({
					"type" : "text" ,
					"name" : "firstSigNum",
					"id" : "firstSigNum",
					"maxlength" : "6"
				});
				firstSigNum.addClass("sigNum");
				
				lastSigNum=$("<input>");
				lastSigNum.attr({
					"type" : "password" ,
					"name" : "lastSigNum",
					"id" : "lastSigNum",
					"maxlength" : "7"
				});
				lastSigNum.addClass("sigNum");
				
				$("#sig").append("주민번호 or 외국인 등록번호");
				$("#sigNum").append(firstSigNum).append("-").append(lastSigNum);
			})
			
			
			// 모달 폼 함수
			$("#promise").click(function(){
				$("#informModal").modal();
			})
			$("#okBtn").click(function(){
				$("input:checkbox[id='member_infoAgree']").prop("checked", true);
				aClick=1;
				$("#informModal").modal('hide');
			})
			
			
			// 법인 회원 버튼 클릭시 동적으로 만드는 함수
			$("#company").click(function(){
				member_kind=1;
				$("#sig").html("");
				$("#sigNum").html("");
				
				firstSigNum=$("<input>");
				firstSigNum.attr({
					"type" : "text" ,
					"name" : "firstSigNum",
					"id" : "firstSigNum",
					"maxlength" : "3"
				});
				firstSigNum.addClass("sigNum");
				
				middleSigNum=$("<input>");
				middleSigNum.attr({
					"type" : "text" ,
					"name" : "middleSigNum",
					"id" : "middleSigNum",
					"maxlength" : "2"
				});
				middleSigNum.addClass("sigNum");
				
				lastSigNum=$("<input>");
				lastSigNum.attr({
					"type" : "text" ,
					"name" : "lastSigNum",
					"id" : "lastSigNum",
					"maxlength" : "5"
				});
				lastSigNum.addClass("sigNum");
				
				$("#sig").append("사업자 번호");
				$("#sigNum").append(firstSigNum).append("-").append(middleSigNum).append("-").append(lastSigNum);
			})
			 
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
				 			idchk=1;
				 		}else if(data=="실패" && $("#member_id").val()!=""){
				 			alert("이 ID는 사용 중이라 사용이 불가능합니다. 다른 ID를 적어주세요.");
				 			$("#member_id").val("");
				 			idchk=0;
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
			 
			$("#email").on("change", function(){
        		$("#eMailBack").val($(this).val());
    		});
			 
			 $("#joinMemberBtn").click(function(){
				 if(member_kind==0){
					 	if($("#firstSigNum").val().replace(/\s/g,"")=="" || $("#lastSigNum").val().replace(/\s/g,"")==""){
						 	alert("주민번호를 입력해주세요.");
						 	$("#firstSigNum").val("");
							 $("#lastSigNum").val("");
							 $("#firstSigNum").focus();
						 	return;
						 }
					 
						 if($("#firstSigNum").val().search(sigNumPersonalPattern)<0 || $("#lastSigNum").val().search(sigNumPersonalPattern)<0){
							 alert("번호를 정확히 입력해주세요.");
							 $("#firstSigNum").val("");
							 $("#lastSigNum").val("");
							 $("#firstSigNum").focus();
							 return;
						 }
				 }else if(member_kind==1){
					 if($("#firstSigNum").val().replace(/\s/g,"")=="" || $("#middleSigNum").val().replace(/\s/g,"")=="" || $("#lastSigNum").val().replace(/\s/g,"")==""){
						 	alert("사업자 등록번호를 입력해주세요.");
						 	$("#firstSigNum").val("");
							 $("#middleSigNum").val("");
							 $("#lastSigNum").val("");
							 $("#firstSigNum").focus();
						 	return;
						 }
					 
					  if($("#firstSigNum").val().search(sigNumCompanyPattern)<0 || $("#middleSigNum").val().search(sigNumCompanyPattern)<0 || $("#lastSigNum").val().search(sigNumCompanyPattern)<0){
						 alert("번호를 정확히 입력해주세요.");
						 $("#firstSigNum").val("");
						 $("#middleSigNum").val("");
						 $("#lastSigNum").val("");
						 $("#firstSigNum").focus();
						 return;
					 }
			 	}
				 
				 if($("#member_infoAgree").prop("checked")){
					 $("#member_infoAgree").val('1');
				 }else{
					 $("#member_infoAgree").val('0');
				 }
				 
				 if($("#member_evenAgree").prop("checked")){
					 $("#member_evenAgree").val('1');
				 }else{
					 $("#member_evenAgree").val('0');
				 }
				 
				 if(!checkForm("#member_id","아이디를 ")) return;
				 else if(!checkForm("#member_pwd","비밀번호를 ")) return;
				 else if(!checkForm("#member_cofirmPwd","확인 비밀번호를")) return;
				 else if(!checkForm("#member_name","이름을 ")) return;
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
				 else if(!$("#member_infoAgree").prop("checked")){
					 alert("개인정보 처리동의 여부를 선택해주세요.");
					 $("#member_infoAgree").val('0');
					 return;
				 }else if($("#member_pwd").val()!=$("#member_cofirmPwd").val()){
					 alert("비밀번호가 같지 않습니다. 확인 부탁드립니다.");
					 $("#cofirmPwd").val("");
					 $("#cofirmPwd").focus();
					 return;
				 }else if($("#member_id").val().search(Pattern)<0){
					 alert("ID를 올바르게 입력해주세요.");
					 $("#member_id").val("");
					 $("member_id").focus();
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
				 }else if(idchk==0){
					 alert("아이디 중복을 확인해 주세요."); 
				 }else if(aClick==0){
					alert("개인 정보 처리 약관을 보고 '확인'을 눌러 주세요."); 
				 }else{
					member_eMail=$("#eMailFront").val()+"@"+$("#eMailBack").val();
					member_phone=$("#phoneFirst").val()+"-"+$("#phoneMiddle").val()+"-"+$("#phoneLast").val();
					if(member_kind==0){
						member_sigNum=$("#firstSigNum").val()+"-"+$("#lastSigNum").val();
					}else if(member_kind==1){
						member_sigNum=$("#firstSigNum").val()+"-"+$("#middleSigNum").val()+"-"+$("#lastSigNum").val();
					}
					$("#member_eMail").val(member_eMail);
					$("#member_phone").val(member_phone);
					$("#member_sigNum").val(member_sigNum);
					$("#member_kind").val(member_kind);
					$.ajax({
						url : "/member/memberJoin",
						type : "post",
						data : $("#joinForm").serialize(),
						dataType : "text",
						error : function(){
							alert("회원 가입 중 오류 발생, 관리자에게 문의바랍니다.");
						},
						success : function(data){
							if(data=="성공"){
								alert("도토리 펀딩's 가입이 완료되었습니다. 많은 이용 부탁드립니다.");
								location.href = "/";
							}else if(data=="실패"){
								alert("회원가입에 실패하였습니다. 잠시후 다시 시도해 주새요.");
							}else if(data=="이메일"){
								alert("입력하신 이메일은 가입이 되어 있습니다. 확인 부탁드립니다.");
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
			<h1>회원 가입</h1>
			<div class="form-group">
				<input type="button" id="personal" name="personal" class="btn btn-warning" value="개인 회원"/>
				<input type="button" id="company" name="company" class="btn btn-primary" value="법인 회원"/>
			</div>
			<div class="form-group">
				<form class="joinForm" id="joinForm">
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
							<td colspan="2"><input type="text" id="member_name" name="member_name" /></td>
						</tr>
						<tr class="tb">	
							<td class="tn">닉네임</td>
							<td colspan="2"><input type="text" id="member_nickName" name="member_nickName"/></td>
						</tr>
						<tr class="tb">
							<td id="sig">주민번호 or 외국인 등록번호</td>
							<td colspan="2" id="sigNum">
								<input type="text" id="firstSigNum" name="firstSigNum" maxlength="6"/> - <input type="password" id="lastSigNum" name="lastSigNum" maxlength="7"/>
							</td> 
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
									<option value="gmail.com">gmail.com</option>
									<option value="nate.com">nate.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
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
							<td colspan="2"><input type="text" name="member_address" id="member_address" maxlength="50"/>&nbsp;&nbsp;<input type="button" id="searchAddr" name="searchAddr" value="주소 찾기"/></td>	
						</tr>
						<tr class="tb">
							<td class="tn">상세주소</td>
							<td colspan="2"><input type="text" name="member_detailAddress" id="member_detailAddress"/><span id="guide" style="color:#999;display:none"></span></td>
						</tr>
						<tr>
							<td><h3 class="plusInfo">추가 정보</h3></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="checkbox" id="member_infoAgree" name="member_infoAgree"/><label for="member_infoAgree">개인정보처리 동의 여부</label>&nbsp;&nbsp;&nbsp;
								<a id="promise">개인 정보처리 약관보기</a><br/><br/><br/>
								<label id="inform">도토리's 펀딩's에서 보내는 정보에 대한 문자와 이메일 전송에 동의하십니까??</label><br/>
								<input type="checkbox" id="member_even" name="member_even"/><label for="member_even">이메일/문자 수신 동의</label>
							</td>
						</tr>	
					</table>
					<input type="hidden" name="member_sigNum" id="member_sigNum" />
					<input type="hidden" name="member_phone" id="member_phone" />
					<input type="hidden" name="member_eMail" id="member_eMail" />
					<input type="hidden" name="member_kind" id="member_kind" />
				</form>
				<div class="text-center">
					<input type="button" class="btn btn-primary" id="joinMemberBtn" name="joinMemberBtn" value="가입하기"/>
					<input type="button" class="btn btn-danger" id="cancelBtn" name="cancelBtn" value="취소"/>
					<input type="button" class="btn btn-success" id="homeBtn" name="homeBtn" value="홈"/>
				</div>
			</div>
		</div>
		
		
		
		<%-- 개인정보 약관 처리 모달 --%>
			<div class="modal fade" id="informModal" tabindex="-1" role="dialog" aria-labelledby="dotoriModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="dotoriModalLabel">도토리's 펀딩's 개인정보 처리 약관</h4>
			      </div>
			      <div class="modal-body">
			        <form id="comment_form" name="comment_form">
			          <div class="form-group informModal">
          				 <span id="dotori">도토리's 펀딩's</span> 는 개인정보 보호법 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을 수립․공개합니다. <br/><br/>

								제1조(개인정보의 처리목적) 회사는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.<br/><br/>
								
								  1. 홈페이지 회원 가입 및 관리 <br/>
								     회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별․인증, 회원자격 유지․관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 만 14세 미만 아동의 개인정보 처리시 법정대리인의 동의여부 확인, 각종 고지․통지, 고충처리 등을 목적으로 개인정보를 처리합니다. <br/>
								  2. 재화 또는 서비스 제공 <br/>
								     물품배송, 서비스 제공, 계약서․청구서 발송, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증, 요금결제․정산, 채권추심 등을 목적으로 개인정보를 처리합니다. <br/>
								  3. 고충처리 <br/>
								     민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락․통지, 처리결과 통보 등의 목적으로 개인정보를 처리합니다. <br/><br/>
								
								 제2조(개인정보의 처리 및 보유기간) ① 회사는 법령에 따른 개인정보 보유․이용기간 또는 정보주체로부터 개인정보를 수집시에 동의받은 개인정보 보유․이용기간 내에서 개인정보를 처리․보유합니다. <br/><br/>
								
								   ② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다. <br/><br/>
								
								   1. 홈페이지 회원 가입 및 관리 : 사업자/단체 홈페이지 탈퇴시까지 <br/>
								     다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료시까지 <br/>
								     1) 관계 법령 위반에 따른 수사․조사 등이 진행중인 경우에는 해당 수사․조사 종료시까지 <br/>
								     2) 홈페이지 이용에 따른 채권․채무관계 잔존시에는 해당 채권․채무관계 정산시까지 <br/>
								
								  2. 재화 또는 서비스 제공 : 재화․서비스 공급완료 및 요금결제․정산 완료시까지<br/>
								     다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료시까지 <br/>
								     1) 「전자상거래 등에서의 소비자 보호에 관한 법률」에 따른 표시․광고, 계약내용 및 이행 등 거래에 관한 기록 <br/>
								        - 표시․광고에 관한 기록 : 6월 <br/>
								        - 계약 또는 청약철회, 대금결제, 재화 등의 공급기록 : 5년 <br/>
								        - 소비자 불만 또는 분쟁처리에 관한 기록 : 3년 <br/>
								     2)「통신비밀보호법」제41조에 따른 통신사실확인자료 보관<br/>
								       - 가입자 전기통신일시, 개시․종료시간, 상대방 가입자번호, 사용도수, 발신기지국 위치추적자료 : 1년 <br/>
								       - 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월<br/><br/>
								
								 제3조(개인정보의 제3자 제공) ① 회사는 정보주체의 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.<br/><br/> 
								   ② 회사는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.<br/>
								     - 개인정보를 제공받는 자 : (주) OOO 카드<br/>
								     - 제공받는 자의 개인정보 이용목적 : 이벤트 공동개최 등 업무제휴 및 제휴 신용카드 발급 <br/>
								     - 제공하는 개인정보 항목 : 성명, 주소, 전화번호, 이메일주소, 카드결제계좌정보, 신용도정보 <br/>
								     - 제공받는 자의 보유․이용기간 : 신용카드 발급계약에 따른 거래기간동안<br/><br/>
								
								 제4조(개인정보처리의 위탁) ① 회사는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다. <br/><br/>
								
								   1. 전화 상담센터 운영 <br/>
								    - 위탁받는 자 (수탁자) : OOO 컨택센터 <br/>
								    - 위탁하는 업무의 내용 : 전화상담 응대, 부서 및 직원 안내 등 <br/>
								
								   2. A/S 센터 운영 <br/>
								    - 위탁받는 자 (수탁자) : OOO 전자 <br/>
								    - 위탁하는 업무의 내용 : 고객 대상 제품 A/S 제공 <br/><br/>
								
								  ② 회사는 위탁계약 체결시 개인정보 보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적․관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리․감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다. <br/> 
								  ③ 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다. <br/><br/>
								
								 제5조(정보주체의 권리․의무 및 행사방법) ① 정보주체는 회사에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다. <br/><br/>
								   1. 개인정보 열람요구<br/>
								   2. 오류 등이 있을 경우 정정 요구<br/>
								   3. 삭제요구 <br/>
								   4. 처리정지 요구  <br/>
								   ② 제1항에 따른 권리 행사는 회사에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 회사는 이에 대해 지체없이 조치하겠습니다. <br/>
								   ③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 회사는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다. <br/>
								   ④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다. <br/>
								   ⑤ 정보주체는 개인정보 보호법 등 관계법령을 위반하여 회사가 처리하고 있는 정보주체 본인이나 타인의 개인정보 및 사생활을 침해하여서는 아니됩니다. <br/>
								
								 제6조(처리하는 개인정보 항목) 회사는 다음의 개인정보 항목을 처리하고 있습니다. <br/><br/>
								  1. 홈페이지 회원 가입 및 관리 <br/>
								    ․필수항목 : 성명, 생년월일, 아이디, 비밀번호, 주소, 전화번호, 성별, 이메일주소, 아이핀번호 <br/>
								    ․선택항목 : 결혼여부, 관심분야 <br/>
								
								  2. 재화 또는 서비스 제공  <br/>
								    ․필수항목 : 성명, 생년월일, 아이디, 비밀번호, 주소, 전화번호, 이메일주소, 아이핀번호, 신용카드번호, 은행계좌정보 등 결제정보 <br/>
								    ․선택항목 : 관심분야, 과거 구매내역  <br/>
								
								  3. 인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다. <br/>
								    ․IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등 <br/><br/>
								
								 제7조(개인정보의 파기) ① 회사는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.<br/><br/> 
								   ② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.<br/> 
								   ③ 개인정보 파기의 절차 및 방법은 다음과 같습니다. <br/>
								   1. 파기절차 <br/>
								     회사는 파기 사유가 발생한 개인정보를 선정하고, 회사의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다. <br/>
								   2. 파기방법 <br/>
								     회사는 전자적 파일 형태로 기록․저장된 개인정보는 기록을 재생할 수 없도록 로우레밸포멧(Low Level Format) 등의 방법을 이용하여 파기하며, 종이 문서에 기록․저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다. <br/><br/>
								
								 제8조(개인정보의 안전성 확보조치) 회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다. <br/><br/>
								   1. 관리적 조치 : 내부관리계획 수립․시행, 정기적 직원 교육 등 <br/>
								   2. 기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화, 보안프로그램 설치<br/> 
								   3. 물리적 조치 : 전산실, 자료보관실 등의 접근통제 <br/><br/>
								
								 제9조(개인정보 자동 수집 장치의 설치∙운영 및 거부에 관한 사항) ① 회사는 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.<br/><br/>
								   ② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다.<br/>
								      가. 쿠키의 사용목적: 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.<br/>
								      나. 쿠키의 설치∙운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.<br/>
								      다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.<br/><br/>
								
								 제10조(개인정보 보호책임자) ① 회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.<br/><br/> 
								
								   ▶ 개인정보 보호책임자 <br/>
								       성명 : 송홍섭 <br/>
								       직책 : 도토리's 펀딩's 이사<br/> 
								       연락처 : 010-1234-5678, shs0219@dotori.com<br/>
								       팩스번호 : 070-3458-3467<br/> 
								         ※ 개인정보 보호 담당부서로 연결됩니다. <br/><br/>
								 
								   ▶ 개인정보 보호 담당부서 <br/>
								       부서명 : 개인정보 보안팀 <br/>
								       담당자 : 정영후 <br/>
								       연락처 : 010-2135-5654, youngHoos@dotori.com <br/> 
								       팩스번호 : 070-2345-6754<br/> <br/>
								
								  ② 정보주체께서는 회사의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 회사는 정보주체의 문의에 대해 지체없이 답변 및 처리해드릴 것입니다. <br/><br/> 
								
								 제11조(개인정보 열람청구) 정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. 회사는 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다. <br/><br/>
								
								   ▶ 개인정보 열람청구 접수․처리 부서 <br/>
								       부서명 : 고객관리팀<br/>
								       담당자 : 김원준 <br/>
								       연락처 : 010-2341-5678, Typhoon@dotori.com<br/> 
								    팩스번호 : 070-1231-4543 <br/><br/>
								
								 제12조(권익침해 구제방법) 정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다. <br/><br/>
								
								  <아래의 기관은 회사와는 별개의 기관으로서, 회사의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다><br/><br/>
								 
								   ▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영) <br/>
								       - 소관업무 : 개인정보 침해사실 신고, 상담 신청<br/> 
								       - 홈페이지 : privacy.kisa.or.kr <br/>
								       - 전화 : (국번없이) 118 <br/>
								       - 주소 : (58324) 전남 나주시 진흥길 9(빛가람동 301-2) 3층 개인정보침해신고센터<br/><br/>
								
								   ▶ 개인정보 분쟁조정위원회<br/>
								       - 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)<br/> 
								       - 홈페이지 : www.kopico.go.kr <br/>
								       - 전화 : (국번없이) 1833-6972<br/>
								       - 주소 : (03171)서울특별시 종로구 세종대로 209 정부서울청사 4층<br/><br/>
								
								   ▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)<br/><br/>
								
								   ▶ 경찰청 사이버안전국 : 182 (http://cyberbureau.police.go.kr)<br/><br/>
								
								 제13조(영상정보처리기기 설치․운영) ① <span id="dotori">도토리's 펀딩's</span>은(는) 아래와 같이 영상정보처리기기를 설치․운영하고 있습니다. <br/><br/>
								
								   1. 영상정보처리기기 설치근거․목적 : <span id="dotori">도토리's 펀딩's</span>의 시설안전․화재예방<br/>
								   2. 설치 대수, 설치 위치, 촬영 범위 : 사옥 로비․전시실 등 주요시설물에 00대 설치, 촬영범위는 주요시설물의 전 공간을 촬영<br/> 
								   3. 관리책임자, 담당부서 및 영상정보에 대한 접근권한자 : 보안팀 이석호 과장 <br/>
								   4. 영상정보 촬영시간, 보관기간, 보관장소, 처리방법 <br/>
								      - 촬영시간 : 24시간 촬영<br/>
								      - 보관기간 : 촬영시부터 30일 <br/>
								      - 보관장소 및 처리방법 : 보안팀 영상정보처리기기 통제실에 보관․처리<br/>
								   5. 영상정보 확인 방법 및 장소 : 관리책임자에 요구 (보안팀) <br/>
								   6. 정보주체의 영상정보 열람 등 요구에 대한 조치 : 개인영상정보 열람․존재확인 청구서로 신청하여야 하며, 정보주체 자신이 촬영된 경우 또는 명백히 정보주체의 생명․신체․재산 이익을 위해 필요한 경우에 한해 열람을 허용함 <br/>
								   7. 영상정보 보호를 위한 기술적․관리적․물리적 조치 : 내부관리계획 수립, 접근통제 및 접근권한 제한, 영상정보의 안전한 저장․전송기술 적용, 처리기록 보관 및 위․변조 방지조치, 보관시설 마련 및 잠금장치 설치 등<br/><br/>
								
								 제14조(개인정보 처리방침 변경) ① 이 개인정보 처리방침은 2019. 6. 18부터 적용됩니다.
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" id="okBtn">확인</button>
			      </div>
			    </div>
			  </div>
			</div>
		
	</body>
</html>