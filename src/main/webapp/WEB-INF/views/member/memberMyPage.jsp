<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	
		<style type="text/css">
		
			
			.li {
				list-style : none;
				font-size: 20px;	
				border : 1;
			}	
			
			.list {
				width: 150px;
				margin-bottom: 50px;
			}
			
			.dotori{
				font-size: 30px;
			}
			
			.btn{
				border: 0;				
				outline : 0;				/* 버튼 테두리 없애는 방법 */
				background-color: rgba( 255, 255, 255, 0.5 );  /* 버튼 배경색 투명하게 하는법 */
				
			}
		</style>
		
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
				$("#modifyPerson").click(function(){
					location.href="/member/confirmPassword"
				})
				
				$("#funding").click(function(){
					$.ajax({
						url : "/member/memberFunding",
						data : "member_id="+$("#member_id").val(),
						type : "post",
						dataType : "text",
						error : function(){
							alert("시스템 오류입니다. 관리자에게 문의 바랍니다.");
						}
					})
				})
				
				$("#usingDotori").click(function(){
					$.ajax({
						url : "/member/usingDotori",
						type : "post",
						data : "member_id="+$("member_id").val(),
						dataType : "text",
						error : function(){
							alert("도토리 사용내역 출력 중 오류 발생. 관리자에게 문의 바랍니다.");
						},success : function(data){
							location.href="/member/memberMyPage";
						}
					})
				})
			})
			
				
		</script>
	</head>
	<body>
		<div>
			<form>
				<input type="hidden" id="member_id" name="member_id" value="${data.member_id }"/>
				<div class="text-center">
					<table class="table table-striped">
						<tr>
							<td></td>
							<td><span class="dotori">도토리</span></td>
						</tr>
						<tr>
							<td><span class="dotori">${data.member_name}</span>님</td>
							<td><span class="dotori">${data.member_point}</span>개</td>
						</tr>
					</table>
				</div>
				
				<div>
					<ul class="li">
						<li class="list"><input type="button" class="btn" id="funding" name="funding" value="펀딩 중 상품"/></li>
						<li class="list"><input type="button" class="btn" id="interested" name="interested" value="관심있는 펀딩"/></li>
						<li class="list"><input type="button" class="btn" id="usingDotori" name="usingDotori" value="사용한 도토리 내역"/></li>
						<li class="list"><input type="button" class="btn" id="makeFund" name="makeFund" value="내가 만든 펀딩"/></li>
						<li class="list"><input type="button" class="btn" id="modifyPerson" name="modifyPerson" value="개인 정보 수정"/></li>
					</ul>
				</div>
				
				<div>
					
				</div>
			</form>
		</div>
	</body>
</html>