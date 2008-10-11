<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	final Integer ROWSIZE = 20;
	final Integer SHOWPAGE = 10;
	
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
	Integer totalCount = (Integer) request.getAttribute("bettingCount");
	
	String gameType = XwinUtil.nvl(request.getParameter("gameType"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String betDate = XwinUtil.nvl(request.getParameter("betDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
		 
<script>
function cancelBetting(id, gameType)
{
	if (confirm("취소하시겠습니까?")) {
		var query = "mode=cancelBetting";
		query += "&id=" + id;
		query += "&gameType=" + gameType;
		var http = new JKL.ParseXML("adminBetting.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message)
		if (result.resultXml.code == 0) {
			location.reload(0);
		}
	}
}
</script>

<div class="title">사용자배팅현황</div>
<form method='get' name='search' action='adminBetting.aspx'>
<input type="hidden" name="mode" value="viewBettingList"/>
<input type="hidden" name="pageIndex"/>
 게임종류
<select name='gameType' onChange='this.form.submit()'>
<option value=''>전체</option>
<option value='wdl' <%=gameType.equals("wdl")?"selected":""%>>승무패</option>
<option value='handy' <%=gameType.equals("handy")?"selected":""%>>핸디캡</option>
                  <option value='oe' <%=gameType.equals("oe")?"selected":""%>>홀짝</option>
</select>

배팅상태
<select name='status' onChange='this.form.submit()'>
<option value=''>전체</option>
<option value='<%=Code.BET_STATUS_RUN%>' <%=status.equals(Code.BET_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_RUN)%></option>
<option value='<%=Code.BET_STATUS_SUCCESS%>' <%=status.equals(Code.BET_STATUS_SUCCESS)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_SUCCESS)%></option>
<option value='<%=Code.BET_STATUS_FAILURE%>' <%=status.equals(Code.BET_STATUS_FAILURE)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_FAILURE)%></option>
<option value='<%=Code.BET_STATUS_NOMATCH%>' <%=status.equals(Code.BET_STATUS_NOMATCH)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_NOMATCH)%></option>
<option value='<%=Code.BET_STATUS_CANCEL%>' <%=status.equals(Code.BET_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_CANCEL)%></option>
</select>

 배팅일자
<input type='text' name='betDate' value='<%=betDate%>' size=10 readonly onClick="popUpCalendar(this, betDate,'yyyy-mm-dd');" style="cursor:hand">

 <select name='search'>
 <option value='userId'>아이디</option>
 <option value='nickName'>닉네임</option>
</select> 
<input type='text' name='keyword' value='<%=keyword%>' size=12>
<input type='submit' value='검 색'>
</form>

<table class="prettytable">
	<tr>
		<th width=5%>번호</th>
		<th>아이디</th>
		<th>닉네임</th>
		<th>배팅시각</th>
		<th>배당률</th>
		<th>배팅금액</th>
		<th>예상금액</th>
		<th>상태</th>		 
		<!-- th>정산</th -->
		<!-- th>취소</th -->
	</tr>
							 
	<%
	if (bettingList != null) {
		for (Betting betting : bettingList) {
			List<BetGame> betGameList = betting.getBetGameList();
	%>
	<tr align='center' bgcolor='#ffffff'>
		<td><a href="adminBetting.aspx?mode=viewBettingDetail&id=<%=betting.getId()%>"><%=betting.getId()%></a></td>								
		<td><%=betting.getUserId()%></td>
		<td><%=betting.getNickName()%></td>
		<td><%=betting.getDateStr()%></td>
		<td><%=betting.getRateStr()%></td>
		<td><%=XwinUtil.comma3(betting.getMoney())%></td>
		<td><%=XwinUtil.comma3(betting.getExpect())%></td>
		<td><B>
		<font color="<%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?"orange":"red"%>">
			<%=Code.getValue(betting.getStatus())%>
		</font></B></td>
		<!-- td><%=Code.getValue(betting.getCalcStatus())%></td -->
		<!--td><input type="button" onclick="cancelBetting(<%=betting.getId()%>, '<%=betting.getGameType()%>')" value="취소"/></td  -->
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
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>
