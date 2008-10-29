var total_rate = 0;

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
	
	var regexp= RegExp(/,/ig);
	money = money.replace(regexp, "");
	
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
	
	row.push("<table width='250' cellspacing='1'>");

	if (data != undefined && data.length > 0) {	
		for (var i = 0 ; i < data.length ; i++) {
			row.push("<tr bgcolor='black'>");
			row.push("<td>&nbsp;&nbsp;");
			row.push(data[i].homeTeam);
			row.push("<font color='FFC602'>&nbsp;&nbsp;vs&nbsp;&nbsp;</font> ");
			row.push(data[i].awayTeam);
			row.push("</font></td>");
			row.push("<td>");
			var rate;
			if (data[i].guess == 'W') {
				row.push('승');
				rate = data[i].winRate;
			} if (data[i].guess == 'D') {
				row.push('무');
				rate = data[i].drawRate;
			} if (data[i].guess == 'L') {
				row.push('패');
				rate = data[i].loseRate;
			}
			row.push("</td>");
			row.push("<td>");
			row.push(rate);
			row.push("</td></tr>");
			
			multi *= rate;
		}
	} else {
		multi = 0.00;
	}
	
	row.push("</table>");
		
	var gameCartDiv = document.getElementById("gameCartDiv");
	var rateDiv = document.getElementById("rateDiv");
	
	gameCartDiv.innerHTML = row.join("");
	var multiStr = Xwin.Digit2(multi);
	rateDiv.value = multiStr;
	total_rate = parseFloat(multiStr);
	//alert(total_rate);
	rateDiv.innerHTML = multiStr;
	
	FnCalcCart();
}

function FnBetting()
{
	if (confirm("배팅하시겠습니까?")) {
		var money = CartFrm.BetAmt.value;
		if (money == undefined || money.length == 0)
			CartFrm.BetAmt.value = money = "0";
		
		var regexp= RegExp(/,/ig);
		money = money.replace(regexp, "");
		
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

function FnDeleteCart(type)
{
	var query = "mode=deleteCart";
	query += "&type=" + type;
	var http = new JKL.ParseXML("game.aspx", query);
	var result = http.parse();
	
	reload();
	FnDrawCart();
}

function FnCalcCart()
{
	var money = CartFrm.BetAmt.value;
	if (money == undefined || money.length == 0) {
		CartFrm.BetAmt.value = "";
		money = "0";
	}
	
	var regexp= RegExp(/,/ig);
	money = money.replace(regexp, "");
	
	var commaMoney = comma3(money);
	if (commaMoney == "0")
		commaMoney = "";
	CartFrm.BetAmt.value = commaMoney;
			
	var rateDiv = document.getElementById("rateDiv");
	var expectDiv = document.getElementById("expectDiv");
	//var afterDiv = document.getElementById("afterDiv");
	//var balanceDiv = document.getElementById("balanceDiv");
	
	var rate = rateDiv.value;
//	var query = "mode=calculateCart";
//	query += "&type=" + gameType;
//	query += "&money=" + money;
//	var http = new JKL.ParseXML("betting.aspx", query);
//	var result = http.parse();
//	if (result.resultXml.code == 0) {
//		var data = result.resultXml.object;
		var expect = parseInt(money * total_rate);
		//alert(expect);
		if (expect > 3000000) {
			alert("배당금이 300만원을 초과 하였습니다.");
			CartFrm.BetAmt.value = "";
			expectDiv.innerHTML = "0";
		} else {
			expectDiv.innerHTML = comma3(expect);
		}
		//expectDiv.innerHTML = comma3(data.expect);
		//afterDiv.innerHTML = comma3(data.after);
		//balanceDiv.innerHTML = comma3(data.balance);
//	} else {
//		alert(result.resultXml.message);
//		CartFrm.BetAmt.value = "";
//		FnCalcCart();
//	}
}