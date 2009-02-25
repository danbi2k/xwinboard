function user_login(frm) {
	if(!frm.userId.value) { alert('아이디를 입력하세요'); frm.userId.focus(); return false; }
	if(!frm.password.value) { alert('패스워드를 입력하세요'); frm.password.focus(); return false; }
	
	var query = "mode=processLogin";
	query += "&userId=" + frm.userId.value;
	query += "&password=" + frm.password.value;
	
	var http = new JKL.ParseXML("login.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code < 0) {
		alert(result.resultXml.message);	
		return;
	}
	
	location.href = "home.aspx";
}