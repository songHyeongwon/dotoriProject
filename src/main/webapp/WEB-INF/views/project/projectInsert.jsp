<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript"
	src="/resources/editor/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>

<!--모바일 웹 페이지 설정 끝 -->
<script type="text/javascript">
	//컨텐츠의 갯수를 받아오는 전역변수
	var ContentCnt = 2;

	$(function() {
		//전역변수
		var obj = [];
		//스마트에디터 프레임생성
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : obj,
			elPlaceHolder : "editor",
			sSkinURI : "/resources/editor/SmartEditor2Skin.html",
			htParams : {
			// 툴바 사용 여부
			//bUseToolbar : true,
			// 입력창 크기 조절바 사용 여부
			//bUseVerticalResizer : true,
			// 모드 탭(Editor | HTML | TEXT) 사용 여부
			//bUseModeChanger : true,
			}
		});

		//버튼 탭 누를시 변경
		$('#myTab a').click(function(e) {
			console.log(this);
			e.preventDefault()
			$(this).tab('show');
		});

		//이전 다음 버튼 누를시 제어
		$(".Prev").click(function() {
			console.log("뒤로");
			//var tabs = $(this).parents(".tab-pane");
			//console.log(tabs.prev().attr("id"))
			$('.nav-tabs > .active').prev('li').find('a').trigger('click');
		});

		$(".Next").click(function() {
			console.log("다음");
			$('.nav-tabs > .active').prev('li').find('a').trigger('click');
		});

		//대분류 선택시 소분류 데이터 가져오기
		$("#Project_pattern1").click(
				function() {
					$("#Project_pattern2").html("");

					var url = "/project/getPatterns/"
							+ $("#Project_pattern1").val() + ".json";

					$.getJSON(url, function(data) {
						$(data).each(function() {
							var project_pattern2 = this.project_pattern2;
							var option = $("<option>");
							option.attr("value", project_pattern2);
							option.text(project_pattern2);
							$("#Project_pattern2").append(option);
						})
					}).fail(function() {
						alert("소분류 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요")
					});
				});
		//상품추가 버튼을 누를시
		$("#ContentAdd").click(function() {
			ContentPlue();
		});
		
		//상품제거 버튼을 누를시
		$("#ContentDel").click(function() {
			$("#ContentTable").find("tr").last().remove();
			ContentCnt = ContentCnt-1
		})
		
	});
	function ContentPlue() {
		//태그 만들기
		//상품명
		var Content_name = $("<input>");
		Content_name.attr("type", "text");
		Content_name.attr("name", "Content_name");
		Content_name.addClass("form-control");

		//금액
		var Content_MinPrice = $("<input>");
		Content_MinPrice.attr("type", "text");
		Content_MinPrice.attr("name", "Content_MinPrice");
		Content_MinPrice.addClass("form-control");
		
		//배송필요유무 체크박스
		var Content_Kind = $("<input>");
		Content_Kind.attr("type","checkbox");
		Content_Kind.attr("name","Content_Kind");
		Content_Kind.attr("value","1");
		
		//옵션추가하기 버튼
		var addOption = $("<input>");
		addOption.attr("type","button");
		addOption.attr("name","addOption");
		addOption.attr("value","옵션추가하기");
		
		//tr & td
		var tr = $("<tr>");
		var td1 = $("<td>");
		td1.html("상품 "+ContentCnt);
		var td2 = $("<td>");
		
		//br
		var br = $("<br>");
		
		//조립하기
		td2.append("상품명").append(Content_name).append("금액").append(Content_MinPrice).append("배송이 필요한 상품인가요?").append(Content_Kind)
		td2.append(br).append(addOption);
		tr.append(td1).append(td2);
		$("#ContentTable").append(tr);
		ContentCnt = ContentCnt+1
	}
	//옵션 라디오체크를 누르면 옵션을 입력할수있는 내역이 나온다.
	function optionPlus() {
		
	}
