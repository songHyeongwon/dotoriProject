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
		<link rel="stylesheet"
			href="/resources/include/dist/css/bootstrap-theme.min.css">
		<!--모바일 웹 페이지 설정 끝 -->
		<script type="text/javascript"
			src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script src="https://code.jquery.com/jquery-latest.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script type="text/javascript" src="/resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
			$(function() {						

			// -----------------네이버 에디터---------------------------
 			       //전역변수
			       var obj = [];              
			       //스마트에디터 프레임생성
			       nhn.husky.EZCreator.createInIFrame({
			           oAppRef: obj,
			           elPlaceHolder: "editor",
			           sSkinURI: "../resources/editor/SmartEditor2Skin.html",
			           htParams : {
			               // 툴바 사용 여부
			               bUseToolbar : true,            
			               // 입력창 크기 조절바 사용 여부
			               bUseVerticalResizer : true,    
			               // 모드 탭(Editor | HTML | TEXT) 사용 여부
			               bUseModeChanger : false,
			           }
			       });
 			//-----------------네이버 에디터---------------------------

 				//초기화 버튼 클릭시 처리 이벤트
				$("#faq_writeCancelBtn").click(function() {
					$("#faq_writeFrm").each(function() {
						this.reset();
						obj.getById["editor"].exec("SET_IR", [""]);
					})
				});
						
				//목록버튼 클릭시 처리 이벤트
				$("#faq_boardListBtn").click(function() {
					if(confirm("작성을 그만하시겠습니까?")){								
						var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
						location.href = "/faq_board/faq_boardList"+queryString;
					}
				});
				
				//클릭시 문의 관리 게시판으로 이동
				$("#faq_masterBoardListBtn").click(function() {
					window.open("/faq_board/faq_masterBoardList", "_blank");
				});
									
				//전송버튼
		        $("#faq_writeBtn").click(function(){
		            //id가 smarteditor인 textarea에 에디터에서 대입
		            obj.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
					if ($("#member_Id")=='master'){
						$("#faq_conf").val("O");
					}
		            var ediVal = $("#editor").val();
					var ediText = ediVal.replace(/[<][^>]*[>]/gi, "").replace(/&nbsp;/gi,"");
					var imgCnt = 0;
					if(ediVal.match(/<img src/g)!=null){
						imgCnt = ediVal.match(/<img src/g).length;						
					}
					if(!chkSubmit($("#faq_title"),"글제목을")) return;
					else if(ediText.trim().length < 10 ){
						alert("내용을 10자 이상 작성해주세요");
						return;
					} else if(ediText.trim().length > 1000) {
						alert("내용을 1000자 이하로 작성해주세요")
						return;
					} else if (imgCnt > 10){
						alert("사진을 10개 이상 등록을 할 수 없습니다");
					} else if( ediVal == ""  || ediVal == null || ediVal == '&nbsp;' || ediVal == '<p>&nbsp;</p>'){
						    alert("내용을 입력하세요.");
						    obj.getById["editor"].exec("FOCUS"); //포커싱				
							return;
					} else {
						if(confirm("등록 하시겠습니까?")){									
				            $.ajax({
				            	url : '/faq_board/faq_writeFormAction',
				            	data : "faq_html="+$("#editor").val()+"",
				            	type : "POST",
				            	dataType : "text",
				            	success : function(result){				
				            	},
				                error : function(request,status,error){
				                
				                }
				            });
				            
				            $("#faq_writeFrm").attr({
				            	action : "/faq_board/faq_boardInsert",
				            	method : "post"				            	
				            });
							alert("문의가 등록되었습니다.");				            
				            //폼 submit
				            $("#faq_writeFrm").submit();
						}
					}				            
			       });
						
						//관리자가 아닐 경우 문의 게시판으로 이동						
				if($("#member_id").val()!="master"){
					location.href = "/cs_board/cs_boardList";
				}
			});
		</script>
			<style type="text/css">
				.faq_writeBtn {
					border: 1px solid #EAEAEA;
					border-radius : 5px;
					width: 60px;
					height: 35px;
				}
				.faq_writeBtn:hover {
					color: rgba(30, 22, 54, 0.6);
					box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px ;			
				}
				.faq_writeBtn:focus {
					outline: none;
				}			
				
			</style>
		</head>
		<body>
			<input type="hidden" name="member_id" id="member_id" value="master"/>						
			<div class="contentContainer container-fluid">
				<div class="contentTit page-header">
					<h3 class="text-center">자주 묻는 게시글 작성</h3>
				</div>
				<div class="contentTB text-center">
					<form id="faq_writeFrm" enctype="multipart/form-data">
						<input type="hidden" name="member_id" id="member_id" value="master"/>						
						<input type="hidden" name="pageNum" id="pageNum" value="${data.pageNum}" /> 
						<input type="hidden" name="amount" id="amount" value="${data.amount}" />
		        		<table class="table table-bordered">
							<colgroup>
								<col width="15%" />
								<col width="85%" />
							</colgroup>
							<tbody>
								<tr>
									<td>글제목</td>
									<td class="text-Left">
										<input type="text" id="faq_title" name="faq_title" class="form-control">
									</td>
								</tr>
								<tr>
									<td>내용</td>
									<td class="text-Left">
		        						<textarea name="editor" id="editor" style="width: 100%; height: 400px;"></textarea>
									</td>
								</tr>
							</tbody>
						</table>       		
						<input type="hidden" name="faq_conf" id="faq_conf" value="X">	
		        		<div class="text-right">
			        		<input type="button" id="faq_writeBtn" value="등록" class="faq_writeBtn" />
			        		<input type="button" id="faq_writeCancelBtn" value="초기화" class="faq_writeBtn" />
							<input	type="button" value="목록" id="faq_boardListBtn" class="faq_writeBtn" />
							<input	type="button" value="관리" id="faq_masterBoardListBtn" class="faq_writeBtn" />
		        		</div>        		
		   		 	</form>	
				</div>
			</div>
		</body>
</html>