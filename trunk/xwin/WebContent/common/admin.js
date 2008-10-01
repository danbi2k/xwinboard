if ( typeof(AdminGame) == 'undefined' ) AdminGame = function() {};

Admin.RegisterGame = function(frm, type)
{
	var query = "mode=registerGame";
	query += "&leagueId=" + frm.leagueId.value;
	query += "&homeTeam=" + frm.homeTeam.value;
	query += "&awayTeam=" + frm.awayTeam.value;
	query += "&winRate=" + frm.winRate.value;
	query += "&drawRate=" + frm.drawRate.value;
	query += "&loseRate=" + frm.loseRate.value;
	query += "&year=" + frm.year.value;
	query += "&month=" + frm.month.value;
	query += "&date=" + frm.date.value;
	query += "&hour=" + frm.hour.value;
	query += "&minute=" + frm.minute.value;
	query += "&type=" + type;
	query += "&status=" + 'GS001';
	var http = new JKL.ParseXML("adminGame.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0) {
		var url = 'adminGame.aspx?mode=viewGameList&type=' + type;
		location.href = url;
	} else {
		alert(result.resultXml.message);
		return;
	}
}

Admin.GetGameList = function(type, status)
{
	var query = "mode=getGameList";
	if (type)
		query += "&type=" + type;
	if (status)
		query += "&status=" + status;
	var http = new JKL.ParseXML("adminGame.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.game);
		Admin.DrawGameList(data);
	}
}

Admin.DrawGameList = function(data)
{
	var row = [];
	row.push("<table>");
	row.push("<thead>")
	row.push("<tr>")
	row.push("<th nowrap>번호</th nowrap>");
	row.push("<th nowrap>날짜</th nowrap>");
	row.push("<th nowrap>홈팀</th nowrap>");
	row.push("<th nowrap>원정팀</th nowrap>");
	row.push("<th nowrap>승</th nowrap>");
	row.push("<th nowrap>무</th nowrap>");
	row.push("<th nowrap>패</th nowrap>");
	row.push("<th nowrap>홈점수</th nowrap>");
	row.push("<th nowrap>원정점수</th nowrap>");
	row.push("<th nowrap>결과</th nowrap>");
	row.push("<th nowrap>상태</th nowrap>");
	row.push("<th nowrap>적용</th nowrap>");
	row.push("</tr>")
	row.push("</thead>");
	for (var i in data) {
		row.push("<tr>");
		row.push("<td>" + data[i].id + "</td>");
		row.push("<td>" + data[i].gameDateStr + "</td>");
		row.push("<td>" + data[i].homeTeam + "</td>");
		row.push("<td>" + data[i].awayTeam + "</td>");
		row.push("<td>" + data[i].winRate + "</td>");
		row.push("<td>" + data[i].drawRate + "</td>");
		row.push("<td>" + data[i].loseRate + "</td>");
		if (data[i].homeScore == undefined)
			row.push("<td><input type='text' id='homeScore_" + data[i].id + "'></td>");
		else
			row.push("<td>" + data[i].homeScore + "</td>");
		
		if (data[i].awayScore == undefined)
			row.push("<td><input type='text' id='awayScore_" + data[i].id + "'></td>");
		else
			row.push("<td>" + data[i].awayScore + "</td>");
		row.push("<td>" + C(data[i].result) + "</td>");
		row.push("<td>" + C(data[i].status) + "</td>");
		row.push("<td><a onclick='Admin.UpdateScore(" + data[i].id + ")'>[적용]</a></td>");
		row.push("</tr>");
	}
	row.push("</table>");
	var tableString = row.join("");
	var gameListDiv = document.getElementById("gameListDiv");
	gameListDiv.innerHTML = tableString;
}

Admin.UpdateScore = function(idval)
{
	var homeScore = document.getElementById("homeScore_" + idval);
	var awayScore = document.getElementById("awayScore_" + idval);
	
	var query = "mode=updateGameScore";
	query += "&id=" + idval;
	query += "&homeScore=" + homeScore.value;
	query += "&awayScore=" + awayScore.value;
	var http = new JKL.ParseXML("adminGame.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		Admin.GetGameList(gameType, gameStatus);
	}
	else {
		alert(result.resultXml.message);
	}	
}

Admin.GetLeagueList = function()
{
	var query = "mode=getLeagueList";
	var http = new JKL.ParseXML("adminGame.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.league);
		Admin.DrawLeagueList(data);
	}
}

Admin.DrawLeagueList = function(data)
{
	var row = [];
	row.push("<table>");
	for (var i in data) {
		row.push("<tr>");
		row.push("<td>" + data[i].id + "</td>");
		row.push("<td>" + data[i].name + "</td>");
		row.push("<td>" + data[i].type + "</td>");
		row.push("<td><img src='images/" + data[i].image + "'></td>");
		row.push("</tr>");
	}
	row.push("</table>");
	var tableString = row.join("");
	var leagueListDiv = document.getElementById("leagueListDiv");
	leagueListDiv.innerHTML = tableString;
}