<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>
		
		<style type="text/css">
			.img{
				width: 150px;
				height: 100px;
			}
		</style>

		<link type="text/css" rel="stylesheet" href="/resources/include/css/lightbox.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css"/>
		<link type="text/css" rel="stylesheet" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/lightbox.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery.form.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		
		<script type="text/javascript">
			$(function(){
				fundingListData();
				
				
				$(document).on("click","a[data-btn='stopBtn']",function(){
					var project_num = $(this).parents("div.col-sm-6").attr("data-num");
					console.log(project_num);
					$.ajax({
						url : "/projectManager/del/"+project_num,
						type : "post",
						error : function(){
							alert("삭제 중 시스템 오류 발생. 관리자에게 문의 바랍니다.");
						},
						success : function(data){
							if(data=="SUCCESS"){
								console.log("값이 들어오니?");
								alert("삭제가 완료되었습니다.");
								fundingListData();
							}else{
								alert("삭제 중 오류 발생. 잠시 후 다시 시도해 주새요.");
							}
						}
					})
				})
				
			})
			
			// 내가 만든 펀딩 동적 생성을 위한 함수
			function fundingListData(){
				$("#myFundingList").html("");
				$.getJSON("/member/myFunding", $("#myPageForm").serialize(), function(data){
					console.log("length : "+data.length);
					$(data).each(function(index){
						var project_num = this.project_num;
						var project_name = this.project_name;
						var project_thumb = this.project_thumb;
						var project_url = this.project_url;
						var project_summary = this.project_summary;
						var member_id = this.member_id;
						var project_content = this.project_content;
						var project_addDate = this.project_addDate;
						var project_status = this.project_status;
						
						chooseList = 1;
						console.log("index : "+index);
						thumbnailList(project_num,member_id,project_content,project_addDate,project_name,project_thumb,project_url,project_summary,project_status,index);
					});
				}).fail(function(){
					alert("목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
				});
			}
			
			function thumbnailList(project_num,member_id,project_content,project_addDate,project_name,project_thumb,project_url,project_summary,project_status,index){
				var column = $("<div>");
				column.attr("data-num",project_num);
				column.addClass("col-sm-6 col-md-4");
				
				var thumbnail = $("<div>");
				thumbnail.addClass("thumbnail");
				
				var img = $("<img>");
				img.attr("src","/uploadStorage/gallery/"+project_thumb);
				console.log(img.attr("src"));
				
				
				var caption = $("<div>");
				caption.addClass("caption");
				
				var h3 = $("<h3>")
				h3.html(project_name.substring(0,12)+"...");
				
				var pInfo = $("<p>");
				pInfo.html("작성자 : "+member_id+"/ 등록일 : "+project_addDate);
				
				var pContent = $("<p>");
				pContent.html(project_content.substring(0,24)+"...");
				
				var pjStatus = $("<p>");
				if(project_status==0){
					pjStatus.html("심사 중");
				}else if(project_status==1){
					pjStatus.html("펀딩 진행중");
				}else if(project_status==2){
					pjStatus.html("관리자 거부");
				}else if(project_status==3){
					pjStatus.html("목표 금액 달성");
				}else if(project_status==4){
					pjStatus.html("목표 금액 미달성");
				}
				
				
				var pBtnArea = $("<p>");
				
				if(project_status==0 || project_status==2){
					var stopBtn = $("<a>");
					stopBtn.attr({"data-btn" : "stopBtn",
								"role" : "button" });
					stopBtn.addClass("btn btn-primary gap");
					stopBtn.html("삭제");
				}
				
				caption.append(h3).append(pInfo).append(pContent).append(pjStatus).append(pBtnArea.append(stopBtn));
				column.append(thumbnail.append(img).append(caption));
				
				$("#myFundingList").append(column);
			}
		</script>
		
	</head>
	<body>
		<%-- <form id="f_search" name="f_search" class="form-inline">
				<input type="hidden" name="pageNum" value="${myFundPageMaker.cvo.pageNum }">
				<input type="hidden" name="amount" value="${myFundPageMaker.cvo.amount }">
		</form> --%>
		<div id="myFundingList">
			
		</div>
		
		<%-- ====================페이징 시작============================= --%>
		
		<%-- <div class="text-center">
			<ul class="pagination">
				<c:if test="${myFundPageMaker.prev }">
					<li class="paginate_button previous">
						<a href="${myFundPageMaker.startPage-1 }">Previous</a>
					</li>
				</c:if>
				
				<c:forEach var="num" begin="${myFundPageMaker.startPage }" end="${myFundPageMaker.endPage }">
					<li class="paginate_button ${myFundPageMaker.cvo.pageNum == num ? 'active' : '' }">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>         
				
				<c:if test="${myFundPageMaker.next }">
					<li class="paginate_button next">
						<a href="${myFundPageMaker.endPage +1 }">Next</a>
					</li>
				</c:if>
			</ul>
		</div> --%>
	</body>
</html>