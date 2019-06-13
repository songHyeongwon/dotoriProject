/**
 * 함수명: chkSubmit(유효성 체크 대상, 메시지 내용)
 * 출력영역: alert으로.
 * 예시: if(!chkSubmit($("#id),"아이디를") return;
 */
function chkSubmit(v_item, v_msg) {
	if(v_item.val().replace(/\s/g,"")==""){
		alert(v_msg+ " 입력해주세요");
		v_item.val("");
		v_item.focus();
		return false;
	} else{
		return true;
	}
}

/**
 * 함수명: chkData (유효성 체크 대상, 메시지 내용)
 * 출력영역: alert으로.
 * 예시: if(!chkData($("#id),"아이디를") return;
 */
function chkData(item, msg) {
	if($(item).val().replace(/\s/g,"")==""){
		alert(msg+" 입력해 주세요.");
		$(item).val();
		$(item).focus();
		return false;
	} else{
		return true;
	}
}
/**
 * 함수명: formCheck (유효성체크대상, 출력영역, 메세지 내용)
 * 출력영역: alert으로.
 * 예시: if(!formCheck($("#id),"아이디를") return;
 */
function formCheck(main, item, msg) {
	if(main.val().replace(/\s/g,"")==""){
		item.html(msg+" 입력해 주세요");
		main.val("");
		return false;
	}else{
		return true;
	}
}

function checkForm(item, msg) {
	var message = "";
	if($(item).val().replace(/\s/g,"")==""){
		message = msg+" 입력해 주세요.";
		$(item).attr("placeholder",message);
		$(item).focus();
		return false;
	}else{
		return true;
	}
}

/*함수명 chkFile(파일명)
 * 설명: 이미지 파일 여부를 확인하기 위해 확장자 확인 함수.
 */
function chkFile(item){
	
	/* 배열내의 값을 찾아서 인덱스를 반환(요소가 없을경우 -1 반환)
	 * jQuery.inArray(찾을값, 검색 대상의 배열)
	 * pop() == 배열의 마지막요소를 반환한다.
	 */
	var ext = item.val().split('.').pop().toLowerCase();
	if(jQuery.inArray(ext,['gif','png','jpg','jpeg'])==-1){
		alert("gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.");
		return false;
	}else{
		return true;
	}
}

function makePaging(area){
	console.log("들어오냐????");
	var column = $("<div>");
	cloumn.addClass("text-center");
	
	var ulist = $("<ul>");
	ulist.addClass("pagination");
	
	var ifc = $("<c:if>");
	ifc.attr("test","${pageMaker.prev}");
	
	var list = $("<li>");
	list.addClass("paginate_button previous");
	
	var a = $("<a>");
	a.attr("href","${pageMaker.startPage-1}");
	a.html("Previous");
	
	var rep = $("<c:forEach>");
	rep.attr({
		"var" : "num",
		"begin" : "${pageMaker.startPage}",
		"end" : "${pageMaker.endPage}"
	});
	
	var list1 = $("<li>");
	list1.addClass("paginate_button ${pageMaker.cvo.pageNum == num ? 'active' : '' }");
	
	var a1 = $("<a>");
	a1.attr("href","${num}");
	a1.html("${num}");
	
	var ifc1 = $("<c:if>");
	ifc1.attr("test","${pageMaker.next}");
	
	var list2 = $("<li>");
	list2.addClass("paginate_button next");
	
	var a2 = $("<a>");
	a2.attr("href","${pageMaker.endPage+1}");
	a2.html("Next");
	
	
	ifc.append(list).append(a);
	rep.append(list1).append(a1);
	ifc1.append(list2).append(a2);
	
	column.append(ul.append(ifc).append(rep).append(ifc2));
	
	$("'#"+area+"'").append(column);
}