function FnGetMyBetList(pageIndex)
{
	var query = "mode=getMyBettingList";
	query += "&pageIndex=" + pageIndex;
	var http = new JKL.ParseXML("myBet.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.betting);
		FnDrawMyBetList(data);
	}
}

function FnDrawMyBetList(data)
{
	var row = [];
	row.push("<table width='900' bgcolor='#d9d8d6' cellspacing='1' cellpadding='3'>");
	row.push("<colgroup>");
	row.push("<col align='center' width='50'>");
	row.push("<col align='center' width='100'>");
	row.push("<col align='center'  width='*'>");
	row.push("<col align='right'  width='80'>");
	row.push("<col align='center' width='70'>");
	row.push("<col align='right'  width='80'>");
	row.push("<col align='center' width='70'>");
	row.push("<col align='center' width='70'>");
	row.push("</colgroup>");

	row.push("<tr bgcolor='#ce892c'>");
	row.push("<th style='color:white;'>No</td>");
	row.push("<th style='color:white;'>배팅일시</td>");
	row.push("<th style='color:white;'>진행상태</td>");
	row.push("<th style='color:white;' align='center' >배팅금액</td>");
	row.push("<th style='color:white;'>배당율</td>");
	row.push("<th style='color:white;' align='center' >배당금</td>");
	row.push("<th style='color:white;'>상태</td>");
	row.push("<th style='color:white;'>자세히</td>");
	row.push("</tr>");

	if (data.length > 0) {
		for (i in data) {
			row.push("<tr height='26' bgcolor='#0a0a0a' onmouseover=\"this.style.background='#303030';\" onmouseout=\"this.style.background='#0a0a0a';\">");
			row.push("<td>" + data[i].id + "</td>");
			row.push("<td>" + data[i].dateStr + "</td>");
			row.push("<td>");
			row.push("<table width='100%' height='24' cellpadding='0' cellspacing='3' bgcolor='black'>");
			row.push("<tr align='center'>");
			
			var betGame = Xwin.ToArray(data[i].betGameList.betGame);
			for (j in betGame) {
				var width = 100.0 / data[i].gameCount;
				if (betGame[j].status == 'GS001' || betGame[j].status == 'GS002' || betGame[j].status == 'GS003') {
					row.push("<td width='" + width + "%' bgcolor='gray' style='color:black' align='center'>-</td>");
				} else if (betGame[j].status == 'GS005') {
					row.push("<td width='" + width + "%' bgcolor='white' style='color:black' align='center'>-</td>");
				} else if (betGame[j].status == 'GS004') {
					if (betGame[j].result != undefined) {
						if (betGame[j].result == betGame[j].guess) {
							row.push("<td width='" + width + "%' bgcolor='green' style='color:black' align='center'>o</td>");
						} else {
							row.push("<td width='" + width + "%' bgcolor='red' style='color:black' align='center'>x</td>");
						}
					}
				}
			}			
			row.push("</tr>");
			row.push("</table>");
			row.push("</td>");
			row.push("<td>" + data[i].money + " 원</td>");
			row.push("<td>" + data[i].rateStr + "</td>");
			row.push("<td><font color='orange'>");
			var strike = (data[i].status == 'BS003' || data[i].status == 'BS004' || data[i].satus == 'BS005');
			if (strike)
				row.push("<STRIKE>");
			row.push(data[i].expect);
			if (strike)
				row.push("</STRIKE>");
			row.push(" 원</td>");
			row.push("<td><font color='orange'>" + C(data[i].status) + "</td>");
			row.push("<td><img src='images/btn_detail.gif' onclick='BetListView(" + data[i].id + ");' style='cursor:hand;filter:gray();' onmouseover='this.style.filter='';' onmouseout='this.style.filter='gray()';'></td>");
			row.push("</tr>");
		}
	} else {
		row.push("<tr bgcolor='#0a0a0a'><td colspan='10' height='50' align='center'>배팅 내역이 없습니다.</td></tr>");
	}
	
	row.push("</table>");
	
	var tableString = row.join("");
	var myBetListDiv = document.getElementById("myBetListDiv");
	
	myBetListDiv.innerHTML = tableString;
}