<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 25;
	int SHOWPAGE = 10;
	
	List<MoneyInOut> moneyInOutList = (List<MoneyInOut>) request.getAttribute("moneyInOutList");
	String status = XwinUtil.nvl(request.getParameter("status"));	
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	Integer totalSum = (Integer) request.getAttribute("totalSum");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
%>

		  
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">직충전차감내역</div>
<font size="5" color="red">총액 : <%=XwinUtil.comma3(new Long(totalSum))%></font>
<form method='get' name='search' action='adminAccount.aspx'>
	<input type='hidden' name='mode' value='viewMoneyInOutList'/>
	<input type='hidden' name='pageIndex'/>
	상태
	<select name='status' onchange='this.form.submit()'>
		<option value='004' <%=status.equals("004")?"selected":""%>>전체</option>
 		<option value='MC004' <%=status.equals("MC004")?"selected":""%>>직충전</option>
 		<option value='ME004' <%=status.equals("ME004")?"selected":""%>>직차감</option>
 	</select>
 	<select name='search'>
 		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
 		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>닉네임</option>
 	</select>
 	<input type='text' name='keyword' value='<%=keyword%>'>
	일자
	<input type='hidden' name='dateType' value='proc'/>
	<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
	<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">		
 	<input type='submit' value='검 색'/>
</form>
<form name="list">
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th>아이디 (닉네임)</th>
		<th>금액</th>
		<th>일자</th>
		<th>상태</th>
		<th>비고</th>
	</tr>

	<%
	if (moneyInOutList != null) {
		for (MoneyInOut moneyInOut : moneyInOutList) {
			boolean plus = moneyInOut.getStatus().equals("MC004");
	%>
	<tr align='center' bgcolor='#ffffff'>
		<td><a href="adminMember.aspx?mode=viewMemberDetail&userId=<%=moneyInOut.getUserId()%>"><%=moneyInOut.getUserId()%></a> (<%=moneyInOut.getNickName()%>)</td>
		<td><font color=<%=plus?"blue":"red"%>><%=XwinUtil.comma3(moneyInOut.getMoney())%></font></td>
		<td><%=moneyInOut.getProcDateStr()%></td>
		<td><%=Code.getValue(moneyInOut.getStatus())%></td>
		<td><%=XwinUtil.nvl(moneyInOut.getNote())%>
	  </tr>
	<%
		}
	}
	%>
 </table>
</form>
<BR>
<!--input type="button" value="삭제" onclick="deleteCheckedItem()"/ -->
<BR>
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
function deleteCheckedItem()
{
	if (confirm("삭제하시겠습니까?")) {
		var query = "mode=<%=status.equals(Code.MONEY_IN_DIRECT)?"deleteMoneyInList":"deleteMoneyOutList"%>";
		var c = document.list.checkCheck;
		c = Xwin.ToArray(c);
		for (var i = 0 ; i < c.length ; i++) {
			if (c[i].checked) {
				query += "&id=" + c[i].value;
			}
		}
	
		var http = new JKL.ParseXML("adminAccount.aspx", query);
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
