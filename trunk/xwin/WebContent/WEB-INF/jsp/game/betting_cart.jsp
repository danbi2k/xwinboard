<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%
	BettingCart bettingCart = (BettingCart) request.getAttribute("bettingCart");
	List<GameFolder> gameFolderList = bettingCart.getGameFolderList();
%>
<%@include file="../header.jsp"%>

<form name="frm" action="bettingCart.aspx">
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">

<table width="900" style="border-bottom:1 solid #909090;">
<tr>
	<td width="100"><img src="images/title_mybet.gif"></td>
	<td>배팅카트 입니다.</td>
</tr>
</table>
</td><tr>
<tr><td valign="top" align="center">
<table border="0" cellpadding="0" cellspacing="0" width="900">

<%
	if (bettingCart != null) {
		int folderCount = 0;
		for (GameFolder gameFolder : gameFolderList) {
%>

<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tbody><tr>
					<td>
						<table bgcolor="#424142" border="0" cellpadding="0" cellspacing="1" width="100%">
							<tbody><tr bgcolor="#212021" height="27">
								<td><font color="#ffffff"><b><nobr>선택</nobr></b></font></td>
								<td align="center" width="120"><font color="#ffffff"><b><nobr>경기날짜</nobr></b></font></td>
								<td align="center" width="300"><font color="#ffffff"><b><nobr>(승)홈 팀</nobr></b></font></td>
								<td align="center" width="85"><font color="#ffffff"><b><nobr>무/핸디캡</nobr></b></font></td>
								
								<td align="center" width="300"><font color="#ffffff"><b><nobr>(패)원정팀</nobr></b></font></td>
								<td align="center" width="60"><font color="#ffffff"><b><nobr>배팅팀</nobr></b></font></td>
								<td align="center" width="80"><font color="#ffffff"><b><nobr>삭제</nobr></b></font></td>								
							</tr>
							
<%
	List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
	if (itemList != null) {
		int itemCount = itemList.size();
		int count = 0;
		for (GameFolderItem folderItem : itemList) {
%>
							<tr bgcolor="#000000" height="25">
								<%
								if (count == 0) {
								%>
								<td align="center" rowspan="<%=itemCount%>">
									<input type="checkbox" name="cartCheck" onclick="calcTotalMoney()" money="<%=gameFolder.getMoney()%>"/>
								</td>
								<%
								}
								%>
								<td align="center"><nobr><font color="#ffffff"><%=folderItem.getGameDateStr()%></font></nobr></td>
								<td align="right"><nobr>
									<font color="#ffffff">
										<%=folderItem.getHomeTeam()%>&nbsp;<%=folderItem.getWinRateStr()%>&nbsp;
									</font>
									</nobr></td>
								<td align="center"><nobr>
									<font color="#ffffff"><%=folderItem.getType().equals("wdl")?"무 " + folderItem.getDrawRateStr():"핸디 " + (folderItem.getDrawRate()>0?"+":"") + folderItem.getDrawRate()%>
								</font></nobr></td>
								
								<td><nobr>&nbsp;
									<font color="#ffffff">
										<%=folderItem.getLoseRateStr()%>&nbsp;<%=folderItem.getAwayTeam()%>
									</font></nobr></td>
								<td align="center"><nobr><font color="#ffffff"><%=Code.getValue(folderItem.getGuess())%></font></nobr></td>
								<%
								if (count == 0) {
								%>
								<td align="center" rowspan="<%=itemCount%>">
									<img src="images/btn_coment_del.gif" onclick="deleteGameFolder(<%=folderCount++%>)">
								</td>
								<%
								count++;
								}
								%>
								
							</tr>
<%
		}	
	}		
%>				
					
						</tbody></table>		
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr>
					<td align="center">배당율 : <%=gameFolder.getRateStr()%> / 배팅금액 : <%=XwinUtil.comma3(gameFolder.getMoney())%>원 / 예상적중금액 : <%=XwinUtil.comma3(gameFolder.getExpect())%>원
					</td>
				</tr>
				</tbody></table>
			</td>
		</tr>
	<tr><td height="10"></td>
	</tr>

<%			
		}
	}
%>
</table>
<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
	<tr>
		<td bgcolor=000000>
			<table border=0 width=100% cellpadding=6 cellspacing=2 >
				<tr>
					<td align=center>
						<img src=images/sub03.gif onclick="deleteAllGameFolder()" style="cursor:pointer" align=absmiddle>&nbsp;
						선택 한 카트 배팅 금액 : <input type=text id="totalMoney" name="totalMoney" size="10" readonly="readonly" value="0">
						<img src=images/btn_bat.gif onclick="betting()" style="cursor:pointer;" align=absmiddle>
					</td>
				</tr>
				</form>
			</table>
		</td>
	</tr>
</table>
</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
</table>
<script>
function deleteGameFolder(id)
{
	if (confirm("배팅카트에서 삭제하시겠습니까?")) {
		var query = "mode=deleteGameFolder";
		query += "&folderIndex=" + id;
		var http = new JKL.ParseXML("bettingCart.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}

function deleteAllGameFolder(id)
{
	if (confirm("전체 삭제하시겠습니까?")) {
		var query = "mode=deleteAllGameFolder";
		var http = new JKL.ParseXML("bettingCart.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}

function calcTotalMoney()
{
	var cartCheck = document.getElementsByName("cartCheck");
	var totalMoney = document.getElementById("totalMoney");
	var sum = 0;
	for (var i = 0 ; i < cartCheck.length ; i++) {
		if (cartCheck[i].checked) {
			sum += Number(cartCheck[i].money);
		}
	}
	totalMoney.value = Xwin.Currency(sum);
}

function betting()
{
	if (confirm("배팅하시겠습니까?")) {
		var cartCheck = document.getElementsByName("cartCheck");
		var count = 0;
		var query = "mode=betting"
		for (var i = 0 ; i < cartCheck.length ; i++) {
			if (cartCheck[i].checked) {
				query += "&folderIndex=" + i;
				count++;
			}
		}

		if (count == 0) {
			alert("선택된 배팅이 없습니다");
			return;
		}

		var http = new JKL.ParseXML("bettingCart.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}
</script>
<%@include file="../footer.jsp"%>