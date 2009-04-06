<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../header.jsp"%>

<%
	Toto toto = (Toto) request.getAttribute("toto");
	Long totalMoney = (Long) request.getAttribute("totalMoney");
	Integer totalCount = (Integer) request.getAttribute("totalCount");
	Integer colNum = null, rowNum = null;
	if (toto != null) {
		colNum= toto.getColNum();
		rowNum = toto.getRowNum();
	}
%>

<tr>
	<td><img src="img/menu18.jpg" border="0"></td>
</tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="33">
		 <tr>
        <td width="771" height="33" align="left" valign="top">
            <p><img src="img/toto_1.jpg" border="0">&nbsp;<a href="myBet.aspx?mode=viewMyTotoList"><img src="img/toto__2.jpg" border="0"></a></p>
        </td>
    </tr>
</table>

<table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
  <tr>
     <td width="680" background="img/minit_02.jpg" valign="top" style="padding:20">
<%if (toto != null) { %>     
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
			            <p><%=toto.getTitle()%></p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="25">
			            <p>총발매금액</p>
			        </td>
			        <td width="200" height="25">
			            <p><%=XwinUtil.comma3(totalMoney)%> 원</p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="25">
			            <p>전체발매수</p>
			        </td>
			        <td width="200" height="25">
			            <p><%=totalCount%> 개</p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="25">
			            <p>발매기간</p>
			        </td>
			        <td width="200" height="25">
			            <p><%=XwinUtil.getBoardItemDate(toto.getGameDate())%> 까지</p>
			        </td>
			    </tr>
			</table>
        </td>
    </tr>
  </table>
 </div>
<BR><BR><BR>
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
	<td align="center" class="totoBody left"><input type="checkbox" id="<%=j%>A<%=i%>" name="<%=j%>A" onclick="checkToto(this)"/></td>
	<td align="center" class="totoBody mid"><span id="C<%=j%>L<%=i%>" name="C<%=j%>L<%=i%>"/></span></td>
	<td align="center" class="totoBody right"><input type="checkbox" id="<%=j%>B<%=i%>" name="<%=j%>B" onclick="checkToto(this)"/></td>
	<td align="center" class="totoBody left"><input type="checkbox" id="<%=j%>C<%=i%>" name="<%=j%>C" onclick="checkToto(this)"/></td>
	<td align="center" class="totoBody mid"><span id="C<%=j%>R<%=i%>" name="C<%=j%>R<%=i%>"/></span></td>
	<td align="center" class="totoBody right"><input type="checkbox" id="<%=j%>D<%=i%>" name="<%=j%>D" onclick="checkToto(this)"/></td>
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
			            <p><input id='moneyDiv' name="m_id" type="text" class="input3" id="11" value='<%=XwinUtil.comma3(toto.getMinMoney())%>' onkeyup="only123(this); comma3Input(this);"></p>
			        </td>
			        <td width="70" height="30">
			            <p>&nbsp;<img src="img/totobutton1.jpg" border="0" onclick="betting()"/></p>
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
			            <p>&nbsp;<img src="img/totobutton2.jpg" border="0" onclick="calcRate()"</p>
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
<%} else { %>
진행중인 토토가 없습니다
<%} %>
        </td>
    </tr>
</table>

<script>

var spot = [];
spot[0] = "A";
spot[1] = "B";
spot[2] = "C";
spot[3] = "D";

<%if (toto != null) {%>
var colNum = <%=toto.getColNum()%>;
var rowNum = <%=toto.getRowNum()%>;
function betting()
{
	var markingString = confirmMarking();
	if (markingString) {
		var money = document.getElementById("moneyDiv").value;
		if (!money) {
			money = 0;
		} else {
			var regexp= RegExp(/,/ig);
			money = money.replace(regexp, "");
		}
		
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

function calcRate()
{
	var markingString = confirmMarking();
	if (markingString) {
		var money = document.getElementById("moneyDiv").value;
		if (!money) {
			money = 0;
		} else {
			var regexp= RegExp(/,/ig);
			money = money.replace(regexp, "");
		}
		
		var query = "mode=calcRate";
		query += "&markingString=" + markingString;
		query += "&totoId=<%=toto.getId()%>";
		query += "&money=" + money;

		var http = new JKL.ParseXML("toto.aspx", query);
		var result = http.parse();

		//alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			var rateDiv = document.getElementById("rateDiv");
			rateDiv.innerHTML = result.resultXml.message;
		}
	}	
}

loadCard('<%=toto.getCardString()%>');
<%}%>
</script>

<%@include file="../footer.jsp"%>