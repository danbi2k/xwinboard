<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.web.command.*" %>
<%
	ResultWap rw = (ResultWap) request.getAttribute("resultWap");
	if (rw == null)
		rw = ResultWap.FAILURE;
%>
<%=rw.getMessage()%>