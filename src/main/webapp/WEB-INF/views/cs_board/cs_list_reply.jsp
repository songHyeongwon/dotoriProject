<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<script type="text/javascript">
		$(function () {
			var cs_num = ${cs_num};
			var cs_r_num = 0;
			var cs_r_name = "";
			var cs_r_content = "";
			var cs_r_recDate = "";
			var cs_showBtn = 0;
			
		
//----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------댓글 보이기-----------------------------------------------------------------
			$("#cs_reply_show${cs_num}").click(function () {
				if(cs_showBtn==0){
					cs_showBtn=1;
					$(this).attr("src","/resources/image/cs_board/up-arrow_icon-icons.com_65094.ico");
					$("#cs_reply_table${cs_num}").show();				
				} else if(cs_showBtn==1) {
					cs_showBtn=0;
					$(this).attr("src","/resources/image/cs_board/down-arrow_icon-icons.com_64915.ico");
					$("#cs_reply_table${cs_num}").hide();				
				}
			});

//-----------------------------------------------댓글 보이기-----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------댓글 등록-----------------------------------------------------------------
			$("#cs_writeBtn${cs_num}").click(function() {
				if(!checkForm("#cs_writeText${cs_num}","댓글 내용을")) return;
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
								cs_r_content:$("#cs_writeText${cs_num}").val().trim(),
								member_id : $("#member_id").val().trim(),
								cs_r_name : $("#cs_r_name").val().trim()
							}),
							error : function() {
								alert("시스템 오류입니다. 관리자에게 문의 하세요");
							},
							success : function(result) {
								if(result=="SUCCESS"){
									alert("댓글 등록이 완료되었습니다.");
									$("#cs_writeText${cs_num}").val("");
									$("#cs_writeReply${cs_num}").empty();
									$("#cs_writeReply${cs_num}").append(listAll(cs_num));
								}														
							}
						});
					}
				}
			});
//-----------------------------------------------댓글 등록-----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------댓글 수정-----------------------------------------------------------------						
						
						//댓글 수정 텍스트로 변환
			$("#cs_writeReply${cs_num}").on("click","input[data-upbtn]",function(){
				cs_r_content = $(this).prev().html();
				cs_r_content = cs_r_content.replace(/<br>/g,"\n").trim();
				$(this).prev().hide();
				$(this).hide();
				$(this).next().hide();
				$(this).next().next().val(cs_r_content);
				$(this).next().next().show();
				$(this).next().next().next().show();
			});
						
			//댓글 수정버튼
			$("#cs_writeReply${cs_num}").on("click","input[data-aftBtn]",function(){
				cs_r_num = $(this).parent("div").parent("div").attr("data-num");
				cs_r_content = $(this).prev().val();
				if(cs_r_content.length <= 0){
					alert("내용을 작성해주세요.");
					return;
				}
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
							cs_r_content : $(this).prev().val()
						}),
						error : function() {
							alert("시스템 오류입니다. 관리자에게 문의 하세요");
						},
						success : function(result) {
							if(result=="SUCCESS"){
								alert("댓글 수정이 완료되었습니다.");
								$(this).hide();
								$(this).prev().hide();
								$(this).prev().prev().show();
								$(this).prev().prev().prev().show();
								$(this).prev().prev().prev().prev().show();
								$("#cs_writeReply${cs_num}").empty();
								$("#cs_writeReply${cs_num}").append(listAll(cs_num));
							}
						}
					});
				}
			});
						
//-----------------------------------------------댓글 수정-----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------댓글 삭제-----------------------------------------------------------------
			//삭제 클릭시
			$("#cs_writeReply${cs_num}").on("click","input[data-delbtn]",function(){					
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
									$("#cs_writeReply${cs_num}").empty();
									$("#cs_writeReply${cs_num}").append(listAll(cs_num));
								}
							}
					});
				}				
			});	
