<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script type="text/javascript">
	$(function() {
		$(".hdpe").click(function() {
			var form = $(this).find("form[name='deteilGo']");
			form.attr({
				"action" : "/project/detail",
				"method" : "post"
			});
			form.submit();
		});
		$(".paginate_button a").click(function(e) {
			//event.preventDefault() 이벤트를 보내지 않고 취소합니다.
			e.preventDefault();
			$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
			goPage();
		});
	})
	function goPage() {
			if($("#search").val()=="all"){
				$("#keyword").val("");
			}
			$("#search").attr({
				"method" : "get",
				"action" : "/board/boardList"
			});
			$("#f_search").submit();
	}
</script>
<style type="text/css">
	.hdpe{height: 400px;
		width: 32%;
		border: black 1px solid;
		margin: 5px;} 	 
	.txt_line {
		width: 80%;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
  	}
</style>
<!--모바일 웹 페이지 설정 끝 -->
</head>
<body>
	<div class="contentContainer">
		<div class="contentTit text-center">
			<h1>프로젝트리스트</h1>
		</div>
		<div id="boardSearch" class="text-right">
			<form id="f_search" name="f_search" class="form-inline">
				<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				<c:choose>
					<c:when test="${not empty listProject}">
						<input type="hidden" name="project_pattern2" value="${listProject[0].project_pattern2}">
					</c:when>
				</c:choose>
				<!-- <div class="form-group">
					<label>검색조건 : </label>
					<select id="search" name="search" class="form-control">
						<option value="all">전체</option>
						<option value="b_title">제목</option>
						<option value="b_content">내용</option>
						<option value="b_name">작성자</option>
					</select> 
					<input type="text" placeholder="검색어를 입력해주세요" id="keyword"
						name="keyword" class="form-control"> 
					<input type="button"
						value="검색" class="btn btn-primary" id="searchData">
				</div> -->
			</form>
		</div>
		<form id="boardList">
			<input type="hidden" id="b_num" name="b_num" /> <input type="hidden"
				name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
			<input type="hidden" name="amount" id="amount"
				value="${pageMaker.cvo.amount }">
		</form>
		<%--============리스트 시작=========== --%>
		<div id="boardList">
			<c:choose>
				<c:when test="${not empty listProject}">
					<c:forEach var="project" items="${listProject}" varStatus="status">
						<div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter hdpe">
							<form name="deteilGo">
								<input type="hidden" name="project_num" value="${project.project_num}">
							</form>
			                <div style="left: 15px; width: 450px; bottom: 200px; font-size: 1.8em; font-weight: bold; position: absolute; color: white;">
								<c:choose>
									<c:when test="${project.project_status==0}">
										관리자검수중
									</c:when>
									<c:when test="${project.project_status==1}">
										진행중
									</c:when>
									<c:when test="${project.project_status==2}">
										관리자거부
									</c:when>
									<c:when test="${project.project_status==3}">
										펀딩 성공
									</c:when>
									<c:when test="${project.project_status==4}">
										펀딩 실패
									</c:when>
								</c:choose>
							</div>
			                <img src="/uploadStorage/gallery/${project.project_thumb}" class="img-responsive" style="height: 200px; width: 600px">
			                <div>
								<div class="txt_line">제목 : ${project.project_name}</div>
								<div class="txt_line">설명 : ${project.project_summary}</div>
								달성률 : ${fn:substring((project.project_sumMoney/project.project_targetMoney)*100,0,5)}%<br>
								종료일 : ${project.project_endDate}<br>
								제작자 : ${project.member_id}<br>
								대분류 : ${project.project_pattern1}<br>
								소분류 : ${project.project_pattern2}<br>
							</div>
			            </div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4" class="tac">등록된 게시물이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<%--============================리스트 종료========================== --%>
	<%--=========================페이징 처리 시작=========================== --%>
	<div class="text-center inpage" id="pagination">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous"><a
					href="${pageMaker.startPage-1}">Previous</a></li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li
					class="paginate_button ${pageMaker.cvo.pageNum==num? 'active': ''}">
					<a href="${num}">${num}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<li class="paginate_button next"><a
					href="${pageMaker.endPage +1}">Next</a></li>
			</c:if>
		</ul>
	</div>
	<%--==========================페이징 처리 종료============================--%>
</body>
</html>