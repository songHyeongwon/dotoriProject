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
						if($("#search").val()=='cs_title') value = "#list tr td.goDetail a";
						else if($("#search").val()=='cs_name') value = "#list tr td.name";
						else if($("#search").val()=='editor') value = "#list tr td.t_editor"
						
						$(value+":contains('"+word+"')").each(function() {
							//정규표현식
						var regex = new RegExp(word,'gi');
							$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"))
						});
					} else {
						value = new Array("#list tr td.goDetail a","#list tr td.name","#list tr td.t_editor");
						
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
				
				$("#cs_insertFormBtn").click(function() {
					var queryString = "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href = "/cs_board/cs_writeForm"+queryString;
				});
		
				$(".goDetail").click(function() {
					var cs_num = $(this).parents("tr").attr("data-num");
					$("#cs_num").val(cs_num);
		
					$("#cs_boardList").attr({
						"method" : "get",
						"action" : "/cs_board/cs_boardDetail"
					});
					$("#cs_boardList").submit();
				});
				
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
			});
			function goPage() {
				$("#search").attr({
					"method" : "get",
					"action" : "/cs_board/cs_boardList"
				});
				$("#f_search").submit();
			}
		</script>
	</head>
	<body>
		<div class="contentContainer">
			<div class="contentTit text-center">
				<h1>게시판 리스트</h1>
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
						<input type="button" value="검색" class="btn btn-primary" id="searchData">
					</div>
				</form>
			</div>
			<%--============리스트 시작=========== --%>
			<div id="cs_boardList">
				<table summary="게시판리스트" class="table table-striped">
					<colgroup>
						<col width="10%" />
						<col width="42%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th data-value="cs_num" class="order">글번호</th>
							<th>글제목</th>
							<th data-value="cs_regDate" class="order">작성일</th>
							<th class="borcle">작성자</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody id="list">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty cs_boardList}">
								<c:forEach var="cs_board" items="${cs_boardList}" varStatus="status">
									<tr class="tac" data-num="${cs_board.cs_num}">
										<td>${cs_board.cs_num}</td>
										<td class="goDetail tal">
											<a href="#">${cs_board.cs_title}</a>
											&nbsp;
											<c:if test="${cs_board.cs_r_cnt > 0}">
												<span>[${cs_board.cs_r_cnt}]</span>
											</c:if>
										</td>
										<td>${cs_board.cs_regDate}</td>
										<td class="name">${cs_board.cs_name}</td>
										<td>${cs_board.cs_hits}</td>
										<td rowspan="2">${cs_board.editor}</td>
									</tr>
									<tr>
										<td class="t_editor" colspan="5">${cs_board.t_editor}</td>
									</tr>
									<tr>
										<td colspan="6">
											<c:set var="cs_num" value="${cs_board.cs_num}" scope="request"></c:set>
 											<jsp:include page="cs_list_reply.jsp"></jsp:include>			
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4" class="tac">등록된 게시물이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
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
			<input type="button" value="글쓰기" id="cs_insertFormBtn"	class="btn btn-primary">
		</div>
		<%--=========================글쓰기 버튼 출력 종료========================= --%>
	</body>
</html>