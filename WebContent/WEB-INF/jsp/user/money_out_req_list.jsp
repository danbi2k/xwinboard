<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<MoneyOut> moneyOutList = (List<MoneyOut>)request.getAttribute("moneyOutList");
	Integer totalCount = (Integer)request.getAttribute("moneyOutCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
			<tr><td><img src="img/menu091.jpg" border="0"></td></tr>
		
</table>
            <table align="center" cellpadding="0" cellspacing="0" width="771" height="33">
    <tr>
        <td width="771" height="37" align="left" valign="top" background="img/bar_bg.gif">
            <p><a href="sendcache.php?mode=viewMoneyOutRequest"><img src="img/9.jpg" border="0"></a>&nbsp;<img src="img/11-.jpg" border="0"></p>
        </td>
    </tr>
	</table>
      <table align="center" cellpadding="0" cellspacing="0" width="771" height="40" background="img/bar1.jpg">
    <tr>
        <td width="131" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">신청날짜</p>      </td>
        <td width="208" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">계좌번호</p>      </td>
        <td width="120" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">환전금액</p>      </td>
        <td width="120" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">상태</p>      </td>
        <td width="150" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">환전날짜</p>      </td>
        <td width="42" height="40" align="center" valign="middle" class="menubar">
            <p style="font-weight: bold">삭제</p>      </td>
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771">
	<%
		if (moneyOutList != null && moneyOutList.size() > 0) {
			for (MoneyOut moneyOut : moneyOutList) {
	%>  
    <tr>
        <td width="131" class="tablebg1" align="center" valign="middle">
            <p><%=moneyOut.getReqDateStr()%></p>
        </td>
        <td width="208" class="tablebg2" align="center" valign="middle">
            <p>[<%=moneyOut.getBankName()%>] <%=moneyOut.getNumber()%> <%=moneyOut.getName()%></p>
        </td>
        <td width="120" class="tablebg1" align="center" valign="middle">
            <p><%=XwinUtil.comma3(moneyOut.getMoney())%></p>
        </td>
        <td width="120" class="tablebg2" align="center" valign="middle">
            <p><%=Code.getValue(moneyOut.getStatus())%></p>
        </td>
        <td width="150" class="tablebg1" align="lecenterft" valign="middle">
            <p><%=moneyOut.getProcDateStr()%></p>
        </td>
        <td width="42" class="tablebg2" align="center" valign="middle">
            <p>
				<%if (moneyOut.getStatus().equals(Code.MONEY_OUT_REQUEST)) { %>
				<%} else {%>
				<img src="img/x.gif" onclick="removeMoneyOutRequestLog(<%=moneyOut.getId()%>)" title="환전기록삭제">
				<%} %>
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
function goPage(index)
{
	location.href="sendcache.php?mode=viewMoneyOutRequestList&pageIndex=" + index;
}

function removeMoneyOutRequestLog(id)
{
	if (confirm("환전 기록을 삭제 하시겠습니까?")) {
		var query = "mode=removeMoneyOutRequestLog";
		query += "&id=" + id;
		var http = new JKL.ParseXML("sendcache.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload(0);
	}
}
</script>

<%@include file="../footer.jsp"%>