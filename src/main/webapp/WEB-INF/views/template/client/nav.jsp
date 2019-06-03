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
						<li class="active"><a href="/project/listForm">전체</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">공연</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="/project/getPatterns2?project_pattern2=뮤지컬">뮤지컬</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=연극">연극</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=패스티벌">패스티벌</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=독립영화">독립영화</a></li>
							</ul></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">출판</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="/project/getPatterns2?project_pattern2=소설">소설</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=아트북">아트북</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=아동출판">아동출판</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=전자출판">전자출판</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=학술지">학술지</a></li>
							</ul></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">패션</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="/project/getPatterns2?project_pattern2=의류">의류</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=액세서리">액세서리</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=뷰티(화장품)">뷰티(화장품)</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=아이템">아이템</a></li>
							</ul></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">게임</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="/project/getPatterns2?project_pattern2=pc게임">pc게임</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=모바일">모바일게임</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=비디오게임">비디오게임</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=보드게임">보드게임</a></li>
							</ul></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">캠페인</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="/project/getPatterns2?project_pattern2=환경">환경</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=인권">인권</a></li>
								<li><a href="/project/getPatterns2?project_pattern2=사회">사회</a></li>
							</ul></li>
					</ul>
				</nav>
			</div>
		</nav>
	</div>
</nav>