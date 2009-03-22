<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../header.jsp"%>

<%
	Toto toto = (Toto) request.getAttribute("toto");

	String _colNum = request.getParameter("colNum");
	String _rowNum = request.getParameter("rowNum");
	
	Integer colNum = toto.getColNum(), rowNum = toto.getRowNum();
%>

<tr>
	<td><img src="img/menu11.jpg" border="0"></td>
</tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="33">
	<tr>
		<td width="771" height="33" align="left" valign="top">
		<p>
			<span style="background-color:AA0055">토토구매</span>&nbsp;
			<a href="myBet.aspx?mode=viewMyTotoList"><span style="background-color:000000">구매내역</span></a></p>
		</td>
	</tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
  <tr>
     <td width="680" background="img/minit_02.jpg" valign="top" style="padding:20">
<!-- -->
 <div>
  <table cellpadding="0" cellspacing="0" width="369">
    <tr>
        <td width="469">
		   <table cellpadding="0" cellspacing="0" width="300" border="0">
			    <tr>
			        <td width="100" height="25">
			            <p>회차</p>
			        </td>
			        <td width="200" height="25">
			            <p>농구토토 11회차</p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="25">
			            <p>총발매금액</p>
			        </td>
			        <td width="200" height="25">
			            <p>100원</p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="25">
			            <p>전체투표수</p>
			        </td>
			        <td width="200" height="25">
			            <p>100</p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="25">
			            <p>발매기간</p>
			        </td>
			        <td width="200" height="25">
			            <p>2009-03-10 까지</p>
			        </td>
			    </tr>
			</table>
        </td>
    </tr>
  </table>
 </div>
<BR><BR><BR>
<table width="100%">
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

<BR><BR><BR>

 <div align="center">
  <table align="center" cellpadding="0" cellspacing="0" width="469">
    <tr>
        <td width="469">
		   <table cellpadding="0" cellspacing="0" width="469" height="90" border="0">
			    <tr>
			        <td width="100" height="30">
			            <p>구매금액</p>
			        </td>
			        <td width="299" height="30">
			            <p><input id='moneyDiv' name="m_id" type="text" class="input3" id="11" value='5,000' onkeyup='FnCalcFolder()'></p>
			        </td>
			        <td width="70" height="30">
			            <p>&nbsp;<input type="button" value="구매" style="background-color:AA0055" onclick="betting()"/></p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="30">
			            <p>예상배당율</p>
			        </td>
			        <td width="299" height="30">
			            <p id='rateDiv'>0.00</p>
			        </td>
			        <td width="70" height="30">
			            <p>&nbsp;<input type="button" onclick="" value="예상배당률계산" style="background-color:AA0055"/></p>
			        </td>
			    </tr>
			    <tr>
			        <td colspan="3">
			        ※ 최소 구매 가능 금액은 <%=XwinUtil.comma3(toto.getMinMoney())%>원 입니다. <br>
			        ※배당률은 실시간으로 변합니다. 배팅시 예상배당률과 배팅후배당률은 다를수 있습니다.
			        </td>
			    </tr>
			</table>
        </td>
    </tr>
  </table>
 </div>
<!-- -->
        </td>
    </tr>
</table>

<script>

var spot = [];
spot[0] = "A";
spot[1] = "B";
spot[2] = "C";
spot[3] = "D";

var colNum = <%=toto.getColNum()%>;
var rowNum = <%=toto.getRowNum()%>;

function betting()
{
	var markingString = confirmMarking();
	if (markingString) {
		var money = document.getElementById("moneyDiv").value;
		var regexp= RegExp(/,/ig);
		money = money.replace(regexp, "");
		
		var query = "mode=betting";
		query += "&markingString=" + markingString;
		query += "&totoId=<%=toto.getId()%>";
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
		var cobj = document.getElementById(markId[i]);
		cobj.checked = true;
	}
}

loadCard('T1L=금호생명|T0R=SKT|I2R=최종(연장포함)|T0L=KTF|I2L=전반(1+2)|I1R=최종(연장포함)|I1L=전반(1+2)|I0R=최종(연장포함)|I0L=전반(1+2)|C2L9=48~51|C2L8=44~47|C2L7=40~43|C2L6=36~39|C2L5=32~35|C2R9=88~91|C2L4=28~31|C1L9=48~51|C2R8=84~87|C2L3=24~27|C1L8=44~47|C2L2=20~23|C2R7=80~83|C1L7=40~43|C2L1=16~19|C2R6=76~79|C1L6=36~39|C2L0=12~15|C2R5=72~75|C1L5=32~35|C2R4=68~71|C1R9=88~91|C1L4=28~31|C2R3=64~67|C0L9=48~51|C1L3=24~27|C1R8=84~87|C2R2=60~63|C0L8=44~47|C1L2=20~23|C1R7=80~83|C2R1=56~59|C0L7=40~43|C1L1=16~19|C1R6=76~79|C2R0=52~55|C0L6=36~39|C1L0=12~15|C1R5=72~75|C0L5=32~35|C1R4=68~71|C0R9=88~91|C0L4=28~31|C1R3=64~67|C0L3=24~27|C0R8=84~87|C1R2=60~63|C0L2=20~23|C0R7=80~83|C1R1=56~59|C0L1=16~19|C0R6=76~79|C1R0=52~55|C0L0=12~15|C0R5=72~75|C0R4=68~71|C0R3=64~67|C0R2=60~63|C0R1=56~59|C0R0=52~55|T2R=두산|T2L=롯데|T1R=신한생명|');
loadMarking('0A3-0B0-0C0-0D0-1A5-1B4-1C7-1D3-2A3-2B2-2C2-2D7');
</script>

<%@include file="../footer.jsp"%>