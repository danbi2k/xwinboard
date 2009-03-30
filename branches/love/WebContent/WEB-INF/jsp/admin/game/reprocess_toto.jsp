<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>
<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Toto toto = (Toto) request.getAttribute("toto");
	
	Integer colNum = toto.getColNum();
	Integer rowNum = toto.getRowNum();
%>
<SCRIPT LANGUAGE="JavaScript">

</SCRIPT>
<div class="title">토토 결과</div>

<form name="totoFrm" action="adminToto.aspx" method="post">
<input type="hidden" name="mode" value="updateToto"/>
<input type="hidden" name="rowNum" value="<%=rowNum%>"/>
<input type="hidden" name="colNum" value="<%=colNum%>"/>
<input type="hidden" name="id" value="<%=toto.getId()%>"/>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">제목</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getTitle()%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">리그명</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getLeagueName()%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">마감시각</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.getBoardItemDate(toto.getGameDate())%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">수익비율</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getEarnRate()%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">최소구매액</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getMinMoney())%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">이월잔액</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getCarryOver())%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">총판매액</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getLeagueName()%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">총발매수</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getTitle()%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">수익</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.getBoardItemDate(toto.getGameDate())%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">당첨금</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getEarnRate()%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">잔액</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getMinMoney())%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">잔액</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getCarryOver())%>
		</td>
	</tr>
</table>
<table class="toto">
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="6" class="totoHeader"><%=j+1%> 경기</td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="2" class="totoTeam"><span id="T<%=j%>L" name="T<%=j%>L"/></span></td>
	<td align="center" colspan="2" class="totoTeam">VS</td>
	<td align="center" colspan="2" class="totoTeam"><span id="T<%=j%>R" name="T<%=j%>R"/></span></td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="3" class="totoCategory"><span id="I<%=j%>L" name="I<%=j%>L"/></span></td>
	<td align="center" colspan="3" class="totoCategory"><span id="I<%=j%>R" name="I<%=j%>R""/></span></td>
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
	<td align="center" class="totoBody left"><img src="img/check_blank.gif" id="<%=j%>A<%=i%>" name="<%=j%>A"/></td>
	<td align="center" class="totoBody mid"><span id="C<%=j%>L<%=i%>" name="C<%=j%>L<%=i%>"/></span></td>
	<td align="center" class="totoBody right"><img src="img/check_blank.gif" id="<%=j%>B<%=i%>" name="<%=j%>B"/></td>
	<td align="center" class="totoBody left"><img src="img/check_blank.gif" id="<%=j%>C<%=i%>" name="<%=j%>C"/></td>
	<td align="center" class="totoBody mid"><span id="C<%=j%>R<%=i%>" name="C<%=j%>R<%=i%>"/></span></td>
	<td align="center" class="totoBody right"><img src="img/check_blank.gif" id="<%=j%>D<%=i%>" name="<%=j%>D"/></td>
<%		
		}
%>
</tr>
<%
	}
%>
</table>
</form>

<script>
var selected = [];
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

function loadMarking(markString)
{
	var markId = markString.split("-");
	for (var i = 0 ; i < markId.length ; i++) {
		var iobj = document.getElementById(markId[i]);
		iobj.src = "img/check_check.gif";
	}
}

function loadResult(resultString)
{
	var resultId = resultString.split("-");
	for (var i = 0 ; i < resultId.length ; i++) {
		var iobj = document.getElementById(resultId[i]);
		iobj.src = "img/check_check_red.gif";
	}
}

loadCard('<%=toto.getCardString()%>');
<%if (toto.getResultString() != null) {%>
loadResult('<%=toto.getResultString()%>');
<%}%>
</script>
<div id="_debug"></div>
<%@ include file="../admin_footer.jsp"%>
