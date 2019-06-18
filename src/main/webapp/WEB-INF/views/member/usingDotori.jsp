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
				
				var orders_num = $(this).parents().parents().children("td:eq(5)").children("input.oN_hidden").attr("value");
				var project_status = $(this).parents().parents().children("td:eq(5)").children("input.ps_hidden").attr("value");
				var orders_price = $(this).parents().parents().children("td:eq(5)").children("input.oP_hidden").attr("value");
				
				$(document).on("click","a[data-btn='refundBtn']",function(){
					$.ajax({
						url : "/member/refund",
						data : "orders_num="+$(this).parents().parents().children("td:eq(5)").children("input.oN_hidden").attr("value")+"&orders_price="+ $(this).parents().parents().children("td:eq(5)").children("input.oP_hidden").attr("value"),
						dataType : "text",
						type : "get",
						error : function(){
							alert("환불 중 시스템 오류 발생. 관리자에게 문의바랍니다.");
						},
						success : function(data){
							if(data.indexOf("성공") >= 0){
								var point = data.split("/");
								
								$("#point").html("");
								$("#point").html(point[1]);
								console.log("value: ");
								usingDotoriListData();
								alert("환불이 완료되었습니다.");
								
								console.log($("#point").html());
							}else{
								alert("환불 중 오류 발생. 잠시후 다시 시도해 주세요.");
							}
							
						}
					})
				});
			})	
			
			function usingDotoriListData(){
				$("#tableBody").html("");
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
						var project_status = this.project_status;
						var refundOk = this.refundOk;
						
						
						console.log("index : "+index);
						DotoriList(order_num,project_num,project_name,member_id,order_content,order_price,order_date,project_status,refundOk,index);
						
					});
				}).fail(function(){
					alert("목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
				});
			}
			
			function DotoriList(order_num,project_num,project_name,member_id,order_content,order_price,order_date,project_status,refundOk,index){
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
				
				var pBtnArea = $("<td>");
				
				if(order_price>0 && project_status==1){
					if(refundOk==0){
						var refundBtn = $("<a>");
						refundBtn.attr({"data-btn" : "refundBtn",
									"role" : "button" });
						refundBtn.addClass("btn btn-primary gap");
						refundBtn.html("환불하기");
						
					}
					
				}
				
				var hiddenTd = $("<td>");
				
				var orderNum = $("<input>");
				orderNum.attr({
					"type" : "hidden",
					"value" : order_num
				});
				orderNum.addClass("oN_hidden");
				
				var projectStatus = $("<input>");
				projectStatus.attr({
					"type" : "hidden",
					"value" : project_status
				});
				projectStatus.addClass("ps_hidden")
				
				var orderPoint = $("<input>");
				orderPoint.attr({
					"type" : "hidden",
					"value" : order_price
				});
				orderPoint.addClass("oP_hidden")
				
				btr.append(td1).append(td2).append(td3).append(td4).append(pBtnArea.append(refundBtn)).append(hiddenTd.append(orderNum).append(projectStatus).append(orderPoint));;
				
				$("#tableBody").append(btr);
			} 
			
			function rebootDotori(){
				$("#point").html("");
				$("#point").html("${data.member_point}");
			}
		</script>
		
	</head>
	<body>
		<div>
			<div>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>프로젝트 명</th>
							<th>프로젝트 내용</th>
							<th>사용한 도토리 개수</th>
							<th>도토리 사용 날짜</th>
							<th>환불하기</th>
						</tr>
					</thead>
					<tbody id="tableBody">
						
					</tbody>
				</table>
			</div>
		</div>
	</body>
</html>