</script>
</head>
<body>
	<h1>프로젝트의 내용을 입력해주세요</h1>
	<form>
		<div role="tabpanel" id="totalDiv">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#home"
					aria-controls="home" role="tab" data-toggle="tab">프로젝트 내용</a></li>
				<li role="presentation"><a href="#profile"
					aria-controls="profile" role="tab" data-toggle="tab">펀딩 및 후원품
						구성</a></li>
				<li role="presentation"><a href="#settings"
					aria-controls="settings" role="tab" data-toggle="tab">계좌설정</a></li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="home">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tr>
							<td class="text-center">프로젝트 명</td>
							<td><input type="text" id="Project_name" name="Project_name"
								class="form-control">
						</tr>
						<tr>
							<td class="text-center">프로젝트 소개</td>
							<td><textarea rows="7" cols="" id="Project_summary"
									name="Project_summary" class="form-control"></textarea>
						</tr>
						<tr>
							<td class="text-center">프로젝트 썸네일</td>
							<td><input type="file" id="Project_thumb"
								name="Project_thumb" class="form-control">
						</tr>
						<tr>
							<td class="text-center">프로젝트 구분</td>
							<td>대분류 <select id="Project_pattern1"
								name="Project_pattern1" class="form-control">
									<option value="게임">게임</option>
									<option value="공연">공연</option>
									<option value="출판">출판</option>
									<option value="패션">패션</option>
									<option value="캠페인">캠페인</option>
							</select><br>소분류 <select id="Project_pattern2"
								name="Project_pattern2" class="form-control">
							</select>
						</tr>
						<tr>
							<td class="text-center">프로젝트 목표금액</td>
							<td><input type="text" id="Project_targetMoney"
								name="Project_targetMoney" class="form-control"
								placeholder="금액입력"></td>
						</tr>
						<tr>
							<td class="text-center">프로젝트 종료일</td>
							<td><input type="date" id="Project_endDate"
								name="Project_endDate" class="form-control"></td>
						</tr>
						<tr>
							<td class="text-center">관련 사이트 URL</td>
							<td><input type="text" id="Project_URL" name="Project_URL"
								class="form-control"></td>
						</tr>
						<tr>
							<td class="text-center">세부내역 입력</td>
							<td><textarea name="Project_content" maxlength="4000"
									id="editor" class="form-control"></textarea></td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" class="Next btn btn-primary"
									style="float: right;">다음</button>
							</td>
						</tr>
					</table>

				</div>
				<%--펀딩 및 후원품 구성 폼 시작 --%>
				<div role="tabpanel" class="tab-pane" id="profile">
					<table class="table table-bordered" id="ContentTable">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tr>
							<td colspan="2">
								<button type="button" id="ContentAdd">추가</button>
								<button type="button" id="ContentDel">제거</button>
							</td>
						</tr>
						<tr>
							<td>상품1</td>
							<td>
								상품명 
								<input type="text" name="Content_name" class="form-control"> 
								
								금액
								<input type="text" name="Content_MinPrice" class="form-control">
								
								배송이 필요한 상품인가요? 
								<input type="checkbox" name="Content_Kind" value="1">
								
								<br> 
								<input type="button" name="addOption" value="옵션추가하기">
							</td>
						</tr>
					</table>
						<button type="button" class="Prev btn btn-default"
									style="float: left">이전</button>
						<button type="button" class="Next btn btn-primary"
									style="float: right;">다음</button>
				</div>
				<%--펀딩 및 후원품 구성 폼 종료 --%>

				<%--계좌설정 폼 시작--%>
				<div role="tabpanel" class="tab-pane" id="settings">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tr>
							<td class="text-center">은행선택</td>
							<td><select id="Project_bank" name="Project_bank"
								class="form-control">
									<option value="국민">국민</option>
									<option value="신한">신한</option>
									<option value="우리">우리</option>
									<option value="하나">하나</option>
									<option value="조흥">조흥</option>
							</select></td>
						</tr>
						<tr>
							<td class="text-center">계좌번호</td>
							<td><input type="text" id="Project_bankNum"
								name="Project_bankNum" class="form-control"></td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" class="form-control btn btn-primary">입력완료</button>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" class="Prev btn btn-default"
									style="float: left">이전</button>
							</td>
						</tr>
					</table>
				</div>
				<%--계좌설정 폼 종료--%>
			</div>
		</div>
	</form>
</body>
</html>