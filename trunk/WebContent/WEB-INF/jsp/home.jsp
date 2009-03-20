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
<body bgcolor="#000000" topmargin="0" leftmargin="0" marginwidth='0' marginheight='0'>
<map name="ImageMap1">
<area shape="rect" coords="551, 26, 596, 47" href="provision.aspx" onfocus="this.blur()">
<area shape="rect" coords="614, 25, 660, 49" href="rules.aspx" onfocus="this.blur()">
<area shape="rect" coords="682, 24, 736, 48" href="aboutHandy.aspx" onfocus="this.blur()">
<area shape="rect" coords="757, 28, 920, 46" href="http://www.kofree.net/DNSFree/Setup.exe" onfocus="this.blur()">
</map>
<map name="ImageMap2">
<area shape="rect" coords="5, 6, 54, 22" href="moneyIn.aspx?mode=viewMoneyInRequest">
<area shape="rect" coords="73, 2, 126, 21" href="moneyOut.aspx?mode=viewMoneyOutRequest">
<area shape="rect" coords="142, 3, 193, 22" href="myMoney.aspx?mode=viewMyMoneyList">
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

<table cellpadding="0" cellspacing="0" width="929" align="center">
    <tr>
        <td width="213">
            <p><a href="home.aspx"><img src="img/logo.jpg" border="0"></a></p>
        </td>
        <td width="716">
            <p><script>mEmbed('src=img/menu.swf','width=716','height=62','wmode=opaque','menu=false','quality=high','bgcolor=#ffffff');</script></p>
        </td>
    </tr>
</table>
<table cellpadding="0" cellspacing="0" width="929" align="center">
    <tr>
        <td width="929" align="left">
			<%if (login) { %>
            <div align="left">
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
					              		<a href='javascript:exchangePoint(<%=member.getPoint()%>)'><%=XwinUtil.comma3(member.getPoint())%></a>         
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
			<%} %>
        </td>
		 <td width="279" height="30" align="right">
            <p><img src="img/m.jpg" border="0" usemap="#ImageMap2">&nbsp;&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="929" height="380" colspan="2" background="">
            <p><script>mEmbed('src=img/img.swf','width=929','height=373','wmode=opaque','menu=false','quality=high','bgcolor=#ffffff');</script></p>
        </td>
    </tr>
    <tr>
        <td width="929" height="80" colspan="2" background="img/m_06.jpg" style="background-repeat:no-repeat">
            <table id="notice" width="900" height="80" border="0" cellpadding="0" cellspacing="0">
			   <tr>
		         <td width="900" height="80" class="notice" align="center" style="padding-top:35;padding-left:15">
				 <marquee onmouseover='this.stop()' onmouseout='this.start()'>
                 <%=Admin.NOTICE%>    
	             </marquee>
			     </td>
	           </tr>
			</table>
        </td>
    </tr>
	</table>

<table cellpadding="0" cellspacing="0" width="929" height="150" align="center">
    <tr>
        <td width="238" height="398">
            <p><img src="img/m_07.jpg" width="238" height="398" border="0" alt="m_07.jpg"></p>
        </td>
        <td width="691" height="398">
            <p><img src="img/m_09.jpg" width="691" height="398" border="0" alt="m_09.jpg"></p>
        </td>
    </tr>
    <tr>
        <td width="929" height="108" colspan="2">
            <p><img src="img/m_10_.jpg" width="929" height="108" border="0" alt="m_10_.jpg"></p>
        </td>
    </tr>
    <tr>
        <td width="929" height="92" colspan="2">
            <p><img src="img/table_04.jpg" width="929" height="92" border="0" alt="table_03.jpg" usemap="#ImageMap1"></p>
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
		if (memo == undefined)
			return;
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