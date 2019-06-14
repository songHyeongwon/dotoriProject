<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<!-- 브라우저의 호환성 보기 모드를 막고, 해당 브라우저에서 지원하는 가장 최신 버전의 방식으로  html을 보여주도록 설정 -->
		<meta name="viewport" content="width=device-width initial-scale=1.0,
		maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
		<!-- viewport : 화면에 보이는 영역을 제어하는 기술.
		width는 device-width로 설정. initial-scale는 초기비율 -->
		<!-- IE8이하 브라우저에서 HTML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다. -->
		<!-- 만약 lt IE 9보다 낮다면 script html5shiv.js를 읽어와 적용하라 -->
		<!-- [if lt IE 9]>
			<script src="../js/html5shiv.js"></script>
		<![endif] -->
		<link rel="shortcut icon" href="../image/icon.png"/>
		<link rel="apple-touch-icon" href="../image/icon.png"/>
		<!--모바일 웹 페이지 설정 끝 -->
		<style type="text/css">
			.reproot{
				margin-left: 60px;}
		</style>
		<script type="text/javascript">
		var qna_board_table_name = "${project.qna_board_table_name}";
		
		$(function() {
			var qna_num = 0;
			var qna_r_title = "";
			var qna_r_content = "";
			var qna_r_hidden = "";
			var member_id_r =""
			var qna_hidden = 0
			listAllboard(qna_board_table_name);
			
			
			//답변하기 클릭시
			$("#qnaInsertBtn").click(function() {
				if(!checkForm("#qna_a_Member_id","작성자명을")) return;
				else if(!checkForm("#qna_a_title","제목을")) return;
				else if(!checkForm("#qna_a_content","내용을")) return;
				else{
					if(confirm("등록하시겠습니까?")){												
						var insertUrl = "/projectBoard/QnaInsert";	
						$.ajax({
							url : insertUrl,
							type : "post",
							headers : {
								"Content-Type":"application/json",
								"X-HTTP-Method-Override" : "POST"
							},
							dataType:"text",
							data: JSON.stringify({
								qna_num : qna_num,
								qna_title : $("#qna_a_title").val(),
								qna_content : $("#qna_a_content").val(),
								member_id : member_id_r,
								qna_board_table_name : $("#qna_board_table_name").val(),
								qna_hidden : qna_hidden,
							}),
							error : function() {
								alert("시스템 오류입니다. 관리자에게 문의 하세요");
							},
							success : function(result) {
								if(result=="SUCCESS"){
									alert("게시글 등록이 완료되었습니다.");
									dataResetBoard();
									$("#QnaboardMadel").modal('hide');
									listAllboard(qna_board_table_name);
								}							
							}
						});
					}
				}
			});
			
			
			
			$(document).on("click","input[data-Qna]",function(){
				qna_num = $(this).parent("div").parent("div").attr("data-num");
				member_id_r = $(this).parent("div").children().eq(1).html();
				qna_r_content = $(this).parent("div").parent("div").children().eq(1).html();
				qna_r_content = qna_r_content.replace(/<br>/g,"\n").trim();
				qna_hidden = $(this).parent("div").parent("div").children().eq(2).val();
				console.log("비밀글인가?" + qna_hidden);
				$("#QnaboardMadel").modal();
			});
			//수정기능
			//업데이트 버튼 클릭시
			$("#updateBoardBtn").click(function() {
				if(!checkForm("#qna_r_content","게시글 내용을")) return;
				else if(!checkForm("#qna_r_title","게시글 제목을")) return;{
					if(confirm("게시글을 수정하시겠습니까?")){
						$.ajax({
							url : "/projectBoard/update/"+qna_num+"/"+qna_board_table_name,
							type : "put",
							headers : {
								"Content-Type":"application/json",
								"X-HTTP-Method-Override" : "put"
							},
							dataType:"text",
							data: JSON.stringify({
								qna_num : qna_num,
								qna_title : $("#qna_r_title").val(),
								qna_content : $("#qna_r_content").val()
							}),
							error : function() {
								alert("시스템 오류입니다. 관리자에게 문의 하세요");
							},
							success : function(result) {
								if(result=="SUCCESS"){
									alert("게시글 수정이 완료되었습니다.");
									dataResetBoard();
									$("#updateBoardForm").modal('hide');
									listAllboard(qna_board_table_name);
								}
							}
						});
					}
				}
			});
			
			
			//수정클릭시 창
			$(document).on("click","input[data-upbtnBoard]",function(){
				qna_num = $(this).parent("div").parent("div").attr("data-num");		
				qna_r_title = $(this).parent("div").children().eq(0).html();
				member_id_r = $(this).parent("div").children().eq(1).html();
				
				qna_r_content = $(this).parent("div").parent("div").children().eq(1).html();
				qna_r_content = qna_r_content.replace(/<br>/g,"\n").trim();
				
				console.log("qna_num = "+qna_num);
				console.log("qna_r_title = "+qna_r_title);
				console.log("member_id_r = "+member_id_r);
				console.log("qna_r_content = "+qna_r_content);
				
				var form = $(".modal-body").children("form");
				form.each(function() {
					this.reset();
				});
				$("#board_r_name").html(member_id_r);
				$("#qna_r_content").html(qna_r_content);
				$("#qna_r_title").val(qna_r_title);
				$("#updateBoardForm").modal();
	
			});
			//삭제기능
			$(document).on("click","input[data-delbtnBoard]",function(){
				console.log($(this).parent("div").parent("div").attr("data-num")+"번 게시글을 삭제합니다.")
				if(confirm("게시글을 삭제하시겠습니까?")){					
					qna_num = $(this).parent("div").parent("div").attr("data-num");
					$.ajax({
						url: '/projectBoard/board/'+qna_num+"/"+qna_board_table_name,
						type: "DELETE",
						headers : {
							"X-HTTP-Method-Override":"DELETE"
						},
						dateType: "text",
						error : function() {
							alert("게시글을 삭제하는중 예기치못한 오류가 발생하였습니다.");
						},
						success : function(result) {
							console.log("result = "+result)
							if(result=="SUCCESS"){
								alert("게시글의 삭제가 완료되었습니다.");
								listAllboard(qna_board_table_name);
							}
						}
					});
					var form = $(".modal-body").children("form");
					form.each(function() {
						this.reset();
					});
				}
			});
			
			//선택값 누르면 값을 바꿈
			$('#qna_hidden').on('change', function(){
				   this.value = this.checked ? 1 : 0;
				   // alert(this.value);
			}).change();
			
			//게시글 등록
			$("#boardInsertBtn").click(function() {
				if(!checkForm("#boardMember_id","작성자명을")) return;
				else if(!checkForm("#qna_title","제목을")) return;
				else if(!checkForm("#qna_content","내용을")) return;
				else{
					if(confirm("등록하시겠습니까?")){												
						var insertUrl = "/projectBoard/boardInsert";	
						$.ajax({
							url : insertUrl,
							type : "post",
							headers : {
								"Content-Type":"application/json",
								"X-HTTP-Method-Override" : "POST"
							},
							dataType:"text",
							data: JSON.stringify({
								qna_title : $("#qna_title").val(),
								qna_content : $("#qna_content").val(),
								member_id : $("#boardMember_id").val(),
								qna_board_table_name : $("#qna_board_table_name").val(),
								qna_hidden : $("#qna_hidden").val()
							}),
							error : function() {
								alert("시스템 오류입니다. 관리자에게 문의 하세요");
							},
							success : function(result) {
								if(result=="SUCCESS"){
									alert("게시글 등록이 완료되었습니다.");
									dataResetBoard();
									$("#boardMadel").modal('hide');
									listAllboard(qna_board_table_name);
								}							
							}
						});
					}
				}
			});
			
			//등록 선택시 게시글  모달 폼 가져옴
			$("#boardInsertFormBtn").click(function() {
				$("#boardMadel").modal();
			});
			
			
		});
		
		//게시글 폼
		function addItemBoard(qna_num,qna_title,qna_content,member_id,qna_regdate,qna_reproot,qna_repindent,qna_hidden) {//새로운 게시글 객체 추가	
			//새로운 글이 추가될 div 태그 객체
			var wrapper_div = $("<div>");
			wrapper_div.attr("data-num",qna_num);
			wrapper_div.addClass("panel panel-default");
			
			
			//작성자 정보가 지정될 <div>태그
			var new_div = $("<div>");
			new_div.addClass("panel-heading");
			
			//작성자 정보의 이름
			var name_span = $("<span>");
			name_span.addClass("name");
			name_span.html(member_id);
			
			//작성일자
			var date_span = $("<span>");
			date_span.html(" / "+qna_regdate+" ");
			
			var qna_hiddenin = $("<input>");
			qna_hiddenin.attr("type","hidden");
			qna_hiddenin.attr("value",qna_hidden);
			//비밀글인가?
			if(qna_reproot!=1&&$("#boardMember_id").val()=="${project.member_id}"){
				//답글이 아니고 로그인 한사람과 제작자가 같으면
				var qnaBtn = $("<input>");
				qnaBtn.attr({"type" : "button", "value" : "답변하기"});
				qnaBtn.attr("data-Qna","qnaBtn");
				qnaBtn.addClass("btn btn-primary gap");
			}
			//온 아이디와 멤버 id가 같은 경우+답변글이 아닌 경우에만 수정 삭제를 만든다. 
			if(member_id==$("#boardMember_id").val()&&qna_reproot!=1){
				//수정하기 버튼
				var upBtn = $("<input>");
				upBtn.attr({"type" : "button", "value" : "수정하기"});
				upBtn.attr("data-upbtnBoard","upBtn");
				upBtn.addClass("btn btn-primary gap");
				
				//삭제하기 버튼
				var delBtn = $("<input>");
				delBtn.attr({"type":"button", "value" : "삭제하기"});
				delBtn.attr("data-delbtnBoard","delBtn");
				delBtn.addClass("btn btn-default gap");
			}
			
			if(qna_hidden==1){
				//비밀글이면
				if(member_id==$("#boardMember_id").val()||$("#boardMember_id").val()=="${project.member_id}"){
					//본인이나 게시물 관리자라면
					//제목
					var titleP = $("<p>");
					titleP.html(qna_title)
					titleP.addClass("panel-body");
					
					//내용
					var content_div = $("<div>");
					content_div.html(qna_content);
					content_div.addClass("panel-body");
				}else{
					//본인이 아니면
					//제목
					var titleP = $("<p>");
					titleP.html("비밀로 작성된 글입니다.")
					titleP.addClass("panel-body");
					
					//내용
					var content_div = $("<div>");
					content_div.html("비밀로 작성된 글입니다.");
					content_div.addClass("panel-body");
				}
			}else{
				//비밀글이 아니면
				//제목
				var titleP = $("<p>");
				titleP.html(qna_title)
				titleP.addClass("panel-body");
				
				//내용
				var content_div = $("<div>");
				content_div.html(qna_content);
				content_div.addClass("panel-body");
			}
			//답글이면 새로운 클래스 입력
			if(qna_reproot==1){
				wrapper_div.addClass("reproot");
				name_span.html(member_id);
				var spenas = $("<span>");
				spenas.html("의 글의 답변입니다.");
				name_span.append(spenas);
				if("${data.member_id}"=="${project.member_id}"){
					
					//수정하기 버튼
					var upBtn = $("<input>");
					upBtn.attr({"type" : "button", "value" : "수정하기"});
					upBtn.attr("data-upbtnBoard","upBtn");
					upBtn.addClass("btn btn-primary gap");
					
					//삭제하기 버튼
					//var delBtn = $("<input>");
					//delBtn.attr({"type":"button", "value" : "삭제하기"});
					//delBtn.attr("data-delbtnBoard","delBtn");
					//delBtn.addClass("btn btn-default gap");
				}
			}
			//조립하기
			new_div.append(titleP).append(name_span).append(date_span).append(upBtn).append(delBtn).append(qnaBtn);
			
			wrapper_div.append(new_div).append(content_div).append(qna_hiddenin);
			$("#boardList").append(wrapper_div);
		}
		
		// 입력 폼 초기화
		function dataResetBoard() {
			$("#qna_title").val("");
			$("#qna_content").val("");
			$("#qna_hidden").prop('checked',false);
		}
		
		//게시글 리스트 출력
		function listAllboard(qna_board_table_name) {
			$("#boardList").empty();
			var url = "/projectBoard/allboard/"+qna_board_table_name+".json";
			
			$.getJSON(url, function(data) {
				$(data).each(function() {
					
					var qna_num = this.qna_num;
					var qna_title = this.qna_title;
					var qna_content = this.qna_content;
					var member_id = this.member_id;
					var qna_regdate = this.qna_regdate;
					var qna_reproot = this.qna_reproot
					var qna_repindent = this.qna_repindent;
					var qna_hidden = this.qna_hidden;
					qna_content = qna_content.replace(/(\r\n|\r|\n)/g,"<br/>");
					
					addItemBoard(qna_num,qna_title,qna_content,member_id,qna_regdate,qna_reproot,qna_repindent,qna_hidden);
				});
			}).fail(function() {
				alert("문의하기 목록을 불러들이는데 오류가 발생하였습니다 잠시후 다시 시도해 주세요");
			});
		}
		</script>
	</head>
	<body>
		<!-- 로그인 하지 않으면 게시글 등록 버튼이 없다. -->
		<c:choose>
			<c:when test="${not empty data}">
				<p>
					<button type="button" class="btn btn-primary" id="boardInsertFormBtn">문의하기</button>
				</p>
			</c:when>
		</c:choose>
		<%--리스트 영역 --%>
		<div id="boardList"></div>
	
		
		<%--등록 화면 영역(modal) --%>
		<div class="modal fade" id="boardMadel" tabindex="-1" role="dialog"
			aria-labelledby="boardModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="boardModalLabel">문의하기 등록</h4>
					</div>
					<div class="modal-body">
						<form id="boardForm" name="boardForm">
							<div class="form-group">
								<input type="hidden" name="qna_board_table_name" value="${project.qna_board_table_name}" id="qna_board_table_name">
								<label for="recipient-name" class="control-label">작성자: </label> 
								<input type="text" class="form-control" id="boardMember_id" name="member_id" value="${data.member_id}" readonly="readonly"/>
								<label for="recipient-name" class="control-label">글제목: </label> 
								<input type="text" class="form-control" id="qna_title" name="qna_title"/>
							</div>
							<div class="form-group">
								<label for="message-text" class="control-label">글내용: </label>
								<textarea class="form-control" id="qna_content" name="qna_content" rows="5"></textarea>
							</div>
							<div>
								<label for="message-text" class="control-label">비밀문의</label>
								<input type="checkbox" class="form-control" name="qna_hidden" id="qna_hidden" value="0">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="boardInsertBtn">등록</button>
					</div>
				</div>
			</div>
		</div>
		<%--등록 화면 영역(modal) 종료--%>
	
		<%--업데이트용 모달폼 --%>
		<div class="modal fade" id="updateBoardForm" tabindex="-1"
			role="dialog" aria-labelledby="boardModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="boardModalLabel">문의글 수정</h4>
					</div>
					<div class="modal-body">
						<form id="updateBoardForm" name="updateBoardForm">
							<div class="form-group">
								<label for="recipient-name" class="control-label">작성자: <span
									id="board_r_name"></span></label>
							</div>
							<div class="form-group">
								<label for="message-text" class="control-label">글제목 : </label>
								<input type="text" class="form-control" id="qna_r_title" name="qna_r_title">
								<label for="message-text" class="control-label">글내용: </label>
								<textarea class="form-control" id="qna_r_content"
									name="qna_r_content" rows="5"></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="updateBoardBtn">수정</button>
					</div>
				</div>
			</div>
		</div>
		<%--업데이트용 모달폼  종료--%>
		
		<%--답글화면 모달 --%>
		<div class="modal fade" id="QnaboardMadel" tabindex="-1" role="dialog"
			aria-labelledby="boardModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="boardModalLabel">제작자의 답변하기</h4>
					</div>
					<div class="modal-body">
						<form id="qnaForm" name="boardForm">
							<div class="form-group">
								<input type="hidden" name="qna_board_table_name" value="${project.qna_board_table_name}" id="qna_board_table_name">
								<label for="recipient-name" class="control-label">작성자: </label> 
								<input type="text" class="form-control" id="qna_a_Member_id" name="member_id" value="${data.member_id}" readonly="readonly"/>
								<label for="recipient-name" class="control-label">글제목: </label> 
								<input type="text" class="form-control" id="qna_a_title" name="qna_title"/>
							</div>
							<div class="form-group">
								<label for="message-text" class="control-label">글내용: </label>
								<textarea class="form-control" id="qna_a_content" name="qna_content" rows="5"></textarea>
							</div>
							<div>
								<!-- <label for="message-text" class="control-label">비밀문의</label> -->
								<input type="hidden" class="form-control" name="qna_hidden" id="qna_a_hidden" value="0">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="qnaInsertBtn">등록</button>
					</div>
				</div>
			</div>
		</div>
		<%--답글화면 모달 종료--%>
	</body>
</html>