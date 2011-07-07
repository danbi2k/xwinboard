<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.join.*"%>
<%@ page import="java.util.*"%>

<%@ include file="dealer_header.jsp"%>

<%
	List<Invitation> noJoinList = (List<Invitation>) request.getAttribute("noJoinList");
%>

<div class="title">회원초대</div>
<form name="regist">
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>휴대폰번호</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input name="mobile" type="text" value=""/>
			<input type="button" value="초대" onclick="sendInvitation()"/>
			* - 없이 숫자만 입력 하세요
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>미사용초대장</td>
		<td width=80% bgcolor='#ffffff' align='left'>
		<table class="prettytable">
		<%
		if (noJoinList != null) {
		%>
		<tr>
			<th>초대장</th>
			<th>핸드폰번호</th>
			<th>지급일</th>
		</tr>
		<%
			for (Invitation invitation : noJoinList) {
		%>
			<tr>
			<td><%=invitation.getInviteKey()%></a></td>
			<td><%=invitation.getMobile()%></a></td>
			<td><%=XwinUtil.toDateStr(invitation.getSendDate(), 1)%></td>
			</tr>
		<%
			}
		}
		%>
		</table>
		</td>
 	</tr>
</table>
</form>
<script>
function sendInvitation()
{
	var frm = document.regist;	
	if (frm.mobile != undefined) {
		if (!frm.mobile.value) {
			alert("초대장을 전송할 핸드폰 번호를 입력해 주십시오");
			return;
		}
	}
	
	var query = "mode=sendInvitation";
	query += "&mobile=" + frm.mobile.value;
	var http = new JKL.ParseXML("dealer.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();	
}
</script>

<%@ include file="dealer_footer.jsp"%>