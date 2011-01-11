<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<BetToto> betTotoList = (List<BetToto>)request.getAttribute("betTotoList");
	Integer totalCount = (Integer)request.getAttribute("betTotoCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
<tr>
	<td><img src="images/menu18.jpg" border="0"></td>
</tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="33">
		 <tr>
        <td width="771" height="33" align="left" valign="top">
            <p><a href="toto.php?mode=viewToto"><img src="images/toto_2.jpg" border="0"></a>&nbsp;<img src="images/toto__1.jpg" border="0"></p>
        </td>
    </tr>
	
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="40"  background="images/bar1.gif">
	<tr>
		<td width="131" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">구매일자</p>	  </td>
		<td width="450" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">회차</p>	  </td>
		<td width="80" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">구매액</p>	  </td>
		<td width="80" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">상태</p>	  </td>
		<td width="30" height="40" align="center" valign="middle"
			class="menubar">
		<p style="font-weight: bold">삭제</p>	
	</tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771" border="0">
	<%
		if (betTotoList != null && betTotoList.size() > 0) {
			for (BetToto betToto : betTotoList) {
	%>
	<tr>
		<td width="131" class="tablebg1" align="center" valign="middle">
		<p><%=XwinUtil.getBoardItemDate(betToto.getDate())%></p>
		</td>
		<td width="450" class="tablebg2" align="center" valign="middle">
		<p><a href="betlog.php?mode=viewMyTotoDetail&id=<%=betToto.getId()%>"><%=betToto.getTitle()%></a></p>
		</td>
		<td width="80" class="tablebg1" align="center" valign="middle">
		<p><%=XwinUtil.comma3(betToto.getMoney())%></p>
		</td>
		<td width="80" class="tablebg2" align="center" valign="middle">
		<p><%=Code.getValue(betToto.getRunStatus())%></p>
		</td>
		<td width="30" class="tablebg1" align="center" valign="middle">
		<p>
		<%
		if (betToto.getRunStatus().equals(Code.BET_STATUS_RUN) == false) {
		%>
		<img src="images/x.gif" onclick="deleteMyToto(<%=betToto.getId()%>)">
		<%
		}
		%>
		</p>
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
		<a href='javascript:goPage(<%=startPage - 1%>)'><img src="images/prev.jpg" border="0" align="absmiddle"></a>
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
		<a href='javascript:goPage(<%=i%>)'><img src="images/next.jpg" border="0" align="absmiddle"></a>
<%
	}
%>

<script>
function deleteMyToto(id)
{
	if (confirm("구매 기록을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyToto";
		query += "&betTotoId=" + id;
		var http = new JKL.ParseXML("betlog.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}

function removeMoneyInRequestLog(id) {
	if (confirm("충전  기록을 삭제 하시겠습니까?")) {
		var query = "mode=removeMoneyInRequestLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("earncache.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}

function goPage(pageIndex)
{
	location.href = "betlog.php?mode=viewMyTotoList&pageIndex=" + pageIndex;
}
</script>

<%@include file="../footer.jsp"%>