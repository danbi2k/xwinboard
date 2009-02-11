if ( typeof(AdminBet) == 'undefined' ) AdminBet = function() {};

AdminBet.GetBettingList = function()
{
	var query = "mode=getBettingList";
	var http = new JKL.ParseXML("adminBetting.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.betting);
		AdminBet.DrawBettingList(data);
	} else {
	}
}

AdminBet.DrawBettingList = function(data)
{
	var row = [];
	row.push("<table>");
	row.push("<thead>")
	row.push("<tr>")
	row.push("<th nowrap>번호</th>");
	row.push("<th nowrap>아이디</th>");
	row.push("<th nowrap>배팅시각</th>");
	row.push("<th nowrap>진행상태</th>");
	row.push("<th nowrap>배팅금액</th>");
	row.push("<th nowrap>배당율</th>");
	row.push("<th nowrap>배당금</th>");
	row.push("<th nowrap>상태</th>");
	row.push("<th nowrap>자세히</th>");
	row.push("</tr>")
	row.push("</thead>");
	for (var i in data) {
		row.push("<tr>");
		row.push("<td>" + data[i].id + "</td>");
		row.push("<td>" + data[i].userId + "</td>");
		row.push("<td>" + data[i].dateStr + "</td>");
		row.push("<td>" + "상태" + "</td>");
		row.push("<td>" + data[i].money + "</td>");
		row.push("<td>" + data[i].rate + "</td>");
		row.push("<td>" + data[i].expect + "</td>");
		row.push("<td>" + data[i].status + "</td>");
		row.push("<td><a onclick='AdminBet.BettingInfo(" + data[i].id + ")'>[ 자세히 ]</a></td>");
		row.push("</tr>");
	}
	row.push("</table>");
	var tableString = row.join("");
	var gameListDiv = document.getElementById("bettingListDiv");
	gameListDiv.innerHTML = tableString;	
}