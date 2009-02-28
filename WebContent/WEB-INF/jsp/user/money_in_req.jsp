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
<form name="frm" method="post">
<table border=0 cellspacing=0 cellpadding=0 width=730 align="center">

<col width=250></col>
<col width=50></col>
<col width=600></col>



 

<tr>
 <td align=right class=menubar>아이디</td>
 <td></td>
 <td><%=member.getUserId()%></td>
</tr>


<tr>
 <td align=right class=menubar>입금계좌</td>
 <td></td>
 <td> <select name="bankBookId" style="credit">
<%
				if (bankBookList != null) {
					for (BankBook bankBook : bankBookList) {
				%>
				<option value="<%=bankBook.getId()%>">[<%=bankBook.getBankName()%>] <%=bankBook.getNumber()%> (<%=bankBook.getName()%>)　　</option>				<%
					}
				}
				%>								
				</select> <font color="orange">☜ 계좌번호 꼭 확인하세요! </td>
</tr>

<tr>
 <td align=right class=menubar>입금예정액</td>
 <td></td>
 <td><table width="100%" cellpadding="0" cellspacing="0"><tr>
			<td width="200">
				<input class="input2" name="money" type="text" value="" maxlength="11" style="IME-MODE: disabled;text-align:right;" onkeyup="only123(this); comma3Input(this);" onblur="">원<BR>				
				<font color="orange"><b>※ 직접입력가능</b></font>
			<td>
			<td>

				<table>
				<tr>
				<td><span style="width:48;height:16;color:red;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='10,000';frm.name.focus();">1만원</span></td>
				<td><span style="width:48;height:16;color:red;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='20,000';frm.name.focus();">2만원</span></td>

				<td><span style="width:48;height:16;color:red;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='30,000';frm.name.focus();">3만원</span></td>
				<td><span style="width:48;height:16;color:red;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='50,000';frm.name.focus();">5만원</span></td>
				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='100,000';frm.name.focus();">10만원</span></td>
				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='150,000';frm.name.focus();">15만원</span></td>
				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='200,000';frm.name.focus();">20만원</span></td>
				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='250,000';frm.name.focus();">25만원</span></td>

				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='300,000';frm.name.focus();">30만원</span></td>
				</tr>
				<tr>
				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='500,000';frm.name.focus();">50만원</span></td>
				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='600,000';frm.name.focus();">60만원</span></td>
				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='700,000';frm.name.focus();">70만원</span></td>
				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='800,000';frm.name.focus();">80만원</span></td>

				<td><span style="width:48;height:16;color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='900,000';frm.name.focus();">90만원</span></td>
				<td><span style="width:48;height:16;color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='1,000,000';frm.name.focus();">100만원</span></td>
				<td><span style="width:48;height:16;color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='2,000,000';frm.name.focus();">200만원</span></td>
				<td><span style="width:48;height:16;color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='3,000,000';frm.name.focus();">300만원</span></td>
				<td><span style="width:48;height:16;color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='5,000,000';frm.name.focus();">500만원</span></td>
				</tr>

				</table>
			</td></tr>
			</table></td>
</tr>
<tr>
 <td align=right class=menubar>입금자</td>
 <td></td>
 <td><input type=text name=name maxlength=200 class="input2"> ☜ 이체시 '보내는분'과 동일해야 합니다.</td>
</tr>

<tr>


</table>
</form>
        </td>
    </tr>
    <tr>
        <td width="771" height="44" background="img/minit_03.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771" height="40">
	        <tr>
			    <td width="771" height="40" align="center">
					<img src="img/chong.jpg" border="0" align="absmiddle" onclick="FnInMoney_Submit(frm);">&nbsp;
					<img src="img/back.jpg" border="0" align="absmiddle" onclick="location.reload();">
			    </td>
			  
			</tr>
		    
     </table>
<%@include file="../footer.jsp"%>