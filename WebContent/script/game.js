var notice = [];
function FnGetGameList(type, leagueId, grade, memberId)
{
	var query = "mode=getGameList";
	if (leagueId != undefined)
		query += "&leagueId=" + leagueId;
	if (type != undefined)
		query += "&type=" + type;
	if (grade != undefined)
		query += "&grade=" + grade;
	
	var http = new JKL.ParseXML("game.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.game);
		FnDrawGameList(data, type, memberId);
		FnDrawFolderCheck(type);
	}
}
function FnDrawGameList(data, type, memberId)
{
	var row = [];
	row.push("<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>");
	row.push("<tr bgcolor=212021 height=27>");
	row.push("<td  width=130 align=center ><font color=FFFFFF><b>경기일시</td>");
	row.push("<td  width=150 align=center ><font color=FFFFFF><b>리 그</td>");
	row.push("<td  width=500 align=center ><font color=FFFFFF><b>(승)홈 팀</td>");
	
	if (type == 'wdl')
		row.push("<td  width=70 align=center ><font color=FFFFFF><b>무</td>");
	else if (type == 'handy')
		row.push("<td  width=70 align=center ><font color=FFFFFF><b>핸디</td>");
	else
		row.push("<td  width=70 align=center ><font color=FFFFFF><b>무/핸디</td>");
	
	row.push("<td  width=600 align=center ><font color=FFFFFF><b>(패)원정팀</td>");
	row.push("<td  width=60 align=center ><font color=FFFFFF><b>상태</td>");
	row.push("<td  width=60 align=center ><font color=FFFFFF><b>공지</td>");
	row.push("</tr>");
	
	if (data.length > 0) {
		for (var i in data) {
			var txtcolor = 'gray';
			var datecolor = 'gray';
			if (data[i].betStatus == 'BTS01') {
				txtcolor = 'white';
				datecolor = '#FFC602';
			}
			
			row.push("<tr height=25 bgcolor=000000>");
			row.push("<td align=center  ><nobr><font color=" + datecolor + ">" + data[i].gameDateStr + "</td>");
			row.push("<td align=left><nobr><font color=" + txtcolor + ">&nbsp;<B><img width=22 height=14 src='images/league/" + data[i].leagueImage + "' align=absmiddle>&nbsp;&nbsp;" + data[i].leagueName + "</B></font></td>");
			row.push("<td align=right>");
			row.push("<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>");
			row.push("<tr>");
			row.push("<td align=center width=60><nobr>&nbsp;</td>");
			row.push("<td align=center width=60>&nbsp;</td>");								
			row.push("<td width=90% align=right>");
			if (memberId == 1)
				row.push("(" + comma3(data[i].winMoney) + ")&nbsp;");
			row.push("<nobr><font size='3' color=" + txtcolor + "><B>" + data[i].homeTeam);			
			if (data[i].betStatus == 'BTS01' && data[i].winDeny == "Y") {
				row.push("&nbsp;<input type='checkbox' name='check" + data[i].id + "' id='check" + data[i].id + "W' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'W');\">");
			} else {
				row.push("&nbsp;<input type='checkbox' disabled></b> ");
			}
			
			row.push("</font></td>");
			row.push("<td width=1 bgcolor=FFFFFF></td>");
			row.push("<td width=90% align=right>&nbsp;<font color=" + txtcolor + ">" + data[i].winRateStr + "&nbsp;</td>");
			row.push("<td width=1 bgcolor=FFFFFF></td>");
			row.push("<td width=90% align=right><nobr></td>");
			row.push("</tr>");
			row.push("</table>");
			row.push("</td>");
			row.push("<td align=center ><nobr>");
			
			if (data[i].type == 'wdl') {
				if (data[i].betStatus == 'BTS01' && data[i].drawDeny == "Y" && data[i].drawRate != 0) {
					row.push("<input type='checkbox' name='check" + data[i].id + "' id='check" + data[i].id + "D' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'D');\">");
					row.push(data[i].drawRateStr);
				} else {
				}	
			} else {
				if (data[i].drawRate > 0)
					row.push("+");
				row.push(data[i].drawRate);	
			}
			

			if (memberId == 1)
				row.push("<br>(" + comma3(data[i].drawMoney) + ")");
			
			row.push("</td>");
			row.push("<td align=left >");
			row.push("<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>");
			row.push("<tr>");
			row.push("<td ></td>");
			row.push("<td width=1% >&nbsp;<font color=" + txtcolor + ">" + data[i].loseRateStr + "</font></td>");
			row.push("<td width=90% ><nobr>");
			
			if (data[i].betStatus == 'BTS01' && data[i].loseDeny == "Y") {
				row.push("<input type='checkbox' name='check" + data[i].id + "' id='check" + data[i].id + "L' onclick=\"FnGameBet(this, '" + data[i].id + "','" + type + "', 'L');\">");
			} else {
				row.push("<input type='checkbox' disabled>");
			}
			
			row.push("&nbsp;<font size='3' color=" + txtcolor + "><B>" + data[i].awayTeam + "</B></font>");
			if (memberId == 1)
				row.push("&nbsp;(" + comma3(data[i].loseMoney) + ")");
			row.push("</td>");								
			row.push("</tr>");
			row.push("</table>");
			row.push("</td>");
			row.push("<td align=center ><nobr><font color='" + datecolor + "'>" + C(data[i].betStatus) + "</td>");
			row.push("<td align=center ><nobr><font color='white'>");
			if (data[i].note) {
				notice[data[i].id] = data[i].note;
				row.push("<a onclick='showNotice(" + data[i].id + ")'>공지</a>");
			}
			row.push("</td>");
			row.push("</tr>");
		}
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

function showNotice(id) {
	alert(notice[id]);
}