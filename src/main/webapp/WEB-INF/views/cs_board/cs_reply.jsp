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
	<link rel="shortcut icon" href="/resources/image/icon.png" />
	<link rel="apple-touch-icon" href="/resources/image/icon.png" />
	<link rel="stylesheet"
		href="/resources/include/dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css">
	<!--모바일 웹 페이지 설정 끝 -->
	<script type="text/javascript"
		src="/resources/include/js/jquery-1.12.4.min.js"></script>
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
				$("#replyMadel").modal();
			});
			
			//댓글 등록
			$("#replyInsertBtn").click(function() {
				if(!checkForm("#cs_r_name","작성자명을")) return;
				else if(!checkForm("#cs_r_content","댓글 내용을")) return;
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
								cs_r_name : $("#cs_r_name").val(),
								cs_r_content:$("#cs_r_content").val()
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
		});
		
		//댓글 폼
		function addItem(cs_r_num, cs_r_name, cs_r_content, cs_r_recDate) {//새로운 댓글 객체 추가		
			//새로운 글이 추가될 div 태그 객체
			var wrapper_div = $("<div>");
			wrapper_div.attr("data-num",cs_r_num);
			wrapper_div.addClass("panel panel-default");
			
			//작성자 정보가 지정될 <div>태그
			var new_div = $("<div>");
			new_div.addClass("panel-heading");
			
			//작성자 정보의 이름
			var name_span = $("<span>");
			name_span.addClass("name");
			name_span.html(cs_r_name+"님");
			
			//작성일자
			var date_span = $("<span>");
			date_span.html("/"+cs_r_recDate+" ");
			
			//수정하기 버튼
			var upBtn = $("<input>");
			upBtn.attr({"type" : "button", "value" : "수정하기"});
			upBtn.attr("data-upbtn","upBtn");
			upBtn.addClass("btn btn-primary gap");
			
			//삭제하기 버튼
			var delBtn = $("<input>");
			delBtn.attr({"type":"button", "value" : "삭제하기"});
			delBtn.attr("data-delbtn","delBtn");
			delBtn.addClass("btn btn-default gap");
			
			//내용
			var content_div = $("<div>");
			content_div.html(cs_r_content);
			content_div.addClass("panel-body");
			
			//조립하기
			new_div.append(name_span).append(date_span).append(upBtn).append(delBtn);
			wrapper_div.append(new_div).append(content_div);
			$("#cs_replyList").append(wrapper_div);
		}
		
		// 입력 폼 초기화
		function dataReset() {
			$("#cs_r_name").val("");
			$("#cs_r_content").val("");
			/* $("#replyForm").each(function() {
				this.reset();
			}); */
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
					cs_r_content = cs_r_content.replace(/(\r\n|\r|\n)/g,"<br/>");
					addItem(cs_r_num,cs_r_name,cs_r_content,cs_r_recDate);
				})
			}).fail(function() {
				alert("댓글목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요");
			});
		}	
	</script>
	</head>
	<body>
		<div id="replyContainer">
			<p>
				<button type="button" class="btn btn-primary" id="replyInsertFormBtn">댓글 등록</button>
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
									<label for="recipient-name" class="control-label">작성자: </label>
									<input type="text" class="form-control" id="cs_r_name"	name="cs_r_name" maxlength="5" placeholder=""/>
								</div>
								<div class="form-group">
									<label for="message-text" class="control-label">글내용: </label>
									<textarea class="form-control" id="cs_r_content" name="cs_r_content" rows="5">
										</textarea>
								</div>
							</form>
						</div>	
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary" id="replyInsertBtn">등록</button>
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
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
						</div>
					</div>
				</div>
			</div>
			<%--업데이트용 모달폼  종료--%>
		</div>
	</body>
</html>