<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.xwin.web.controller.admin.AdminGameController"%>
<%
	final Integer ROWSIZE = 40;
	final Integer SHOWPAGE = 20;

	Toto toto = (Toto) request.getAttribute("toto");
	
	Integer colNum = toto.getColNum();
	Integer rowNum = toto.getRowNum();
	
	List<BetToto> betTotoList = (List<BetToto>) request.getAttribute("betTotoList");
	Integer totalCount = (Integer) request.getAttribute("betTotoCount");
	
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String runStatus = XwinUtil.nvl(request.getParameter("runStatus"));
	String betStatus = XwinUtil.nvl(request.getParameter("betStatus"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>

<%@ include file="../admin_header.jsp"%>

<div class="title">토토 구매 현황</div>

<form method='get' name='search' action='adminToto.aspx'>
<input type='hidden' name='mode' value='viewBetTotoList'/>
<input type='hidden' name='pageIndex'/>

상태
<select name='runStatus' onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='<%=Code.BET_STATUS_RUN%>' <%=runStatus.equals(Code.BET_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_RUN)%></option>
	<option value='<%=Code.BET_STATUS_SUCCESS%>' <%=runStatus.equals(Code.BET_STATUS_SUCCESS)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_SUCCESS)%></option>
	<option value='<%=Code.BET_STATUS_FAILURE%>' <%=runStatus.equals(Code.BET_STATUS_FAILURE)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_FAILURE)%></option>
	<option value='<%=Code.BET_STATUS_CANCEL%>' <%=runStatus.equals(Code.BET_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_CANCEL)%></option>	
 </select>
<select name='search'>
	<option value='userIdLike' <%=search.equals("userIdLike")?"selected":""%>>회원아이디</option>
	<option value='nickNameLike' <%=search.equals("nickNameLike")?"selected":""%>>회원닉네임</option>
</select>
<input type='text' name='keyword' value='<%=keyword%>'>
<input type='submit' value='검 색'>
</form>
<BR>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">제목</td>
		<td bgcolor="#FFFFFF"  colspan=3><%=toto.getTitle()%></td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">총발매수</td>
		<td bgcolor="#FFFFFF"  colspan=3><%=XwinUtil.comma3(toto.getTotalCount())%></td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">총발매액</td>
		<td bgcolor="#FFFFFF"  colspan=3><%=XwinUtil.comma3(toto.getTotalMoney())%></td>
	</tr>
</table>

<table class="toto"">
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="6"><%=j+1%> 경기</td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="2"><span id="T<%=j%>L" name="T<%=j%>L"/></span></td>
	<td align="center" colspan="2">VS</td>
	<td align="center" colspan="2"><span id="T<%=j%>R" name="T<%=j%>R"/></span></td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="3"><span id="I<%=j%>L" name="I<%=j%>L"/></span></td>
	<td align="center" colspan="3"><span id="I<%=j%>R" name="I<%=j%>R""/></span></td>
<%
	}
%>
</tr>
<%
	for (int i = 0 ; i < rowNum ; i++) {
%>
<tr>
<%
		for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center"><input type="checkbox" id="<%=j%>A<%=i%>" name="<%=j%>A" onclick="checkToto(this)"/></td>
	<td align="center"><span id="C<%=j%>L<%=i%>" name="C<%=j%>L<%=i%>"/></span></td>
	<td align="center"><input type="checkbox" id="<%=j%>B<%=i%>" name="<%=j%>B" onclick="checkToto(this)"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>C<%=i%>" name="<%=j%>C" onclick="checkToto(this)"/></td>
	<td align="center"><span id="C<%=j%>R<%=i%>" name="C<%=j%>R<%=i%>"/></span></td>
	<td align="center"><input type="checkbox" id="<%=j%>D<%=i%>" name="<%=j%>D" onclick="checkToto(this)"/></td>
<%		
		}
%>
</tr>
<%
	}
%>
</table>

<input type="button" value="결과처리" onclick="endToto()"/>
<input type="button" value="토토취소(전체)" onclick="cancelToto()"/>

