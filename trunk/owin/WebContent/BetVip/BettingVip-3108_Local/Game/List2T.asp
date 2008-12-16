<!--	#include virtual=/common/asp/Connect.asp	-->
<!--	#include virtual=/common/asp/config.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<%
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.expires = -1
Response.buffer = true
Call CloseGame()
%>	
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<META http-equiv="Pragma" content="no-cache">
<link href="/common/css/style.css" rel="stylesheet" type="text/css">
<link href="/common/css/default.css" rel="stylesheet" type="text/css">
<script language=javascript src="/js/common.js"></script>
<script language='JavaScript'>
//if (top.frames.length == 0) { top.document.location = '/'; }
//if(!top.frames['mainFrame']) { top.document.location = '/'; }
</script>
<script language=javascript src="/common/js/swf.js"></script>
<script language=javascript src="/common/js/common.js"></script>
<title>베팅</title>
</HEAD>
<script Language="Javascript">
function right(e) {  // 오른쪽 마우스 금지
if (navigator.appName == "Netscape" && (e.which == 3 || e.which == 2)) {
return false;
} 

}

document.onmousedown=right;
document.onmouseup=right;
if (document.layers) {
window.captureEvents(Event.MOUSEDOWN);
window.captureEvents(Event.MOUSEUP);
window.onmousedown=right;
window.onmouseup=right;
}

function cnj_click() {  
if((event.ctrlKey) && (event.keyCode == 82)) { // Ctrl+R : 문서 다시 읽음 
return false;
}

if((event.ctrlKey) && (event.keyCode == 114)) { 
return false;
}


if((event.ctrlKey) && (event.keyCode == 78)) {  
return false;
}

if((event.ctrlKey) && (event.keyCode == 110)) { 
return false;
}

}
if (document.layers) {
document.captureEvents(Event.MouseDown);//protect from keyboard keypress

function keypressed() {
alert("키작동이 안됩니다.  ^^");  
}
}
document.onmousedown=cnj_click
document.onkeydown=cnj_click
</script>
<SCRIPT LANGUAGE=JAVASCRIPT> 
function cnj_status() { 
window.status='OKBET365.COM'
} 
</SCRIPT> 

<BODY onLoad="cacheOff()" style="margin:0" bgcolor=000000 oncontextmenu="return false" onselectstart="return false" ondragstart="return false" >
<!--------- 로딩전에 보여주는 공치창입니다.------------>
<div id="loadingBar" >
	<table border=0 height="600" width=1000 cellspacing="0" >   
		<tr>      
			<td align="absmiddle">
			<center>로딩중 입니다. 잠시만 기다려 주세요.<br>
<marquee scrollamount='45' direction='right' width="370">
<table border='1' cellpadding='1' width=100% height=15 cellspacing='1' bgcolor=FFFFFF >
<tr><td width='100%'></td></tr></table></marquee>


</center></td>   
		</tr>
	</table>            
</div>
<table border="0" cellpadding="0" cellspacing="0" width=1003 align=center>
    <tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td ><a name='' onMouseDown="document.location='/'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/top011.jpg></a></td>
                    <td><script language='JavaScript'><!--
                    setFlash('/images/menu.swf', '650', '73');//-->
                    </script></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td height=2 bgcolor="424142"></td></tr>
	<tr>
        <td  bgcolor="212021">
            <table border="0" cellpadding="0" cellspacing="0"  >
                <tr>
                    <td ><img src=/images/top02.jpg></td>
                    <td >
						<% If isNone(Session("UId")) Then %>
						<script language='javascript'>
							function LoginChack(f) {
								if(!trim(f.fid.value) ) {	
									alert(f.fid.title + "은(는) 필수항목입니다.");
									f.fid.value=''; f.fid.focus(); return false;

								} else if(!trim(f.fpwd.value) ) {	
									alert(f.fpwd.title + "은(는) 필수항목입니다.");
									f.fpwd.value=''; f.fpwd.focus(); return false;
								}

								f.action='/member/login_prc.asp';
								f.target="_top";
							}


						</script>
						<table border="0" cellpadding="0" cellspacing="0" height="27" width=100%>
							<form name=frms method=post onsubmit="return LoginChack(this);" >
							<tr>
								<td><font color=D2D2D2><b>ID : </td>
								<td>&nbsp;<input type=text size=15 tabindex=1 size=10 class=input14 name="fid" Information="Required" MaxBytes="15" title="아이디" ></td>
								
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=D2D2D2><b>PWD : </td>
								<td>&nbsp;<input type=password size=15 tabindex=2 class=input14 name="fpwd" Information="Required" MaxBytes="15" title="비밀번호" ></td>
								<td >&nbsp;&nbsp;<input tabindex=3 type=image src=/images/btn_login.gif align=absmiddle id=image1 name=image1></td>
