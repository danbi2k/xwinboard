<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInOutList");
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	Integer totalSum = (Integer) request.getAttribute("totalSum");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String status = XwinUtil.nvl(request.getParameter("status"));	
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	int ROWSIZE = 25;
	int SHOWPAGE = 10;
%>

<div class="title">충전요청</div>
<font size="5" color="red">총액 : <%=XwinUtil.comma3(new Long(totalSum))%></font>		  
<SCRIPT LANGUAGE="JavaScript">
	function acceptMoneyInRequest(id) {
		if(confirm('충전하시겠습니까?')) {
			var query = "mode=acceptMoneyInRequest";
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
	
<form method='get' name='search' action='adminAccount.aspx'>
	<input type='hidden' name='mode' value='viewMoneyInList'/>
	<input type='hidden' name='pageIndex'/>
	<input type='hidden' name='status' value='<%=status%>'/>
 	<select name='search'>
 		<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
 		<option value='nickName' <%=search.equals("nickName")?"selected":""%>>닉네임</option>
		<option value='name' <%=search.equals("name")?"selected":""%>>입금자명</option>
 	</selec>
 	<input type='text' name='keyword' value='<%=keyword%>'>
	<!--select name='searchDate'>
 		<option value='procDate' >충전일</option>
 		<option value='reqDate' >신청일</option>
 	</select>
 	<input type='text' name='fromDate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
 	~
 	<input type='text' name='toDate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value='' -->		
 	<input type='submit' value='검 색'>
</form>
<form name="list">
<table class="prettytable">
	<tr align="center" bgcolor="#E4E4E4">
		<th></th>
		<th width=5%>번호</th>
		<th>아이디 (닉네임)</th>
		<th>입금자</th>
		<th>충전요청금액</th>
		<th>신청일자</th>
		<th>상태</th>
		<th>충전</th>
	</tr>

	<%
	if (moneyInList != null) {
		for (MoneyIn moneyIn : moneyInList) {
	%>
	<tr align='center' bgcolor='#ffffff'>
		<th><input type="checkbox" name="checkCheck" value="<%=moneyIn.getId()%>" onclick="saveMoneyInIsChecked(this)" <%=moneyIn.getIsChecked().equals("Y")?"checked":""%>/></th>
		<td width=5%><%=moneyIn.getId()%></td>
		<td><%=moneyIn.getUserId()%> (<%=moneyIn.getNickName()%>)</td>
		<td><%=moneyIn.getName()%></td>
		<td><%=XwinUtil.comma3(moneyIn.getMoney())%></td>
		<td><%=moneyIn.getReqDateStr()%></td>
		<td>
		<font color="<%=moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)?"blue":"red"%>">
			<%=Code.getValue(moneyIn.getStatus())%>
		</font>
		</td>
		<td>
		<%if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) { %>
		<input type='button' value='충전' onclick='acceptMoneyInRequest(<%=moneyIn.getId()%>)'>		
		<input type='button' value='취소' onclick='cancelMoneyInRequest(<%=moneyIn.getId()%>)'></td>
		<%} %>
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
function saveMoneyInIsChecked(cobj)
{
	var query = "mode=saveMoneyInIsChecked";
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
		var query = "mode=deleteMoneyInList";
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

function cancelMoneyInRequest(id)
{
	if (confirm("충전 요청을 취소하시겠습니까?")) {
		var query = "mode=cancelMoneyInRequest";
		query += "&id=" + id;
		
		var http = new JKL.ParseXML("adminAccount.aspx", query);
		var result = http.parse();
	
		if (result.resultXml.code == 0) {
			alert("충전이 취소되었습니다");
			location.reload();
		}
	
		checkIndi();
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