//-----------------------------------------------댓글 삭제-----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
			//댓글 제한
			$('.cs_writeText').on("keyup", function() {
				if($(this).val().length > 500) {
					alert("글자수는 500자로 이내로 제한됩니다.");
					$(this).val($(this).val().substring(0, 500));
				}
			});
			$('.cs_writeText').on("mouseup", function() {
				if($(this).val().length > 500) {
					alert("글자수는 500자로 이내로 제한됩니다.");
					$(this).val($(this).val().substring(0, 500));
				}
			});
			$('.cs_writeText').on("click","input[ata-aftBtn]", function() {
				if($(this).val().length > 500) {
					alert("글자수는 500자로 이내로 제한됩니다.");
					$(this).val($(this).val().substring(0, 500));
				}
			});

			
			//댓글리스트		
			$("#cs_writeReply${cs_num}").append(listAll(cs_num));			
			$("#cs_reply_table${cs_num}").hide();
			
			//계정 분류
			if($("#member_id").val().trim() == ''){
				$("#cs_writeBtn${cs_num}").hide();
				$("#cs_writeText${cs_num}").hide();
				$("#cs_reply_text${cs_num}").hide();
			}
		});
		
		function addItem(cs_r_num, cs_r_name, cs_r_content, cs_r_recDate,member_id) {//새로운 댓글 객체 추가		
			//새로운 글이 추가될 div 태그 객체
			var wrapper_div = $("<div>");
			wrapper_div.attr("data-num",cs_r_num);
			
			//작성자 정보가 지정될 <div>태그
			var new_div = $("<div>");
			
			//작성자 정보의 이름
			var name_span = $("<span>");
			name_span.html(cs_r_name+"님");
			
			//작성일자
			var date_span = $("<span>");
			date_span.html("/"+cs_r_recDate+" ");
			
			//수정하기 버튼
			var upBtn = $("<input>");
			upBtn.attr({"type" : "image", "src" : "/resources/image/cs_board/inclinedpencil_122017.ico"});
			upBtn.attr("data-upbtn","upBtn");
			
			//삭제하기 버튼
			var delBtn = $("<input>");
			delBtn.attr({"type":"image", "src" : "/resources/image/cs_board/bigcancelsymbol_121964.ico"});
			delBtn.attr("data-delbtn","delBtn");
			
			//내용
			var content_div = $("<div>");
			content_div.html(cs_r_content);
			
			//내용 바꿀 텍스트
			var upInput = $("<input>");
			upInput.attr({"type" : "text","data-upInp":"upInp","maxlength":"500"});
			
			//수정 후 버튼
			var aftBtn = $("<input>");
			aftBtn.attr({"type" : "image", "src" : "/resources/image/cs_board/inclinedpencil_122017.ico"});
			aftBtn.attr("data-aftBtn","aftBtn");
			
			//계정
			var member_input = $("<input>");
			member_input.attr("type" , "hidden");
			member_input.val(member_id);
			
			//조립하기
			new_div.append(content_div).append(upBtn).append(delBtn).append(upInput).append(aftBtn);
			wrapper_div.append(new_div).append(name_span).append(date_span).append(member_input);			

			return wrapper_div;
		}
		
		//리스트출력
		function listAll(cs_num) {
			$("#cs_writeText${cs_num}").val("");
			var url = "/replies/all/"+cs_num+".json";
			var div = $("<div>");
			$.getJSON(url, function(data) {
				$(data).each(function() {
					var cs_r_num = this.cs_r_num;
					var cs_r_name = this.cs_r_name;
					var cs_r_content = this.cs_r_content;
					var cs_r_recDate = this.cs_r_recDate;
					var member_id = this.member_id.trim();
					cs_r_content = cs_r_content.replace(/(\r\n|\r|\n)/g,"<br/>");
					div.append(addItem(cs_r_num,cs_r_name,cs_r_content,cs_r_recDate,member_id));
					if($("#member_id").val().trim() != member_id){						
						$("div[data-num="+cs_r_num+"]").children().children("input").hide();						
					}
					if($("#member_id").val().trim() == 'master'){						
						$("div[data-num="+cs_r_num+"]").children().children("input[data-delbtn]").show();											
					} 
					$("input[data-upInp]").hide();
					$("input[data-aftBtn]").hide();
				})
			}).fail(function() {
				
			});
			return div;
		}
	</script>
	<style type="text/css">
		.cs_reply_table {
			width: 98%;
			margin: 0 auto;
		}
		.cs_reply_table tr td {
			margin: 0 auto;			
		}
		.cs_reply_table tr:first-child td {
			padding-left: 1.5%; 
		}
		.cs_writeText{		
			width: 93%;
			height: 50px;
			margin-left: 2%; 
		}
		
		.cs_writeBtn {
			position : relative;
			width: 30px;
			height: 30px;
			top : -22.5px;
			border: none;
			background: transparent;
		}
		
		.cs_writeBtn:focus,.cs_reply_show:focus,.cs_writeReply div div div input:focus {
			border: none;
			outline:none;
		}
		.cs_writeBtn:hover,.cs_reply_show:hover,.cs_writeReply div div div input:hover {
			transform: scale( 1.1 );
		}
		
		.cs_writeBtn img {
			padding : 0px;
			width: 30px;
			height: 30px;		
		}
		.cs_reply_show {
			width: 20px;
			height: 20px;
		}
		
		.cs_writeReply {
			width: 100%;
		}
		.cs_writeReply div {
			width: 100%;
			margin : 0 auto;
		}
		.cs_writeReply > div > div {
			width : 95%;
			padding: 10px;
		}
		.cs_writeReply > div > div:nth-child(2n) {
			background: #F6F6F6;
		}
		.cs_writeReply > div > div:nth-child(2n+1) {
			background: #FFFFFF;
		}
		.cs_writeReply div div div {
			width:100%;
			margin-left:0px;
		}
		.cs_writeReply > div > div > div > div {
			width: 90%;
			height:20px;
			display: inline-block;
			overflow: hidden;
		}
		.cs_writeReply div div div input {
			width: 20px;
			height:20px;
			margin-left : 15px;
		}
		.cs_writeReply div div div input:nth-child(4) {
			width: 94%;
			height: 30px;
			margin-left: 0px;
			display: inline-block;
			transform: scale( 1.0 );
			border: 1px black solid;					
		}
		.cs_writeReply div div div input:nth-child(4):focus {
			border: 1px black solid;
		}
		.cs_writeReply div div div input:nth-child(5) {
			margin-left : 30px;
		}
		.cs_writeReply div div div input:nth-child(5), .cs_writeReply div div div input:nth-child(2) ,.cs_writeReply div div div input:nth-child(3) {
			position:relative;
			top:5px;
		}
	</style>
	<input type="hidden" name="member_id" id="member_id" value="${sessionScope.data.member_id}"/>						
	<input type="hidden" name="cs_r_name" id="cs_r_name" value="${sessionScope.data.member_name}"/>						
	<input id="cs_reply_show${cs_num}" class="cs_reply_show" type="image" src="/resources/image/cs_board/down-arrow_icon-icons.com_64915.ico"/>
	댓글<div id="cs_reply_cnt${cs_num}"></div>
	<table id="cs_reply_table${cs_num}" class="cs_reply_table">			
		<tr>
			<td id="cs_reply_text${cs_num}"><label>빠른 답변</label></td>
		</tr>
		<tr>
			<td>
				<textarea id="cs_writeText${cs_num}" name="cs_writeText${cs_num}" class="cs_writeText" rows="2"></textarea>
					<button id="cs_writeBtn${cs_num}" class="cs_writeBtn"><img src="/resources/image/cs_board/plus_47697.ico" /></button>
			</td>
		</tr>
		<tr>
			<td id="cs_writeReply${cs_num}" class="cs_writeReply"></td>
		</tr>
	</table>		