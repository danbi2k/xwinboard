var topLink = [];
topLink[1] = "game.aspx?mode=viewGameList&type=wdl&grade=1";
topLink[2] = "game.aspx?mode=viewGameList&type=handy&grade=1";
topLink[3] = "game.aspx?mode=viewGameList&type=mix&grade=10";
topLink[4] = "board.aspx?mode=viewBoard&boardName=user";
topLink[5] = "board.aspx?mode=viewBoard&boardName=qna";
topLink[6] = "game.aspx?mode=viewGameResultList";
topLink[7] = "introduce.aspx?mode=viewIntroduceForm";
topLink[8] = "moneyIn.aspx?mode=viewMoneyInRequest";
topLink[9] = "moneyOut.aspx?mode=viewMoneyOutRequest";
topLink[10] = "myMoney.aspx?mode=viewMyMoneyList";

function goTopLink(index)
{
	//alert(index);
	location.href = topLink[index];
}

function exchangePoignt(point)
{
	var balance = point - (point % 10000);
	if (balance < 10000) {
		alert("포인트는 10,000원 단위로 충전이 가능합니다");
		return;
	}

	if (confirm("포인트 " + comma3(balance) + "원 을 머니로 충전하시겠습니까?")) {
		var query = "mode=exchangePoint";
		var http = new JKL.ParseXML("member.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();
	}
}

function havingSqlKeyword(str)
{
	var lower = str.toLowerCase();
	if (lower.indexOf("select") >= 0 ||
		lower.indexOf("update") >= 0 ||
		lower.indexOf("delete") >= 0 ||
		lower.indexOf("create") >= 0 ||
		lower.indexOf("alter") >= 0 ||
		lower.indexOf("tbl_") >= 0) {		
		return true;
	}
	
	return false;
}

function comma3Input(obj)
{
	var num = obj.value;
	
	var regexp= RegExp(/,/ig);
	num = num.replace(regexp, "");
	
	var val = comma3(num);
	
	if (val == "0")
		val = "";
	
	obj.value = val;
}

function trimComma3(num)
{
	var regexp= RegExp(/,/ig);
	num = num.replace(regexp, "");
	
	return num;
}

function comma3(num)
{
	var str = "" + num;
	
	var tmp = [];
	var cnt = 0;
	for (var i = str.length-1 ; i >= 0 ; i--) {
		cnt++;
		tmp.push(str.charAt(i));
		if (cnt % 3 == 0 && cnt < str.length)
			tmp.push(",");
	}
	tmp = tmp.reverse();
	var ret = tmp.join("");
	
	return ret;
}

function go(url)
{
	alert(url);
	location.href = url;
}

// 플래쉬(swf) 파일 링크
function FnFlash(id,w,h,s,wmode) {
  var str="", sID="";
  if (id.length > 0) { sID = " id='"+id+"' name='"+id+"'"; }
  str += "<object "+sID+" classid='clsid:D27CDB6E-AE6D-11cf-96B8";
  str += "-444553540000'";
  str += " codebase='http://download.macromedia.com/pub/shockwave/cabs";
  str += "/flash/swflash.cab#version=6,0,29,0'";
  str += " width='"+w+"' height='"+h+"'>";
  str += "<param name='movie' value='"+s+"'>";
  str += "<param name='quality' value='high'>";
  str += "<param name='wmode' value='"+wmode+"'>";
  str += "<embed "+sID+" src='"+s+"' quality='high' wmode='"+wmode+"'";
  str += " pluginspage='http://www.macromedia.com/go/getflashplayer'";
  str += " type='application/x-shockwave-flash'";
  str += " width='"+w+"' height='"+h+"'></embed>";
  str += "</object>";
  document.write(str);
}


function FnLogin_Submit(frm){	
	if(frm.userId.value==""){ alert("아이디를 입력하세요"); frm.userId.focus(); return false; }
	if(frm.password.value==""){ alert("비밀번호를 입력하세요"); frm.password.focus(); return false; }
	
	var query = "mode=processLogin";
	query += "&userId=" + frm.userId.value;
	query += "&password=" + frm.password.value;
	query += "&pin=" + frm.pin.value;
	
	var http = new JKL.ParseXML("login.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);
		location.href = "index.aspx";
		return;
	}
	
	location.href = "home.aspx";
}

function FnLogout(){	
	if(!confirm("로그아웃 하시겠습니까?")){ return false; }
	document.location.href = "login.aspx?mode=processLogout";
}

