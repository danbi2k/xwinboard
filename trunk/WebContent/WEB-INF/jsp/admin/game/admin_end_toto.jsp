<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.xwin.web.controller.admin.AdminTotoController"%>
<%
	final Integer ROWSIZE = 30;
	final Integer SHOWPAGE = 10;

	List<Toto> totoList = (List<Toto>) request.getAttribute("totoList");
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Integer totalCount = (Integer) request.getAttribute("totoCount");
	
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String betStatus = XwinUtil.nvl(request.getParameter("betStatus"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
%>
<%@ include file="../admin_header.jsp"%>
<SCRIPT LANGUAGE="JavaScript">

	function cancelToto(id)
	{
		if (confirm("" + id + "번 경기를 취소 하시겠습니까?")) {
			var query = "mode=cancelToto";
			query += "&id=" + id;
			
			var http = new JKL.ParseXML("adminToto.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			//if (result.resultXml.code == 0) {
			//	location.reload();
			//}
		}
	}

	function changeDisplayStatus(id, oselect)
	{
		var displayStatus = oselect.value;

		var query = "mode=changeDisplayStatus";
		query += "&displayStatus=" + displayStatus;
		query += "&id=" + id;
		
		var http = new JKL.ParseXML("adminToto.aspx", query);
		var result = http.parse();
		//alert(result.resultXml.message);
	}

	function removeToto(id)
	{
		var query = "mode=removeToto";
		query += "&id=" + id;
		
		var http = new JKL.ParseXML("adminToto.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}

	function calcelAllToto()
	{
		var c = document.game.checkToto;
		c = Xwin.ToArray(c);
		for (var i=0; i < c.length ; i++) {
			if (c[i].checked) {
				cancelToto(c[i].value);
			} 
		}

		location.reload();
	}
</SCRIPT>

<br>
<br>
<form method='get' name='search'>
<input type='hidden' name='pageIndex'/>
<input type='hidden' name='mode' value='viewTotoList'/>

리그명
<select name='leagueId' onChange='this.form.submit()'>
	<option value=''>전체</option>
	<%
	if (leagueList != null) {
		for (League league : leagueList) {
			
	%>
	<option value='<%=league.getId()%>' <%=leagueId.equals(league.getId())?"selected":""%>> <%=league.getName()%> </option>
	<%
		}
	}
	%>
</select>
경기상태
<select name='status' onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='<%=Code.GAME_STATUS_END%>' <%=status.equals(Code.GAME_STATUS_END)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_END)%></option>
	<option value='<%=Code.GAME_STATUS_CANCEL%>' <%=status.equals(Code.GAME_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_CANCEL)%></option>	
 </select>
<BR>
 경기일
<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">

 <select name='search'>
	 <option value='title'>제목</option>
 </select>
 <input type='text' name='keyword' value='<%=keyword%>'>
 <input type='submit' value='검 색'>
</form>
<form method='get' name='game'>
	<table class="prettytable">
 		<tr>
			<th><input type="checkbox"></th>
			<th width=5%>번호</th>
			<th>리그명</th>
			<th>경기시각</th>
			<th width="*">제목</th>
			<th>총발매수</th>
			<th>총발매액</th>
			<th>총당첨수</th>
			<th>수익</th>
			<th>상태</th>
	  	</tr>

		<%
		if (totoList != null) {
			for (Toto toto : totoList) {
				
		%>
 		<tr>
			<th><input type="checkbox" name="checkToto" value="<%=toto.getId()%>"></th>
			<td width=5%><a href="adminToto.aspx?mode=viewReprocessToto&id=<%=toto.getId()%>&pageIndex=<%=pIdx%>"><%=toto.getId()%></a></td>
			<td><%=toto.getLeagueName()%></td>			
			<td><%=XwinUtil.toDateStr(toto.getGameDate(), 0)%></td>
			<td><%=toto.getTitle()%></td>
			<td><%=toto.getTotalCount()%></td>
			<td><%=XwinUtil.comma3(toto.getTotalMoney())%></td>
			<td><%=XwinUtil.comma3(toto.getSuccessCount())%></td>
			<td><%=XwinUtil.comma3(toto.getEarnMoney())%></td>
			<td><%=Code.getValue(toto.getStatus())%></td>
		</tr>
			<%
				}
			}
			%>
	</table>
<div class="pages">
<%
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
	</div>
<script>
function changeDisplayStatus(id, oselect)
{
	var displayStatus = oselect.value;

	var query = "mode=changeDisplayStatus";
	query += "&displayStatus=" + displayStatus;
	query += "&id=" + id;
	
	var http = new JKL.ParseXML("adminToto.aspx", query);
	var result = http.parse();
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);
		location.reload();
	}
}

function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>