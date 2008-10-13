<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyInOutList");
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String status = XwinUtil.nvl(request.getParameter("status"));	
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	int ROWSIZE = 20;
	int SHOWPAGE = 10;
%>

<div class="title">환전요청</div>
		 
<SCRIPT LANGUAGE="JavaScript">
	function acceptMoneyOutRequest(id) {
		var d=document.regist;
		if(confirm('환전하시겠습니까?')) {			
			var query = "mode=acceptMoneyOutRequest";
			query += "&id=" + id;
			var http = new JKL.ParseXML("adminAccount.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();		
			} 
		}
	}
</SCRIPT>
	
<form method='post' name='search' action='adminAccount.aspx'>
	<input type='hidden' name='mode' value='viewMoneyOutList'/>
	<input type='hidden' name='pageIndex'/>
	<input type='hidden' name='status' value='<%=status%>'/>
	<select name='search'>
		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
 		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>닉네임</option>
		<option value='name' <%=search.equals("name")?"selected":""%>>예금주명</option>
	</select>
	<input type='text' name='keyword' value='<%=keyword%>'>
	<!--select name='searchDate'>
		<option value='procDate'>환전일</option>
		<option value='regDate'>신청일</option>
	</select>
		<input type='text' name='fromDate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
		~
		<input type='text' name='toDate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value=''  -->				
		<input type='submit' value='검 색'>  
</form>
<form name="list">
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th></th>
		<td width=5%>번호</td>
		<th>아이디</td>
		<th>환전요청금액</td>
		<th>은행명</td>
		<th>계좌번호</td>
		<th>예금주</td>
		<th>신청일자</td>
		<th>상태</td>
		<th>충전</th>
	</tr>
	<%
	if (moneyOutList != null) {
		for (MoneyOut moneyOut : moneyOutList) {
	%>
	<tr>
		<td><input type="checkbox" name="checkCheck" value="<%=moneyOut.getId()%>" onclick="saveMoneyOutIsChecked(this)" <%=moneyOut.getIsChecked().equals("Y")?"checked":""%>/></td>
		<td><%=moneyOut.getId()%></td>
		<td><B><%=moneyOut.getUserId()%></B></td>
		<td><%=XwinUtil.comma3(moneyOut.getMoney())%></td>
		<td><%=moneyOut.getBankName()%></td>
		<td><%=moneyOut.getNumber()%></td>
		<td><%=moneyOut.getName()%></td>
		<td><%=moneyOut.getReqDateStr()%></td>
		<td><%=Code.getValue(moneyOut.getStatus())%></td>
		<td><input type='button' value='환전' onclick='acceptMoneyOutRequest(<%=moneyOut.getId()%>)'></td>
	</tr>
<%
	}
}
%>

</table>
</form>
<BR>
<input type="button" value="삭제" onclick="deleteCheckedItem()"/>
<BR>
<div class="pages">
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) totalCount / ROWSIZE + 1;
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
function saveMoneyOutIsChecked(cobj)
{
	var query = "mode=saveMoneyOutIsChecked";
	query += "&id=" + cobj.value;
	if (cobj.checked)
		query += "&isChecked=Y";
	else
		query += "&isChecked=N";
	
	var http = new JKL.ParseXML("adminAccount.aspx", query);
	var result = http.parse();	

	checkIndi();	
}

function deleteCheckedItem()
{
	if (confirm("삭제하시겠습니까?")) {
		var query = "mode=deleteMoneyOutList";
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
