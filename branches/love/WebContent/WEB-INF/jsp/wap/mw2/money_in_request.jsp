<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
    <title>&nbsp; </title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=0" />
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
    <div style="width:<%=lcdlx%>px">
        <div><table width="100%" cellspacing="0" cellpadding="0">
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">?충전신청?</td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
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
        <hr style="color:#000000;width:100%;"/>
        <div><form name="money_in_request" method="post" action="./earncache.wap">
            <div><input type="hidden" name="mode" value="moneyInRequest" /></div>
            <div><input type="hidden" name="bankBookId" value="<%=bankBook.getId()%>" /></div>
            <div style="text-align:center;">
            <table width="100%" cellspacing="0" cellpadding="0" style="height:100%;background-color:#FFFFFF;">
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
                        <div><img src="../picto_images/gif/core-arrow-right_2.gif" alt=""/>입금액</div>
                        <div><input type="text" name="money" value="" style="width:98%;text-align:center;" /></div>
                        <div><img src="../picto_images/gif/core-arrow-right_2.gif" alt=""/>신청자명</div>
                        <div><input type="text" name="name" value="" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div><input type="hidden" name="auto_login" value="$(auto_login)" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="전송"/></div>
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
        <div><a title="상위" href="main.wap?token=<%=token%>">상위</a></div>
    </div>
    </body>
</html>
