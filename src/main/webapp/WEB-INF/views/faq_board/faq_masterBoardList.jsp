<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<link rel="shortcut icon" href="/resources/image/icon.png" />
		<link rel="apple-touch-icon" href="/resources/image/icon.png" />
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css">
		<!--모바일 웹 페이지 설정 끝 -->
		<!-- <script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script> -->
		<!-- <script src="/resources/include/dist/js/bootstrap.min.js"></script> -->

		<script type="text/javascript">
			$(function() {
				var word= "<c:out value='${pageScope.data.keyword}'/>";
				var value = "";
				if(word!=""){
					$("#keyword").val("<c:out value='${pageScope.data.keyword}'/>");
					$("#search").val("<c:out value='${pageScope.data.search}'/>");
					
						//contains()는 특정 텍스트를 포함한 요소 반환
					if($("#search").val()!='all'){
						if($("#search").val()=='cs_title') value = "#list div div.goDetail a";
						else if($("#search").val()=='cs_name') value = "#list div div.name";
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
				
				//리스트 제목을 클릭시 그 제목의 목록을 순서대로 볼 수 있음
				$("#list_title").on("click","div[data-value]",function(){					
					var prevPath = $("input[name='path']").val();
					if($(this).attr("data-value")=="cs_num" && prevPath == "cs_numDesc" ){
						path="cs_numAsc";
 					} 
					else if($(this).attr("data-value")=="cs_title" && prevPath == "cs_titleDesc" ){
						path="cs_titleAsc";							
 					}
					else if($(this).attr("data-value")=="cs_regDate" && prevPath == "cs_regDateDesc"){
 						path="cs_regDateAsc";
					}
					else if($(this).attr("data-value")=="cs_name" && prevPath == "cs_nameDesc"){
 						path="cs_nameAsc";
					}
					else if($(this).attr("data-value")=="cs_hits" && prevPath == "cs_hitsDesc"){
 						path="cs_hitsAsc";
					}
					else if($(this).attr("data-value")=="cs_num"){
						path="cs_numDesc";
					} 
					else if($(this).attr("data-value")=="cs_title"){
						path="cs_titleDesc";							
					}
					else if($(this).attr("data-value")=="cs_regDate"){
						path="cs_regDateDesc";
					}
					else if($(this).attr("data-value")=="cs_name"){
						path="cs_nameDesc";
					}
					else if($(this).attr("data-value")=="cs_hits"){
						path="cs_hitsDesc";
					}
					$("input[name='path']").val(path);					
				
					$("#f_search").find("input[name='pageNum']").val("1");
					goPage();					
				});
				clickListTitle();
				
				
				//게시글로 이동
				$(".goDetail").click(function() {
					var cs_num = $(this).parents("div").attr("data-num");
					$("#cs_num").val(cs_num);
		
					$("#cs_boardList").attr({
						"method" : "get",
						"action" : "/cs_board/cs_boardDetailHits"
					});
					$("#cs_boardList").submit();
				});
				
				//검색어를 작성하고 클릭시
				$("#searchData").click(function() {
					if($("#search").val()!="all"){
						if(!chkData("#keyword","검색어를")) return
					}
					//검색시 페이지를 1번으로 되돌립니다.
					$("#f_search").find("input[name='pageNum']").val("1");
					goPage();
				});
				
				$(".paginate_button a").click(function(e) {
					//event.preventDefault() 이벤트를 보내지 않고 취소합니다.
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
				
				//자주 묻는 게시판 이동
				$("#faq_boardListBtn").click(function(e) {
					location.href = "/faq_board/faq_boardList";
				});
				//문의게시판으로 이동
				$("#cs_boardListBtn").click(function(e) {
					location.href = "/cs_board/cs_boardList";
				});

								
				//관리자가 아닐 경우 문의 게시판으로 이동
				if($("#member_id").val()!="master"){
					location.href = "/cs_board/cs_boardList";
				}

				$("#list").stop().animate({ "opacity": "1", "margin-top" : "-20px" }, 'slow');

			
			});
			function clickListTitle() {
				var nowPath = $("input[name='path']").val();
				if(nowPath =="cs_numDesc"){
					$("#list_title > div[data-value='cs_num']").html("글번호 ▼");
				} else if(nowPath =="cs_numAsc") {
					$("#list_title > div[data-value='cs_num']").html("글번호 ▲");					
				} else if(nowPath =="cs_titleDesc"){
					$("#list_title > div[data-value='cs_title']").html("글제목 ▼");
				} else if(nowPath =="cs_titleAsc") {
					$("#list_title > div[data-value='cs_title']").html("글제목 ▲");					
				} else if(nowPath =="cs_regDateDesc"){
					$("#list_title > div[data-value='cs_regDate']").html("작성일 ▼");
				} else if(nowPath =="cs_regDateAsc") {
					$("#list_title > div[data-value='cs_regDate']").html("작성일 ▲");					
				} else if(nowPath =="cs_nameDesc"){
					$("#list_title > div[data-value='cs_name']").html("작성자 ▼");
				} else if(nowPath =="cs_nameAsc") {
					$("#list_title > div[data-value='cs_name']").html("작성자 ▲");					
				} else if(nowPath =="cs_hitsDesc"){
					$("#list_title > div[data-value='cs_hits']").html("조회수 ▼");
				} else if(nowPath =="cs_hitsAsc") {
					$("#list_title > div[data-value='cs_hits']").html("조회수 ▲");					
				}
			}
			function goPage() {
				$("#search").attr({
					"method" : "get",
					"action" : "/cs_board/cs_boardList"
				});
				$("#f_search").submit();
			}
		</script>
		<style type="text/css">
			#cs_boardList {
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
				margin-left: 60px;	
				margin-right: 250px;				 
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
			}
			#list > div > div:nth-child(1),#list > div > div:nth-child(5) {
				width: 70px;
			}
			#list > div > div:nth-child(2) {
				width: 300px;
				height: 20px;
				overflow:hidden;								
			}
			#list > div > div:nth-child(3),#list > div > div:nth-child(4) {
				width: 100px;
			}
			#list > div > div:nth-child(6) {
				width: 100px;
				height: 100px;
				background-color: #EAEAEA;
				margin: 0 auto;
			}
			#list > div > div:nth-child(7) {
				display: block;
				position:relative;
				top:-30px;
				width:900px;
				height: 20px;
				margin-left: 0px;
				overflow:hidden;																
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
			#list_title > div:hover {
				cursor: pointer;
			}
			.required{
				color: red;
			}
		</style>
	</head>
	<body>
		<input type="hidden" name="member_id" id="member_id" value="${sessionScope.data.member_id}"/>
		<div class="contentContainer">
			<div class="contentTit text-center">
				<h1>문의 관리 게시판</h1>
			</div>
			<form id="cs_boardList">
				<input type="hidden" id="cs_num" name="cs_num" />
				<input type="hidden" name="path" id="path" value="${pageMaker.cvo.path}">
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}">
			</form>
			<%--검색 div 시작 --%>
			<div id="boardSearch" class="text-right">
				<form id="f_search" name="f_search" class="form-inline">
					<input type="hidden" name="path" id="path" value="${pageMaker.cvo.path}">
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<label>검색조건 : </label>
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="cs_title">제목</option>
							<option value="editor">내용</option>
							<option value="cs_name">작성자</option>
						</select> 
						<input type="text" placeholder="검색어를 입력해주세요" id="keyword" name="keyword" class="form-control"> 
						<input type="image" value="검색" class="searchbtn" src="/resources/image/cs_board/-search_90025.ico" id="searchData">
					</div>
				</form>
			</div>
			<%--============리스트 시작=========== --%>
			<div id="cs_boardList">
				<div>
					<div id="list_title">
						<div data-value="cs_num">글번호</div>
						<div data-value="cs_title">글제목</div>
						<div data-value="cs_regDate">작성일</div>
						<div data-value="cs_name">작성자</div>
						<div data-value="cs_hits">조회수</div>
					</div>
						<!-- 데이터 출력 -->
					<div id="list">
						<c:choose>
							<c:when test="${not empty cs_boardList}">
								<c:forEach var="cs_board" items="${cs_boardList}" varStatus="status">
									<div class="tac" data-num="${cs_board.cs_num}">
										<div>${cs_board.cs_num}</div>
										<div class="goDetail tal"><a href="#">${cs_board.cs_title}</a></div>
										<div>${cs_board.cs_regDate}</div>
										<div class="name">${cs_board.cs_name}</div>
										<div>${cs_board.cs_hits}</div>
										<div>${cs_board.editor}</div>
										<div class="t_editor">${cs_board.t_editor}</div>
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
						<a href="${pageMaker.endPage + 1}">Next</a>
					</li>
				</c:if>
			</ul>
		</div>
		<%--========================클라이언트 게시판으로 돌아가기========================= --%>
		<div class="contentBtn">
			<input type="button" value="CS" id="cs_boardListBtn" class="writebtn">
			<input type="button" value="FAQ" id="faq_boardListBtn" class="writebtn">
		</div>
		<%--=========================클라이언트 게시판으로 돌아가기========================= --%>
		
	</body>
</html>