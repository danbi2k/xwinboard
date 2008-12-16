<SCRIPT LANGUAGE="JavaScript">
<!-- 
var data = "0123456789";
var done = 1;
function statusIn(text) {
decrypt(text, 2, 1);
}
function statusOut() {
self.status = '';
done = 1;
}
function decrypt(text, max, delay) {
if (done) {
done = 0;
decrypt_helper(text, max, delay,  0, max);
   }
}
function decrypt_helper(text, runs_left, delay, charvar, max) {
if (!done) {
runs_left = runs_left - 1;
var status = text.substring(0, charvar);
for (var current_char = charvar; current_char < text.length; current_char++) {
status += data.charAt(Math.round(Math.random()*data.length));
}
window.status = status;
var rerun = "decrypt_helper('" + text + "'," + runs_left + "," + delay + "," + charvar + "," + max + ");"
var new_char = charvar + 1;
var next_char = "decrypt_helper('" + text + "'," + max + "," + delay + "," + new_char + "," + max + ");"
if(runs_left > 0) {
setTimeout(rerun, delay);
}
else {
if (charvar < text.length) {
setTimeout(next_char, Math.round(delay*(charvar+3)/(charvar+1)));
}
else {
done = 1;
         }
      }
   }
}
//-->
</script>
<table border="0" cellpadding="0" cellspacing="0" width=100% height=100%>
						    <tr>
						        <% If isNone(Session("UId")) Then %>
						        <td background=/images/llogin01.gif width=194 height=178 valign=top style="padding-top:41pt;padding-left:17pt">
						        
									<table border="0" cellpadding="1" cellspacing="0" width=130>
										<form name=frms method=post action="/member/login_prc.asp" onsubmit="return DefaultFormValidation(this);" >
									    <tr>
									        <td style="padding-left:7pt"><input type=text tabindex=1 size=10 class=input10 name="fid" Information="Required" MaxBytes="15" title="아이디" ></td>
									        <td rowspan=2><input tabindex=3 type=image src=/images/llogin02.gif></td>
										</tr>
									    <tr>
									        <td style="padding-left:7pt"><input tabindex=2 type=password size=10 class=input10 name="fpwd" Information="Required" MaxBytes="15" title="비밀번호" ></td>
										</tr>
										<tr>
									        <td colspan=2><a href="/member/regist.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/llogin03.gif></a></td>
										</tr>
										<tr>
									        <td colspan=2><a href="/member/MybetList.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/llogin04.gif></td>
										</tr>
										</form>
									</table>
								</td>
								<% Else 
									Session("UPoint") = UsePoints("", Session("UId"), 2)
								%>
								<td background=/images/llogin05.gif width=194 height=178 valign=top style="padding-top:41pt;padding-left:12pt">
									<table border="0" cellpadding="1" cellspacing="0" width=157>
										<tr>
									        <td colspan=2 align=center><font color=FFFFFF><b><%=Session("UName")%></b>님 환영합니다.</td>
										</tr>
									    <tr>
									        <td style="padding-left:7pt" width=400><font color=FFFFFF><b>내 베팅머니</td>
									        <td rowspan=2><a href="/member/logout.asp"><img src=/images/llogin06.gif ></a>
									        <a href="/member/modify.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/llogin07.gif ></a></td>
										</tr>
									    <tr>
									        <td style="padding-left:7pt" align=center width=400><font color=FFFFFF><b><%=formatnumber(Session("UPoint"),[])%></td>
										</tr>
										
										<tr>
									        <td align=center colspan=2><a href="/member/MybetList.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/llogin04.gif></td>
										</tr>
										
									</table>
								</td>
								<% End If %>
							</tr>
							<tr>
						        <td height=100%>
									<table border="0" cellpadding="0" cellspacing="0" width=130>
										<tr>
									        <td ><a href="/member/ReCash.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/left01.gif></td>
										</tr>
										<tr>
									        <td ><a href="/member/Cash.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/left02.gif></td>
										</tr>
										<tr>
									        <td ><a href="/company/HowBet.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/left03.gif></td>
										</tr>
										<tr>
									        <td ><a href="/game/HowGame.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/left04.gif></td>
										</tr>
										<tr>
									        <td ><a href="/company/LiveScore.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/left05.gif></td>
										</tr>
										<tr>
									        <td ><a href="/company/HowHandCap.asp" onMouseOver="statusIn('HTTP://WWW.OKBET888.COM');return true;"><img src=/images/left06.gif></td>
										</tr>
										<tr>
									        <td >
												<table border="0" cellpadding="0" cellspacing="0" width=130>
													<tr>
													    <td ><img src=/images/left07.gif></td>
													    <td ><img src=/images/left08.gif></td>
													</tr>
													<tr>
													    <td ><img src=/images/left09.gif></td>
													    <td ><img src=/images/left10.gif></td>
													</tr>
													<tr>
													    <td ><img src=/images/left11.gif></td>
													    <td ><img src=/images/left12.gif></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr><td height=20>&nbsp;</td></tr>
									</table>
								</td>
							</tr>
						</table>