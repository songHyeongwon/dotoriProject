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
				fundingListData();
				
			})
			
			// 내가 만든 펀딩 동적 생성을 위한 함수
			function fundingListData(){
				$.getJSON("/member/myFunding", $("#myPageForm").serialize(), function(data){
					console.log("length : "+data.length);
					$(data).each(function(index){
						var project_num = this.prject_num;
						var project_name = this.project_name;
						var project_thumb = this.project_thumb;
						var project_url = this.project_url;
						var project_summary = this.project_summary;
						var member_id = this.member_id;
						var project_content = this.project_content;
						var project_addDate = this.project_addDate;
						
						chooseList = 1;
						console.log("index : "+index);
						thumbnailList(project_num,member_id,project_content,project_addDate,project_name,project_thumb,project_url,project_summary,index);
					});
				}).fail(function(){
					alert("목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
				});
			}
			
			function thumbnailList(project_num,member_id,project_content,project_addDate,project_name,project_thumb,project_url,project_summary,index){
				var column = $("<div>");
				column.attr("data-num",project_num);
				column.addClass("col-sm-6 col-md-4");
				
				var thumbnail = $("<div>");
				thumbnail.addClass("thumbnail");
				
				var img = $("<img>");
				img.attr("src","/uploadStorage/project/thumbnail/"+project_thumb);
				console.log(img.attr("src"));
				
				
				var caption = $("<div>");
				caption.addClass("caption");
				
				var h3 = $("<h3>")
				h3.html(project_name.substring(0,12)+"...");
				
				var pInfo = $("<p>");
				pInfo.html("작성자 : "+member_id+"/ 등록일 : "+project_addDate);
				
				var pContent = $("<p>");
				pContent.html(project_content.substring(0,24)+"...");
				
				var pBtnArea = $("<p>");
				
				var upBtn = $("<a>");
				upBtn.attr({"data-btn" : "delBtn",
							"role" : "button" });
				upBtn.addClass("btn btn-primary gap");
				upBtn.html("삭제");
				
				var delBtn = $("<a>");
				delBtn.attr({"data-btn" : "cancleBtn",
							 "role" : "button" });
				delBtn.addClass("btn btn-default");
				delBtn.html("중지");
				
				caption.append(h3).append(pInfo).append(pContent).append(pBtnArea.append(upBtn).append(delBtn));
				column.append(thumbnail.append(img).append(caption));
				
				$("#myFundingList").append(column);
			}
		</script>
		
	</head>
	<body>
		<div id="myFundingList">
			
		</div>
	</body>
</html>