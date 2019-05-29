<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- <link rel="icon" href="../../favicon.ico"> -->

<title><tiles:getAsString name="title" /></title>
<!-- Bootstrap core CSS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/include/dist/js/bootstrap.min.js"></script>
<link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/include/dist/css/bootstrap-theme.min.css" rel="stylesheet">
<link href="/resources/include/css/sticky-footer-navbar.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/include/css/default.css">



<link href="/resources/include/dist/css/theme.css" rel="stylesheet">
<link href="/resources/include/dist/css/justified-nav.css" rel="stylesheet">
<script src="/resources/include/dist/js/docs.min.js"></script>
<script src="/resources/include/dist/js/ie10-viewport-bug-workaround.js"></script>
<script src="/resources/include/dist/js/ie-emulation-modes-warning.js"></script>
</head>

<body>

	<!-- Fixed navbar -->
	<header>
		<tiles:insertAttribute name="header"/>
	</header>

	<div class="container">
		<tiles:insertAttribute name="nav" />
		<section>
			<!-- 호버 이미지 영역 -->
			<div id="carousel-example-generic" class="carousel slide"
				data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
					<li data-target="#carousel-example-generic" data-slide-to="1"></li>
					<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					<li data-target="#carousel-example-generic" data-slide-to="3"></li>
				</ol>

				<div class="carousel-inner" role="listbox">
					<div class="item active">
						<a href="#"> <img
							data-src="holder.js/1140x500/auto/#777:#555/text:First slide"
							alt="First slide">
						</a>
					</div>
					<div class="item">
						<a href="#"> <img
							data-src="holder.js/1140x500/auto/#666:#444/text:Second slide"
							alt="Second slide">
						</a>
					</div>
					<div class="item">
						<a href="#"> <img
							data-src="holder.js/1140x500/auto/#555:#333/text:Third slide"
							alt="Third slide">
						</a>
					</div>
					<div class="item">
						<a href="#"> <img
							data-src="holder.js/1140x500/auto/#555:#333/text:Third slide"
							alt="fors slide">
						</a>
					</div>
				</div>
				<a class="left carousel-control" href="#carousel-example-generic"
					role="button" data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#carousel-example-generic"
					role="button" data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
			<!-- 호버 이미지 영역 끝-->

			<!-- Example row of columns -->

			<div class="row">
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h2>컨텐츠 1</h2>
					<p class="text-danger">As of v8.0, Safari exhibits a bug in
						which resizing your browser horizontally causes rendering errors
						in the justified nav that are cleared upon refreshing.</p>
					<p>Donec id elit non mi porta gravida at eget metus. Fusce
						dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
						ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
						magna mollis euismod. Donec sed odio dui.</p>
					<p>
						<a class="btn btn-primary" href="#" role="button">View details
							&raquo;</a>
					</p>
				</div>
			</div>
		</section>
	</div>
	<footer>
		<tiles:insertAttribute name="footer" />
	</footer>
</body>
</html>