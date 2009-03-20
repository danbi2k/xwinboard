<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.dao.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="java.util.*" %>
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
<script>
var memoId;

function receiveMemo()
{
	var query = "mode=receiveMemo";
	var http = new JKL.ParseXML("member.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0 && result.resultXml.object) {
		var span = document.getElementById("memoContents");
		var memo = result.resultXml.object.memo;
		if (memo == undefined) {
			return;
		}
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

<center>
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
        <td width="650" align="left">
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
        <td width="929" height="80" colspan="2" background="img/m_06_.jpg" style="background-repeat:no-repeat">
            <table id="notice" width="900" height="80" border="0" cellpadding="0" cellspacing="0" align="center">
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
		<td width="929" height="33" align="center" valign="middle" background="img/table_01.jpg">
			
		</td>
	</tr>


	<tr>
		<td width="929" height="683" align="center" valign="top" background="img/table_02.jpg">
            <table align="center" cellpadding="0" cellspacing="0" width="887" height="40">