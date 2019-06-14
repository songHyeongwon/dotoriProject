<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		<script type="text/javascript">
			var memberNum = 0;
			
			
			//회원을 클릭하면 회원의 세부내역을 보여줌
			$(function() {
				
				$("#qnaInsertBtn").click(function() {
					if(confirm("정말로 탈퇴시키시겠습니까?")){
						$.ajax({
							url : "/memberManager/del/"+memberNum,
							error : function() {
								alert("시스템 오류입니다. 관리자에게 문의 하세요");
							},
							success : function(result) {
								if(result=="SUCCESS"){
									alert("탈퇴가 완료되었습니다.");
									location.href ="/memberManager/memberManagerForm"
								}
							}
						});
					}
					
				});
				
				
				//검색기능 구현
				$("#searchData").click(function() {
					if($("#search").val()!="all"){
						if(!chkData("#keyword","검색어를")) return
					}
					//검색시 페이지를 1번으로 되돌립니다.
					$("#f_search").find("input[name='pageNum']").val("1");
					goPage();
				});
				
				$(".ids").click(function() {
					console.log(memberNum);
					memberNum = $(this).next().val();
					
					var url = '/memberManager/detail/'+memberNum;
					$.getJSON(url, function(data) {
						replyCnt = data.length;
						$(data).each(function() {
							$("#member_num").val(data.member_num);
							$("#member_id").html(data.member_id);
							$("#member_name").html(data.member_name);
							$("#member_address").html(data.member_address+" "+data.member_detailAddress);
							$("#member_phone").html(data.member_phone);
							$("#member_eMail").html(data.member_eMail);
							if(data.member_kind==0){
								$("#member_kind").html("개인회원");
							}else{
								$("#member_kind").html("법인회원");
							}
							$("#member_point").html(data.member_point);
							$("#member_addDate").html(data.member_addDate);
							$("#member_mPwdDate").html(data.member_mPwdDate);
							$("#member_nickName").html(data.member_nickName);
							$("#member_mPwdDate").html(data.member_mPwdDate);
						});
						$("#memberMadel").modal();
					}).fail(function() {
						alert("댓글목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요");
					});
				});
				
				//페이지 버튼 누르면 처리
				$(".paginate_button a").click(
					function(e) {
						//event.preventDefault() 이벤트를 보내지 않고 취소합니다.
						e.preventDefault();
						$("#f_search").find("input[name='pageNum']").val(
								$(this).attr("href"));
						goPage();
				});
			});
			
			//goPage메서드
			function goPage() {
				if ($("#search").val() == "all") {
					$("#keyword").val("");
				}
				$("#search").attr({
					"method" : "post",
					"action" : "/memberManager/memberManagerForm"
				});
				$("#f_search").submit();
			}
		</script>
	</head>
	<body>
		<h1 class="text-center">회원관리</h1>
		<div id="boardSearch" class="text-right">
			<form id="f_search" name="f_search" class="form-inline">
				<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				<div class="form-group">
					<select id="search" name="search" class="form-control">
						<option value="all">전체</option>
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
					</select>
					<input type="text" placeholder="검색하기" id="keyword"
						name="keyword" class="form-control"> 
					<input type="button" value="검색" class="btn btn-primary" id="searchData">
				</div>
			</form>
		</div>
	<c:choose>
		<c:when test="${not empty list}">
			<table class="table">
				<thead>
					<tr>
						<td>번호</td>
						<td>id</td>
						<td>이름</td>
						<td>법인/개인</td>
						<td>도토리 개수</td>
						<td>가입일</td>
					</tr>
				</thead>
				<c:forEach var="member" items="${list}" varStatus="status">
					<tbody>
						<tr>
							<td>${member.member_num}</td>
							
							<td>
								<a href="#" class="ids">${member.member_id}</a>
								<input type="hidden" name="member_id" value="${member.member_num}">
							</td>
							
							<td>${member.member_name}</td>
							<td>
								<c:choose>
									<c:when test="${member.member_kind==0}">
										개인
									</c:when>
									<c:when test="${member.member_kind==1}">
										법인
									</c:when>
								</c:choose>
							</td>
							<td>${member.member_point}</td>
							<td>${member.member_addDate}</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</c:when>
		<c:otherwise>
			<h1>관련내용을 찾을수 없습니다.</h1>
		</c:otherwise>
	</c:choose>
	<div class="text-center">
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
	
	<%--회원 세부내역 모달 --%>
		<div class="modal fade" id="memberMadel" tabindex="-1" role="dialog"
			aria-labelledby="boardModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="boardModalLabel">회원세부내역</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="member_num">
						<table class="table table-bordered">
							<colgroup>
								<col width="20%" />
								<col width="80%" />
							</colgroup>
							<tr>
								<td>아이디</td>
								<td><label id="member_id"></label></td>
							</tr>
							<tr>
								<td>회원이름</td>
								<td><label id="member_name"></label></td>
							</tr>
							<tr>
								<td>닉네임</td>
								<td><label id="member_nickName"></label></td>
							</tr>
							<tr>
								<td>구분</td>
								<td><label id="member_kind"></label></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><label id="member_eMail"></label></td>
							</tr>
							<tr>
								<td>연락처</td>
								<td><label id="member_phone"></label></td>
							</tr>
							<tr>
								<td>가입일</td>
								<td><label id="member_addDate"></label></td>
							</tr>
							<tr>
								<td>마지막 수정일</td>
								<td><label id="member_mPwdDate"></label></td>
							</tr>
							<tr>
								<td>포인트</td>
								<td><label id="member_point"></label></td>
							</tr>
							<tr>
								<td>주소</td>
								<td><label id="member_address"></label></td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="qnaInsertBtn">탈퇴시키기</button>
					</div>
				</div>
			</div>
		</div>
		<%--회원 세부내역 모달 종료--%>
	</body>
</html>