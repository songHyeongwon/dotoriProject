<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav>
	<div class="masthead">
		<nav>
			<div class="masthead">
				<nav>
					<ul class="nav nav-justified">
						<li class="active"><a href="/">관리자 홈으로</a></li>
						<li class="dropdown"><a href="/projectManager/projectManagerForm">프로젝트 관리</a>
							</li>
						<li class="dropdown"><a href="/memberManager/memberManagerForm">회원관리</a>
							</li>
						<li class="dropdown"><a href="#">게시판 글 관리</a>
							</li>
						<li class="dropdown"><a href="/ordersManager/ordersManagerView">결제내역 관리</a>
							</li>
						<!-- <li class="dropdown"><a href="#">기타 관리</a>
							</li> -->
					</ul>
				</nav>
			</div>
		</nav>
	</div>
</nav>