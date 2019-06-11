<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css">
		<!--모바일 웹 페이지 설정 끝 -->
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script src="/resources/include/dist/js/bootstrap.min.js"></script>
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
				// -----------------네이버 에디터---------------------------


				
				//수정버튼을 눌렀을시 작업
				$("#cs_boardUpdateBtn").click(function() {
		            obj.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
					var ediVal = $("#editor").val();
					var ediText = ediVal.replace(/[<][^>]*[>]/gi, "").replace(/&nbsp;/gi,"");
					var imgCnt = 0;
					if(ediVal.match(/<img src/g)!=null){
						imgCnt = ediVal.match(/<img src/g).length;						
					}
					if(!chkSubmit($("#cs_title"),"글제목을")) return;
					else if(ediText.trim().length < 10 ){
						alert("내용을 10자 이상 작성해주세요");
						return;
					} else if(ediText.trim().length > 1000) {
						alert("내용을 1000자 이하로 작성해주세요");
						return;
					} else if (imgCnt > 10){
						alert("사진을 10개 이상 등록을 할 수 없습니다");
					} else if( ediVal == ""  || ediVal == null || ediVal == '&nbsp;' || ediVal == '<p>&nbsp;</p>'){
						    alert("내용을 입력하세요.");
						    obj.getById["editor"].exec("FOCUS"); //포커싱				
							return;
					} else {
						if(confirm("업데이트를 하시겠습니까?")){ 							
				            $.ajax({
				            	url : '/cs_board/cs_updateFormAction',
				            	data : {
				            		cs_html : $("#editor").val(),
				            		cs_num : "${cs_updateData.cs_num}"
				            	},
				            	type : "POST",
				            	success : function(result){
	
				            	},
				                error : function(request,status,error){
				                
				            	}
				            });
							
							$("#f_updateForm").attr({
								"method":"post",
								"action":"/cs_board/cs_boardUpdate"
							});
							$("#f_updateForm").submit();
						}
					}
				});
				
				//취소버튼을 눌렀을시 작업
				$("#cs_boardCancelBtn").click(function() {
					$("#cs_title").val("");
					obj.getById["editor"].exec("SET_IR", [""]);
				});
				
				
				//목록버튼 클릭시
				$("#cs_boardListBtn").click(function() {
					if(confirm("작성을 그만하시겠습니까?")){								
					var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href = "/cs_board/cs_boardList"+queryString;
					}				
				})
			})
		</script>
		<!--모바일 웹 페이지 설정 끝 -->
		
		<style type="text/css">
			.cs_updateBtn {
				border: 1px solid #EAEAEA;
				border-radius : 5px;
				width: 60px;
				height: 35px;
			}
			.cs_updateBtn:hover {
				color: rgba(30, 22, 54, 0.6);
				box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px ;			
			}
			.cs_updateBtn:focus {
				outline: none;
			}			
		</style>
	</head>
	<body>
		<div class="contentContainer container-fiuid">
			<div class="contentTit page-header"><h3 class="text-center">게시판 글수정</h3></div>
			
			<div class="contentTB text-center">
				<textarea name="prevEditor" id="prevEditor" hidden="hidden">${cs_updateData.editor}</textarea>
				<form id="f_updateForm" name="f_updateForm">
					<input type="hidden" name="cs_num" value="${cs_updateData.cs_num}"/>
					<input type="hidden" name="pageNum" id="pageNum" value="${data.pageNum}"/>
					<input type="hidden" name="amount" id="amount" value="${data.amount}"/>
					
					<table class="table table-bordered">
						<colgroup>
							<col width="17%"/>
							<col width="33%"/>
							<col width="17%"/>
							<col width="33%"/>
						</colgroup>
						<tbody>
							<tr>
								<td>작성일</td>
								<td class="text-left">${cs_updateData.cs_regDate}</td>
								<td>작성자</td>
								<td colspan="3" class="text-left">${cs_updateData.cs_name}</td>
							</tr>
							<tr>
								<td>글제목</td>
								<td colspan="3" class="text-left">
									<input type="text" value="${cs_updateData.cs_title}" id="cs_title" name="cs_title" class="form-control">
								</td>
							</tr>
							<tr class="table-height">
								<td>내 용</td>
								<td colspan="3" class="text-left">
									<textarea name="editor" id="editor" style="width: 100%; height: 400px;">${cs_updateData.editor}</textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="contentBtn text-right">
				<input type="button" value="수정" id="cs_boardUpdateBtn" class="cs_updateBtn"/>
				<input type="button" value="초기화" id="cs_boardCancelBtn" class="cs_updateBtn"/>
				<input type="button" value="목록" id="cs_boardListBtn" class="cs_updateBtn"/>
			</div>
		</div>
	</body>
</html>