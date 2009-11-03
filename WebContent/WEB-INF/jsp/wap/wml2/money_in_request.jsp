<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/wml20.dtd">
<html>
    <head>
    <title>?충전신청?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body id ="card1">
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?충전신청?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
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
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
        <div><form name="money_in_request" method="post" action="./earncache.wap">
            <div><input type="hidden" name="mode" value="moneyInRequest" /></div>
            <div><input type="hidden" name="bankBookId" value="<%=bankBook.getId()%>" /></div>
            <div align="center">
            <table width="100%" height="100%" cellspacing="0" cellpadding="0" style="background-color:#FFFFFF;">
                <tr>
                    <td align="left" valign="top" style="background-color:#FFFFFF;padding : 5 0 0 5;">
                        <div>은행명 :&nbsp;<%=bankBook.getBankName()%></div>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>계좌번호 :&nbsp;<%=bankBook.getNumber()%></div>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>예금주 :&nbsp;<%=bankBook.getName()%></div>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>&nbsp;<br/>
                        ■ 입금액과 입금자명을 입력해주세요.<br/>
                        &nbsp;</div>
                        <div><img localsrc="pict:///core/arrow/right_2" alt=""/>입금액</div>
                        <div><input type="text" name="money" value="" format="N*N" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><img localsrc="pict:///core/arrow/right_2" alt=""/>신청자명</div>
                        <div><input type="text" name="name" value="" emptyok="true" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div><input type="hidden" name="auto_login" value="$(auto_login)" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="전송"/></div>
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
        <wml:do type="vnd.up" label="상위"><wml:go href="main.wap?token=<%=token%>"/></wml:do>
    </body>
</html>

