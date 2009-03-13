<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%
	BettingCart bettingCart = (BettingCart) request.getAttribute("bettingCart");
	List<GameFolder> gameFolderList = bettingCart.getGameFolderList();
%>
<%@include file="../header.jsp"%>

		<div class='sub_ti1'>
		<img src='img/sub_cartlist_ti.gif' alt='배팅내역' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 배팅 카트 입니다.</div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href=''>배팅내역보기</a></span -->
			</div>
		</div>	
		<div class='sub_ti_bar'></div>
		</div>

		<div id='sub_content1'>
			<div class='cart_list'>
<%
	if (bettingCart != null) {
		int folderCount = 0;
		for (GameFolder gameFolder : gameFolderList) {
%>
				
				<div class='list_box'>
					<img src='img/sub_betlist_del_bt.gif' alt='삭제' class='img_bt ml5' onclick="deleteGameFolder(<%=folderCount%>)"> 배당율 : <span><%=gameFolder.getRateStr()%></span> / 배팅금액 : <span><%=XwinUtil.comma3(gameFolder.getMoney())%></span> / 예상적중금액 : <span><%=XwinUtil.comma3(gameFolder.getExpect())%></span>
					<table>
						<tr>
							<th class='t0'>선택</th>
							<th class='t1'>배팅일시</th>
							<th class='t2'>(승) 홈팀</th>
							<th class='t3'>무/핸디캡</th>
							<th class='t4'>(패) 원정팀</th>
							<th class='t5'>배팅팀</th>
						</tr>
<%
	List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
	if (itemList != null) {
		int itemCount = itemList.size();
		int count = 0;
		for (GameFolderItem folderItem : itemList) {
%>
						<tr>
							<%
							if (count == 0) {
							%>
							<td rowspan=<%=itemCount%>><input type='checkbox' class='input_check' name='cartCheck' onclick="calcTotalMoney()" money="<%=gameFolder.getMoney()%>"></td>
							<%
							count++;
							}
							%>
							<td><%=XwinUtil.getBoardItemDate(folderItem.getGameDate())%></td>
							<td><%=folderItem.getHomeTeam()%>&nbsp;<%=folderItem.getWinRateStr()%></td>
							<td><%=folderItem.getType().equals("wdl")?"무 " + folderItem.getDrawRateStr():"핸디 " + (folderItem.getDrawRate()>0?"+":"") + folderItem.getDrawRate()%></td>
							<td><%=folderItem.getLoseRateStr()%>&nbsp;<%=folderItem.getAwayTeam()%></td>
							<td><%=Code.getValue(folderItem.getGuess())%><img src='img/sub_cartlist_sdel_bt.gif' alt='삭제' class='img_bt ml5' onclick="deleteGameInGameFolder(<%=folderCount%>, <%=folderItem.getId()%>)"></td>
						</tr>
<%
		}
	}
%>
					</table>
				</div>
<%			
		}
	}
%>
				
				<div class='bet_box'>
				<table>
				<tr>
				<td><img src='img/sub_alldel_bt.gif' alt='전체삭제' onclick="deleteAllGameFolder()"></td>
				<td>선택한 카트 배팅금액 :<input type='text' class='input_text w100' id="totalMoney" value="0" readonly></td>
				<td><img src='img/sub_cartlist_bet_bt.gif' alt='배팅하기' onclick="betting()"></td>
				</table>
				</div>
				


			</div>
			<!-- end bet_list -->
		</div>
		<!-- sub_content1 -->

<script>
function deleteGameInGameFolder(index, gameId)
{
	if (confirm("경기를 삭제하시겠습니까?")) {
		var query = "mode=deleteGameInGameFolder";
		query += "&folderIndex=" + index;
		query += "&gameId=" + gameId;
		var http = new JKL.ParseXML("cart.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}

function deleteGameFolder(id)
{
	if (confirm("배팅카트에서 삭제하시겠습니까?")) {
		var query = "mode=deleteGameFolder";
		query += "&folderIndex=" + id;
		var http = new JKL.ParseXML("cart.php", query);
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
		var http = new JKL.ParseXML("cart.php", query);
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

		var http = new JKL.ParseXML("cart.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}
</script>
<%@include file="../footer.jsp"%>