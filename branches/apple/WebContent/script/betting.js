var total_rate = 0;

function FnEmptyGameFolder(type)
{
	var query = "mode=emptyGameFolder";
	query += "&type=" + type;
	
	var http = new JKL.ParseXML("bet.php", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		document.location.reload();
	}
}

function FnDrawFolderCheck(type)
{
	var query = "mode=getGameFolder";
	query += "&type=" + type;
	
	var http = new JKL.ParseXML("bet.php", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.gameFolderItem);
		for (i in data) {
			var id = "check" + data[i].id +	data[i].guess;
			var obj = document.getElementById(id);
			if (obj)
				obj.checked = true;
		}
	}
}

function FnDeleteGameFolder(id, type, guess)
{
	var moneyDiv = document.getElementById("moneyDiv");
	var money = moneyDiv.value;
	if (money == undefined || money.length == 0)
		moneyDiv.value = money = "0";
	
	var regexp= RegExp(/,/ig);
	money = money.replace(regexp, "");
	
	var query = "";
	query = "mode=deleteGameFolder";
	query += "&gameId=" + id;
	query += "&type=" + type;
	
	var http = new JKL.ParseXML("bet.php", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var id = "check" +	guess + id;
		var obj = document.getElementById(id);
		if (obj)
			obj.className = "out";
		
		var data = Xwin.ToArray(result.resultXml.object.gameFolderItem);
		FnDrawFolder(data, type);
	}
}


function FnGameBet(cobj, id, type, guess)
{
	if (cobj.className == "")
		return;
	
	var checked;
	if (cobj.className == "click")
		checked = false;
	else
		checked = true;
	
	var moneyDiv = document.getElementById("moneyDiv");
	var money = moneyDiv.value;
	if (money == undefined || money.length == 0)
		moneyDiv.value = money = "0";
	
	var regexp= RegExp(/,/ig);
	money = money.replace(regexp, "");
	var query = "";
	var boxes = document.getElementsByName("check"+id);
	if (checked) {
		var checkW = document.getElementById("checkW"+id);
		var checkD = document.getElementById("checkD"+id);
		var checkL = document.getElementById("checkL"+id);
		
		if (checkW.className == 'click')
			checkW.className="out";
		if (checkD.className == 'click')
			checkD.className="out";
		if (checkL.className == 'click')
			checkL.className="out";
		
		query = "mode=addGameFolder";
		query += "&gameId=" + id;
		query += "&guess=" + guess;
		query += "&type=" + type;
		query += "&money=" + money;
		cobj.className = "click";
		cobj.tempmouseover = cobj.onmouseover;
		cobj.onmouseover = "";
		cobj.tempmouseout = cobj.onmouseout;
		cobj.onmouseout = "";
	} else {
		query = "mode=deleteGameFolder";
		query += "&gameId=" + id;
		query += "&type=" + type;
		cobj.className = "out";
		cobj.onmouseover = cobj.tempmouseover;
		cobj.onmouseout = cobj.tempmouseout;
	}
	var http = new JKL.ParseXML("bet.php", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		var data = Xwin.ToArray(result.resultXml.object.gameFolderItem);
		FnDrawFolder(data, type);
	} else {
		alert(result.resultXml.message);
		cobj.className = "out";
		if (result.resultXml.code == -1) {
			var data = Xwin.ToArray(result.resultXml.object.gameFolderItem);
			FnDrawFolder(data, type);
		} else {
			location.reload();
		}
	}
}

