<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!--최상단 네비게이션 -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/">도토리s펀딩s</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="/projectManager/projectManagerForm">프로젝트 관리하기 <span
							class="sr-only">(current)</span></a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">고객센터
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">자주묻는 게시판</a></li>
							<li><a href="#">문의하기</a></li>
						</ul></li>
				</ul>
				<!-- <form class="navbar-form navbar-left" role="search" id="search" action="/projectM/listForm" method="get">
					<input type="hidden" value="b_title" name="search">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="검색어를 입력하세요" name="keyword">
					</div>
					<button type="submit" class="btn btn-default">검색</button>
				</form> -->
				<ul class="nav navbar-nav navbar-right">
					<c:if test="${data==null}">
					<li><a href="/member/login">로그인</a></li>
					<li><a href="/member/join">회원가입</a></li>
					</c:if>
					<c:if test="${data!=null }">
						<li><jsp:include page="/WEB-INF/views/member/loginSuccess.jsp" /></li>
					</c:if>
					<li><div>&nbsp;&nbsp;</div></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<!--최상단 네비게이션  종료-->
	<div class="jumbotron container theme-showcase">
		<h1>토토리s 펀딩s에 어서오세요</h1>
		<p>현재 마스터 계정으로 로그인 하였습니다.</p>
	</div>