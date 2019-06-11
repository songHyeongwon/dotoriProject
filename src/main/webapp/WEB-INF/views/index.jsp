<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:choose>
    <c:when test="${data.member_id=='master'}">
		<tiles:insertDefinition name="manager"/>
    </c:when>
    <c:otherwise>
	<tiles:insertDefinition name="intro"/>
    </c:otherwise>
</c:choose>
