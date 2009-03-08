<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.log.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	List<HackingLog> hackingLogList = (List<HackingLog>) request.getAttribute("hackingLogList");
	Integer totalCount = (Integer) request.getAttribute("hackingLogCount");

	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
<div class="title">해킹탐지</div>

<form method='GET' name="search" action="adminLog.aspx">
	<input type='hidden' name='mode' value='viewHackingLog'/>
	<input type='hidden' name='pageIndex'/>
 </form>
<table class="prettytable">
	<tr>
		<th></th>
		<th width=5%>번호</th>
		<th width=10%>아이디</th>
		<th width=15%>닉네임</th>
		<th width=10%>시각</th>
		<th width=15%>모드</th>
		<th width=*>내용</th>
	</tr>
<%
if (hackingLogList != null) {
	for (HackingLog hackingLog : hackingLogList) {
%>
	<tr>
		
		<th><input type="checkbox" name="checkCheck" value="<%=hackingLog.getId()%>" onclick="saveHackingLogIsChecked(this)" <%=hackingLog.getIsChecked().equals("Y")?"checked":""%>/></th>
		<td width=5%><%=hackingLog.getId()%></td>
		<td width=10%>
			<a href='javascript:goMemberDetail("<%=hackingLog.getUserId()%>")'><%=XwinUtil.nvl(hackingLog.getUserId())%></a>
		</td>
		<td width=15%><%=XwinUtil.nvl(hackingLog.getNickName())%></td>
		<td width=10%><%=XwinUtil.toDateStr(hackingLog.getDate(), 1)%></td>
		<td width=15%><%=XwinUtil.nvl(hackingLog.getMode())%></td>
		<td width=45% style='word-break:break-all;'><%=XwinUtil.nvl(hackingLog.getValue())%>
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
function saveHackingLogIsChecked(cobj)
{
	var query = "mode=saveHackingLogIsChecked";
	query += "&id=" + cobj.value;
	if (cobj.checked)
		query += "&isChecked=Y";
	else
		query += "&isChecked=N";
	
	var http = new JKL.ParseXML("adminLog.aspx", query);
	var result = http.parse();

	checkIndi();	
}

function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>