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

			<tr><td><img src="img/menu10.jpg" border="0"></td></tr>
		
            </table>
            <table align="center" cellpadding="0" cellspacing="0" width="771" height="33">
    <tr>
        <td width="887" height="33" align="left" valign="top">
            <p><a href="myMoney.aspx?mode=viewMyMoneyList"><img src="img/10.jpg" border="0"></a>&nbsp;<img src="img/12-.jpg" border="0"></p>
        </td>
    </tr>
    
</table>
     <table align="center" cellpadding="0" cellspacing="0" width="771" height="40" background="img/bar-.jpg">
    <tr>
        <td width="131" height="40" align="center" valign="middle" class="menubar">
            <p>일자</p>
        </td>
        <td width="140" height="40" align="center" valign="middle" class="menubar">
            <p>기포인트</p>
        </td>
        <td width="140" height="40" align="center" valign="middle" class="menubar">
            <p>입출포인트</p>
       </td>
        <td width="140" height="40" align="center" valign="middle" class="menubar">
            <p>잔여포인트</p>
        </td>
        <td width="220" height="40" align="center" valign="middle" class="menubar">
            <p>배팅한사용자</p>
        </td>
     
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771">
	<%
	if (pointList != null && pointList.size() > 0) {
		for (Point point : pointList) {
	%>  
    <tr>
        <td width="131" class="tablebg1" align="center" valign="middle">
            <p><%=point.getDateStr()%></p>
        </td>
        <td width="140" class="tablebg2" align="center" valign="middle">
            <p><%=XwinUtil.comma3(point.getOldBalance())%></p>
        </td>
        <td width="140" class="tablebg1" align="center" valign="middle">
            <p><%=XwinUtil.comma3(point.getMoney())%></p>
        </td>
        <td width="140" class="tablebg2" align="center" valign="middle">
            <p><%=XwinUtil.comma3(point.getBalance())%></p>
        </td>
        <td width="220" class="tablebg1" align="center" valign="middle">
            <p><%=XwinUtil.nvl(point.getNote())%></p>
        </td>
     
    </tr>
	<%
		}
	}
	%>
     </table>
<br>
<br>
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'><img src="img/prev.jpg" border="0" align="absmiddle"></a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b>&nbsp;&nbsp;<%=i+1%>&nbsp;&nbsp;</b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>&nbsp;&nbsp;<%=i+1%>&nbsp;&nbsp;</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'><img src="img/next.jpg" border="0" align="absmiddle"></a>
<%
	}
%>
<script>
function goPage(index)
{
	location.href="myMoney.aspx?mode=viewMyPointList&pageIndex=" + index;
}

function deleteMyMoneyLog(id)
{
	if (confirm("ingin hapuskan rekor jumlah uang?")) {
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