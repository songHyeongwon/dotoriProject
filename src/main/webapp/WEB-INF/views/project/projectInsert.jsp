<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript" src="/resources/include/js/common.js"></script>

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
			$('.nav-tabs > .active').prev('li').find('a')[0].click();
		});

		$(".Next").click(function() {
			$('.nav-tabs > .active').next('li').find('a')[0].click();
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
			if (ContentCnt != 2) {
				$("#ContentTable").find("tr").last().remove();
				ContentCnt = ContentCnt - 1
			} else {
				alert("더이상 상품을 지울수 없습니다.");
			}
		})

		//옵션 추가하기 버튼을 누를시
		$(document).on("click", "input[name='addOptions']", function() {
			optionPlus($(this));

			$(this).next().val(parseInt($(this).next().val()) + 1);
			console.log($(this).next().val());
		});

		//옵션필요 버튼 누를시
		$(document).on("click", 'input[optionData=""]', function() {
			if ($(this).is(":checked") == true) {
				console.log('체크')
				$(this).next().removeClass()
			} else {
				console.log('아웃')
				$(this).next().addClass("hide")
			}
		});

		//옵션제거 버튼을 누를시<span>제거하기
		$(document).on("click", "input[name='delOptionDiv']", function() {
			var n = $(this).parents("td").children("input[name='optionCnt']");
			n.val(parseInt(n.val()) - 1)
			$(this).parent("span").remove();
			console.log(n.val());

		});

		//옵션넣기버튼 텍스트에리어게 옵션값을 넣는다.
		$(document).on("click", "input[name='addOption']", function() {
			//텍스에리어의 내용찾음
			var text = $(this).prev().prev().val();
			var value = $(this).prev("input").val();
			text = text + "/" + value;
			console.log(text);
			$(this).prev().prev().val(text);
			$(this).prev("input").val("");
		});

		//마지막 옵션 제거하기 버튼 클릭시
		$(document).on("click", "input[name='delOption']", function() {
			var text = $(this).prev().prev().prev().val();
			//전체 문자열 길이
			//마지막 /좌표 찾기
			var last = text.lastIndexOf("/");
			text = text.substring(0, last);
			$(this).prev().prev().prev().val(text);
		});

		//서브밋 버튼
		$("#ProjectSut").click(function() {
			if (!chkData('#Project_name', "프로젝트명을")) return;
			else if (!chkData('#Project_summary', "프로젝트 소개를")) return;
			else if (!chkData('#file', "등록할 이미지를")) return;
			else if (!chkFile($('#file'))) return;
			//else if (!chkData('#Project_pattern1',"대분류를")) return;
			//else if (!chkData('#Project_pattern2',"소분류를")) return;
			else if (!chkData('#Project_targetMoney', "목표금액을")) return;
			else if (!chkData('#Project_endDate', "종료날짜를")) return;
			//else if (!chkData('#editor',"프로젝트 소개를")) return;
			else if (!chkData('#Project_bank', "입금은행명을")) return;
			else if (!chkData('#Project_bankNum', "입금계좌를")) return;
			else {
				//스마트 에디터 내용 삽입
				obj.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
				//url 에 조건으로 https붙이기 
				var url = $("#Project_URL").val();
				if(url.indexOf("http://")==-1){
					if(url.indexOf("https://"==-1)){
						$("#Project_URL").val("http://"+url);
					}
				}

				$("#projectInsertForm").attr({
					"method" : "post",
					"action" : "/project/insertProject",
					"enctype" : "multipart/form-data"
				});
				$("#projectInsertForm").submit();
				
			}
		})

	});
	function ContentPlue() {
		//태그 만들기
		//상품명
		var Content_name = $("<input>");
		Content_name.attr("type", "text");
		Content_name
				.attr("name", "list[" + (ContentCnt - 1) + "].content_name");
		Content_name.addClass("form-control");
		Content_name.attr("maxlength","50");

		//히든 태그 만들기
		var hidden = $("<input>");
		hidden.attr("type", "hidden");
		hidden.attr("name", "contentCnt");
		hidden.attr("value", "" + (ContentCnt - 1));

		//옵션갯수가 몇개인지 알수있는 태그 만들기
		var hidden2 = $("<input>");
		hidden2.attr("type", "hidden");
		hidden2.attr("name", "optionCnt");
		hidden2.attr("value", "0");

		//금액
		var Content_MinPrice = $("<input>");
		Content_MinPrice.attr("type", "text");
		Content_MinPrice.attr("name", "list[" + (ContentCnt - 1)
				+ "].content_MinPrice");
		Content_MinPrice.addClass("form-control");

		//배송필요유무 체크박스
		var Content_Kind = $("<input>");
		Content_Kind.attr("type", "checkbox");
		Content_Kind
				.attr("name", "list[" + (ContentCnt - 1) + "].content_Kind");
		Content_Kind.attr("value", "1");

		//옵션추가하기 버튼
		var addOption = $("<input>");
		addOption.attr("type", "button");
		addOption.attr("name", "addOptions");
		addOption.attr("value", "옵션추가하기");
		addOption.addClass("form-control");

		//tr & td
		var tr = $("<tr>");
		var td1 = $("<td>");
		td1.html("상품 " + ContentCnt);
		var td2 = $("<td>");

		//br
		var br = $("<br>");

		//조립하기
		td2.append("상품명").append(Content_name).append("금액").append(
				Content_MinPrice).append("배송이 필요한 상품인가요?").append(Content_Kind)
				.append(hidden);
		td2.append(br).append(addOption).append(hidden2);
		tr.append(td1).append(td2);
		$("#ContentTable").append(tr);
		ContentCnt = ContentCnt + 1
	}
	//옵션 추가하기 버튼을 누르면 옵션을 입력할수있는 내역이 나온다.
	function optionPlus(button) {
		//히든값 뽑아 만들기
		var cnt = button.prev().prev().val();
		console.log(cnt + "번째 상품의");//몇번째 상품의
		var cntOption = button.next().val();
		console.log(cntOption + "번째 옵션이다.")

		//옵션명
		var optionName = $("<input>");
		optionName.attr("type", "text");
		optionName.attr("name", "list[" + cnt + "].listOption[" + cntOption
				+ "].option_name");
		optionName.addClass("form-control");
		optionName.attr("maxlength","50");
		
		//옵션선택이 필요한가요?
		var optionKind = $("<input>");
		optionKind.attr("type", "checkbox");
		optionKind.attr("name", "list[" + cnt + "].listOption[" + cntOption
				+ "].option_kind");
		optionKind.attr("value", "1");
		optionKind.attr("optionData", "");
		//옵션 리스트 div
		var optionDiv = $("<div>");
		optionDiv.addClass("hide");

		//마지막 옵션을 담는 에리어
		//var lastOption = $("<input>");
		//lastOption.attr("type", "hidden");
		//lastOption.attr("name", "lastOption");

		//옵션담는 텍스트 에리어
		var optionValue = $("<textarea>");
		optionValue.attr("name", "list[" + cnt + "].listOption[" + cntOption
				+ "].option_value_text");
		optionValue.attr("readonly", "readonly");
		optionValue.addClass("form-control");

		//옵션입력을 해주는 텍스트
		var inOption = $("<input>");
		inOption.attr("type", "text");
		inOption.attr("name", "inOption");
		inOption.addClass("form-control");
		inOption.attr("maxlength","50");

		//옵션을 넣는 버튼
		var addOption = $("<input>");
		addOption.attr("type", "button");
		addOption.attr("name", "addOption");
		addOption.attr("value", "옵션넣기");

		//마지막 옵션 제거하기
		var delOption = $("<input>");
		delOption.attr("type", "button");
		delOption.attr("name", "delOption");
		delOption.attr("value", "마지막 옵션 제거하기");

		//옵션틀 전체 제거 버튼
		var delOptionDiv = $("<input>");
		delOptionDiv.attr("type", "button");
		delOptionDiv.attr("name", "delOptionDiv");
		delOptionDiv.attr("value", "옵션제거하기");

		//전체틀 span
		var span = $("<span>");
		//조립하기
		optionDiv.append("옵션을 입력해주세요").append(optionValue).append(inOption)
		optionDiv.append(addOption).append(delOption);

		span.append($("<br>")).append("옵션명").append(optionName).append(
				"옵션선택이 필요한가요? ");
		span.append(optionKind).append(optionDiv).append(delOptionDiv);
		button.parent().append(span);
	}
