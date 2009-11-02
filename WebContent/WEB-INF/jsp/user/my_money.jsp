<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<Account> accountList = (List<Account>) request.getAttribute("accountList");
	Integer totalCount = (Integer) request.getAttribute("accountCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>

			<tr><td><img src="../../../img/menu101.jpg" border="0"></td></tr>
		
</table>
            <table align="center" cellpadding="0" cellspacing="0" width="771" height="40"  background="img/bar1.gif">
    <tr>
        <td width="131" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">거래일자</p>      </td>
        <td width="100" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">기잔고</p>      </td>
        <td width="100" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">입출금</p>      </td>
        <td width="148" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">잔액</p>      </td>
        <td width="100" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">종류</p>      </td>
        <td width="150" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">비고</p>      </td>
        <td width="42" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">삭제</p>      </td>
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771">
	<%
	if (accountList != null && accountList.size() > 0) {
		for (Account account : accountList) {
	%>  
    <tr>
        <td width="131" class="tablebg1" align="center" valign="middle">
            <p><%=account.getDateStr()%></p>
        </td>
        <td width="100" class="tablebg2" align="center" valign="middle">
            <p><%=XwinUtil.comma3(account.getOldBalance())%></p>
        </td>
        <td width="100" class="tablebg1" align="center" valign="middle">
            <p><%=XwinUtil.comma3(account.getMoney())%></p>
        </td>
        <td width="148" class="tablebg2" align="center" valign="middle">
            <p><%=XwinUtil.comma3(account.getBalance())%></p>
        </td>
        <td width="100" class="tablebg1" align="center" valign="middle">
            <p><%=Code.getValue(account.getType())%></p>
        </td>
        <td width="150" class="tablebg2" align="center" valign="middle">
            <p><%=XwinUtil.nvl(account.getNote())%></p>
        </td>
        <td width="42" class="tablebg1" align="center" valign="middle">
            <p><img src="img/x.gif" onclick="deleteMyMoneyLog(<%=account.getId()%>)"></p>
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
	location.href="myMoney.php?mode=viewMyMoneyList&pageIndex=" + index;
}

function deleteMyMoneyLog(id)
{
	if (confirm("캐쉬기록을 삭제하시겠습니까?")) {
		var query = "mode=deleteMyMoneyLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("myMoney.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>
<%@include file="../footer.jsp"%>