<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.comm.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jkl-parsexml.js"></script>
</head>
<body>
<script>
function deleteSms(msgSeq, inDate, sm)
{
	var http = new JKL.ParseXML("delsms.jsp", "msgSeq=" + msgSeq + "&inDate=" + inDate + "&sm=" + sm);
	http.parse();
	
	document.location.reload();
}
</script>
<table border=1>
<tr>
<td>회신번호</td>
<td>내용</td>
<td>msgSeq</td>
<td>inDate</td>
<td>sm</td>
<td>삭제</td>
</tr>
<%
	List<KtfSmsMessage> smsList = (List<KtfSmsMessage>)request.getAttribute("smsList");
	Iterator<KtfSmsMessage> smsIter = smsList.iterator();
	
	while (smsIter.hasNext()) {
		KtfSmsMessage message = smsIter.next();
%>
<tr>
<%
		out.print("<td>" + message.getCallBack() + "</td>");
		out.print("<td>" + message.getMsg() + "</td>");
		out.print("<td>" + message.getMsgSeq() + "</td>");
		out.print("<td>" + message.getInDate() + "</td>");
		out.print("<td>" + message.getSm() + "</td>");
%>
		<td><a href="#" onclick="javascript:deleteSms('<%=message.getMsgSeq()%>', '<%=message.getInDate()%>', '<%=message.getSm()%>')">O</a></td>
</tr>
<%
	}
	
%>
</table>
</body>
</html>