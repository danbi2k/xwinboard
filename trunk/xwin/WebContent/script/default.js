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
	
	var http = new JKL.ParseXML("login.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);
		return;
	}
	
	location.href = "index.aspx";	
}

function FnLogout(){	
	if(!confirm("로그아웃 하시겠습니까?")){ return false; }
	document.location.href = "login.aspx?mode=processLogout";
}

