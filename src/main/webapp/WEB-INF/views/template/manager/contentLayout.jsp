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

<title>Sticky Footer Navbar Template for Bootstrap</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/include/dist/css/bootstrap-theme.min.css" rel="stylesheet">
<script src="/resources/include/dist/js/bootstrap.min.js"></script>

<link href="/resources/include/css/sticky-footer-navbar.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/include/css/default.css">
<link href="/resources/include/dist/css/theme.css" rel="stylesheet">
<link href="/resources/include/dist/css/justified-nav.css" rel="stylesheet">
<script src="/resources/include/dist/js/ie-emulation-modes-warning.js"></script>
<script src="/resources/include/dist/js/ie10-viewport-bug-workaround.js"></script>
<script src="/resources/include/dist/js/docs.min.js"></script>

</head>

<body>

	<!-- Fixed navbar -->
	<header>
		<tiles:insertAttribute name="header" />
	</header>

	<!-- Begin page content -->
	<div class="container">
		<tiles:insertAttribute name="nav" />
		<tiles:insertAttribute name="bodyManager" />
	</div>
	<footer>
		<tiles:insertAttribute name="footer" />
	</footer>


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<!-- <script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
</body>
</html>