<!--								<td >&nbsp;&nbsp;<a href="/member/regist.asp" ><img src=/images/btn_reg.gif align=absmiddle ></td>-->
								<td width=200>&nbsp;</td>
								<td>
									<table border="0" cellpadding="0" cellspacing="0" width=100%>
										<tr>		
											<td >&nbsp;&nbsp;<font color=FFC602><b>[캐쉬충전]</td>
											<td >&nbsp;&nbsp;<font color=FFC602><b>[캐쉬환전]</td>
										</tr>
									</table>
								</td>
								
							</tr>
							</form>
						</table>
						<% Else 
							Session("UPoint") = UsePoints("", Session("UId"), 2)
						%>
								
						<table border="0" cellpadding="0" cellspacing="0" height="27" width=100%>
							<tr>
								<td><font color=FFFFFF><b><%=Session("UName")%></b>님 환영합니다.</td>
								<td >&nbsp;&nbsp;<b>내 베팅머니 &nbsp;[ <font color=FFC700><%=formatnumber(Session("UPoint"),[])%></font> C ]</td>
								<td >&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/modify.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/btn_modify.gif align=absmiddle ></td>
								<td >&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/logout.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/btn_logout.gif align=absmiddle ></td>
								<td >&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/MybetList.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/btn_betinfo.gif align=absmiddle ></td>
								
								<td width=170>&nbsp;</td>
								
								<td>
									<table border="0" cellpadding="0" cellspacing="0" width=100%>
										<tr>		
											<td >&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/Cash.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><font color=FFC602><b>[캐쉬충전]</td>
											<td >&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/ReCash.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><font color=FFC602><b>[캐쉬환전]</td>
										</tr>
									</table>
								</td>
								
							</tr>
						</table>		
						<% End If %>
                    </td>
				</tr>
			</table>
			
		</td>
	</tr>
	<tr><td height=1 bgcolor="424142"></td></tr>
	<tr><td height=15 ></td></tr>

	<tr>
        <td >
        
        
            <table border="0" cellpadding="0" cellspacing="0"  >
                <tr>
                    <td ><img src=/images/top02.gif></td>
                    <td width=903 valign=bottom style="margin-right:10pt" background=/images/top03.gif>
						<marquee id=cnj direction="left" height="27" scrollamount="10" onmouseover="cnj.stop()" onmouseout="cnj.start()">
						<table border="0" cellpadding="0" cellspacing="0" height="36" width=90%>
							<tr>
							<%
								Set ScrSet = RunSQLReturnRs("SELECT * FROM Community_TB WHERE Sect=4 Order By Idx DESC")
								If Not ScrSet.EOF Then
									Do Until ScrSet.EOF
							%>
							    <td ><nobr><font color=FFFFFF><%=reString(ScrSet("Content"),"text")%>&nbsp;&nbsp;</td>
							<%
									ScrSet.MoveNext
									Loop
								End If
								Set ScrSet = Nothing
							%>
							</tr>
						</table>
						</marquee >
					
                    </td>
                    <td ><img src=/images/top04.gif></td>
				</tr>
			</table>
			
		</td>
	</tr>
<script language=javascript src="/js/bet.js"></script>

