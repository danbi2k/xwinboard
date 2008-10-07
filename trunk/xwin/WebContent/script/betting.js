function FnEmptyGameWdlCart(type)
{
	var query = "mode=emptyGameCart";
	query += "&type=" + type;
	
	var http = new JKL.ParseXML("betting.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		document.location.reload();
	}
}


function FnGameBet(cobj, id, type, guess)
{
	var money = CartFrm.BetAmt.value;
	if (money == undefined || money.length == 0)
		CartFrm.BetAmt.value = money = "0";
	
	var query = "";
	var boxes = document.getElementsByName("check"+id);
	if (cobj.checked) {
		for (var i = 0 ; i < boxes.length ; i++) {
			if (boxes[i] != cobj) {
				boxes[i].checked = false;
			}
		}
		query = "mode=addGameCart";
		query += "&gameId=" + id;
		query += "&guess=" + guess;
		query += "&type=" + type;
		query += "&money=" + money;
	} else {
		query = "mode=deleteGameCart";
		query += "&gameId=" + id;
		query += "&type=" + type;
	}
	
	var http = new JKL.ParseXML("betting.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.gameCartItem);
		FnDrawCart(data, type);
	} else {
		alert(result.resultXml.message);
		if (cobj.checked) {
			cobj.checked = false;
		}
		if (result.resultXml.code == -1) {
			var data = Xwin.ToArray(result.resultXml.object.gameCartItem);
			FnDrawCart(data, type);
		} else {
			location.reload();
		}
	}
}

function FnDrawCart(data, type) {	
	var row = [];
	var rate = "0.0";
	var multi = 1.0;
	
	row.push("<table width='550' bgcolor='#d9d8d6' cellspacing='1' bgcolor='#0a0a0a'>");

	row.push("<colgroup>");
	row.push("<col align='center' width='50'>");
	row.push("<col width='*'>");
	row.push("<col align='center' width='50'>");
	row.push("<col align='center' width='60'>");
	row.push("</colgroup>");

	row.push("<tr bgcolor='#ce892c' align='center'>");
	row.push("<td style='color:white'>");
	//row.push("<input type='checkbox' name='GameDel' onclick=\"CheckAll(CartFrm.GameDel);\">");
	row.push("<b>No.</b></td>");

	row.push("<td style='color:white'><b>리그</td>");	
	row.push("<td style='color:white'><b>선택</td>");
	row.push("<td style='color:white'><b>배당율</td>");
	row.push("</tr>");
	
	if (data != undefined && data.length > 0) {	
		for (var i = 0 ; i < data.length ; i++) {
			row.push("<tr bgcolor='black'>");
			row.push("<td height='25'>");
			//row.push("<input type='checkbox'/>");
			row.push(i+1);
			row.push("</td>");
			row.push("<td>&nbsp;&nbsp;");
			row.push(data[i].league);
			row.push("<font size='-1'>(");
			row.push(data[i].homeTeam);
			row.push("<font color='darkorange'>vs</font> ");
			row.push(data[i].awayTeam);
			row.push(")</font></td>");
			row.push("<td>");
			if (data[i].guess == 'W')
				row.push('승');
			if (data[i].guess == 'D')
				row.push('무');
			if (data[i].guess == 'L')
				row.push('패');
			row.push("</td>");
			row.push("<td>");
			row.push(data[i].rate);
			row.push("</td></tr>");
			
			multi *= data[i].rate;
		}
	} else {
		row.push("<tr id='nonSelect' style='display:block' bgcolor='black'>");
		row.push("<td colspan='4' height='118' align='center' style='line-height:30px;'>배팅할 경기를 선택하세요!<br>최대 10 경기까지 복수선택 가능합니다.</td>");
		row.push("</tr>");
		
		multi = 0.00;
	}
	
	row.push("</table>");
		
	var gameCartDiv = document.getElementById("gameCartDiv");
	var rateDiv = document.getElementById("rateDiv");
	
	gameCartDiv.innerHTML = row.join("");
	var multiStr = Xwin.Digit2(multi);
	rateDiv.value = multi;
	rateDiv.innerHTML = multiStr;
	
	FnCalcCart();
}

function FnBetting()
{
	if (confirm("배팅하시겠습니까?")) {
		var money = CartFrm.BetAmt.value;
		if (money == undefined || money.length == 0)
			CartFrm.BetAmt.value = money = "0";
		
		var query = "mode=betting";
		query += "&type=" + gameType;
		query += "&money=" + money;
		var http = new JKL.ParseXML("betting.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0 || result.resultXml.code == -2) {			
			document.location.reload();
		}
	}
}

function FnCalcCart()
{
	var money = CartFrm.BetAmt.value;
	if (money == undefined || money.length == 0)
		CartFrm.BetAmt.value = money = "0";
			
	var rateDiv = document.getElementById("rateDiv");
	var expectDiv = document.getElementById("expectDiv");
	var afterDiv = document.getElementById("afterDiv");
	var balanceDiv = document.getElementById("balanceDiv");
	
	var rate = rateDiv.value;
	var query = "mode=calculateCart";
	query += "&type=" + gameType;
	query += "&money=" + money;
	var http = new JKL.ParseXML("betting.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0) {
		var data = result.resultXml.object;
		expectDiv.innerHTML = comma3(data.expect);
		afterDiv.innerHTML = comma3(data.after);
		balanceDiv.innerHTML = comma3(data.balance);
	} else {
		alert(result.resultXml.message);
		CartFrm.BetAmt.value = 0;
		FnCalcCart();
	}
}