<table class="prettytable">
		<tr>
		<th width=5%>번호</th>
		<th>아이디 (닉네임)</th>
		<th>구매일</th>
		<th>구매액</th>
		<th>당첨액</th>
		<th>상태</th>
		<th>취소</th>
  	</tr>

	<%
	if (betTotoList != null) {
		for (BetToto betToto : betTotoList) {
	%>
		<tr>
		<td width=5%><a href="adminToto.aspx?mode=viewBetTotoDetail&id=<%=betToto.getId()%>"><%=betToto.getId()%></a></td>
		<td width=15% align='left'>&nbsp;<a href='javascript:goMemberDetail("<%=betToto.getUserId()%>")'><%=betToto.getUserId()%></a> (<%=betToto.getNickName()%>)
		<td width=15%><%=XwinUtil.getBoardItemDate(betToto.getDate())%></td>
		<td><%=XwinUtil.comma3(betToto.getMoney())%></td>
		<td><%=XwinUtil.comma3(betToto.getExpect())%></td>
		<td><%=Code.getValue(betToto.getRunStatus())%></td>
		<td><input type="button" value="취소" onclick="cancelBetToto(<%=betToto.getId()%>)"/></td>
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
var rowNum = <%=rowNum%>;
var colNum = <%=colNum%>;

var spot = [];
spot[0] = "A";
spot[1] = "B";
spot[2] = "C";
spot[3] = "D";

function loadCard(formString)
{
	var formList = formString.split("|");
	for (var i = 0 ; i < formList.length ; i++) {
		var keyValue = formList[i].split("=");
		if (keyValue[0].length == 0)
			continue;
		var tobj = document.getElementById(keyValue[0]);
		if (tobj != null)	
			tobj.innerHTML = keyValue[1];
	}
}

function endToto()
{
	if (confirm("입력하신 내역으로 토토를 처리하시겠습니까?")) {
		var resultString = confirmMarking();
		if (resultString) {
			var query = "mode=endToto";
			query += "&resultString=" + resultString;
			query += "&id=<%=toto.getId()%>";
	
			var http = new JKL.ParseXML("adminToto.aspx", query);
			var result = http.parse();
	
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.replace("adminToto.aspx?mode=viewReprocessToto&id=<%=toto.getId()%>");
			}
		}
	}
}

function cancelToto()
{
	if (confirm("토토를 취소하시겠습니까?")) {
		var query = "mode=cancelToto";
		query += "&id=<%=toto.getId()%>";

		var http = new JKL.ParseXML("adminToto.aspx", query);
		var result = http.parse();

		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.replace("adminToto.aspx?mode=viewReprocessToto&id=<%=toto.getId()%>");
		}
	}
}

function cancelBetToto(id)
{
	if (confirm("구매를 취소하시겠습니까?")) {
		var query = "mode=cancelBetToto";
		query += "&id=" + id;

		var http = new JKL.ParseXML("adminToto.aspx", query);
		var result = http.parse();

		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}
}


function confirmMarking()
{
	var markId = [];
	for (var i = 0 ; i < colNum ; i++) {
		for (var j = 0 ; j < 4 ; j++) {
			var name = i + spot[j];
			var cobjList = document.getElementsByName(name);
			var flag = false;
			for (var x = 0 ; x < cobjList.length ; x++) {
				flag |= cobjList[x].checked;
				if (cobjList[x].checked)
					markId.push(cobjList[x].id);
			}
			if (flag == false) {
				alert("선택되지 않은 항목이 있습니다");
				return;
			}
		}
	}

	var markString = markId.join("-");
	return markString;
}

function checkToto(cobj)
{
	var cobjList = document.getElementsByName(cobj.name);
	if (cobj.checked) {
		for (var i = 0 ; i < cobjList.length ; i++) {
			if (cobjList[i] != cobj)
				cobjList[i].checked = false;
		}
	}
}

loadCard('<%=toto.getCardString()%>');

function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>