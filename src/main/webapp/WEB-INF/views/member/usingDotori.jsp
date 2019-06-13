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
				usingDotoriListData();
			})
			
			function usingDotoriListData(){
				$.getJSON("/member/usingDotoriList", $("#myPageForm").serialize(), function(data){
					console.log("length : "+data.length);
					$(data).each(function(index){
						var order_num = this.orders_num;
						var project_num = this.project_num;
						var project_name = this.project_name;
						var member_id = this.member_id;
						var order_content = this.orders_content;
						var order_price = this.orders_price;
						var order_date = this.orders_date;
						
						
						console.log("index : "+index);
						DotoriList(order_num,project_num,project_name,member_id,order_content,order_price,order_date,index);
						//makePaging(listArea);
					});
				}).fail(function(){
					alert("목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
				});
			}
			
			function DotoriList(order_num,project_num,project_name,member_id,order_content,order_price,order_date,index){
				console.log("들어오니?");
				var btr=$("<tr>");
				
				var td1 = $("<td>");
				td1.html(project_name);
				
				
				var td2= $("<td>");
				td2.html(order_content);
				
				var td3=$("<td>");
				td3.html(order_price+"개");
				
				var td4=$("<td>");
				td4.html(order_date);
				
				btr.append(td1).append(td2).append(td3).append(td4);
				
				$("#tableBody").append(btr);
			} 
		</script>
		
	</head>
	<body>
		<div>
			<%-- <form id="usingDotoriForm">
				<input type="hidden" id="usingDotoriId" name="member_id" value="${data.member_id }"/>
			</form> --%>
			<div>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>프로젝트 명</th>
							<th>프로젝트 내용</th>
							<th>사용한 도토리 개수</th>
							<th>도토리 사용 날짜</th>
						</tr>
					</thead>
					<tbody id="tableBody">
						
					</tbody>
				</table>
			</div>
		</div>
	</body>
</html>