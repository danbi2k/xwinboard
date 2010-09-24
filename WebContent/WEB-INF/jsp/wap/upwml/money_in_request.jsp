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
<!--Web Logic 웹서버에서 한글이 깨진다면 DOCTYPE 라인을 삭제해 보세요.-->
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1">
        <p align="center" mode="wrap">&lt;충전신청&gt;</p>
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
        <p mode="wrap">닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</p>
        <p>----------------</p>
        <p mode="wrap">은행명 :&nbsp;<%=bankBook.getBankName()%></p>
        <p mode="wrap">계좌번호 :&nbsp;<%=bankBook.getNumber()%></p>
        <p mode="wrap">예금주 :&nbsp;<%=bankBook.getName()%></p>
        <do type="options" label="상위"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>