<script>
				var f_coin="<%=UsePoints("", Session("UId"), 2)%>";
				var min_bet1="5000";
				var min_bet2="5000";
				var max_bet1="1000000";
				var max_bet2="1000000";
				var max_amount1="5000000";
				var max_amount2="5000000";
			</script>
	<form name="betForm" method="post" >
	<input type="hidden" name="mode" value="betting">
	<input type="hidden" name="betmoney" value="">
	<input type="hidden" name="betcontent" value="">
	<input type="hidden" id="game_type" name="game_type" value="2">
	<input type="hidden" id="Sect" name="Sect" value="<%=Sect%>">
	<input type="hidden" name="hapr" >
	<input type="hidden" name="haa" >
	<input type="hidden" name="thispage" value="List2.asp">
</form>
	<tr>
        <td >
			<table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 >&nbsp;</td>
					<td valign=top >
						<table border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table width=980 border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign=top >
												<table border="0" cellpadding="0" cellspacing="0" height=750>
													<tr>
														<td valign=top>
															<table border="0" cellpadding="3" cellspacing="2" width=98%>
																<tr>
																    <td ><img src=/images/title_gamelist.gif  ></td>
																</tr>
																<tr>
																    <td >
																		
																		<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>
																			<tr bgcolor=212021 height=27>
																				<td  width=130 align=center ><font color=FFFFFF><b>경기일시</td>
																				<td  width=150 align=center ><font color=FFFFFF><b>리 그</td>
																				<td  width=500 align=center ><font color=FFFFFF><b>(승)홈 팀</td>
																				<td  width=70 align=center ><font color=FFFFFF><b>무</td>
																				<td  width=600 align=center ><font color=FFFFFF><b>(패)원정팀</td>
																				<td  width=60 align=center ><font color=FFFFFF><b>상태</td>
																			</tr>
<%
																			Sect	= reInt(Request("Sect"),5)
																			SQL = "SELECT Idx, gName, convert(varchar(16),gsDate,120 ) As gsDat, League, hTname, "
																			SQL = SQL &" hAllot, hCap, HcapAllotl, vTname, vAllot, hcont, vcont, Upflag, Status, UpAllot, event "
																			SQL = SQL &" FROM Game_TB WHERE  Status <>3"
'																			SQL = SQL &" FROM Game_TB WHERE  ( Status=0 or Status=1 )  "
																		'	If Not isNone(Sect) Then SQL = SQL &" And Sect='"& Sect &"'"
																			SQL = SQL &" And Sect='"& Sect &"'"
																		'	SQL = SQL &" Order By Idx ASC "
																			SQL = SQL &" Order By convert(varchar(20),gsDate,120 ) ASC, League ASC "
																			Set objRs = RunSQLReturnRs(SQL)
																		'	Response.Write RandomCode()
'																			SQL = " exec Game2_list '"& Sect &"'"
																			Set objRs = RunSQLReturnRs(SQL)

																			If Not objRs.EOF Then
																				Do Until objRs.EOF
																				If objRs("Status")=0 Then fcolor = "FFC602" Else fcolor = "FFFFFF" End If
