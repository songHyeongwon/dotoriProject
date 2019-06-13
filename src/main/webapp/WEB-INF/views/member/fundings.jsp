<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>갤러리 리스트</title>

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
				myFundingListData();
			})
			
			// 내가 만든 펀딩 동적 생성을 위한 함수
			function myFundingListData(){
				$.getJSON("/member/fundingProcess", $("#myPageForm").serialize(), function(data){
					console.log("length : "+data.length);
					$(data).each(function(index){
						var project_num = this.project_num;
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
				var column = $("<div>");
				column.attr("data-num",project_num);
				column.addClass("col-sm-6 col-md-4");				
				
				var caption = $("<div>");
				caption.addClass("caption");
				
				var h3 = $("<h3>")
				h3.html(project_name.substring(0,12)+"...");
				
				var pInfo = $("<p>");
				pInfo.html("작성자 : "+member_id+"/ 마감일 : "+project_endDate);
				
				var percentage1 = $("<p>");
				percentage1.html(percentage+"%");
				
				var myMoney = $("<p>");
				myMoney.html(orders_price+"개 후원");
				
				var pBtnArea = $("<p>");
				
				var upBtn = $("<a>");
				upBtn.attr({"data-btn" : "delBtn",
							"role" : "button" });
				upBtn.addClass("btn btn-primary gap");
				upBtn.html("환불");
				
				caption.append(h3).append(pInfo).append(percentage).append(myMoney).append(pBtnArea.append(upBtn));
				column.append(caption);
				
				$("#fundingList").append(column);
			}
		</script>
	</head>
	<body>
		<div id="fundingList">
		
		</div>
	</body>
</html>