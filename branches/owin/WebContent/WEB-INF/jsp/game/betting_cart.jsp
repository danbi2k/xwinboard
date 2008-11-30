<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.web.command.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>

<%@include file="../header.jsp"%>

<%
	String type = request.getParameter("type");
%>
<script>
var gameType = '<%=type%>'
</script>
<%
	List<AllCartItem> allCartList = (List<AllCartItem>) request.getSession().getAttribute("allCartList");
%>

<%
 
%>

<TABLE cellSpacing=2 cellPadding=3 width="960" 
                              border=0>
                                <FORM name=myform method=post>
                                <TBODY>
                                <TR>
                                <TD height=10></TD></TR>
                                <TR>
                                <TD></TD></TR>
                                <TR>
                                <TD>
                                <TABLE cellSpacing=0 cellPadding=0 width="100%" 
                                border=0>
                                <TBODY>
                                <TR>
                                <TD>
                                <TABLE cellSpacing=0 cellPadding=3 width="100%" 
                                border=0>
                                <TBODY>
<%
	if (allCartList != null) {
		for (AllCartItem allCartItem : allCartList) {
			List<GameCartItem> gciList = allCartItem.getCartItemList();
			if (gciList != null) {
				for (GameCartItem gci : gciList) {
%>
                                <TR>
                                <TD>
                                <TABLE cellSpacing=1 cellPadding=0 width="100%" 
                                bgColor=#424142 border=0>
                                <TBODY>
                                <TR bgColor=#212021 height=27>
                                <TD align=middle width=220><FONT 
                                color=#ffffff><B>경기일시</B></FONT></TD>
                                <TD align=middle width=220><FONT 
                                color=#ffffff><B>배팅시간</B></FONT></TD>
                                <TD align=middle width=550><FONT 
                                color=#ffffff><B>(승)홈 팀</B></FONT></TD>
                                <TD align=middle width=150><FONT 
                                color=#ffffff><B>무/핸드캡</B></FONT></TD>
                                <TD align=middle width=550><FONT 
                                color=#ffffff><B>패(원정팀)</B></FONT></TD>
                                <TD align=middle width=100><FONT 
                                color=#ffffff><B>배팅팀</B></FONT></TD>
                                <TD align=middle width=100><FONT 
                                color=#ffffff><B>상태</B></FONT></TD></TR>
                                <TR bgColor=#000000 height=25>
                                <TD align=middle></TD>
                                <TD align=middle><%=XwinUtil.toDateStr(allCartItem.getDate(), 1)%></TD>
                                <TD align=right>
                                <TABLE cellSpacing=1 cellPadding=0 width="100%" 
                                bgColor=#424142 border=0>
                                <TBODY>
                                <TR>
                                <TD align=right 
width="90%"><NOBR>밀워키</NOBR></TD>
                                <TD align=right 
width="90%">&nbsp;2.00&nbsp;</TD>
                                <TD align=right width="90%"><NOBR><IMG height=14 
                                src="Cart.files/06.gif" width=22 
                                align=absMiddle></NOBR></TD></TR></TBODY></TABLE></TD>
                                <TD align=middle>0.00</TD>
                                <TD align=left>
                                <TABLE cellSpacing=1 cellPadding=0 width="100%" 
                                bgColor=#424142 border=0>
                                <TBODY>
                                <TR>
                                <TD><IMG height=14 src="Cart.files/06.gif" 
                                width=22 align=absMiddle> </TD>
                                <TD width="1%">&nbsp;1.50&nbsp;</TD>
                                <TD 
                                width="90%"><NOBR>디트로이트&nbsp;</NOBR></TD></TR></TBODY></TABLE></TD>
                                <TD align=middle>홈팀</TD>
                                <TD align=middle>대기</TD></TR>
                                <TR bgColor=#000000 height=25>
                                <TD align=middle>2008-10-12 10:30</TD>
                                <TD align=middle>2008-10-12 07:05</TD>
                                <TD align=right>
                                <TABLE cellSpacing=1 cellPadding=0 width="100%" 
                                bgColor=#424142 border=0>
                                <TBODY>
                                <TR>
                                <TD align=right 
                                width="90%"><NOBR>Honduras</NOBR></TD>
                                <TD align=right 
width="90%">&nbsp;1.45&nbsp;</TD>
                                <TD align=right width="90%"><NOBR><IMG height=14 
                                src="Cart.files/19.gif" width=22 
                                align=absMiddle></NOBR></TD></TR></TBODY></TABLE></TD>
                                <TD align=middle>3.55</TD>
                                <TD align=left>
                                <TABLE cellSpacing=1 cellPadding=0 width="100%" 
                                bgColor=#424142 border=0>
                                <TBODY>
                                <TR>
                                <TD><IMG height=14 src="Cart.files/19.gif" 
                                width=22 align=absMiddle> </TD>
                                <TD width="1%">&nbsp;5.95&nbsp;</TD>
                                <TD 
                                width="90%"><NOBR>Canada&nbsp;</NOBR></TD></TR></TBODY></TABLE></TD>
                                <TD align=middle>홈팀</TD>
                                <TD 
                                align=middle>대기</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR>
                                <TR>
                                <TD>
                                <TABLE cellSpacing=5 cellPadding=5 width="100%" 
                                bgColor=#212021 border=0>
                                <TBODY>
                                <TR>
                                <TD bgColor=#000000>
                                <TABLE cellSpacing=2 cellPadding=1 align=center 
                                border=0>
                                <TBODY>
                                <TR>
                                <TD>배당율 : 2.90 / 배팅금액 : 5,000 / 최고 예상적중금액 : 
                                14,500 <IMG style="CURSOR: hand" 
                                onclick="del_cart('1641')" 
                                src="images/bet_delete.gif" align=absMiddle 
                                border=0> <INPUT id=cart_num 
                                onclick=check_cart() type=checkbox value=1641 
                                name=cart_num> <INPUT id=betmoney type=hidden 
                                value=5000 name=betmoney>5000 
                                </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR>
<%
				}
			}
		}
	}
%>

                                
                                <TR>
                                <TD>
                                <TABLE cellSpacing=5 cellPadding=5 width="100%" 
                                bgColor=#212021 border=0>
                                <TBODY>
                                <TR>
                                <TD bgColor=#000000>
                                <TABLE cellSpacing=2 cellPadding=6 width="100%" 
                                border=0>
                                <FORM name=frmcs method=post><INPUT type=hidden 
                                value=cart_bet name=mode> <INPUT type=hidden 
                                name=gCnt> 
                                <TBODY>
                                <TR>
                                <TD align=middle><IMG style="CURSOR: pointer" 
                                onclick=delall() src="images/sub03.gif" 
                                align=absMiddle>&nbsp; 선택 한 카트 배팅 금액 : <INPUT 
                                class=input14 id=amount readOnly size=19 
                                name=amount> <IMG style="CURSOR: pointer" 
                                onclick=cart_bet() src="images/btn_bat.gif" 
                                align=absMiddle> 
                                </TD></TR></FORM></TBODY></TABLE>
<%@include file="../footer.jsp"%>