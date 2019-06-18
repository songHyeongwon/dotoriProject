<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<link rel="shortcut icon" href="/resources/image/icon.png" />
		<link rel="apple-touch-icon" href="/resources/image/icon.png" />

		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css">

		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<!--모바일 웹 페이지 설정 끝 -->

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
				
				//게시글 작성
				$("#cs_insertFormBtn").click(function() {
					var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href = "/cs_board/cs_writeForm"+queryString;
				});
				
				//
				$("#master_cs_boardListBtn").click(function() {
					location.href = "/cs_board/master_cs_boardAllList";
				});
				
				//문의게시글
				$(".goDetail").click(function() {
					var cs_num = $(this).parents("div").attr("data-num");
					$("#cs_num").val(cs_num);
						$("#cs_boardList").attr({
							"method" : "get",
							"action" : "/cs_board/cs_boardDetailHits"
						});
					$("#cs_boardList").submit();
				});
				
				//관리자 공지 게시글
				$(".goMasterDetail").click(function() {
					var cs_num = $(this).parents("div").attr("data-num");
					$("#cs_num").val(cs_num);
						$("#cs_boardList").attr({
							"method" : "get",
							"action" : "/cs_board/master_cs_boardDetailHits"
						});
					$("#cs_boardList").submit();
				});
				
				//게시글 검색
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
				//--------회원 분류--------------			
				if($("#member_id").val().trim()==""){					
					$("#cs_insertFormBtn").hide();
				}
				if($("#member_id").val().trim()!="master") {
					$("#master_cs_boardListBtn").hide();
				}
				
				$("#list").stop().animate({ "opacity": "1", "margin-top" : "-20px" }, 'slow');
				$("#master_list").stop().animate({ "opacity": "1", "margin-top" : "-15px" }, 'slow');
			});
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
				margin-top: 15px;
			}
			#list,#master_list {
				opacity : 0;
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
			
			#list > div , #master_list > div {
				border : 1px solid #EAEAEA;
				box-shadow : 0px 0px 10px 3px #EAEAEA;
				margin: 30px 0;
				padding: 20px;
				padding-bottom: 0;
			}
			#list > div > div , #master_list > div > div {
				display: inline-block;
				vertical-align: text-top;
				margin-left: 80px;					
			}
			#list > div > div:nth-child(1),#master_list > div > div:nth-child(1) {
				margin-left: 0px;
			}
			#list > div > div:nth-child(1),#list > div > div:nth-child(5),#master_list > div > div:nth-child(1),#master_list > div > div:nth-child(5) {
				width: 70px;
			}
			#list > div > div:nth-child(2),#master_list > div > div:nth-child(2) {
				width: 300px;
				height:20px;
				overflow:hidden;				
			}
			#list > div > div:nth-child(3),#list > div > div:nth-child(4),#master_list > div > div:nth-child(3),#master_list > div > div:nth-child(4) {
				width: 100px;
			}
			#list > div > div:nth-child(6),#master_list > div > div:nth-child(6) {
				width: 100px;
				height: 100px;
				background-color: #EAEAEA;
				margin: 0 auto;
			}
			#list > div > div:nth-child(7),#master_list > div > div:nth-child(7) {
				display: block;
				position:relative;
				top:-30px;
				height: 20px;
				margin-left: 0px;
				width:900px;
				overflow:hidden;
			}
			#list > div > div:nth-child(7){
				margin-top: 10px;
			}
			#list > div > div:nth-child(8) {
				border-top:0.5px solid #EAEAEA;
				position:relative;
				top:-20px;
				width: 98%;
				height: auto;
				margin-left: 0px;
				padding-top: 10px;	
			}
			/*관리 공지 게시글*/
			#master_list{
				margin-top: 30px;
				margin-bottom: 50px;
			}
			#master_list > div {
				box-shadow : 0px 0px 10px 3px #FFA7A7;
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
			.writebtn:nth-child(2) {
				width: 85px;
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
			
			.required{
				color: red;
			}
		</style>
	</head>
	<body>
		<input type="hidden" name="member_id" id="member_id" value="${sessionScope.data.member_id}"/>
		<div class="contentContainer">
			<div class="contentTit text-center">
				<h1>문의 게시판</h1>
			</div>
			<form id="cs_boardList">
				<input type="hidden" id="cs_num" name="cs_num" />
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
						<div data-value="cs_num" class="order">글번호</div>
						<div>글제목</div>
						<div data-value="cs_regDate" class="order">작성일</div>
						<div>작성자</div>
						<div>조회수</div>
					</div>
						<!-- 데이터 출력 -->
					<div id="master_list">
						<c:choose>
							<c:when test="${not empty master_cs_boardList}">
								<c:forEach var="master_cs_board" items="${master_cs_boardList}" varStatus="status">
									<div class="tac" data-num="${master_cs_board.cs_num}">
										<div>${master_cs_board.cs_num}</div>
										<div class="goMasterDetail "><a href="#">${master_cs_board.cs_title}</a></div>
										<div>${master_cs_board.cs_regDate}</div>
										<div class="name">${master_cs_board.cs_name}</div>
										<div>${master_cs_board.cs_hits}</div>
										<div>${master_cs_board.editor}</div>
										<div class="t_editor">${master_cs_board.t_editor}</div>
									</div>
									<input type="hidden" id="member_id" value="${master_cs_board.t_editor}">
								</c:forEach>
							</c:when>
						</c:choose>
					</div>
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
										<div>
											<c:set var="member_id" scope="request" value="$('member_id').val()"></c:set>
											<c:set var="cs_num" value="${cs_board.cs_num}" scope="request"></c:set>
											<jsp:include page="cs_list_reply.jsp"></jsp:include>			
										</div>	
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
			<input type="button" value="글쓰기" id="cs_insertFormBtn"	class="writebtn">
			<input type="button" value="공지 목록" id="master_cs_boardListBtn"	class="writebtn">
		</div>
		<%--=========================글쓰기 버튼 출력 종료========================= --%>
	</body>
</html>