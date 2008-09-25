function FnEmptyGameWdlCart()
{
	var query = "mode=emptyGameWdlCart";
	var http = new JKL.ParseXML("game_wdl.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		document.location.reload();
	}
}

function FnGetGameList(leagueId)
{
	var query = "mode=getGameListXml";
	if (leagueId != undefined)
		query += "&leagueId=" + leagueId;
	
	var http = new JKL.ParseXML("game_wdl.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.gameWdl);
		FnDrawGameList(data);
	}
}

function FnDrawGameList(data)
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
			row.push("<td>" + data[i].date + "</td>");
			row.push("<td>");
			row.push("<table cellpadding='0' cellspacing='2'><tr><td><img src='symbol/165.gif' style='display:none' onload=\"this.style.display=''\"></td>");
			row.push("<td>" + data[i].leagueName + "</tr>");
			row.push("</table>");
			row.push("</td>");
			row.push("<td>" + data[i].homeTeam);
			row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "', 'w');\">");
			row.push(data[i].winRate);
			row.push("<span style='width:8;'>&nbsp;</span>");
			row.push("</td>");
			row.push("<td>");
			if (data[i].drawRate > 0) {
				row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "', 'd');\">");
			} else {
				row.push("<b style='font-size:15px;'>□</b> ");
			}
			row.push(data[i].drawRate);
			row.push("</td>");
			row.push("<td><span style='width:8;'>&nbsp;</span>");
			row.push(data[i].loseRate);
			row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "', 'l');\">");
			row.push(data[i].awayTeam);
			row.push("</td>");
			row.push("<td><font color='darkorange'>" + data[i].status + "</td>");
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

function FnGameBet(cobj, id, match) {
	var query = "";
	var boxes = document.getElementsByName("check"+id);
	if (cobj.checked) {
		for (var i = 0 ; i < boxes.length ; i++) {
			if (boxes[i] != cobj) {
				boxes[i].checked = false;
			}
		}
		query = "mode=addGameWdlCart";
		query += "&gameId=" + id;
		query += "&match="+ match;		
	} else {
		query = "mode=deleteGameWdlCart";
		query += "&gameId=" + id;
	}
	
	var http = new JKL.ParseXML("game_wdl.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.gameCartItem);
		FnDrawCart(data);
	}
}

function FnDrawCart(data) {	
	var row = [];
	var rate = "0.0";
	var multi = 1.0;
	
	row.push("<table width='550' bgcolor='#d9d8d6' cellspacing='1' bgcolor='#0a0a0a'>");

	row.push("<colgroup>");
	row.push("<col align='left' width='50'>");
	row.push("<col width='*'>");
	row.push("<col align='center' width='50'>");
	row.push("<col align='center' width='60'>");
	row.push("</colgroup>");

	row.push("<tr bgcolor='#ce892c' align='center'>");
	row.push("<td style='color:white'><input type='checkbox' name='GameDel' onclick=\"CheckAll(CartFrm.GameDel);\">No.</td>");

	row.push("<td style='color:white'><b>리그</td>");	
	row.push("<td style='color:white'><b>선택</td>");
	row.push("<td style='color:white'><b>배당율</td>");
	row.push("</tr>");
	
	if (data != undefined && data.length > 0) {	
		for (var i = 0 ; i < data.length ; i++) {
			row.push("<tr bgcolor='black'>");
			row.push("<td><input type='checkbox'/>");
			row.push(i+1);
			row.push("</td>");
			row.push("<td>");
			row.push(data[i].league);
			row.push("  <font size='-1'>(");
			row.push(data[i].homeTeam);
			row.push("<font color='darkorange'>vs</font> ");
			row.push(data[i].awayTeam);
			row.push(")</font></td>");
			row.push("<td>");
			row.push(data[i].match);
			row.push("</td>");
			row.push("<td>");
			row.push(data[i].rate);
			row.push("</td></tr>");
			
			multi *= data[i].rate;
		}
	} else {
		row.push("<tr id='nonSelect' style='display:block' bgcolor='black'>");
		row.push("<td colspan='4' height='110' align='center' style='line-height:30px;'>배팅할 경기를 선택하세요!<br>최대 10 경기까지 복수선택 가능합니다.</td>");
		row.push("</tr>");
	}
	
	row.push("</table>");
		
	var gameCartDiv = document.getElementById("gameCartDiv");
	var rateDiv = document.getElementById("rateDiv");
	
	gameCartDiv.innerHTML = row.join("");
	rateDiv.innerHTML = Xwin.Digit2(multi);
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
	frm.submit();
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
	window.open("/member/mybet_detail.asp?BetNo="+ BetNo,"BetDetail",'status=no,width='+ w +',height='+ h +',top=' + window_top + ',left=' + window_left + '');
}