function FnDrawFolder(data, type) {	
	var row = [];
	var rate = "0.0";
	var multi = 1.0;
	
	row.push("<table>");

	if (data != undefined && data.length > 0) {	
		for (var i = 0 ; i < data.length ; i++) {
			row.push("<tr>");
			row.push("<td class='t1'>" + data[i].homeTeam + "</td>");
			row.push("<td class='t2'><img src='img/side_del_bt.gif' onclick='FnDeleteGameFolder(" + data[i].id + ",\"" + type + "\",\"" + data[i].guess + "\")'></td>");
			row.push("</tr>");
			
			row.push("<tr>");
			row.push("<td class='t1'>" + data[i].awayTeam + "</td>");
			row.push("<td class='t2'>" + C(data[i].guess) + " " + Xwin.Digit2(data[i].selRate) + "</td>");
			row.push("</tr>");
			
			row.push("<tr><td class='line' colspan=2></td></tr>");
			
			multi *= data[i].selRate;
		}
	} else {
		multi = 0.00;
	}
	
	row.push("</table>");
		
	var gameFolderDiv = document.getElementById("gameFolderDiv");
	gameFolderDiv.innerHTML = row.join("");
	
	var rateDiv = document.getElementById("rateDiv");
	//alert(gameFolderDiv.innerHTML);
	var multiStr = Xwin.Digit2(multi);
	rateDiv.value = multiStr;
	total_rate = parseFloat(multiStr);
	//alert(total_rate);
	rateDiv.innerHTML = multiStr;
	FnCalcFolder();
}

function FnBetting()
{
	if (confirm("배팅하시겠습니까?")) {
		var moneyDiv = document.getElementById("moneyDiv");
		var money = moneyDiv.value;
		if (money == undefined || money.length == 0)
			moneyDiv.value = money = "0";
		
		var regexp= RegExp(/,/ig);
		money = money.replace(regexp, "");
		
		var query = "mode=betting";
		query += "&type=" + gameType;
		query += "&money=" + money;
		query += "&action=betting";
		var http = new JKL.ParseXML("bet.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0 || result.resultXml.code == -2) {			
			document.location.reload();
		}
	}
}

function FnAddBettingCart()
{
	if (confirm("배팅카트에 추가 하시겠습니까?")) {
		var moneyDiv = document.getElementById("moneyDiv");
		var money = moneyDiv.value;
		if (money == undefined || money.length == 0)
			moneyDiv.value = money = "0";
		
		var regexp= RegExp(/,/ig);
		money = money.replace(regexp, "");
		
		var query = "mode=betting";
		query += "&type=" + gameType;
		query += "&money=" + money;
		query += "&action=cart";
		var http = new JKL.ParseXML("bet.php", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0 || result.resultXml.code == -2) {			
			document.location.reload();
		}
	}
}

function FnDeleteFolder(type)
{
	var query = "mode=deleteFolder";
	query += "&type=" + type;
	var http = new JKL.ParseXML("play.php", query);
	var result = http.parse();
	
	location.reload();
}

function FnCalcFolder()
{
	var moneyDiv = document.getElementById("moneyDiv");
	var money = moneyDiv.value;
	if (money == undefined || money.length == 0) {
		moneyDiv.value = "";
		money = "0";
	}
	
	var regexp= RegExp(/,/ig);
	money = money.replace(regexp, "");
	
	var commaMoney = comma3(money);
	if (commaMoney == "0")
		commaMoney = "";
	moneyDiv.value = commaMoney;
			
	var rateDiv = document.getElementById("rateDiv");
	var expectDiv = document.getElementById("expectDiv");
	//var afterDiv = document.getElementById("afterDiv");
	//var balanceDiv = document.getElementById("balanceDiv");
	
	var rate = rateDiv.value;
//	var query = "mode=calculateCart";
//	query += "&type=" + gameType;
//	query += "&money=" + money;
//	var http = new JKL.ParseXML("bet.php", query);
//	var result = http.parse();
//	if (result.resultXml.code == 0) {
//		var data = result.resultXml.object;
		var expect = parseInt(money * total_rate);
		//alert(expect);
		if (expect > 3000000) {
			alert("배당금이 300만원을 초과 하였습니다.");
			moneyDiv.value = "";
			expectDiv.innerHTML = "0";
		} else {
			expectDiv.innerHTML = comma3(expect);
		}
		//expectDiv.innerHTML = comma3(data.expect);
		//afterDiv.innerHTML = comma3(data.after);
		//balanceDiv.innerHTML = comma3(data.balance);
//	} else {
//		alert(result.resultXml.message);
//		moneyDiv.value = "";
//		FnCalcFolder();
//	}
}