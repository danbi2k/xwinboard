<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>
			<tr><td><img src="img/menu09.jpg" border="0"></td></tr>
		
            </table>
            <table align="center" cellpadding="0" cellspacing="0" width="771" height="246">
    <tr>
        <td width="771" height="33" align="left" valign="top">
            <p><img src="img/9-.jpg" border="0">&nbsp;<a href="sendcache.php?mode=viewMoneyOutRequestList"><img src="img/11.jpg" border="0"></a></p>
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

<input type="hidden" name="account_bank" value="<%=member.getBankName()%>"/>
<input type="hidden" name="account_num" value="<%=member.getBankNumber()%>"/>
<input type="hidden" name="account_name" value="<%=member.getBankOwner()%>"/>

<table border=0 cellspacing=0 cellpadding=0 width=730 align="center">

<col width=100></col>
<col width=10></col>
<col width=600></col>


 

<tr>
 <td align=right class=menubar>캐쉬잔액</td>
 <td></td>
 <td><%=XwinUtil.comma3(member.getBalance())%> 원</td>
</tr>


<tr>
 <td align=right class=menubar>환전신청액</td>
 <td></td>
 <td> <input type=text name=out_money maxlength=200 class=input2 onkeyup="only123(this); comma3Input(this);"> 원 </td>
</tr>

<tr>
 <td align=right class=menubar>환전계좌은행</td>
 <td></td>
 <td><%=member.getBankName()%></td>
</tr>
<tr>
 <td align=right class=menubar>환전계좌번호</td>
 <td></td>
 <td><%=member.getBankNumber()%></td>
</tr>
<tr>
 <td align=right class=menubar>환전계좌수취인</td>
 <td></td>
 <td><%=member.getBankOwner()%></td>
</tr>
<tr>
 <td align=right class=menubar>비밀번호</td>
 <td></td>
 <td><input type=password name=password maxlength=200 class=input2 ><BR>(로그인 비밀번호를 입력하세요!) </td>
</tr>



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
					<img src="img/ok.jpg" border="0" align="absmiddle" onclick="FnOutMoney_Submit(frm);">&nbsp;
					<img src="img/back.jpg" border="0" align="absmiddle" onclick="location.reload();">
			    </td>
			  
			</tr>
		    
     </table>

<%@include file="../footer.jsp"%>