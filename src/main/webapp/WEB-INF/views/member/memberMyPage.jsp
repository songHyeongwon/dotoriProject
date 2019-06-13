<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				})
				
				
				// 도토리 사용내역
				$("#usingDotori").click(function(){
					usingDotoriListData();
				})
				
				// 내가 만든 펀딩
				$("#makeFund").click(function(){
					fundingListData();
				})
				
				// '도토리 충전' 버튼 클릭 시 함수
				$("#dotoriCharge").click(function(){
					$("#card").click();
					$("#dotoriModal").modal();
				})
				
				// 비밀번호 확인 버튼 클릭시 함수
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
				
				// 도토리 충전
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
			
			
			// 내가 만든 펀딩 동적 생성을 위한 함수
			function fundingListData(){
				$("#listArea").html("");
				$.getJSON("/member/myFunding", $("#myPageForm").serialize(), function(data){
					console.log("length : "+data.length);
					$(data).each(function(index){
						var project_num = this.prject_num;
						var project_name = this.project_name;
						var project_thumb = this.project_thumb;
						var project_url = this.project_url;
						var project_summary = this.project_summary;
						var member_id = this.member_id;
						var project_content = this.project_content;
						var project_addDate = this.project_addDate;
						
						console.log("index : "+index);
						thumbnailList(project_num,member_id,project_content,project_addDate,project_name,project_thumb,project_url,project_summary,index);
					});
				}).fail(function(){
					alert("목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
				});
			}
			
			function thumbnailList(project_num,member_id,project_content,project_addDate,project_name,project_thumb,project_url,project_summary,index){
				var column = $("<div>");
				column.attr("data-num",project_num);
				column.addClass("col-sm-6 col-md-4");
				
				var thumbnail = $("<div>");
				thumbnail.addClass("thumbnail");
				
				var img = $("<img>");
				img.attr("src","/uploadStorage/project/thumbnail/"+project_thumb);
				console.log(img.attr("src"));
				
				
				var caption = $("<div>");
				caption.addClass("caption");
				
				var h3 = $("<h3>")
				h3.html(project_name.substring(0,12)+"...");
				
				var pInfo = $("<p>");
				pInfo.html("작성자 : "+member_id+"/ 등록일 : "+project_addDate);
				
				var pContent = $("<p>");
				pContent.html(project_content.substring(0,24)+"...");
				
				var pBtnArea = $("<p>");
				
				var upBtn = $("<a>");
				upBtn.attr({"data-btn" : "upBtn",
							"role" : "button" });
				upBtn.addClass("btn btn-primary gap");
				upBtn.html("수정");
				
				var delBtn = $("<a>");
				delBtn.attr({"data-btn" : "delBtn",
							 "role" : "button" });
				delBtn.addClass("btn btn-default");
				delBtn.html("중지");
				
				caption.append(h3).append(pInfo).append(pContent).append(pBtnArea.append(upBtn).append(delBtn));
				column.append(thumbnail.append(img).append(caption));
				
				$("#listArea").append(column);
			}
			
			// 펀딩 중 화면 동적 생성을 위한 함수
			/* function fundingListData(){
				$("#listArea").html("");
				$.getJSON("/member/memberFunding", $("#myPageForm").serialize(), function(data){
					console.log("length : "+data.length);
					$(data).each(function(index){
						var orders_num = this.prject_num;
						var orders_name = this.project_name;
						var orders_content = this.project_thumb;
						var project_url = this.project_url;
						var project_summary = this.project_summary;
						var member_id = this.member_id;
						var project_content = this.project_content;
						var project_addDate = this.project_addDate;
						
						console.log("index : "+index);
						thumbnailList(project_num,member_id,project_content,project_addDate,project_name,project_thumb,project_url,project_summary,index);
						//makePaging(listArea);
					});
				}).fail(function(){
					alert("목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
				});
			}
			
			function thumbnailList(project_num,member_id,project_content,project_addDate,project_name,project_thumb,project_url,project_summary,index){
				var column = $("<div>");
				column.attr("data-num",project_num);
				column.addClass("col-sm-6 col-md-4");
				
				var thumbnail = $("<div>");
				thumbnail.addClass("thumbnail");
				
				var img = $("<img>");
				img.attr("src","/uploadStorage/project/thumbnail/"+project_thumb);
				console.log(img.attr("src"));
				
				
				var caption = $("<div>");
				caption.addClass("caption");
				
				var h3 = $("<h3>")
				h3.html(project_name.substring(0,12)+"...");
				
				var pInfo = $("<p>");
				pInfo.html("작성자 : "+member_id+"/ 등록일 : "+project_addDate);
				
				var pContent = $("<p>");
				pContent.html(project_content.substring(0,24)+"...");
				
				var pBtnArea = $("<p>");
				
				var upBtn = $("<a>");
				upBtn.attr({"data-btn" : "upBtn",
							"role" : "button" });
				upBtn.addClass("btn btn-primary gap");
				upBtn.html("이동");
				
				var delBtn = $("<a>");
				delBtn.attr({"data-btn" : "delBtn",
							 "role" : "button" });
				delBtn.addClass("btn btn-default");
				delBtn.html("환불");
				
				caption.append(h3).append(pInfo).append(pContent).append(pBtnArea.append(upBtn).append(delBtn));
				column.append(thumbnail.append(img).append(caption));
				
				$("#listArea").append(column);
			} */
			
			// 사용한 도토리 내역 동적 생성을 위한 함수
			function usingDotoriListData(){
				$("#listArea").html("");
				$.getJSON("/member/usingDotori", $("#myPageForm").serialize(), function(data){
					console.log("length : "+data.length);
					$(data).each(function(index){
						var order_num = this.order_num;
						var project_num = this.prject_num;
						var project_name = this.project_name;
						var member_id = this.member_id;
						var order_content = this.order_content;
						var order_price = this.order_price;
						var order_date = this.order_date;
						
						console.log("index : "+index);
						thumbnailList(order_num,project_num,project_name,member_id,order_content,order_price,order_date,index);
						//makePaging(listArea);
					});
				}).fail(function(){
					alert("목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
				});
			}
			
			function thumbnailList(order_num,project_num,project_name,member_id,order_content,order_price,order_date,index){
				var column = $("<div>");
				column.attr("data-num",order_num);
				column.addClass("col-sm-6 col-md-4");
				
				var table = $("<table>");
				table.addClass("table");
				
				var thead=$("<thead>");
				
				var htr = $("<tr>");
				
				var th1=$("<th>");
				th1.html("프로젝트 이름");
				
				var th2=$("<th>");
				th2.html("프로젝트 내용");
				
				var th3=$("<th>");
				th3.html("사용한 도토리 개수");
				
				var th4=$("<th>");
				th4.html("도토리 사용 날짜");
				
				var tbody = $("<tbody>");
				
				var btr=$("<tr>");
				
				var td1 = $("<td>");
				td1.html(project_name);
				
				var td2= $("<td>");
				td2.html(project_content);
				
				var td3=$("<td>");
				td3.html(order_price);
				
				var td4=$("<td>");
				td4.html(order_date);
				
				table.append(thead.append(htr).append(th1).append(th2).append(th3).append(th4).append(tbody).append(btr).append(td1).append(td2).append(td3).append(td4));
				column.append(table);
				
				$("#listArea").append(column);
			} 
				
		</script>
	</head>
	<body>
		<div>
			<form id="myPageForm">
				<input type="hidden" id="member_id" name="member_id" value="${data.member_id }"/>
				<%-- <input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cvo.pageNum }"/>
				<input type="hidden" id="amount" name="amount" value="${pageMaker.cvo.amount }"/> --%>
				<div class="text-center">
					<table class="table table-striped">
						<tr>
							<td></td>
							<td><span class="dotori">도토리</span></td>
						</tr>
						<tr>
							<td><span class="dotori">${data.member_name}</span>님</td>
							<td><span class="dotori">${data.member_point}</span>개
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
				
				<div id="listArea">
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