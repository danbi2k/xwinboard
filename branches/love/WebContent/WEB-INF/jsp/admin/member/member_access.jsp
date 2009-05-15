<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	List<Access> accessList = (List<Access>) request.getAttribute("accessList");
	Integer totalCount = (Integer) request.getAttribute("accessCount");

	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	String block = XwinUtil.nvl(request.getParameter("block"));
%>
<div class="title">접속목록</div>

<form method='GET' name="search" action="adminMember.aspx">
	<input type='hidden' name='mode' value='viewAccessList'/>
	<input type='hidden' name='pageIndex'/>
	<select name='block' onchange='this.form.submit()'>
		<option value=''>전체</option>
		<option value='block' <%=block.equals("block")?"selected":""%>>해제</option>
		<option value='noBlock' <%=block.equals("noBlock")?"selected":""%>>차단</option>
	</select>
	검색
	<select name='search'>
		<option value='userId' <%=search.equals("userId")?"selected":""%>>anggota idenditas</option>
		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>anggota nama pangilan</option>
		<option value='ipAddress' <%=search.equals("ipAddress")?"selected":""%>>아이피</option>
	</select>
	<input type='text' name='keyword' value='<%=keyword%>'>
	접속일
	<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
	<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">
	<input type='submit' value='검 색'>
 </form>

<table class="prettytable">
	<tr>
		<th width=5%>번호</th>
		<th width=10%>아이디</th>
		<th width=15%>닉네임</th>
		<th width=*>접속시각</th>
		<th width=15%>아이피</th>
		<th>차단</th>
	</tr>
<%
if (accessList != null) {
	for (Access access : accessList) {
%>
	<tr>
		<td width=5%><%=access.getId()%></td>
		<td width=10%><a href='javascript:goMemberDetail("<%=access.getUserId()%>")'><%=access.getUserId()%></a></td>
		<td width=10%><%=access.getNickName()%></td>
		<td width=*><%=XwinUtil.toDateStr(access.getDate(), 1)%></td>
		<td width=10%><%=access.getIpAddress()%></td>
		<td width=10%>
			<%if ("Y".equals(access.getBlock())) { %>
			<input type="button" onclick="releaseIp('<%=access.getIpAddress()%>')" value="해제"/>
			<%} else { %>
			<input type="button" onclick="blockIp('<%=access.getIpAddress()%>')" value="차단"/>
			<%} %>
		</td>
	</tr>
<%
 }
}
%>							
</table>

<div class="pages">
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
</div>
<script>
function blockIp(ip)
{
	if (confirm(ip + " 를 차단하시겠습니까?")) {
		var query = "mode=blockIp";
		query += "&ip=" + ip;
		var http = new JKL.ParseXML("adminMember.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}

function releaseIp(ip)
{
	if (confirm(ip + " 를 해제하시겠습니까?")) {
		var query = "mode=releaseIp";
		query += "&ip=" + ip;
		var http = new JKL.ParseXML("adminMember.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
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