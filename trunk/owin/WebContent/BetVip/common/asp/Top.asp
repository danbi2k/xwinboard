
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
Call IpFilter()
Sect		= Request("Sect")
tPageName	= Request.ServerVariables("SCRIPT_NAME")
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
window.status='KOR-OKBET.COM'
} 
</SCRIPT> 

<% If Sect ="2" And ( inRStr(tPageName, "/community/list.asp", "/", 1, 1) or inRStr(tPageName, "/community/content.asp", "/", 1, 1) ) Then %>
<BODY style="margin:0" bgcolor=000000 >
<% ElseIf inRStr(tPageName, "/member/mybetlist.asp", "/", 1, 1) Then %>
<BODY style="margin:0" bgcolor=000000 >
<% ElseIf inRStr(tPageName, "/game/list2.asp", "/", 1, 1) Then %>
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
<% Else %>
<BODY style="margin:0" bgcolor=000000 oncontextmenu="return false" onselectstart="return false" ondragstart="return false" >
<% End If %>

<table border="0" cellpadding="0" cellspacing="0" width=1003 align=center>
    <tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td ><a name='' onMouseDown="document.location='/'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/top011.jpg></a></td>
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
								<td >&nbsp;&nbsp;<input tabindex=3 type=image src=/images/btn_login.gif align=absmiddle></td>
								<td >&nbsp;&nbsp;<a href="/member/regist.asp" ><img src=/images/btn_reg.gif align=absmiddle ></td>
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
							Session("APoint") = NowMileage(Session("UId"), "APoint")
						%>
								
						<table border="0" cellpadding="0" cellspacing="0" height="27" width=100%>
							<tr>
								<td><nobr><font color=FFFFFF><b><%=Session("UName")%></b>님 환영합니다.</td>
								<td ><nobr>&nbsp;&nbsp;<b>내 베팅머니 &nbsp;[ <font color=FFC700><%=formatnumber(Session("UPoint"),[])%></font> C ]&nbsp;&nbsp;</td>
								<td ><nobr>&nbsp;&nbsp;<b>내 포인트 &nbsp;[ <font color=FFC700><%=formatnumber(Session("APoint"),[])%></font> P ]</td>
								<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/modify.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/btn_modify.gif align=absmiddle ></td>
								<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/logout.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/btn_logout.gif align=absmiddle ></td>
								<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/MybetList.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=/images/btn_betinfo.gif align=absmiddle ></td>
								
								<td width=50>&nbsp;</td>
								
								<td>
									<table border="0" cellpadding="0" cellspacing="0" width=100%>
										<tr>		
											<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/Cash.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><font color=FFC602><b>[캐쉬충전]</td>
											<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/ReCash.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><font color=FFC602><b>[캐쉬환전]</td>
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
								Set ScrSet = RunSQLReturnRs("SELECT * FROM Community_TB WHERE Sect=4 And Hidden=0 Order By Idx DESC")
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

	