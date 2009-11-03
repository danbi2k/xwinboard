<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>

<%@include file="../header.jsp"%>

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

			<tr><td><img src="img/menu081.jpg" border="0"></td></tr>
			<tr><td align="center"><img src="img/moneynotice.jpg" border="0"></td></tr>

</table>
            <table align="center" cellpadding="0" cellspacing="0" width="771">
    <tr>
        <td width="771" height="37" align="left" valign="top" background="img/bar_bg.gif"><img src="img/8-.jpg" border="0">&nbsp;<a href="earncache.php?mode=viewMoneyInRequestList"><img src="img/10.jpg" border="0" /></a></td>
    </tr>
 
    <tr>
        <td width="771" height="5" background="img/minit_01.jpg">
            <p>&nbsp;</p>        </td>
    </tr>
    <tr>
        <td width="497" height="132" background="img/minit_02.jpg" valign="top" style="padding:20">
<form name="frm" method="post">
<input type='hidden' name='bankBookId' value='<%=bankBook.getId()%>'/>
<table border=0 cellspacing=0 cellpadding=0 width=730 align="center">

<col width=100></col>
<col width=10></col>
<col width=600></col>

<tr>
 <td align=right class=menubar height=40>은행명</td>
 <td></td>
 <td><%=bankBook.getBankName()%></td>
</tr>

<tr>
 <td align=right class=menubar height=40>계좌번호</td>
 <td></td>
 <td> <%=bankBook.getNumber()%></td>
</tr>

<tr>
 <td align=right class=menubar height=40>예금주</td>
 <td></td>
 <td><%=bankBook.getName()%></td>
</tr>

<tr>
 <td align=right class=menubar height=40>입금액</td>
 <td></td>
 <td>
 	<input class="input2" name="money" type="text" value="" maxlength="11" style="IME-MODE: disabled;text-align:right;" onKeyUp="only123(this); comma3Input(this);" onBlur=""> 원
</td>
</tr>
<tr>
 <td align=right class=menubar height=40>입금자명</td>
 <td></td>
 <td><input type=text name=name maxlength=200 class="input2"></td>
</tr>

<tr>
</table>
</form>        </td>
    </tr>
    <tr>
        <td width="771" height="44" background="img/minit_03.jpg">
            <p>&nbsp;</p>        </td>
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771" height="40">
	        <tr>
			    <td width="771" height="40" align="center">
					<img src="img/chong.jpg" border="0" align="absmiddle" onClick="FnInMoney_Submit(frm);">&nbsp;
					<img src="img/back.jpg" border="0" align="absmiddle" onClick="location.reload();">
			    </td>
			  
			</tr>
		    
</table>
