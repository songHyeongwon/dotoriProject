<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="shortcut icon" href="../image/icon.png" />
<link rel="apple-touch-icon" href="../image/icon.png" />
<!--모바일 웹 페이지 설정 끝 -->
<script type="text/javascript">
var reply_table_name = "${project.reply_table_name}";
	$(function() {
		listAll(reply_table_name);
		var cs_r_num = 0;
		var cs_r_content = "";
		var cs_r_name = "";
		
		//업데이트 버튼 클릭시
		$("#updateBtn").click(function() {
			if(!checkForm("#cs_r_content2","댓글 내용을")) return;
			else{
				//var insertUrl = "/replies/replyUpdate";
				if(confirm("댓글 수정하시겠습니까?")){
					$.ajax({
						url : "/projectReply/"+cs_r_num+"/"+reply_table_name,
						type : "put",
						headers : {
							"Content-Type":"application/json",
							"X-HTTP-Method-Override" : "PUT"
						},
						dataType:"text",
						data: JSON.stringify({
							reply_num : cs_r_num,
							reply_content:$("#cs_r_content2").val()
						}),
						error : function() {
							alert("시스템 오류입니다. 관리자에게 문의 하세요");
						},
						success : function(result) {
							if(result=="SUCCESS"){
								alert("댓글 수정이 완료되었습니다.");
								dataReset();
								$("#updateModalForm").modal('hide');
								listAll(reply_table_name);
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
		
		//삭제 클릭시
		$(document).on("click","input[data-delbtn]",function(){
			if(confirm("댓글 삭제하시겠습니까?")){					
				cs_r_num = $(this).parent("div").parent("div").attr("data-num");
				$.ajax({
					url: '/projectReply/'+cs_r_num+"/"+reply_table_name,
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
							listAll(reply_table_name);
						}
					}
				});
				var form = $(".modal-body").children("form");
				form.each(function() {
					this.reset();
				});
			}
		});
		
		//댓글등록 선택시 댓글 값 가져옴
		$("#replyInsertFormBtn").click(function() {
			$("#replyMadel").modal();
		});
		
		//댓글 등록
		$("#replyInsertBtn").click(function() {
			if(!checkForm("#member_id","작성자명을")) return;
			else if(!checkForm("#reply_content","댓글 내용을")) return;
			else{
				if(confirm("댓글 등록하시겠습니까?")){												
					var insertUrl = "/projectReply/replyInsert";	
					$.ajax({
						url : insertUrl,
						type : "post",
						headers : {
							"Content-Type":"application/json",
							"X-HTTP-Method-Override" : "POST"
						},
						dataType:"text",
						data: JSON.stringify({
							project_num : $("#replyProject_num").val(),
							reply_table_name : $("#reply_table_name").val(),
							member_id : $("#member_id").val(),
							reply_content : $("#reply_content").val()
						}),
						error : function() {
							alert("시스템 오류입니다. 관리자에게 문의 하세요");
						},
						success : function(result) {
							if(result=="SUCCESS"){
								alert("댓글 등록이 완료되었습니다.");
								dataReset();
								$("#replyMadel").modal('hide');
								listAll(reply_table_name);
							}							
						}
					});
				}
			}
		});
	});
	
	
	//댓글 폼
	function addItem(reply_num, member_id, reply_content, reply_recdate) {//새로운 댓글 객체 추가		
		//새로운 글이 추가될 div 태그 객체
		var wrapper_div = $("<div>");
		wrapper_div.attr("data-num",reply_num);
		wrapper_div.addClass("panel panel-default");
		
		//작성자 정보가 지정될 <div>태그
		var new_div = $("<div>");
		new_div.addClass("panel-heading");
		
		//작성자 정보의 이름
		var name_span = $("<span>");
		name_span.addClass("name");
		name_span.html(member_id+"님");
		
		//작성일자
		var date_span = $("<span>");
		date_span.html("/"+reply_recdate+" ");
		
		//온 아이디와 멤버 id가 같은 경우에만 수정 삭제를 만든다.
		if(member_id==$("#member_id").val()){
			
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
		}
		
		//내용
		var content_div = $("<div>");
		content_div.html(reply_content);
		content_div.addClass("panel-body");
		
		//조립하기
		new_div.append(name_span).append(date_span).append(upBtn).append(delBtn);
		wrapper_div.append(new_div).append(content_div);
		$("#replyList").append(wrapper_div);
	}
	
	// 입력 폼 초기화
	function dataReset() {
		$("#reply_content").val("");
	}
	
	//댓글 리스트 출력
	function listAll(reply_table_name) {
		$("#replyList").empty();
		var url = "/projectReply/all/"+reply_table_name+".json";
		
		$.getJSON(url, function(data) {
			replyCnt = data.length;
			$(data).each(function() {
				var reply_num = this.reply_num;
				var member_id = this.member_id;
				var reply_content = this.reply_content;
				var reply_recdate = this.reply_recdate;
				reply_content = reply_content.replace(/(\r\n|\r|\n)/g,"<br/>");
				addItem(reply_num,member_id,reply_content,reply_recdate);
			});
		}).fail(function() {
			alert("댓글목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요");
		});
	}	
</script>
</head>
<body>
	<!-- 로그인 하지 않으면 댓글 등록 버튼이 없다. -->
	<c:choose>
		<c:when test="${not empty data}">
			<p>
				<button type="button" class="btn btn-primary" id="replyInsertFormBtn">댓글등록</button>
			</p>
		</c:when>
	</c:choose>
	<%--리스트 영역 --%>
	<div id="replyList"></div>

	
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
							<input type="hidden" name="project_num" value="${project.project_num}" id="replyProject_num"> 
							<input type="hidden" name="reply_table_name" value="${project.reply_table_name}" id="reply_table_name">
							<label for="recipient-name" class="control-label">작성자: </label> 
							<input type="text" class="form-control" id="member_id" name="member_id" value="${data.member_id}" readonly="readonly"/>
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label">글내용: </label>
							<textarea class="form-control" id="reply_content" name="reply_content" rows="5"></textarea>
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
	<div class="modal fade" id="updateModalForm" tabindex="-1"
		role="dialog" aria-labelledby="replyModalLabel" aria-hidden="true">
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
							<label for="recipient-name" class="control-label">작성자: <span
								id="cs_r_name2"></span></label>
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label">글내용: </label>
							<textarea class="form-control" id="cs_r_content2"
								name="cs_r_content2" rows="5"></textarea>
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
</body>
</html>