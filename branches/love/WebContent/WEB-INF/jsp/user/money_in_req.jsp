<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>

<%@include file="../header.jsp"%>

<%
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
%>

			<tr><td><img src="img/menu08.jpg" border="0"></td></tr>
			<tr><td align="center"><img src="img/moneynotice.jpg" border="0"></td></tr>

            </table>
            <table align="center" cellpadding="0" cellspacing="0" width="771" height="246">
    <tr>
        <td width="771" height="33" align="left" valign="top">
            <p><img src="img/8-.jpg" border="0">&nbsp;<a href="moneyIn.aspx?mode=viewMoneyInRequestList"><img src="img/10.jpg" border="0"></a></p>
        </td>
    </tr>
    <tr>
        <td width="771" height="37" background="img/minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="497" height="132" background="img/minit_02.jpg" valign="top" style="padding:20">
            <p>내용</p>
        </td>
    </tr>
    <tr>
        <td width="771" height="44" background="img/minit_03.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>

<%@include file="../footer.jsp"%>