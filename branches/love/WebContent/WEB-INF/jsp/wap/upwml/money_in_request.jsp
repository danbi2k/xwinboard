<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//PHONE.COM//DTD WML 1.1//EN" "http://www.phone.com/dtd/wml11.dtd">
<!--Web Logic ���������� �ѱ��� �����ٸ� DOCTYPE ������ ������ ������.-->
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1">
        <p align="center" mode="wrap">&lt;������û&gt;</p>
<%	
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
	BankBook bankBook = null;
	if (bankBookList != null) {
		int size = bankBookList.size();
		String mobile = member.getMobile();
		String lastDigit = mobile.substring(mobile.length()-1);
		int digit = Integer.parseInt(lastDigit);
		bankBook = bankBookList.get(digit % size);
	}
%>
        <p mode="wrap">�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</p>
        <p>----------------</p>
        <p mode="wrap">����� :&nbsp;<%=bankBook.getBankName()%></p>
        <p mode="wrap">���¹�ȣ :&nbsp;<%=bankBook.getNumber()%></p>
        <p mode="wrap">������ :&nbsp;<%=bankBook.getName()%></p>
        <do type="options" label="����"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>

