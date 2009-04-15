<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../header.jsp"%>

<%
	Toto toto = (Toto) request.getAttribute("toto");
	BetToto betToto = (BetToto) request.getAttribute("betToto");
	String rateString = (String) request.getAttribute("rateString");
	List<BetToto> successList = (List<BetToto>) request.getAttribute("successList");
	
	Integer colNum = betToto.getColNum(), rowNum = betToto.getRowNum();
%>

<tr>
	<td><img src="img/menu18.jpg" border="0"></td>
</tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="33">
	 <tr>
        <td width="771" height="33" align="left" valign="top">
            <p><a href="toto.aspx?mode=viewToto"><img src="img/toto_2.jpg" border="0"></a>&nbsp;<img src="img/toto__1.jpg" border="0"></p>
        </td>
    </tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
  <tr>
     <td width="680" background="img/minit_02.jpg" valign="top" style="padding:20">
<!-- -->
 <div>
  <table cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td width="100%">
		   <table width="100%">
			    <tr>
			        <td class="totoLeft" height="25">
			            <p>회차</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=betToto.getTitle()%></p>
			        </td>
			        <td class="totoLeft" height="25">
			            <p>마감시각</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=XwinUtil.getBoardItemDate(betToto.getGameDate())%></p>
			        </td>
			    </tr>
			    <tr>
			        <td class="totoLeft" height="25">
			            <p>이월잔액</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=XwinUtil.comma3(betToto.getCarryOver())%></p>
			        </td>
			        <td class="totoLeft" height="25">
			            <p>총발매금액</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=XwinUtil.comma3(XwinUtil.ntz(toto.getTotalMoney()) + XwinUtil.ntz(toto.getEarnMoney()))%>원</p>
			        </td>
			    </tr>
			    <tr>
			        <td class="totoLeft" height="25">
			            <p>전체투표수</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=XwinUtil.comma3(toto.getTotalCount())%></p>
			        </td>
			        <td class="totoLeft" height="25">
			            <p>구매일</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=XwinUtil.getBoardItemDate(betToto.getDate())%></p>
			        </td>
			    </tr>
			    <tr>
			        <td class="totoLeft" height="25">
			            <p>구매금액</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=XwinUtil.comma3(betToto.getMoney())%> 원</p>
			        </td>
			        <td class="totoLeft" height="25">
			            <p>당첨여부</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=Code.getValue(betToto.getRunStatus())%></p>
			        </td>
			    </tr>
			    <tr>
			        <td class="totoLeft" height="25">
			            <p>배당</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=betToto.getRunStatus().equals(Code.BET_STATUS_RUN)?rateString:betToto.getRate()%> 배</p>
			        </td>
			        <td class="totoLeft" height="25">
			            <p>당첨금</p>
			        </td>
			        <td class="totoRight" height="25">
			            <p><%=XwinUtil.comma3(betToto.getExpect())%> 원</p>
			        </td>
			    </tr>
			</table>
        </td>
    </tr>
  </table>
 </div>
<BR><BR>
<table cellpadding="0" cellspacing="0" width="100%">
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
<BR><BR>
<%
if (toto.getStatus().equals(Code.GAME_STATUS_END)) {
%>
<table align="center" cellpadding="0" cellspacing="0" width="650"
	height="40" background="img/bar-.jpg">
	<tr>
		<td width="250" height="40" align="center" valign="middle"
			class="menubar">
		<p>닉네임</p>
		</td>
		<td width="200" height="40" align="center" valign="middle"
			class="menubar">
		<p>구매액</p>
		</td>
		<td width="200" height="40" align="center" valign="middle"
			class="menubar">
		<p>당첨액</p>
		</td>
	</tr>
</table>
<%} %>
<table align="center" width="650">
<%
if (toto.getStatus().equals(Code.GAME_STATUS_END)) {
	if (successList != null) {
		for (BetToto successToto : successList) {
%>
			    <tr>
			        <td class="tablebg1" height="25" width="250" align="center">
			            <p><%=successToto.getNickName()%></p>
			        </td>
			        <td class="tablebg2" height="25" width="200" align="center">
			            <p><%=XwinUtil.comma3(successToto.getMoney())%></p>
			        </td>
					<td class="tablebg1" height="25" width="200" align="center">
						<p><%=XwinUtil.comma3(successToto.getExpect())%></p>
					</td>
			    </tr>
<%			
		}
	} else {
%>
		<tr>
			<td class="tablebg1" heigh="25" width="650" calspan="3" align="center">
				<p>당첨자가 없습니다.</p>
			</td>
		</tr>		
<%
	}
}
%>
			</table>
        </td>
    </tr>
</table>

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
</script>

<%@include file="../footer.jsp"%>