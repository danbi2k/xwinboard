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
		FnDrawGameList2(data, type);
	}
}
function FnDrawGameList2(data,type)
{
	var row = [];
	row.push("<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>");
	row.push("<tr bgcolor=212021 height=27>");
	row.push("<td  width=130 align=center ><font color=FFFFFF><b>경기일시</td>");
	row.push("<td  width=150 align=center ><font color=FFFFFF><b>리 그</td>");
	row.push("<td  width=500 align=center ><font color=FFFFFF><b>(승)홈 팀</td>");
	
	if (type == 'wdl')
		row.push("<td  width=70 align=center ><font color=FFFFFF><b>무</td>");
	else
		row.push("<td  width=70 align=center ><font color=FFFFFF><b>핸디</td>");
	row.push("<td  width=600 align=center ><font color=FFFFFF><b>(패)원정팀</td>");
	row.push("<td  width=60 align=center ><font color=FFFFFF><b>상태</td>");
	row.push("</tr>");
	
	if (data.length > 0) {
		for (var i in data) {
			row.push("<tr height=25 bgcolor=000000>");
			row.push("<td align=center  ><nobr><font color=FFC602>" + data[i].gameDateStr + "</td>");
			row.push("<td align=center  ><nobr><font color=FFC602><img width=22 height=14 src='images/league/" + data[i].leagueImage + "' align=absmiddle>&nbsp;&nbsp;" + data[i].leagueName + "</td>");
			row.push("<td align=right  >");
			row.push("<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>");
			row.push("<tr>");
			row.push("<td align=center width=60><nobr>&nbsp;</td>");
			row.push("<td align=center width=60>&nbsp;</td>");								
			row.push("<td width=90% align=right><nobr><font color=FFC602>");
			row.push("<span id='team1_2567'>" + data[i].homeTeam + "</span>");
			
			if (data[i].status == 'GS002') {
				row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'W');\">");
			} else {
				row.push("<b style='font-size:15px;'><input type='checkbox' disabled></b> ");
			}
			
			row.push("</td>");
			row.push("<td width=1 bgcolor=FFFFFF></td>");
			row.push("<td width=90% align=right>&nbsp;<font color=FFC602><span id='bet1_2567'>" + data[i].winRateStr + "</span>&nbsp;</td>");
			row.push("<td width=1 bgcolor=FFFFFF></td>");
			row.push("<td width=90% align=right><nobr></td>");
			row.push("</tr>");
			row.push("</table>");
			row.push("</td>");
			row.push("<td align=center ><nobr>");
			row.push("<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424242>");
			row.push("<tr>");
			row.push("<td align=center bgcolor=424242><nobr><font color=FFC602>");
			
			if (data[i].type == 'wdl') {
				if (data[i].drawRate > 0 && data[i].status == 'GS002') {
					row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'D');\">");
				} else {
					row.push("<b style='font-size:15px;'><input type='checkbox' disabled></b> ");
				}
				row.push("<span id='bet3_2567' bgcolor=424242>" + data[i].drawRateStr + "</span>");	
			} else {
				row.push("<span id='bet3_2567' bgcolor=424242>" + data[i].drawRate + "</span>");	
			}
			
			row.push("</td>");
			row.push("</tr>");
			row.push("</table>");		
			row.push("</td>");
			row.push("<td align=left >");
			row.push("<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>");
			row.push("<tr>");
			row.push("<td ></td>");
			row.push("<td width=1% >&nbsp;<font color=FFC602><span id='bet2_2567'>" + data[i].loseRateStr + "</span>&nbsp;</td>");
			row.push("<td width=90% ><nobr>");
			
			if (data[i].status == 'GS002') {
				row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'L');\">");
			} else {
				row.push("<b style='font-size:15px;'><input type='checkbox' disabled></b> ");
			}
			
			row.push("<font color=FFC602><span id='team2_2567'>" + data[i].awayTeam + "</span>&nbsp;");
			row.push("</td>");								
			row.push("</tr>");
			row.push("</table>");
			row.push("</td>");
			if (data[i].status == 'GS002')
				row.push("<td align=center ><nobr><font color='white'>" + C(data[i].status) + "</td>");
			else
				row.push("<td align=center ><nobr><font color='gray'>" + C(data[i].status) + "</td>");
			row.push("</tr>");
		}
	}
	
	row.push("</table>");
	var tbodyString = row.join("");
	var gameListDiv = document.getElementById("gameListDiv");
	gameListDiv.innerHTML = tbodyString;
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
			row.push("<table cellpadding='0' cellspacing='2'><tr><td><img src='images/league/" + data[i].leagueImage + "' style='display:none' onload=\"this.style.display=''\"></td>");
			row.push("<td>&nbsp;" + data[i].leagueName + "</tr>");
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
			if (data[i].type == 'wdl') {
				if (data[i].drawRate > 0 && data[i].betStatus == 'BTS01') {
					row.push("<input type='checkbox' name='check" + data[i].id + "' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'D');\">");
				} else {
					row.push("<b style='font-size:15px;'>□</b> ");
				}
				row.push(data[i].drawRateStr);
			} else {
				row.push(data[i].drawRate);
			}
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