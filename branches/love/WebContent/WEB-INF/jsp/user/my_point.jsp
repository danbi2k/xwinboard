<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<Point> pointList = (List<Point>) request.getAttribute("pointList");
	Integer totalCount = (Integer) request.getAttribute("pointCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>

<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_mymoney.gif"></td><td>포인트 입출금 내역 입니다.</td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

	<table width="800" cellpadding="0" cellspacing="0" style="margin-top:15">
	<tr><td>
		<table  cellpadding="0" cellspacing="0" >
		<tr><td>
			<a href="myMoney.aspx?mode=viewMyMoneyList"><img src="images/tab_money.gif" style="cursor:hand;" border=0></a>
			</td>
		<td>
			<a href="myMoney.aspx?mode=viewMyPointList"><img src="images/tab_point.gif" style="cursor:hand;" border=0></a>
			</td>	
		</tr></table>

	</td></tr>
	</table>

	<table width="800" bgcolor="#d9d8d6" cellspacing="1" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="140" align="center">
	<col width="100" align="right">
	<col width="100" align="right">
	<col width="100" align="right">
	<col width="*" align="center">
	<col width="*" align="center">
	<col width="*" align="center">
	</colgroup>

	<tr bgcolor="#ce892c">
		<th style="color:white" align="center">일자</th>
		<th style="color:white" align="center">기포인트</th>
		<th style="color:white" align="center">입출포인트</th>
		<th style="color:white" align="center">잔여포인트</th>
		<!-- th style="color:white" align="center">종류</th -->
		<th style="color:white" align="center">배팅한사용자</th>
		<!-- th style="color:white" align="center">삭제</th -->
		
	</tr>
	<%
	if (pointList != null && pointList.size() > 0) {
		for (Point point : pointList) {
	%>
	<tr bgcolor='black'>
	<td><%=point.getDateStr()%></td>
	<td><%=XwinUtil.comma3(point.getOldBalance())%></td>
	<td><%=XwinUtil.comma3(point.getMoney())%></td>
	<td><%=XwinUtil.comma3(point.getBalance())%></td>
	<!-- td><%=Code.getValue(point.getType())%></td -->
	<td><%=XwinUtil.nvl(point.getNote())%>
	<!-- td><img src="images/btn_coment_del.gif" onclick="deleteMyMoneyLog(<%=point.getId()%>)"></td -->
	</tr>
	<%
		}
	} else {
	%>
	<tr bgcolor='black'><td colspan='6' height='150' align='center' bgcolor='black'>포인트  내역이 없습니다.</td></tr>
	<%
	}
	%>
	</table>

	<tr bgcolor='black'>
	<td colspan='6' height='40' align='center' bgcolor='black'>
	<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'>&lt;&lt;&lt;</a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b> <%=i+1%> </b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>[ <%=i+1%> ]</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'>&gt;&gt;&gt;</a>
<%
	}
%>
	</td>
	</tr>

</td></tr>
</table>

<script>
function goPage(index)
{
	location.href="myMoney.aspx?mode=viewMyPointList&pageIndex=" + index;
}

function deleteMyMoneyLog(id)
{
	if (confirm("머니기록을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyMoneyLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("myMoney.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>
<%@include file="../footer.jsp"%>