<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.xwin.web.controller.admin.AdminGameController"%>
<%
	BetToto betToto = (BetToto) request.getAttribute("betToto");
	
	Integer colNum = betToto.getColNum(), rowNum = betToto.getRowNum();
%>

<%@ include file="../admin_header.jsp"%>

<div class="title">토토 구매 내역</div>
<table cellpadding="0" cellspacing="0" width="100%" class="prettytable">
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
	<td align="center"><img src="img/check_blank.gif" id="<%=j%>A<%=i%>" name="<%=j%>A"/></td>
	<td align="center"><span id="C<%=j%>L<%=i%>" name="C<%=j%>L<%=i%>"/></span></td>
	<td align="center"><img src="img/check_blank.gif" id="<%=j%>B<%=i%>" name="<%=j%>B"/></td>
	<td align="center"><img src="img/check_blank.gif" id="<%=j%>C<%=i%>" name="<%=j%>C"/></td>
	<td align="center"><span id="C<%=j%>R<%=i%>" name="C<%=j%>R<%=i%>"/></span></td>
	<td align="center"><img src="img/check_blank.gif" id="<%=j%>D<%=i%>" name="<%=j%>D"/></td>
<%		
		}
%>
</tr>
<%
	}
%>
</table>
<ul>
<li>구매일 : <%=XwinUtil.getBoardItemDate(betToto.getDate())%></li>
<li>구매액 : <%=XwinUtil.comma3(betToto.getMoney())%></li>
<li>상태 : <%=Code.getValue(betToto.getRunStatus())%></li>
<li>배당율 : <%=XwinUtil.nvl(betToto.getRate())%></li>
<li>당첨금 : <%=XwinUtil.comma3(betToto.getExpect())%></li>

</ul>
<script>
var spot = [];
spot[0] = "A";
spot[1] = "B";
spot[2] = "C";
spot[3] = "D";

var colNum = <%=betToto.getColNum()%>;
var rowNum = <%=betToto.getRowNum()%>;

function betting()
{
	var markingString = confirmMarking();
	if (markingString) {
		var money = document.getElementById("moneyDiv").value;
		var regexp= RegExp(/,/ig);
		money = money.replace(regexp, "");
		
		var query = "mode=betting";
		query += "&markingString=" + markingString;
		query += "&totoId=<%=betToto.getId()%>";
		query += "&money=" + money;

		var http = new JKL.ParseXML("toto.aspx", query);
		var result = http.parse();

		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}	
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

function confirmMarking()
{
	var markingId = [];
	for (var i = 0 ; i < colNum ; i++) {
		for (var j = 0 ; j < 4 ; j++) {
			var name = i + spot[j];
			var cobjList = document.getElementsByName(name);
			var flag = false;
			for (var x = 0 ; x < cobjList.length ; x++) {
				flag |= cobjList[x].checked;
				if (cobjList[x].checked)
					markingId.push(cobjList[x].id);
			}
			if (flag == false) {
				alert("선택되지 않은 항목이 있습니다");
				return false;
			}
		}
	}

	var markingString = markingId.join("-");
	//_debug.innerHTML = markString;
	return markingString;
}

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
		if (iobj.src.indexOf("img/check_check.gif") >= 0)
			iobj.src = "img/check_check_red.gif";
		else
			iobj.src = "img/check_blank_red.gif";
	}
}

loadCard('<%=betToto.getCardString()%>');
loadMarking('<%=betToto.getMarkingString()%>');
<%if (betToto.getResultString() != null) {%>
loadResult('<%=betToto.getResultString()%>');
<%}%>

function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>
<%@ include file="../admin_footer.jsp"%>