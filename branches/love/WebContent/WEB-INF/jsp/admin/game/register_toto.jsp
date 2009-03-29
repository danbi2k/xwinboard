<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>
<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");

	String _colNum = request.getParameter("colNum");
	String _rowNum = request.getParameter("rowNum");
	
	Integer colNum = 0, rowNum = 0;
	if (_colNum != null)
		colNum = Integer.parseInt(_colNum);
	if (_rowNum != null)
		rowNum = Integer.parseInt(_rowNum);
%>
<SCRIPT LANGUAGE="JavaScript">

</SCRIPT>
<div class="title">토토 등록</div>

※ 입력란에 update, select, delete, create, alter 라는 문자열은 사용하지 마세요

<form>
<input type="hidden" name="mode" value="viewRegisterTotoForm"/>
<select name="colNum">
	<option value="1" <%=colNum==1?"selected":""%>>1경기</option>
	<option value="2" <%=colNum==2?"selected":""%>>2경기</option>
	<option value="3" <%=colNum==3?"selected":""%>>3경기</option>
</select>
<input type="text" name="rowNum" size="2" value="<%=rowNum%>"/>줄
<input type="submit" value="토토폼생성"/>
</form>

<form name="totoFrm" action="adminToto.aspx" method="post">
<input type="hidden" name="mode" value="registerToto"/>
<input type="hidden" name="rowNum" value="<%=rowNum%>"/>
<input type="hidden" name="colNum" value="<%=colNum%>"/>
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
			<input type="text" size="80" name="title" id="title"/>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">마감시각</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type='text' name='gameDate' size=10 readonly onClick="popUpCalendar(this,gameDate,'yyyy-mm-dd');" style="cursor:hand">
			<select name='gameHour'>
			<%
				for (int i = 0 ; i < 24 ; i++) {
					String hour = "" + i;
			%>
				<option value='<%=hour%>'><%=XwinUtil.Int2Digit(i)%></option>
			<%
				}
			%>
			</select>
			시
			<select name='gameMinute'>
			<%
				for (int i = 0 ; i < 60 ; i+=5) {
					String minute = "" + i;
			%>
				<option value='<%=minute%>'><%=XwinUtil.Int2Digit(i)%></option>
			<%
				}
			%>
			</select>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">수익비율</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type="text" size="10" name="earnRate" id="earnRate"/>%
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">최소구매액</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type="text" size="10" name="minMoney" id="minMoney" value="2000"/>원
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">이월잔액</td>
		<td bgcolor="#FFFFFF"  colspan=3>
			<input type="text" size="10" name="carryOver" id="carryOver" value="0"/>원
		</td>
	</tr>
</table>
<table class="toto">
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
	<td align="center"><input type="checkbox" id="<%=j%>A<%=i%>" name="<%=j%>A" onclick="checkToto(this)" disabled/></td>
	<td align="center"><input type="text" size="8" id="C<%=j%>L<%=i%>" name="C<%=j%>L<%=i%>"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>B<%=i%>" name="<%=j%>B" onclick="checkToto(this)" disabled/></td>
	<td align="center"><input type="checkbox" id="<%=j%>C<%=i%>" name="<%=j%>C" onclick="checkToto(this)" disabled/></td>
	<td align="center"><input type="text" size="8" id="C<%=j%>R<%=i%>" name="C<%=j%>R<%=i%>"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>D<%=i%>" name="<%=j%>D" onclick="checkToto(this)" disabled/></td>
<%		
		}
%>
</tr>
<%
	}
%>
</table>
<input type="button" value="저장" onclick="submitTotoForm()"/>
<input type="button" value="샘플폼로드" onclick="loadForm('T1L=금호생명|T0R=SKT|I2R=최종(연장포함)|T0L=KTF|I2L=전반(1+2)|I1R=최종(연장포함)|I1L=전반(1+2)|I0R=최종(연장포함)|I0L=전반(1+2)|C2L9=48~51|C2L8=44~47|C2L7=40~43|C2L6=36~39|C2L5=32~35|C2R9=88~91|C2L4=28~31|C1L9=48~51|C2R8=84~87|C2L3=24~27|C1L8=44~47|C2L2=20~23|C2R7=80~83|C1L7=40~43|C2L1=16~19|C2R6=76~79|C1L6=36~39|C2L0=12~15|C2R5=72~75|C1L5=32~35|C2R4=68~71|C1R9=88~91|C1L4=28~31|C2R3=64~67|C0L9=48~51|C1L3=24~27|C1R8=84~87|C2R2=60~63|C0L8=44~47|C1L2=20~23|C1R7=80~83|C2R1=56~59|C0L7=40~43|C1L1=16~19|C1R6=76~79|C2R0=52~55|C0L6=36~39|C1L0=12~15|C1R5=72~75|C0L5=32~35|C1R4=68~71|C0R9=88~91|C0L4=28~31|C1R3=64~67|C0L3=24~27|C0R8=84~87|C1R2=60~63|C0L2=20~23|C0R7=80~83|C1R1=56~59|C0L1=16~19|C0R6=76~79|C1R0=52~55|C0L0=12~15|C0R5=72~75|C0R4=68~71|C0R3=64~67|C0R2=60~63|C0R1=56~59|C0R0=52~55|T2R=두산|T2L=롯데|T1R=신한생명|')"/>
<!-- 
<input type="button" value="마킹검사" onclick="confirmMarking()"/>
<input type="button" value="마킹로드" onclick="loadMarking('0A3-0B0-0C0-0D0-1A5-1B4-1C7-1D3-2A3-2B2-2C2-2D7')"/>
 -->
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
</script>
<div id="_debug"></div>
<%@ include file="../admin_footer.jsp"%>
