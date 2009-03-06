<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%
	Member member = (Member) session.getAttribute("Member");
	Boolean isIndex = (Boolean) request.getAttribute("isIndex");
	Boolean isModify = (Boolean) request.getAttribute("isModify");
	if (isIndex == null)
		isIndex = false;
	if (isModify == null)
		isModify = false;
	
	if (member != null) {
		Member dbMember = Admin.memberDao.selectMember(member.getUserId(), null);
		dbMember.setBettingDate(member.getBettingDate());
		dbMember.setLoginDate(member.getLoginDate());
		session.setAttribute("Member", dbMember);
		
		member = dbMember;
	}
	boolean login = member == null ? false : true;

	List<Game> wdlList = (List<Game>) request.getAttribute("wdlList");
	List<Game> handyList = (List<Game>) request.getAttribute("handyList");
%>

<html>
<head>
<title>환영합니다</title>
	<Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=UTF-8">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Refresh" Content="900; URL=login.aspx?mode=processLogout">
	
	<script language="JavaScript" src="script/code.js"></script>
	<script language="JavaScript" src="script/default.js"></script>
	<script language="JavaScript" src="script/game.js"></script>
	<script language="JavaScript" src="script/betting.js"></script>
	<script language="JavaScript" src="script/member.js"></script>
	<script language="JavaScript" src="script/mybet.js"></script>
	<script language="JavaScript" src="script/board.js"></script>
	<script language="JavaScript" src="script/jkl-parsexml.js"></script>
	<script language="JavaScript" src="script/xwin.js"></script>
	<script language="JavaScript" src="script/utf8.js"></script>
	<script language="JavaScript" src="script/xwin_user.js"></script>
	<script language="javascript" src="script/mEmbed.js"></script>
	<link rel="stylesheet" type="text/css" href="style/style.css">
</head>
<body bgcolor="#1a1a1a" topmargin="0" leftmargin="0" marginwidth='0' marginheight='0' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<map name="ImageMap1">
<area shape="rect" coords="25, 22, 65, 42" href="provision.aspx" onfocus="this.blur()">
<area shape="rect" coords="86, 23, 128, 41" href="rules.aspx" onfocus="this.blur()">
<area shape="rect" coords="153, 21, 203, 41" href="aboutHandy.aspx" onfocus="this.blur()">
<area shape="rect" coords="232, 22, 383, 43" href="http://www.kofree.net/DNSFree/Setup.exe" onfocus="this.blur()">
</map>
<center>
<div id="popup" style="position:absolute;left:50%;top:130px;width:950px;z-index:1;margin-left:-470px;visibility:hidden;background-color:#111111">
<table align="center" width="95%" cellpadding="0" cellspacing="0" style="margin-top:7px;">
<tr align="center">
<td width="10"></td>
<td width="*"><b style="color:white">긴급공지</td>
<td width="10"></td>
</tr>
</table>

<table width="95%" border="0" align="center"  cellpadding="3" cellspacing="1" style="margin-top:7px;border:1 solid #4a4a4a;">
<tr height="100%" valign="top"><td style="padding:13px;" bgcolor="#555555" style="color:black;">

    <%
    String context = Admin.POPUP;
    context = StringEscapeUtils.escapeHtml(context);
    context = context.replaceAll("\n", "<br>");
    out.print(context);
    %>

</td></tr>
<tr><td bgcolor="#525252">
    <table width="100%" style="color:#8b8b8b;">
    <tr>
        <td width="50%"><b style="color:black">작성자 : <b>관리자</b></td>
        <td width="50%" align="right"><b style="color:black">
			오늘하루이창을열지않음 <input type="checkbox" id="popupcheck">
			닫기 <img src="img/x.gif" onclick="popupclose()">	
		</td>
    </tr></table>
