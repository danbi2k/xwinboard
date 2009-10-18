<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1" title="알림">
<%
	ResultWap rw = (ResultWap) request.getAttribute("resultWap");
	if (rw == null)
		rw = ResultWap.FAILURE;
%>
        <p mode="wrap"><%=rw.getMessage()%></p>
        <do type="vnd.up" label="상위"><go href="<%=rw.getReturnUrl()%>"/></do>
    </card>
</wml>

