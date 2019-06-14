<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<meta name="viewport" content="width=device-width initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<link rel="shortcut icon" href="/resources/image/icon.png" />
	<link rel="apple-touch-icon" href="/resources/image/icon.png" />
	<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css">
	<!--모바일 웹 페이지 설정 끝 -->
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script src="/resources/include/dist/js/bootstrap.min.js"></script>
	<!--모바일 웹 페이지 설정 끝 -->
	<script type="text/javascript">
		$(function() {
			var cs_num = ${cs_detail.cs_num};
			var btnNum = 0;
			var cs_r_num = 0;
			var cs_r_content = "";
			var cs_r_name = "";
							
//----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------댓글 수정-----------------------------------------------------------------
			//업데이트 버튼 클릭시
			$("#updateBtn").click(function() {
				if(!checkForm("#cs_r_content2","댓글 내용을")) return;
				else{
					//var insertUrl = "/replies/replyUpdate";
					if(confirm("댓글 수정하시겠습니까?")){
						$.ajax({
							url : "/replies/"+cs_r_num,
							type : "put",
							headers : {
								"Content-Type":"application/json",
								"X-HTTP-Method-Override" : "PUT"
							},
							dataType:"text",
							data: JSON.stringify({
								cs_r_num : cs_r_num,
								cs_r_content:$("#cs_r_content2").val()
							}),
							error : function() {
								alert("시스템 오류입니다. 관리자에게 문의 하세요");
							},
							success : function(result) {
								if(result=="SUCCESS"){
									alert("댓글 수정이 완료되었습니다.");
									dataReset();
									$("#updateModalForm").modal('hide');
									listAll(cs_num);
								}
							}
						});
					}
				}
			});
			
			
			//수정클릭시 창
			$(document).on("click","input[data-upbtn]",function(){
				cs_r_num = $(this).parent("div").parent("div").attr("data-num");				
				cs_r_name = $(this).parent("div").children().eq(0).html();
				cs_r_content = $(this).parent("div").parent("div").children().eq(1).html();
				cs_r_content = cs_r_content.replace(/<br>/g,"\n").trim();
				$("#cs_r_name2").html(cs_r_name);
				$("#cs_r_content2").html(cs_r_content);
				$("#updateModalForm").modal();

				var form = $(".modal-body").children("form");
				form.each(function() {
					this.reset();
				});
			});
			
//-----------------------------------------------댓글 수정-----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------댓글 삭제-----------------------------------------------------------------
			//삭제 클릭시
			$(document).on("click","input[data-delbtn]",function(){
				if(confirm("댓글 삭제하시겠습니까?")){					
					cs_r_num = $(this).parent("div").parent("div").attr("data-num");
					
					$.ajax({
						url: '/replies/'+cs_r_num,
						type: "delete",
						headers : {
							"X-HTTP-Method-Override":"DELETE"
						},
						dateType: "text",
						error : function() {
							alert("댓글을 삭제하는중 예기치못한 오류가 발생하였습니다.");
						},
						success : function(result) {
							console.log("result = "+result)
							if(result=="SUCCESS"){
								alert("댓글 삭제가 완료되었습니다.");
								listAll(cs_num);
							}
						}
					});
	
					
					var form = $(".modal-body").children("form");
					form.each(function() {
						this.reset();
					});
				}
			});
			
//-----------------------------------------------댓글 삭제-----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------댓글 등록-----------------------------------------------------------------
			//댓글 등록창
			$("#replyInsertFormBtn").click(function() {
				$("#cs_r_content").val("");
				$("#replyMadel").modal();
			});
			
			//댓글 등록
			$("#replyInsertBtn").click(function() {
				if(!checkForm("#cs_r_content","댓글 내용을")) return;
				else{
					if(confirm("댓글 등록하시겠습니까?")){												
						var insertUrl = "/replies/replyInsert";					
						$.ajax({
							url : insertUrl,
							type : "post",
							headers : {
								"Content-Type":"application/json",
								"X-HTTP-Method-Override" : "POST"
							},
							dataType:"text",
							data: JSON.stringify({
								cs_num : cs_num,
								cs_r_content:$("#cs_r_content").val().trim(),
								member_id : $("#member_id").val().trim(),
								cs_r_name : $("#cs_r_name").val().trim()
							}),
							error : function() {
								alert("시스템 오류입니다. 관리자에게 문의 하세요");
							},
							success : function(result) {
								if(result=="SUCCESS"){
									alert("댓글 등록이 완료되었습니다.");
									dataReset();
									$("#replyMadel").modal('hide');
									listAll(cs_num);
								}							
							}
						});
					}
				}
			});
//-----------------------------------------------댓글 등록-----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
			//버튼 클릭시 입력 폼 초기화
			$('button[data-dismiss="modal"]').click(function() {
				dataReset();
			});
			//문서 시작시 댓글리스트 반환
			listAll(cs_num);
			//계정분류
			if($("#member_id").val().trim()==''){
				$("#replyInsertFormBtn").hide();				
			}
			$("#cs_replyList").stop().animate({ "opacity": "1", "margin-top" : "0px" }, 'slow');
		});
		
		//댓글 폼
		function addItem(cs_r_num, cs_r_name, cs_r_content, cs_r_recDate , member_id) {//새로운 댓글 객체 추가		
			//새로운 글이 추가될 div 태그 객체
			var wrapper_div = $("<div>");
			wrapper_div.attr("data-num",cs_r_num);
			
			//작성자 정보가 지정될 <div>태그
			var new_div = $("<div>");
			
			//작성자 정보의 이름
			var name_span = $("<span>");
			name_span.addClass("name");
			name_span.html(cs_r_name+"님");
			
			//작성일자
			var date_span = $("<span>");
			date_span.html(""+cs_r_recDate+" ");
			
			//수정하기 버튼
			var upBtn = $("<input>");
			upBtn.attr({"type" : "button", "value" : "수정하기"});
			upBtn.attr("data-upbtn","upBtn");
			upBtn.addClass("cs_replyBtn");
			
			//삭제하기 버튼
			var delBtn = $("<input>");
			delBtn.attr({"type":"button", "value" : "삭제하기"});
			delBtn.attr("data-delbtn","delBtn");
			delBtn.addClass("cs_replyBtn");
			
			//내용
			var content_div = $("<div>");
			content_div.html(cs_r_content);
			content_div.addClass("panel-body");
			
			//계정
			var member_input = $("<input>");
			member_input.attr("type" , "hidden");
			member_input.val(member_id);

			
			//조립하기
			new_div.append(name_span).append(date_span).append(upBtn).append(delBtn);
			wrapper_div.append(new_div).append(content_div);
			$("#cs_replyList").append(wrapper_div).append(member_input);
		}
		
		// 입력 폼 초기화
		function dataReset() {
			$("#cs_r_content").val("");
		}
		
		//댓글 리스트 출력
		function listAll(cs_num) {
			$("#cs_replyList").empty();
			var url = "/replies/all/"+cs_num+".json";
			
			$.getJSON(url, function(data) {
				replyCnt = data.length;
				$(data).each(function() {
					var cs_r_num = this.cs_r_num;
					var cs_r_name = this.cs_r_name;
					var cs_r_content = this.cs_r_content;
					var cs_r_recDate = this.cs_r_recDate;
					var member_id = this.member_id;
					cs_r_content = cs_r_content.replace(/(\r\n|\r|\n)/g,"<br/>");
					addItem(cs_r_num,cs_r_name,cs_r_content,cs_r_recDate,member_id);
					if($("#member_id").val().trim() != member_id){						
						$("div[data-num="+cs_r_num+"]").children().children("input").hide();						
					}
					if($("#member_id").val().trim() == 'master'){						
						$("div[data-num="+cs_r_num+"]").children().children("input[data-delbtn]").show();											
					} 
				})
			}).fail(function() {
				alert("댓글목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요");
			});
		}	
	</script>
	<style type="text/css">
		.cs_replyBtn {
			border: 1px solid #EAEAEA;
			border-radius : 5px;
			width: 80px;
			height: 35px;
		}
		.cs_replyBtn:hover,.cs_replyBtnS:hover {
			color: rgba(30, 22, 54, 0.6);
			box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px ;			
		}
		.cs_replyBtn:focus,.cs_replyBtnS:focus {
			outline: none;
		}

		.cs_replyBtnS {
			border: 1px solid #EAEAEA;
			border-radius : 5px;
			width: 60px;
			height: 35px;
		}
		#cs_replyList {
			margin-top : 40px;
			opacity: 0;					
		}
		#cs_replyList > div {
			margin: 20px 0;
			padding: 10px 15px;
			border: 1px solid #F6F6F6;
			box-shadow: 0px 0px 10px 3px #EAEAEA;
		}
		#cs_replyList > div > div {
			padding-left: 0px;
		}
		#cs_replyList > div > div:nth-child(1) {
			padding-right: 10px;
		}
		#cs_replyList > div > div:nth-child(2) {
			margin-top:10px;
			border-top:1px solid #EAEAEA;
			padding-left: 10px;
		}
		#cs_replyList > div > div > span {
			margin-right: 30px;
		}
		#cs_replyList > div > div > span:nth-child(1) {
			margin-left: 10px;
		}
		#cs_replyList > div > div > input[value='수정하기'] {
			margin-left : 58.0%;
			margin-right: 10px;
		}
		#cs_replyList > div > div > input[value='삭제하기'] {
			
			margin-right: 10px;
		}
	</style>
	</head>
	<body>
		<div id="replyContainer">
			<p>
				<button type="button" class="cs_replyBtn" id="replyInsertFormBtn">댓글 등록</button>
			</p>
			<%--리스트 영역 --%>
			<div id="cs_replyList">
			</div>
	
			<%--등록 화면 영역(modal) --%>
			<div class="modal fade" id="replyMadel" tabindex="-1" role="dialog"
				aria-labelledby="replyModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="replyMadalLabel">댓글 등록</h4>
						</div>
						<div class="modal-body">
							<form id="replyForm" name="replyForm">
								<div class="form-group">
									<label for="message-text" class="control-label">글내용: </label>
									<input type="hidden" name="member_id" id="member_id" value="${sessionScope.data.member_id}">
									<input type="hidden" name="cs_r_name" id="cs_r_name" value="${sessionScope.data.member_name}">
									<textarea class="form-control" id="cs_r_content" name="cs_r_content" rows="5">
									</textarea>
								</div>
							</form>
						</div>	
						<div class="modal-footer">
							<button type="button" class="cs_replyBtnS" data-dismiss="modal">닫기</button>
							<button type="button" class="cs_replyBtnS" id="replyInsertBtn">등록</button>
						</div>
					</div>
				</div>
			</div>
			<%--등록 화면 영역(modal) 종료--%>
						
			<%--업데이트용 모달폼 --%>
			<div class="modal fade" id="updateModalForm" tabindex="-1" role="dialog"
				aria-labelledby="replyModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="replyMadalLabel">댓글 수정</h4>
						</div>
						<div class="modal-body">
							<form id="updateForm" name="updateForm">
								<div class="form-group">
									<label for="recipient-name" class="control-label">작성자: <span id="cs_r_name2"></span></label>
								</div>
								<div class="form-group">
									<label for="message-text" class="control-label">글내용: </label>
									<textarea class="form-control" id="cs_r_content2" name="cs_r_content2" rows="5"></textarea>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="cs_replyBtnS" data-dismiss="modal">닫기</button>
							<button type="button" class="cs_replyBtnS" id="updateBtn">수정</button>
						</div>
					</div>
				</div>
			</div>
			<%--업데이트용 모달폼  종료--%>
		</div>
	</body>
</html>