</td></tr>
</table>
&nbsp;
</div>
<div id="memoDiv" style="padding:10 10 10 10;position:absolute;left:50%;top:50%;width:350px;height:350px;z-index:2;margin-left:-175px;margin-top:-175px;visibility:hidden;background-color:#CCCCCC;color:#000000">
<form>
<table border=0 style='width:100%;color:#000000'>
<tr>
<td align='center' style='color:#000000'><font size=3><B>긴급알림</B></font></td>
</tr>
<tr height=100%>
<td height=280px>
<span id="memoContents" style='width:100%;height:100%;color:#000000' valign='top'></span>
</td>
</tr>
<tr>
<td align='right' style='color:#000000'>
	다시보지않음<input type="checkbox" id="isReaded"/>
	닫기 <img src="img/x.gif" onclick="memoClose()"/>
</td>
</tr>
</table>
</form>
</div>

<table id="" width="1100" height="1270" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3" width="958" height="81" valign="top" background="img/m_01.jpg">
			<!-----------------------------------로고, 로그인------------------------------->
			<table id="logo" width="958" height="81" border="0" cellpadding="0" cellspacing="0">
			   <tr>
		         <td width="308" height="81" align="left">
			     	<a href="home.aspx"><img src="img/logo.jpg" border="0"></a>
			     </td>
				 <td width="650" height="81" align="right" style="padding-right:13;padding-top:50;">
				 	<%if (login) { %>
					<div align="right">
					    <table cellpadding="0" cellspacing="0" width="650" height="25">
					        <tr>
					            <td width="451" height="25" align="left" valign="middle" background="img/login/lo.jpg">
					               <table cellpadding="0" cellspacing="0" width="451" height="25">
					                <tr>
					                 <td width="451" height="25" align="left" valign="middle" class="maint" style="padding-left:70">
					              		<%=member.getNickName()%>         
					                </td>
									<td width="451" height="25" align="left" valign="middle" class="maint" style="padding-left:100">
					              		<%=XwinUtil.comma3(member.getBalance())%>         
					                </td>
									<td width="451" height="25" align="left" valign="middle" class="maint" style="padding-left:70">
					              		<%=XwinUtil.comma3(member.getPoint())%>         
					                </td>					           
					        </tr>
					    </table>    
					            </td>
					            <td width="199" height="25" align="right" valign="middle">
					                <a href='login.aspx?mode=processLogout' target='_self'><img src="img/login/out.jpg" border="0"></a>&nbsp;
									<a href='member.aspx?mode=viewModifyForm'><img src="img/login/info.jpg" border="0">&nbsp;</a>
									<a href='myBet.aspx?mode=viewMyBettingList'><img src="img/login/sp.jpg" border="0"></a>
					            </td>
					        </tr>
					    </table>
					</div>
					<%} else { %>
					<div align="right">
						<form name="login">
					    <table cellpadding="0" cellspacing="0" width="650" height="25">
					        <tr>
					            <td width="525" height="25" align="left" valign="middle" >
					               <table cellpadding="0" cellspacing="0" width="525" height="25">
					                <tr>
					                 <td width="525" height="25" align="right" valign="middle">
					               <input name='userId' onkeydown="enter(document.login)" type="text" class="input1" id="m_id"  style="background-image:url(img/login/idbg.jpg);" >&nbsp;
									<input name='password' onkeydown='enter(document.login)' type="password" class="input1" id="m_passwd"  style="background-image:url(img/login/pwbg.jpg);">          
					                </td>
					           
					        </tr>
					    </table>    
					            </td>
					            <td width="125" height="25" align="right" valign="bottom">
					                <img src="img/login/login.jpg" border="0" onclick="FnLogin_Submit(document.login)">&nbsp;<img src="img/login/join.jpg" border="0" onclick="location.href='join.aspx?mode=viewJoinForm'">
					            </td>
					        </tr>
					    </table>
						</form>
					</div>
					<%} %>
			     </td>
	           </tr>
			</table>
			<!-----------------------------------로고, 로그인끝------------------------------->
		
		</td>
		<td rowspan="9" width="142" height="1170" background="img/m_02.jpg">
		</td>
	</tr>
	<tr>
		<td colspan="3" width="958" height="60" align="center" valign="middle" background="img/m_03.jpg">
			<script>mEmbed('src=img/menu.swf','width=931','height=60','wmode=opaque','menu=false','quality=high','bgcolor=#ffffff');</script> 
		</td>
	</tr>
	<tr>
		<td colspan="3" width="958" height="309" align="center" valign="top" background="img/m_04.jpg" style="padding-top:8;padding-left:2">
			<script>mEmbed('src=img/img.swf','width=929','height=300','wmode=opaque','menu=false','quality=high','bgcolor=#ffffff');</script>
		</td>
	</tr>
	<tr>
		<td colspan="3" width="958" height="66" background="img/m_05.jpg">
			</td>
	</tr>
	<tr>
		<td colspan="3" width="958" height="54" align="center" valign="middle" background="img/m_06.jpg">
           <table id="notice" width="900" height="50" border="0" cellpadding="0" cellspacing="0">
			   <tr>
		         <td width="898" height="50" class="notice" align="center">
				 <marquee onmouseover='this.stop()' onmouseout='this.start()'>
	             <%=Admin.NOTICE%>
				 </marquee>
			     </td>
	           </tr>
			</table>
 		
		
	   </td>
	</tr>
	<tr>
		<td rowspan="3" width="214" height="534" background="img/m_07.jpg">
			
	    </td>
		<td width="473" height="257" align="center" valign="top" background="img/m_08.jpg">
         <!------------------------------승무패------------------------>


        <table align="center" cellpadding="0" cellspacing="0" width="473" height="257" valign="top">
            <tr>
              <td width="473" height="26" colspan="4">
           
             </td>
           </tr>
			<%
			for (int i = 0 ; i < 9 ; i++) {
				String date = "", homeTeam = "", awayTeam = "";
				if (wdlList != null && wdlList.size() > i) {
					Game game = wdlList.get(i);
					date = XwinUtil.getBoardItemDate(game.getGameDate());
					homeTeam = game.getHomeTeam();
					awayTeam = game.getAwayTeam();
				}
			%>
               <tr>
                 <td align="center"  class="maindate">
           
                 <p><%=date%></p>
                 </td>
                <td align="left" valign="middle" class="maint" onmouseover="this.className='button_over'" onmouseout="this.className='button_out'">
           
                <p>&nbsp;<%=homeTeam%></p>
                </td>
                <td width="24" height="24" align="left" valign="middle">
           
                <p>&nbsp;</p>
                </td>
                <td align="left" valign="middle" class="maint" onmouseover="this.className='button_over'" onmouseout="this.className='button_out'">
           
                 <p>&nbsp;<%=awayTeam%></p>
                </td>
              </tr>
			<%
			}
			%>

         </table>			


 
	    </td>
		<td rowspan="3" width="271" height="534" background="img/m_09.jpg" valign="top">
          <table border="0" cellpadding="0" cellspacing="0">
		    <tr>
		      <td style="padding-top:11;padding-left:16">
		         <iframe name="iframetoto" src="http://free.7m.cn/U_fUpDown.aspx?width=215&height=500&file=10&mark=3&title=LIVESCORE&urls=http://&timezone=" width="215" height="503" marginwidth=0 marginheight=0 border=0 scrolling=no frameborder=0></iframe>
		     </td>
		    </tr>
		</table>
		</td>
	</tr>

	<tr>
		<td width="473" height="257" align="center" valign="top" background="img/m_10.jpg">
            <!------------------------------핸디캡시작------------------------>
            <table align="center" cellpadding="0" cellspacing="0" width="473" height="257">
            <tr>
              <td width="473" height="26" colspan="4">
           
             </td>
           </tr>
           <%
			for (int i = 0 ; i < 9 ; i++) {
				String date = "", homeTeam = "", awayTeam = "";
				if (handyList != null && handyList.size() > i) {
					Game game = handyList.get(i);
					date = XwinUtil.getBoardItemDate(game.getGameDate());
					homeTeam = game.getHomeTeam();
					awayTeam = game.getAwayTeam();
				}
			%>
               <tr>
                 <td align="center"  class="maindate">
           
                 <p><%=date%></p>
                 </td>
                <td align="left" valign="middle" class="maint" onmouseover="this.className='button_over'" onmouseout="this.className='button_out'">
           
                <p>&nbsp;<%=homeTeam%></p>
                </td>
                <td width="24" height="24" align="left" valign="middle">
           
                <p>&nbsp;</p>
                </td>
                <td align="left" valign="middle" class="maint" onmouseover="this.className='button_over'" onmouseout="this.className='button_out'">
           
                 <p>&nbsp;<%=awayTeam%></p>
                </td>
              </tr>
			<%
			}
			%>

         </table>	

		</td>
	
	</tr>
	<tr>
		<td width="473" height="20" align="center" valign="top" background="img/m_10_.jpg">
                <p>&nbsp;</p>


		</td>
	
	</tr>
	<tr>
		<td colspan="3" width="958" height="166">
			<img src="img/foot.jpg" alt="" usemap="#ImageMap1" border="0">
		</td>
	</tr>
