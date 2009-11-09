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
            <table align="center" cellpadding="0" cellspacing="0" width="771" height="40"  background="img/bar1.gif">
    <tr>
        <td width="131" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">날짜</p>      </td>
        <td width="140" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">기존포인트</p>      </td>
        <td width="140" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">거래포인트</p>      </td>
        <td width="140" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">현존포인트</p>      </td>
        <td width="220" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">비고</p>      </td>
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
<table align="center" cellpadding="0" cellspacing="0" width="771" height="40">
	        <tr>
			    <td width="750" height="40" align="center">
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
			    </td>
			    <td width="100" height="40" align="right"><a href="javascript:exchangePoint(<%=member.getPoint()%>)"><img src="img/cchange1.jpg" / border="0"></a></td>
			</tr>
		    
     </table>
<script>
function goPage(index)
{
	location.href="account.php?mode=viewMyPointList&pageIndex=" + index;
}

function deleteMyMoneyLog(id)
{
	if (confirm("캐쉬기록을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyMoneyLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("account.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>
<%@include file="../footer.jsp"%>