</script>
</head>
<body>
	<h1>프로젝트의 내용을 입력해주세요</h1>
	<form id="projectInsertForm">
		<c:choose>
			<c:when test="${not empty data}">
				<input type="hidden" value="${data.member_id}" id="member_id" name="member_id">
			</c:when>
		</c:choose>
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
								class="form-control" maxlength="100">
						</tr>
						<tr>
							<td class="text-center">프로젝트 소개</td>
							<td><textarea rows="7" cols="" id="Project_summary"
									name="Project_summary" class="form-control" maxlength="250"></textarea>
						</tr>
						<tr>
							<td class="text-center">프로젝트 썸네일</td>
							<td><input type="file" id="file" name="file"
								class="form-control">
						</tr>
						<tr>
							<td class="text-center">프로젝트 구분</td>
							<td>대분류 <select id="Project_pattern1"
								name="Project_pattern1" class="form-control">
									<option value=" ">선택하세요</option>
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
								placeholder="금액입력" maxlength="15"></td>
						</tr>
						<tr>
							<td class="text-center">프로젝트 종료일</td>
							<td><input type="date" id="Project_endDate"
								name="Project_endDate" class="form-control"></td>
						</tr>
						<tr>
							<td class="text-center">관련 사이트 URL</td>
							<td><input type="text" id="Project_URL" name="Project_URL"
								class="form-control" maxlength="50"></td>
						</tr>
						<tr>
							<td class="text-center">세부내역 입력</td>
							<td><textarea name="Project_content" maxlength="4000"
									id="editor" class="form-control"></textarea></td>
						</tr>
					</table>
					<button type="button" class="Next btn btn-primary"
						style="float: right;">다음</button>
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
							<td>상품 1</td>
							<td>
								상품명 <input type="text" name="list[0].content_name"class="form-control" maxlength="50">
								금액 <input type="text"name="list[0].content_MinPrice" class="form-control" >

								배송이 필요한 상품인가요? <input type="checkbox" name="list[0].content_Kind" value="1"> 
								<input type="hidden" name="contentCnt" value="0"> <br> 
								<input type="button" name="addOptions" value="옵션추가하기" class="form-control"> 
								<input type="hidden" name="optionCnt" value="0">
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
								<button type="button" class="form-control btn btn-primary"
									id="ProjectSut">입력완료</button>
							</td>
						</tr>
					</table>
					<button type="button" class="Prev btn btn-default"
						style="float: left">이전</button>
				</div>
				<%--계좌설정 폼 종료--%>
			</div>
		</div>
	</form>
</body>
</html>