<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>
		
		<style type="text/css">
			.caption{
				border: 1px,bold,black;
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
			var project_num;
			$(function(){
				console.log()
				myFundingListData();
				
				$(document).on("click","a[data-btn='locatBtn']",function(){
					var project_num = $(this).parents("div.col-sm-6").attr("data-num");
					console.log(project_num);
					/* $.ajax({
						url : "/project/detail",
						type : "get",
						data : "project_num="+project_num,
						dataType : "text",
						error : function(){
							alert("페이지 이동 중 시스템 오류 발생. 관리자에게 문의 바랍니다.");
						}
					}) */
					var url = "/project/details/"+project_num;
					location.href=url;
				});
				
				$(".paginate_button a").click(function(e){
					e.preventDefault();
					$("#funding_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
			})
			
			// 내가 만든 펀딩 동적 생성을 위한 함수
			function myFundingListData(){
				console.log("들어가니?");
				$.getJSON("/member/fundingProcess", $("#myPageForm").serialize(), function(data){
					console.log("length : "+data.length);
					$(data).each(function(index){
						project_num = this.project_num;
						var project_name = this.project_name;
						var orders_price = this.orders_price;
						var project_summoney = this.project_sumMoney;
						var project_targetMoney = this.project_targetMoney;
						var member_id = this.member_id;
						var project_endDate = this.project_endDate;
						
						project_targetMoney *=1;
						project_summoney *=1;
						
						console.log("project_targetMoney : "+ project_targetMoney);
						console.log(project_summoney);
						console.log("orders_price : "+orders_price);
						
						var percentage = (project_summoney/project_targetMoney)*100;
						
						percentage = percentage.toFixed(2);
						
						console.log(percentage);
						
						chooseList = 1;
						console.log("index : "+index);
						fundingList(project_num,project_name,orders_price,project_summoney,project_targetMoney,member_id,project_endDate,percentage,index);
					});
				}).fail(function(){
					alert("목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
				});
			}
			
			function fundingList(project_num,project_name,orders_price,project_summoney,project_targetMoney,member_id,project_endDate,percentage,index){
				if(orders_price>0){
					var column = $("<div>");
					column.attr("data-num",project_num);
					column.addClass("col-sm-6 col-md-4");
					
					var thumbnail = $("<div>");
					thumbnail.addClass("thumbnail");
					
					var caption = $("<div>");
					caption.addClass("caption");
					
					var h3 = $("<h3>")
					h3.html(project_name.substring(0,12)+"...");
					
					var pInfo = $("<p>");
					pInfo.html("펀딩 개설자 : "+member_id+"/ 마감일 : "+project_endDate);
					
					var percentage1 = $("<p>");
					percentage1.html("달성률 : " +percentage+"%");
					
					var myMoney = $("<p>");
					myMoney.html("후원한 도토리 개수 : "+orders_price+"개 후원");
					
					var pBtnArea = $("<p>");
					
					var locationBtn = $("<a>");
					locationBtn.attr({"data-btn" : "locatBtn",
								"role" : "button" });
					locationBtn.addClass("btn btn-primary gap");
					locationBtn.html("이동");
					
					caption.append(h3).append(pInfo).append(percentage1).append(myMoney).append(pBtnArea.append(locationBtn));
					column.append(thumbnail.append(caption));
					
					$("#fundingList").append(column);
				}
			}
			
			
		</script>
	</head>
	<body>
	
		<%-- <form id="funding_search" name="funding_search" class="funding_search">
				<input type="hidden" name="pageNum" value="${fundingPageMaker.cvo.pageNum }">
				<input type="hidden" name="amount" value="${fundingPageMaker.cvo.amount }">
		</form> --%>
		<div id="fundingList">
		
		</div>
		
		<%-- <div class="text-center">
			<ul class="pagination">
				<c:if test="${fundingPageMaker.prev }">
					<li class="paginate_button previous">
						<a href="${fundingPageMaker.startPage-1 }">Previous</a>
					</li>
				</c:if>
				
				<c:forEach var="num" begin="${fundingPageMaker.startPage }" end="${fundingPageMaker.endPage }">
					<li class="paginate_button ${fundingPageMaker.cvo.pageNum == num ? 'active' : '' }">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>         
				
				<c:if test="${fundingPageMaker.next }">
					<li class="paginate_button next">
						<a href="${fundingPageMaker.endPage +1 }">Next</a>
					</li>
				</c:if>
			</ul>
		</div> --%>
	</body>
</html>