function FnGetGameList(type, leagueId, status)
{
	var query = "mode=getGameList";
	if (leagueId != undefined)
		query += "&leagueId=" + leagueId;
	if (type != undefined)
		query += "&type=" + type;
	if (status != undefined)
		query += "&status=" + status;
	
	var http = new JKL.ParseXML("game.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.game);
		FnDrawGameList(data, type);
	}
}

function FnDrawGameList(data, type)
{
	var row = [];
	row.push("<table width='900' bgcolor='#9A9492' cellspacing='1' cellpadding='3'>");
	row.push("<colgroup>");
	row.push("<col bgcolor='#0a0a0a' align='center' width='100'>");
	row.push("<col bgcolor='#0a0a0a' width='*'>");
	row.push("<col bgcolor='#0a0a0a' width='180' align='right'>");
	row.push("<col bgcolor='#0a0a0a' width='80'  align='center' >");
	row.push("<col bgcolor='#0a0a0a' width='180'>");
	row.push("<col bgcolor='#0a0a0a' width='50'  align='center'>");
	row.push("</colgroup>");
	
	if (data.length > 0) {
		for (var i in data) {
			row.push("<tr height='34'>");
			row.push("<td>" + data[i].gameDateStr + "</td>");
			row.push("<td>");
			row.push("<table cellpadding='0' cellspacing='2'><tr><td><img src='symbol/165.gif' style='display:none' onload=\"this.style.display=''\"></td>");
			row.push("<td>" + data[i].leagueName + "</tr>");
			row.push("</table>");
			row.push("</td>");
			row.push("<td>" + data[i].homeTeam);
			if (data[i].betStatus == 'BTS01') {
				row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'W');\">");
			} else {
				row.push("<b style='font-size:15px;'>□</b> ");
			}
			row.push(data[i].winRateStr);
			row.push("<span style='width:8;'>&nbsp;</span>");
			row.push("</td>");
			row.push("<td>");
			if (data[i].drawRate > 0 && data[i].betStatus == 'BTS01') {
				row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'D');\">");
			} else {
				row.push("<b style='font-size:15px;'>□</b> ");
			}
			row.push(data[i].drawRateStr);
			row.push("</td>");
			row.push("<td><span style='width:8;'>&nbsp;</span>");
			row.push(data[i].loseRateStr);
			if (data[i].betStatus == 'BTS01') {
				row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'L');\">");
			} else {
				row.push("<b style='font-size:15px;'>□</b> ");
			}
			row.push(data[i].awayTeam );
			row.push("</td>");
			row.push("<td><font color='darkorange'>" + C(data[i].betStatus) + "</td>");
			row.push("</tr>");
		}
	} else {
		row.push("<tr><td colspan='6' align='center' height='100'>등록된 경기가 없습니다.</td></tr>");
	}
	
	row.push("</table>");
	var tbodyString = row.join("");
	var gameListDiv = document.getElementById("gameListDiv");
	gameListDiv.innerHTML = tbodyString;
}

function CheckAll(obj){
	if(obj.length>0){
		for(var i=1;i<obj.length;i++){
			obj[i].checked = obj[0].checked;
		}
	}
}

function FnGameSelDel(frm){
	var sel_cnt=0;
	for(var i=0;i<frm.GameDel.length;i++){
		if(frm.GameDel[i].checked){ sel_cnt++; break; }
	}
	if(sel_cnt==0){ alert("삭제할 항목을 선택하세요!"); return false; }
	if(!confirm("삭제하시겠습니까?")){ return false; }
	frm.action = "game_cart.asp";
	frm.submit();
}

function FnCartApply(frm){
	frm.action = "game_cart.asp";
	
}
function FnBet(frm){
	frm.action = "game_bet_submit.asp";
	frm.submit();
}

function BetListView(BetNo){
	var w = 800;
	var h = 500;
	var window_left = (screen.width-w)/2;
	var window_top  = (screen.height-h)/2;
	window.open("myBet.aspx?mode=viewMyBettingDetail&bettingId="+ BetNo, "BetDetail",'status=no,width='+ w +',height='+ h +',top=' + window_top + ',left=' + window_left + '');
}