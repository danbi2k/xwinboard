<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Count.asp	-->
<SCRIPT LANGUAGE="JavaScript"> 
<!-- 

// 쿠키가 있는지 찾습니다 
function getCookie( name ){ 
var nameOfCookie = name + "="; 
var x = 0; 
while ( x <= document.cookie.length ) 
{ 
var y = (x+nameOfCookie.length); 
if ( document.cookie.substring( x, y ) == nameOfCookie ) { 
if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
endOfCookie = document.cookie.length; 
return unescape( document.cookie.substring( y, endOfCookie ) ); 
} 
x = document.cookie.indexOf( " ", x ) + 1; 
if ( x == 0 ) 
break; 
} 
return ""; 
} 
 
// 팝업창에서 만들어진 쿠키 PopCookie 의 값이 done 이 아니면(즉, 체크하지 않으면,) 
if ( getCookie( "PopCookie" ) != "done" ) { // 새창(today-close.html)을 띄웁니다 
PopCookieWindow = window.open('popup.asp','PopCookie','width=520,height=500,scrollbars=1'); 
PopCookieWindow.opener = self; 
} 

// --> 
</SCRIPT>
	<tr><td height=1 bgcolor="424142"></td></tr>
	<tr>
		<td>

			<table border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td><!--<img src=/images/flash.gif align=center>--><script language='JavaScript'><!--
                    setFlash('/images/main.swf', '1003', '260');//-->
                    </script></td>
								
				</tr>
			</table>
		</td>
	</tr>
	<tr><td height=1 bgcolor="424142"></td></tr>
	<tr>
		<td valign=top>

			<table border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td valign=top>
					
						<table border="0" cellpadding="0" cellspacing="0" >
							<tr>
								<td><a name='' onMouseDown="document.location='/Game/List.asp?Sect=2'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/main01.gif></td>
								<td><a name='' onMouseDown="document.location='/Game/List.asp?Sect=1'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/main02.gif></td>
							</tr>
							
							<tr>
								<td><a name='' onMouseDown="document.location='/Game/List.asp?Sect=3'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/main03.gif></td>
								<td><a name='' onMouseDown="document.location='/Game/List.asp?Sect=6'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/main04.gif></td>
							</tr>
						</table>
						
					</td>
					<td valign=top style="padding-top:3pt">
						<table width=100% border=0 cellpadding=0 cellspacing=1 >
							<tr >
								<td><img src=/images/title_gamelist.gif></td>
							</tr>
							<tr><td height=5></td></tr>
							<tr>
								<td height=335 valign=top>
									<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>
										<tr bgcolor=212021 height=27>
											<td  width=100 align=center ><nobr><font color=FFFFFF><b>경기일시</td>
											<td  width=150 align=center ><nobr><font color=FFFFFF><b>리 그</td>
											<td  width=600 align=center ><nobr><font color=FFFFFF><b>(승)홈 팀</td>
											<td  width=70 align=center ><nobr><font color=FFFFFF><b>무</td>
											<td  width=600 align=center ><nobr><font color=FFFFFF><b>(패)원정팀</td>
											<!--<td  width=60 align=center ><nobr><font color=FFFFFF><b>상태</td>-->
										</tr>
										<%
											
											SQL = "SELECT TOP 13 Idx, gName, Status, convert(varchar(16),gsDate,120 ) As gsDat, Upflag, League, hTname, hAllot, hCap, HcapAllotl, vTname, vAllot, hcont, vcont, event, UpAllot FROM Game_TB WHERE Status=1 And Sect=5 Order By Idx DESC "
											Set objRs = RunSQLReturnRs(SQL)
											If Not objRs.EOF Then 
							Do Until objRs.EOF
										%>																					
										<tr height=25>
											<td align=center bgcolor=000000 ><nobr><%=mid(objRs("gsDat"),6,20)%></td>
											<td align=center bgcolor=000000 ><nobr><%=objRs("League")%></td>
											<td align=right bgcolor=000000 ><nobr>
												<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
													<tr>
														<td align=center width=60><nobr>&nbsp;<% If objRs("event")=1 Then %><img src=/images/icon_event.gif align=absmiddle hspace=1 ><% End If %></td>
														<td align=center width=60><nobr>&nbsp;<% If objRs("Upflag")=1 Then %><img src=/images/icon_close.gif align=absmiddle hspace=1 alt="<%=objRs("UpAllot")%>" style="cursor:hand"><% End If %></td>
														<td align=right width=90%><nobr>
															<%=objRs("hTname")%>&nbsp;
															
															<td width=10>
															<%=objRs("hAllot")%>&nbsp;
															<td width=10>
															<img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif" align=absmiddle>
														</td>
													</tr>
												</table>
											</td>
											<td align=center bgcolor=000000 ><nobr>
												<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
													<tr>
														<td align=center><nobr>
															<% If getInt(objRs("HcapAllotl")) Then %>
															<%=objRs("HcapAllotl")%>
															<% Else %>
															 - 
															<% End If %>
														</td>
													</tr>
												</table>
											</td>
											<td align=left bgcolor=000000 ><nobr>
												<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
													<tr>
														<td width=10><img width=22 height=14 src="/flag/<%=right("0"&objRs("vcont"),2)%>.gif"></td>
														<td width=30>&nbsp;<%=objRs("vAllot")%>&nbsp;</td>
														<td><nobr><%=objRs("vTname")%>&nbsp;</td>
													</tr>
												</table>
											</td>
											<!--<td align=center bgcolor=000000 ><nobr><% If objRs("Status")=0 Then%>마감<%Else%>배팅<%End If %></td>-->
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
								<td  >
									<a name='' onMouseDown="document.location='/company/LiveScore.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/main07.gif><a href="http://www.afreeca.com/" target="_blink" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/main08.gif><a name='' onMouseDown="document.location='/company/HowHandCap.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/main09.gif><a name='' onMouseDown="document.location='/company/HowBet.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='OKBET365.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/main10.gif>
								
								</td>
							</tr>
						</table>	
					</td>			
				</tr>
				<tr>
					<td align=center colspan=2><img src=/images/main06.jpg></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td height=10>&nbsp;</td></tr>
<!--	#include virtual=/common/asp/bottom.asp	-->