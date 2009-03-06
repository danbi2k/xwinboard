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
<body bgcolor="#1a1a1a" topmargin="0" leftmargin="0" marginwidth='0' marginheight='0' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<map name="ImageMap2">
<area shape="rect" coords="24, 51, 64, 71" href="provision.aspx" onfocus="this.blur()">
<area shape="rect" coords="86, 52, 128, 70" href="rules.aspx" onfocus="this.blur()">
<area shape="rect" coords="152, 51, 202, 71" href="aboutHandy.aspx" onfocus="this.blur()">
<area shape="rect" coords="233, 50, 384, 71" href="http://www.kofree.net/DNSFree/Setup.exe" onfocus="this.blur()">
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
<table id="" width="1100" height="300" cellpadding="0" cellspacing="0">
	<tr>
		<td width="958" height="81" valign="top" background="img/s_01.jpg">
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
									<td width="451" height="25" align="left" valign="middle" class="maint" style="padding-left:80">
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
		<td rowspan="6" width="142" height="1170" background="img/s_02.jpg">
	
		</td>
	</tr>
	<tr>
		<td width="958" width="958" height="60" align="center" valign="middle" background="img/s_03.jpg">
			<script>mEmbed('src=img/menu2.swf','width=931','height=60','wmode=#ffffff','menu=false','quality=high','bgcolor=#ffffff');</script> 
		</td>
	</tr>
	<tr>
		<td width="958" height="113" valign="top" class="notice" align="center" background="img/s_04.jpg">
			  <table id="notice" width="900" height="50" border="0" cellpadding="0" cellspacing="0">
			   <tr>
		         <td width="880" height="50" class="notice" align="center" style="padding-left:50;padding-top:74;">
				 <marquee onmouseover='this.stop()' onmouseout='this.start()'>
				<%=Admin.NOTICE%>
	             </marquee>
			     </td>
	           </tr>
			</table>
 		
		</td>
	</tr>
	<tr>
		<td width="958" height="38" align="center" valign="middle" background="img/table_01.jpg">
			
		</td>
	</tr>


	<tr>
		<td width="958" height="683" align="center" valign="top" background="img/table_02.jpg">
            <table align="center" cellpadding="0" cellspacing="0" width="887" height="40">	