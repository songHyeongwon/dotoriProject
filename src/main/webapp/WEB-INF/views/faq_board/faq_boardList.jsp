<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
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
		<style type="text/css">
			.required{
				color: red;}
		</style>
		<script src="/resources/include/dist/js/bootstrap.min.js"></script>

		<script type="text/javascript">
			$(function() {
				var word= "<c:out value='${data.keyword}'/>";
				var value = "";
				if(word!=""){
					$("#keyword").val("<c:out value='${data.keyword}'/>");
					$("#search").val("<c:out value='${data.search}'/>");
					
						//contains()는 특정 텍스트를 포함한 요소 반환
					if($("#search").val()!='all'){
						if($("#search").val()=='faq_title') value = "#list div div.goDetail a";
						else if($("#search").val()=='faq_name') value = "#list div div.name";
						else if($("#search").val()=='editor') value = "#list div div.t_editor"
						
						$(value+":contains('"+word+"')").each(function() {
							//정규표현식
						var regex = new RegExp(word,'gi');
							$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"))
						});
					} else {
						value = new Array("#list div div.goDetail a","#list div div.name","#list div div.t_editor");
						
						for(var i = 0;i < 3;i++){
							value[i];
							$(value[i]+":contains('"+word+"')").each(function() {
								//정규표현식
							var regex = new RegExp(word,'gi');
								$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"))
							});
						}
					}						
				}
				
				$("#faq_insertFormBtn").click(function() {
					var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href = "/faq_board/faq_writeForm"+queryString;
				});
		
				$(".goDetail").click(function() {
					var faq_num = $(this).parents("div").attr("data-num");
					$("#faq_num").val(faq_num);
		
					$("#faq_boardList").attr({
						"method" : "get",
						"action" : "/faq_board/faq_boardDetail"
					});
					$("#faq_boardList").submit();
				});
				
				$("#searchData").click(function() {
					if($("#search").val()!="all"){
						if(!chkData("#keyword","검색어를")) return
					}
					//검색시 페이지를 1번으로 되돌립니다.
					$("#f_search").find("input[name='pageNum']").val("1");
					goPage();
				});
				//원하는 페이지로 이동
				$(".paginate_button a").click(function(e) {
					//event.preventDefault() 이벤트를 보내지 않고 취소합니다.
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
				
				$("#faq_masterBoardListBtn").click(function(e) {
					location.href = "/faq_board/faq_masterBoardList";
				});
				$("#faq_masterBoardListNewBtn").click(function(e) {
					window.open("/faq_board/faq_masterBoardList", "_blank")
				});

				
				
				//--------회원 분류--------------			
				if ($("#member_id").val().trim()!="master"){					
					$("#faq_insertFormBtn").hide();
					$("#faq_masterBoardListBtn").hide();
				}
				
				

				//----------게시판 리스트 효과---------
				$("#list").stop().animate({ "opacity": "1", "margin-top" : "-20px" }, 'slow');
				
			});
			function goPage() {
				$("#search").attr({
					"method" : "get",
					"action" : "/faq_board/faq_boardList"
				});
				$("#f_search").submit();
			}
		</script>
		<style type="text/css">
			#faq_boardList {
				width: 100%;
				margin-top: 30px;
			}
			#list {
				opacity : 0;
				margin-top: 20px;
			}
			
			#list_title > div {
				display: inline-block;
				margin: 0 65px;				
			}
			#list_title > div:nth-child(1) {
				margin-left: 20px;	
			}
			#list_title > div:nth-child(2) {
				margin-left: 675px;	
			}
			
			#list > div {
				border : 1px solid #EAEAEA;
				box-shadow : 0px 0px 10px 3px #EAEAEA;
				margin: 30px 0;
				padding: 20px;
				padding-bottom: 0;
			}
			#list > div > div {
				display: inline-block;
				vertical-align: text-top;
				margin-left: 80px;					
			}
			#list > div > div:nth-child(1) {
				margin-left: 0px;
				width: 500px;
				margin-right: 200px;				
			}
			#list > div > div:nth-child(2) {
				margin-right: 100px;				
				width: 100px;
			}
			#list > div > div:nth-child(3) {
				width: 100px;
				height: 100px;
				background-color: #EAEAEA;
				margin: 0 auto;
			}
			#list > div > div:nth-child(4) {
				display: block;
				position:relative;
				top:-30px;
				height: 30px;
				margin-left: 0px;
				overflow: hidden;
			}
			#defaultTr {
				width: 100%;
				height: 60px;
			}
			.writebtn {
				border: 1px solid #EAEAEA;
				border-radius : 5px;
				width: 60px;
				height: 35px;
			}
			.writebtn:nth-child(3) {
				width: 80px;
				height: 35px;
			}
			.writebtn:hover {
				color: rgba(30, 22, 54, 0.6);
				box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px ;			
			}
			.writebtn:focus {
				outline: none;
			}
			.searchbtn:focus {
				outline: none;
			}
			.searchbtn:hover {
				transform:scale(1.1);          /*  default */
				-webkit-transform:scale(1.1);  /*  크롬 */
				-moz-transform:scale(1.1);     /* FireFox */
				-o-transform:scale(1.1);  
			}
			.searchbtn {
				vertical-align: middle;
			}
			.paginate_button{
				color: red;
				background: red;
			}
		</style>
	</head>
	<body>
		<input type="hidden" name="member_id" id="member_id" value="master"/>
		<div class="contentContainer">
			<div class="contentTit text-center">
				<h1>자주 묻는 게시판</h1>
			</div>
			<form id="faq_boardList">
				<input type="hidden" id="faq_num" name="faq_num" />
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}">
			</form>
			<%--검색 div 시작 --%>
			<div id="boardSearch" class="text-right">
				<form id="f_search" name="f_search" class="form-inline">
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<label>검색조건 : </label>
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="faq_title">제목</option>
							<option value="editor">내용</option>
							<option value="faq_name">작성자</option>
						</select> 
						<input type="text" placeholder="검색어를 입력해주세요" id="keyword" name="keyword" class="form-control"> 
						<input type="image" value="검색" class="searchbtn" src="/resources/image/faq_board/-search_90025.ico" id="searchData">
					</div>
				</form>
			</div>
			<%--============리스트 시작=========== --%>
			<div id="faq_boardList">
				<div>
					<div id="list_title">
						<div>글제목</div>
						<div data-value="faq_regDate" class="order">작성일</div>
					</div>
						<!-- 데이터 출력 -->
					<div id="list">
						<c:choose>
							<c:when test="${not empty faq_boardList}">
								<c:forEach var="faq_board" items="${faq_boardList}" varStatus="status">
									<div class="tac" data-num="${faq_board.faq_num}">
										<div class="goDetail tal"><a href="#">${faq_board.faq_title}</a></div>
										<div>${faq_board.faq_regDate}</div>
										<div>${faq_board.editor}</div>
										<div class="t_editor">${faq_board.t_editor}</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="defaultTr" id="defaultTr">
									<span class="tac">등록된 게시물이 없습니다.</span>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<%--============================리스트 종료========================== --%>
		<div class="text-center">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous">
						<a href="${pageMaker.startPage-1}">Previous</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="paginate_button ${pageMaker.cvo.pageNum==num? 'active': ''}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li class="paginate_button next">
						<a href="${pageMaker.endPage +1}">Next</a>
					</li>
				</c:if>
			</ul>
		</div>

 		<%--=========================글쓰기 버튼 출력 시작========================= --%>
		<div class="contentBtn">
			<input type="button" value="글쓰기" id="faq_insertFormBtn" class="writebtn">
			<input type="button" value="관리" id="faq_masterBoardListBtn" class="writebtn">
			<input type="button" value="관리(새창)" id="faq_masterBoardListNewBtn" class="writebtn">
		</div>
		<%--=========================글쓰기 버튼 출력 종료========================= --%>
	</body>
</html>