%>																						
																			<tr height=25 bgcolor=000000>
																				<td align=center  ><nobr><font color=<%=fcolor%>><%=objRs("gsDat")%></td>
																				<td align=center  ><nobr><font color=<%=fcolor%>><%=objRs("League")%></td>
																				<td align=right  >
																					<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																						<tr>
																							<td align=center width=60><nobr>&nbsp;<% If objRs("event")=1 Then %><img src=/images/icon_event.gif align=absmiddle hspace=1 ><% End If %></td>
																							<td align=center width=60>&nbsp;<% If objRs("Upflag")=1 Then %><img src=/images/icon_close.gif align=absmiddle alt="<%=objRs("UpAllot")%>" style="cursor:hand" hspace=1><% End If %></td>
																										
																							<td width=90% align=right><nobr><font color=<%=fcolor%>>
																							<span id="team1_<%=objRs("Idx")%>"><%=objRs("hTname")%></span>
																							<input <% If objRs("Status")=0 Then%> disabled <%End If %> type=checkbox id="chk1_<%=objRs("Idx")%>" value="1" onclick="check_bet(event)" num="<%=objRs("Idx")%>">
																							</td>
																							<td width=1 bgcolor=FFFFFF></td>
																							<td width=90% align=right>&nbsp;<font color=<%=fcolor%>><span id="bet1_<%=objRs("Idx")%>"><%=objRs("hAllot")%></span>&nbsp;</td>
																							<td width=1 bgcolor=FFFFFF></td>
																							<td width=90% align=right><nobr><img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif" align=absmiddle></td>
																						</tr>
																					</table>
																				</td>
																				<td align=center ><nobr>
																					<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																						<tr>
																							<td align=center><nobr><font color=<%=fcolor%>>
																								<% If getInt(objRs("HcapAllotl")) Then %>
																								<input <% If objRs("Status")=0  Then%> disabled <%End If %> type="checkbox" id="chk3_<%=objRs("Idx")%>" value="3" onclick="check_bet(event)" num="<%=objRs("Idx")%>"  > <span id="bet3_<%=objRs("Idx")%>" ><%=objRs("HcapAllotl")%></span>
																								<% Else %>
																								 - 
																								<% End If %>
																							</td>
																						</tr>
																					</table>
																				
																				</td>
																				<td align=left >
																					<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																						<tr>
																							<td ><img width=22 height=14 src="/flag/<%=right("0"&objRs("vcont"),2)%>.gif" align=absmiddle> </td>
																								<td width=1% >&nbsp;<font color=<%=fcolor%>><span id="bet2_<%=objRs("Idx")%>"><%=objRs("vAllot")%></span>&nbsp;</td>
																								<td width=90% ><nobr>
																								<input <% If objRs("Status")=0 Then%> disabled <%End If %> type=checkbox id="chk2_<%=objRs("Idx")%>" value="2" onclick="check_bet(event)" num="<%=objRs("Idx")%>">
																								<font color=<%=fcolor%>><span id="team2_<%=objRs("Idx")%>"><%=objRs("vTname")%></span>&nbsp;
																							</td>
																										
																						</tr>
																					</table>
																				</td>
																				<td align=center ><nobr><font color=<%=fcolor%>><% If objRs("Status")=0 Then%>마감<%Else%>배팅<%End If %></td>
																			</tr>
<%
																				objRs.MoveNext
																				Loop
																			End If
%>																						
																						
																		</table>		
																					
																		
																    </td>
																</tr>
																
																<tr>
																	<td>
																		<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
																			<tr >
																				<td bgcolor=000000 >
																					<table border=0 cellpadding=6 cellspacing=2 align=center>
																						<tr>
																							<td>
																				<img src=/images/icon02.gif align=absmiddle><b>선택하신 경기&nbsp;
																				<img src=/images/sub02.gif onclick="location.href='Cart.asp'" style="cursor:pointer" align=absmiddle>
																				<img src=/images/sub03.gif onclick="del_all()" style="cursor:pointer" style="cursor:pointer" align=absmiddle>
																				
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																		</table>																					
																	</td>
																</tr>
																<tr>
																	<td style="padding-top: 10px; padding-bottom: 10px;" align="center" >
																		
																		<div id="Div1">
																			<table id="tb_list"></table>
																		</div>
																	</td>
																</tr>
																<tr>
																	<td>
																		<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
																			<tr >
																				<td bgcolor=000000>
																				
																					<table border=0 align=center cellpadding=1 cellspacing=2 >
																						<tr  >
																							<td >배팅금액</td>
																							<td >: <input type=text id="txt_point" size="19" value="5,000" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value);calc()" type="text" ID="Text4" class=input14></td>
																							<td align=center><img src=/images/btn_bat.gif onclick="betting('betting')" style="cursor:pointer"></td>
																						</tr>
																						<tr  >
																							<td align=center>예상배당율</td>
																							<td >: <b><span id="sp_bet">0.00</span></td>
																							<td align=center><img src=/images/btn_in.gif onclick="betting('cart')" style="cursor:pointer" ></td>
																						</tr>
																						<tr  >
																							<td >예상적중금</td>
																							<td >: <b><span id="sp_total">0</span> 원</td>
																							<td align=center></td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														
														</td>
													</tr>
												</table>
		</td>
													</tr>
												</table>
														</td>
													</tr>
												</table>
														</td>
													</tr>
												</table>								
											</td>
										</tr>
									<script language="javascript">   
									document.all.loadingBar.style.display="none";   
									document.all.divBody.style.display="";
									</script>
<!--	#include virtual=/common/asp/bottom.asp	-->										