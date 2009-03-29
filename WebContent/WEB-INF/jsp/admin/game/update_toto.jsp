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
<div class="title">토토 수정</div>

※ 입력란에 update, select, delete, create, alter 라는 문자열은 사용하지 마세요

<form name="totoFrm" action="adminToto.aspx" method="post">
<input type="hidden" name="mode" value="updateToto"/>
<input type="hidden" name="rowNum" value="<%=rowNum%>"/>
<input type="hidden" name="colNum" value="<%=colNum%>"/>
<input type="hidden" name="id" value="<%=toto.getId()%>"/>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">리그명</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<select name='leagueName'>
				<%
				if (leagueList != null) {
					for (League league : leagueList) {
						
				%>
				<option value='<%=league.getName()%>' > <%=league.getName()%> </option>
				<%
					}
				}
				%>
			</select>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">제목</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type="text" size="80" name="title" id="title" value="<%=toto.getTitle()%>"/>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">게임시간</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type='text' name='gameDate' size=10 readonly value='<%=XwinUtil.toDateStr(toto.getGameDate(), 2)%>' onClick="popUpCalendar(this,gameDate,'yyyy-mm-dd');" style="cursor:hand">
			<select name='gameHour'>
			<%
			String gameHour = XwinUtil.getHour(toto.getGameDate());
			for (int i = 0 ; i < 24 ; i++) {
				String hour = "" + i;
			%>
			<option value='<%=hour%>' <%=hour.equals(gameHour)?"selected":""%>><%=XwinUtil.Int2Digit(i)%></option>
			<%
			}
			%>
			</select>
			시
			<select name='gameMinute'>
			<%
			String gameMinute = XwinUtil.getMinute(toto.getGameDate());
			for (int i = 0 ; i < 60 ; i+=5) {
				String minute = "" + i;
			%>
			<option value='<%=minute%>' <%=minute.equals(gameMinute)?"selected":""%>><%=XwinUtil.Int2Digit(i)%></option>
			<%
			}
			%>
			</select>
		</td>
	</tr>		
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">수익비율</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type="text" size="10" name="earnRate" id="earnRate" value="<%=toto.getEarnRate()%>"/>%
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">최소구매액</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type="text" size="10" name="minMoney" id="minMoney" value="<%=toto.getMinMoney()%>"/>원
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">이월잔액</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type="text" size="10" name="carryOver" id="carryOver" value="<%=toto.getCarryOver()%>"/>원
		</td>
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
	<td align="center" colspan="2"><input type="text" size="10" id="T<%=j%>L" name="T<%=j%>L"/></td>
	<td align="center" colspan="2">VS</td>
	<td align="center" colspan="2"><input type="text" size="10" id="T<%=j%>R" name="T<%=j%>R"/></td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="3"><input type="text" size="14" id="I<%=j%>L" name="I<%=j%>L"/></td>
	<td align="center" colspan="3"><input type="text" size="14" id="I<%=j%>R" name="I<%=j%>R""/></td>
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
	<td align="center"><input type="text" size="8" id="C<%=j%>L<%=i%>" name="C<%=j%>L<%=i%>"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>B<%=i%>" name="<%=j%>B" onclick="checkToto(this)"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>C<%=i%>" name="<%=j%>C" onclick="checkToto(this)"/></td>
	<td align="center"><input type="text" size="8" id="C<%=j%>R<%=i%>" name="C<%=j%>R<%=i%>"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>D<%=i%>" name="<%=j%>D" onclick="checkToto(this)"/></td>
<%		
		}
%>
</tr>
<%
	}
%>
</table>
<input type="button" value="변경" onclick="submitTotoForm()"/>
<input type="button" value="결과처리" onclick="endToto()"/>
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
	_debug.innerHTML = markString;
	return markString;
}

function loadMarking(markString)
{
	var markId = markString.split("-");
	for (var i = 0 ; i < markId.length ; i++) {
		var cobj = document.getElementById(markId[i]);
		cobj.checked = true;
	}
}

function loadForm(formString)
{
	var formList = formString.split("|");
	for (var i = 0 ; i < formList.length ; i++) {
		var keyValue = formList[i].split("=");
		if (keyValue[0].length == 0)
			continue;
		var tobj = document.getElementById(keyValue[0]);
		if (tobj != null)	
			tobj.value = keyValue[1];
	}
}

function submitTotoForm()
{
	var frm = document.totoFrm;
	if (!frm.title.value) { alert("제목을 입력하세요"); return false;}
	if (!frm.gameDate.value) { alert("마감시각을 입력하세요"); return false;}
	if (!frm.earnRate.value) { alert("수익비율을 입력하세요"); return false;}
	if (!frm.minMoney.value) { alert("최소구매액을 입력하세요"); return false;}
	if (!frm.carryOver.value) { alert("이월잔액을 입력하세요"); return false;}
	if (frm.rowNum.value < 1) { alert("토토폼을 1줄 이상 생성하세요"); return false;}

	frm.submit();
}

function endToto()
{
	var resultString = confirmMarking();
	if (resultString) {
		var query = "mode=endToto";
		query += "&resultString=" + resultString;
		query += "&id=<%=toto.getId()%>";

		var http = new JKL.ParseXML("adminToto.aspx", query);
		var result = http.parse();

		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}	
}

var cardString = '<%=toto.getCardString()%>';
var resultString = '<%=toto.getResultString()%>';
loadForm(cardString);
loadMarking(resultString);
</script>
<div id="_debug"></div>
<%@ include file="../admin_footer.jsp"%>
