<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*" %>

<%
	Member member = (Member) session.getAttribute("Member");
	boolean login = member == null ? false : true;
%>
<html>

<head>
<title>10xBet-local</title>
    <Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=Euc-Kr">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Refresh" Content="1800; URL=/member/logout.asp?auto=1">

    <link rel="stylesheet" href="common/default.css">
    <script language="JavaScript" src="common/default.js"></script>
	<script language="JavaScript" src="common/game.js"></script>
	<script language="JavaScript" src="common/member.js"></script>
	<script language="JavaScript" src="common/board.js"></script>
	<script language="JavaScript" src="common/jkl-parsexml.js"></script>
</head>
<body style="margin:0" oncontextmenu="return false">
<a name="top"></a>


<table width="960" height="76" cellpadding="0" cellspacing="0" background="images/top_bg.jpg">
<tr><td width="207" align="center"><a href="index.aspx"><img src="images/top_logo.jpg" border="0"></a></td>
    <td width="753" valign="bottom" align="right">
		<table align="right" width="712" height="33" cellpadding="0" cellspacing="0">

		<tr><td valign="top" bgcolor="white">
			<IMG id="top1" style="position:absolute;" SRC="images/top_menu0.gif" USEMAP="#map_top_menu" BORDER="0">
			<IMG id="top2" style="position:absolute;filter:alpha(opacity=100)" SRC="images/top_menu1.gif" USEMAP="#map_top_menu" BORDER="0"  style="cursor:hand;">
		</td></tr>
		</table>
	</td>
</tr>
</table>

<MAP NAME="map_top_menu">
	<AREA SHAPE=RECT COORDS="  0,0,100,33" href="gameWdl.jsp" onMouseOver="clipthis('top1','top2',  0,0,100,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="102,0,197,33" href="gameHandy.jsp" onMouseOver="clipthis('top1','top2',102,0,197,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="199,0,281,33" href="gameOE.jsp" onMouseOver="clipthis('top1','top2',199,0,281,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="283,0,387,33" href="result.jsp"	 onMouseOver="clipthis('top1','top2',283,0,387,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="389,0,507,33" href="guide.jsp"   onMouseOver="clipthis('top1','top2',389,0,507,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="509,0,613,33" href="rules.jsp"	 onMouseOver="clipthis('top1','top2',509,0,613,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
	<AREA SHAPE=RECT COORDS="615,0,712,33" href="board.jsp"   onMouseOver="clipthis('top1','top2',615,0,712,33)" onmouseout="top_menu_out();" onfocus="this.blur();">
</MAP>


<script language="JavaScript">
function top_menu_out(){
    if (window.menu_out){ clearInterval(menu_out); }
    menu_out=setInterval("top_menu_init()",500);
}
function top_menu_init(){
    if (window.menu_out){ clearInterval(menu_out); }
	
		clipthis('top1','top2', 0,0,100,33,100);	
		
	
}
function clipthis(menu1,menu2,clipleft,cliptop,clipright,clipbottom,alpha){
	if (window.menu_out){ clearInterval(menu_out); }
    var obj1 = document.getElementById(menu1);
    var obj2 = document.getElementById(menu2);
    obj2.filters.alpha.opacity=alpha;
    high(obj2);
    if (document.all) { obj2.style.clip ="rect("+cliptop+" "+clipright+" "+clipbottom+" "+clipleft+")"; }
    if (document.layers) { obj2.clip.left=clipleft; obj2.clip.right=clipright; obj2.clip.top=cliptop; obj2.clip.bottom=clipbottom; }
}
function high(obj){
    theobject=obj;
    if (window.highlighting){ clearInterval(highlighting); }
    highlighting=setInterval("highlightit(theobject,100,true)",20);
}
function highlightit(obj,val,view){
	if(view){
	    if (obj.filters.alpha.opacity<val){ obj.filters.alpha.opacity+=10; } else if (window.highlighting){ clearInterval(highlighting); }
	}else{
		if (obj.filters.alpha.opacity>val){ obj.filters.alpha.opacity-=10; } else if (window.highlighting){ clearInterval(highlighting); }
	}
}
top_menu_init();
</script>

<iframe name='hidden_iframe' style='display:none' src='About:Blank'></iframe>
<table width="960" height="42" background="images/login_bg.jpg" cellpadding="0" cellspacing="0" >

<%
if (login) {
%>
<tr><td>

	<table>
	<tr>
	<td><img src="images/login_img2.gif" hspace="10"></td>
	<td align="center"><b><%=member.getNickName()%></b></td>

	<td style="padding-right:10;padding-left:10;">
		<table cellpadding="0" cellspacing="0">
		<tr><td><img src="images/money_1.gif"></td>
			<td background="images/money_2.gif" width="40" align="right" style="padding-left:5;color:orange;padding-top:3;">0</td>
			<td><img src="images/money_3.gif"></td>			
		</tr>
		</table>
	</td>	
	<td><img src="images/btn_logout.gif" onclick="FnLogout();" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';"></td>

	<td><img src="images/btn_meminfo.gif" onclick="location.href='modify.jsp'" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';"></td>
	<td><img src="images/btn_mybet.gif" onclick="location.href='mybet.jsp'" style="cursor:hand;"></td>
	</tr>
	</form>
	</table>

</td><td align="right">

	<table cellpadding="0" cellspacing="0">
	<tr>

	<td><img src="images/smenu_1.gif" onclick="location.href='inmoney.jsp';" style="cursor:hand"></td>
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_2.gif" onclick="location.href='outmoney.jsp';" style="cursor:hand"></td>
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_3.gif" onclick="location.href='mymoney.jsp';" style="cursor:hand"></td>
<!--
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_5.gif"></td>
//-->
	</tr>
	</table>

</td></tr>

<% } else { %>
	<form name="login_frm" onsubmit="FnLogin_Submit(this);return false;">
<tr><td align="left">
	<table cellpadding="0" cellspacing="0"><tr>
	<td><img src="images/login_img.gif" hspace="10"></td>
	<td><img src="images/login_id.gif"></td>
	<td><input class="member" type="text" name="id" hspace="2"></td>
	<td><img src="images/login_pw.gif" hspace="3"></td>
	<td><input class="member" type="password" name="pw"></td>

	<td><input type="image" src="images/btn_login.gif" style="cursor:hand;" hspace="5"></td>
	<td><img src="images/btn_join.gif" hspace="5" onclick="location.href='member/join.asp';" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';"></td>
	</tr></table>

	</td>
	<td width="*" align="right">

	<table cellpadding="0" cellspacing="0">
	<tr>
	<td><img src="images/smenu_1.gif"></td>

	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_2.gif"></td>
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_3.gif"></td>
	<td><img src="images/smenu_gap.gif"></td>
	<td><img src="images/smenu_4.gif"></td>
	</tr>
	</table>

</td></tr>
</form>

<%} %>
</table>
<%if (false) { %>
<script>FnFlash("main","960","280","images/main.swf","");</script>
<%} %>
<table width="960" height="25" style="border:1 solid #909090;margin-bottom:5px;" background="images/dot_02.gif">
<tr><td width="80" align="center"><b style="color:white">Notice</td>
	<td width="880">&nbsp;
	<marquee>
	★ 입금계좌 변경안내 ★ 계좌를 확인하시고 충전신청바랍니다.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	[x10bet@hotmail.com] 관리자 이메일(MSN)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	★ 배팅제한 최소1천원 ~ 최대100만원 적중지급상한 300만원 ★ 승무패, 핸디캡, 홀짝 다양한배팅방식 최고의 서비스 3분이내 입출금&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	</marquee>
	</td>
</tr>
</table>