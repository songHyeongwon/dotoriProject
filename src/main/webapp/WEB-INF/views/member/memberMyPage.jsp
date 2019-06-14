<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	
		<!-- <style type="text/css">
		
			
			.li {
				list-style : none;
				font-size: 20px;	
				border : 1;
			}	
			
			.list {
				width: 150px;
				margin-bottom: 50px;
			}
			
			.dotori{
				font-size: 30px;
			}
			
			.btn{
				border: 0;				
				outline : 0;				/* 버튼 테두리 없애는 방법 */
				background-color: rgba( 255, 255, 255, 0.5 );  /* 버튼 배경색 투명하게 하는법 */
				
			}
		</style> -->
		
		<meta charset="UTF-8">
		<title>마이 페이지</title>

		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery.form.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		
		<script type="text/javascript">
			$(function(){
				var bank = ["우리","국민","기업","농협","신한","KEB하나","한국씨티","SC제일","경남","광주","대구","도이치","부산","비엔피파리바","산림조합","산업","수협","신협","우체국","카카오뱅크"];
				var chooseBtn = 0;
				var chooseConfirmBtn=0;
				var Pattern = /^[0-9]$/;
				
				$("#card").click(function(){
					$("#bankName").hide();
					$("#transact_method").html("");
					chooseBtn=0;
					$("#transact_method").append("카드");
				})
				
				$("#bank_count").click(function(){
					$("#bankName").show();
					var nameBank = $("<select>");
					nameBank.attr({
						"name" : "bank_name",
						"id" : "bank_name"
					});
					for(var count =0; count< bank.length; count++){
						var option = $("<option>"+bank[count]+"</option>");
						
						nameBank.append(option);
					}
					
					$("#bankName").html(nameBank);
					
					$("#transact_method").html("");
					
					chooseBtn=1;
					$("#transact_method").append("은행계좌");
				})
				
				// 정보 수정 버튼 클릭 시 함수 
				$("#modifyPerson").click(function(){
					location.href="/member/confirmPassword"
				})
				
				
				// 펀딩중 클릭 시 함수
				$("#funding").click(function(){
					$.ajax({
						url : "/member/memberFunding",
						data : "member_id="+$("#member_id").val(),
						type : "post",
						dataType : "text",
						error : function(){
							alert("펀딩 중 상품 로딩 중 시스템 오류입니다. 관리자에게 문의 바랍니다.");
						},
						success : function(data){
							if(data=="성공"){
								alert("비밀번호 확인되었습니다.");
							}else{
								alert("비밀번호 확인 중 오류 발생 잠시 후 다시 시도해 주세요.");
								$("member_pwd").val("");
								$("member_pwd").focus();
							}
						}
					})
				})
				
				
				// 도토리 사용내역
				$("#usingDotori").click(function(){
					$.ajax({
						url : "/member/usingDotori",
						type : "post",
						data : "member_id="+$("member_id").val(),
						dataType : "text",
						error : function(){
							alert("도토리 사용내역 출력 중 오류 발생. 관리자에게 문의 바랍니다.");
						},success : function(data){
							location.href="/member/memberMyPage";
						}
					})
				})
				
				// '도토리 충전' 버튼 클릭 시 함수
				$("#dotoriCharge").click(function(){
					$("#card").click();
					$("#dotoriModal").modal();
				})
				
				$("#pwdCheckBtn").click(function(){
					$.ajax({
						url : "/member/passwordConfirm",
						data : "member_pwd="+$("#member_pwd").val()+"&member_id="+$("#member_id").val(),
						type : "post",
						dataType : "text",
						error : function(){
							alert("비밀번호 확인 중 오류 발생 관리자에게 문의하세요.");
						},
						success : function(data){
							if(data=="성공"){
								alert("비밀번호가 확인 되었습니다.");
								chooseConfirmBtn = 1;
							}else if(data=="실패" && $("#member_pwd").val()!=''){
								alert("비밀번호가 같지 않습니다. 다시 확인 바랍니다.");
								$("#member_pwd").val("");
								$("#member_pwd").focus();
								chooseConfirmBtn = 0;
							}else if($("#member_pwd").val()==''){
								alert("비밀번호를 입력해주세요.");
							}
						}
					})
				})
				
				$("#chargeBtn").click(function(){
					if(!chkData("#member_pointCharge","충전할 도토리를")) return;
					else if(!chkData("#transact_num","번호를")) return;
					else if(!chkData("#member_pwd","비밀번호를")) return;
					else if(chooseConfirmBtn==0){
						alert("비밀번호 확인 버튼을 눌러주세요.");
					}else if($("#member_pointCharge").val().search(Pattern)<0 || $("#transact_num").val().search(Pattern)<0){
						alert("정확하게 입력해주세요.");	
					}else{
						$.ajax({
							url : "/member/dotoriCharge",
							type : "post",
							data : "member_id="+$("#member_id").val()+"&member_pointCharge="+$("#member_pointCharge").val()+"&member_point="+$("#member_point").val(),
							dataType : "text",
							error : function(){
								alert("도토리 충전 중 시스템 오류 발생 관리자에게 문의바랍니다. ");
							},
							success : function(data){
								if(data=="성공"){
									alert("도토리 충전이 완료되었습니다.");
									$("#dotoriModal").modal('hide');
									location.href = "/member/memberMyPage"
								}else{
									alert("도토리 충전 중 오류 발생 잠시 후 다시 시도해 주세요.");
								}
							}
						})
					}
				})
				
				$("#cancelBtn").click(function(){
					$("#member_pointCharge").val("");
					$("#transact_num").val("");
					$("#member_pwd").val("");
				})
				
				
			})
			
				
		</script>
	</head>
	<body>
		<div>
			<form>
				<input type="hidden" id="member_id" name="member_id" value="${sessionScope.data.member_id }"/>
				<div class="text-center">
					<table class="table table-striped">
						<tr>
							<td></td>
							<td><span class="dotori">도토리</span></td>
						</tr>
						<tr>
							<td><span class="dotori">${sessionScope.data.member_name}</span>님</td>
							<td><span class="dotori">${sessionScope.data.member_point}</span>개
								<input type="button" id="dotoriCharge" name="dotoriCharge" value="도토리 충전"></td>
						</tr>
					</table>
				</div>
				
				<div>
					<ul class="li">
						<li class="list"><input type="button" class="btn" id="funding" name="funding" value="펀딩 중 상품"/></li>
						<li class="list"><input type="button" class="btn" id="usingDotori" name="usingDotori" value="사용한 도토리 내역"/></li>
						<li class="list"><input type="button" class="btn" id="makeFund" name="makeFund" value="내가 만든 펀딩"/></li>
						<li class="list"><input type="button" class="btn" id="modifyPerson" name="modifyPerson" value="개인 정보 수정"/></li>
					</ul>
				</div>
				
				<div>
				
				</div>
			</form>
			
			<%-- 등록 화면 영역(modal) --%>
			<div class="modal fade" id="dotoriModal" tabindex="-1" role="dialog" aria-labelledby="dotoriModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="dotoriModalLabel">도토리 충전</h4>
			      </div>
			      <div class="modal-body">
			        <form id="comment_form" name="comment_form">
			          <div class="form-group">
			            <label class="control-label">현재 가지고 도토리</label>
			            <input type="text" class="form-control" id="member_point" name="member_point" value="${data.member_point }" readonly="readonly" maxlength="6">
			          </div>
			          <div class="form-group">
			            <label class="control-label">충전 할 도토리</label>
			            <input type="text" class="form-control" id="member_pointCharge" name="member_pointCharge" maxlength="6">
			          </div>
			          <div class="form-group">
			            <input type="button"  id="card" name="card" value="카드"/>
			            <input type="button"  id="bank_count" name="bank_count" value="은행계좌"/>
			          </div>
			          <div class="form-group">
			            <label class="control-label" id="transact_method">카드</label>
			            <div id="bankName"></div>
			            <input type="text" class="form-control" id="transact_num" maxlength="16"/>
			            <label class="control-label">'-'를 빼고 입력해 주새요.</label>
			          </div>
			          <div class="form-group">
			            <label class="control-label">비밀번호</label>
			            <input type="password" id="member_pwd" name="member_pwd"/>
			            <input type="button" id="pwdCheckBtn" name="pwdCheckBtn" value="비밀번호 확인"/> 
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" id="chargeBtn">충전</button>
			        <button type="button" class="btn btn-default" data-dismiss="modal" id="cancelBtn">닫기</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
	</body>
</html>