</table>
<script>
function enter(frm)
{
	if (event.keyCode == 13) {
		FnLogin_Submit(frm);
	}
}

function popupopen()
{
	var popup = document.getElementById("popup");
	popup.style.visibility = "visible"
}

function popupclose()
{
	var popup = document.getElementById("popup");
	var popupcheck = document.getElementById("popupcheck");
	popup.style.visibility = "hidden";

	if (popupcheck.checked) {
		setCookie("COOKIEFLAG", "N", 1);
	}		
}

function setCookie( name, value, expiredays )
{
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function getCookie( name )
{
	var seoroopCookie = name + "=";
	var i = 0;
	while ( i <= document.cookie.length )
	{
 		var e = (i+seoroopCookie.length);
 		if ( document.cookie.substring( i, e ) == seoroopCookie ) {
 			if ( (popendCookie=document.cookie.indexOf( ";", e )) == -1 )
 				popendCookie = document.cookie.length;
				return unescape( document.cookie.substring( e, popendCookie ) );
 			}
 			i = document.cookie.indexOf( " ", i ) + 1;
		if ( i == 0 )
			break;
	}
	return "";
}


var POPUPFLAG = "<%=Admin.POPUPFLAG%>";
var COOKIEFLAG = getCookie("COOKIEFLAG");

if (POPUPFLAG == "Y" && COOKIEFLAG == "" && <%=login%> == true)
{
	popupopen();
}

var memoId;

function receiveMemo()
{
	var query = "mode=receiveMemo";
	var http = new JKL.ParseXML("member.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0 && result.resultXml.object) {
		var span = document.getElementById("memoContents");
		var memo = result.resultXml.object.memo;
		var regexp = new RegExp(/\n/ig);
		memo = memo.replace(regexp, "<BR>");
		span.innerHTML = memo;
		memoId = result.resultXml.object.id;
		var memoDiv = document.getElementById("memoDiv");
		memoDiv.style.visibility = "visible";
	}
}

function memoClose()
{
	var isReaded = document.getElementById("isReaded");
	if (isReaded.checked) {
		var query = "mode=readMemo";
		query += "&id=" + memoId;
		var http = new JKL.ParseXML("member.aspx", query);
		var result = http.parse();
	}
	
	var memoDiv = document.getElementById("memoDiv");
	memoDiv.style.visibility = "hidden";

	receiveMemo();
}
<%if (login) {%>
receiveMemo();
<%}%>
</script>
</center></body>

</html>