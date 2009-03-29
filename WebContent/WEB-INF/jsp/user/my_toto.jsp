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
	<td><img src="img/menu11.jpg" border="0"></td>
</tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="33">
	<tr>
		<td width="771" height="33" align="left" valign="top">
		<p>
			<a href="toto.aspx?mode=viewToto"><span style="background-color:000000">토토구매</span></a>&nbsp;
			<span style="background-color:AA0055">구매내역</span></p>
		</td>
	</tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="40" background="img/bar-.jpg">
	<tr>
		<td width="131" height="40" align="center" valign="middle"
			class="menubar">
		<p>구매일자</p>
		</td>
		<td width="450" height="40" align="center" valign="middle"
			class="menubar">
		<p>회차</p>
		</td>
		<td width="80" height="40" align="center" valign="middle"
			class="menubar">
		<p>구매액</p>
		</td>
		<td width="80" height="40" align="center" valign="middle"
			class="menubar">
		<p>상태</p>
		</td>
		<td width="30" height="40" align="center" valign="middle"
			class="menubar">
		<p>삭제</p>
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
		<p><a href="myBet.aspx?mode=viewMyTotoDetail&id=<%=betToto.getId()%>"><%=betToto.getTitle()%></a></p>
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
		<img src="img/x.gif" onclick="deleteMyToto(<%=betToto.getId()%>)">
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
function deleteMyBetting(id)
{
	if (confirm("배팅 기록을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyToto";
		query += "&betTotoId=" + id;
		var http = new JKL.ParseXML("myBet.aspx", query);
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
		var http = new JKL.ParseXML("moneyIn.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>

<%@include file="../footer.jsp"%>