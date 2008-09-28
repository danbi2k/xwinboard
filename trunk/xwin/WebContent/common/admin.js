if ( typeof(Admin) == 'undefined' ) Admin = function() {};

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

Admin.DrawGameList = function()
{
	var row = [];
	row.push("<table>");
	for (var i in data) {
		row.push("<tr>");
		row.push("<td>" + data[i].id + "</td>");
		row.push("<td>" + data[i].homeTeam + "</td>");
		row.push("<td>" + data[i].awayTeam + "</td>");
		row.push("</tr>");
	}
	row.push("</table>");
	var tableString = row.join("");
	var gameListDiv = document.getElementById("gameListDiv");
	gameListDiv.innerHTML = tableString;
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