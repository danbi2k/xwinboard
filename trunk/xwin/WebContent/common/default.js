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
	if(frm.id.value==""){ alert("아이디를 입력하세요"); frm.id.focus(); return false; }
	if(frm.pw.value==""){ alert("비밀번호를 입력하세요"); frm.pw.focus(); return false; }
//	frm.action="login.aspx";
//	frm.method = "post";
//	frm.target = "hidden_iframe";	
//	frm.submit();
	
	var query = "mode=processLogin";
	query += "&userId=" + frm.id.value;
	query += "&password=" + frm.pw.value;
	
	var http = new JKL.ParseXML("login.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);
		return;
	}
	
	document.location.reload();	
}

function FnLogout(){	
	if(!confirm("로그아웃 하시겠습니까?")){ return false; }
	document.location.href = "login.aspx?mode=processLogout";
}

