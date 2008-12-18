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
<title>OkBet</title>
    <Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=Euc-Kr">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Refresh" Content="1800; URL=login.php?mode=processLogout">

    <link href="style/style.css" rel="stylesheet" type="text/css">
	<link href="style/default.css" rel="stylesheet" type="text/css">
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
	<script language="JavaScript" src="script/swf.js"></script>
	<script language="JavaScript" src="script/common.js"></script>
	<script language="JavaScript">
	<%
	if (login == false && isIndex == false) {
	%>
	alert("로그인이 필요합니다");
	location.href = "login.php?mode=processLogout";
	<%
	}
	%>
	</script>
</head>


<BODY style="margin:0" bgcolor=000000 >
<table border="0" cellpadding="0" cellspacing="0" width=1003 align=center>
    <tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td ><a name='' onMouseDown="document.location='home.php'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=images/top011.jpg></a></td>
                    <td><script language='JavaScript'><!--
                    setFlash('images/menu.swf', '650', '73');//-->
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
                    <td ><img src=images/top02.jpg></td>
                    <td >
						<table border="0" cellpadding="0" cellspacing="0" height="27" width=100%>
							<tr>
								<td><nobr><font color=FFFFFF><b><%=member.getNickName()%></b>님 환영합니다.</td>
								<td ><nobr>&nbsp;&nbsp;<b>내 베팅머니 &nbsp;[ <font color=FFC700><%=XwinUtil.comma3(member.getBalance())%></font> C ]&nbsp;&nbsp;</td>
								<td ><nobr>&nbsp;&nbsp;<b>내 포인트 &nbsp;[ <font color=FFC700><%=XwinUtil.comma3(member.getPoint())%></font> P ]</td>
								<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/modify.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=images/btn_modify.gif align=absmiddle ></td>
								<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/logout.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=images/btn_logout.gif align=absmiddle ></td>
								<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='/member/MybetList.asp'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><img src=images/btn_betinfo.gif align=absmiddle ></td>
								
								<td width=50>&nbsp;</td>
								
								<td>
									<table border="0" cellpadding="0" cellspacing="0" width=100%>
										<tr>		
											<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='moneyIn.php?mode=viewMoneyInRequest'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><font color=FFC602><b>[캐쉬충전]</td>
											<td ><nobr>&nbsp;&nbsp;<a name='' onMouseDown="document.location='moneyOut.php?mode=viewMoneyOutRequest'" onMouseOver="this.style.color='#506CC8';this.style.fontWeight='bold';window.status='KOR-OKBET.COM' ;return true" onMouseOut="this.style.color='';this.style.fontWeight='normal'" style='cursor:hand' onfocus='this.blur()'><font color=FFC602><b>[캐쉬환전]</td>
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
	<tr><td height=1 bgcolor="424142"></td></tr>
	<tr><td height=15 ></td></tr>

	<tr>
        <td >
        
        
            <table border="0" cellpadding="0" cellspacing="0"  >
                <tr>
                    <td ><img src=images/top02.gif></td>
                    <td width=903 valign=bottom style="margin-right:10pt" background=images/top03.gif>
						<marquee id=cnj direction="left" height="27" scrollamount="10" onmouseover="cnj.stop()" onmouseout="cnj.start()">
						<table border="0" cellpadding="0" cellspacing="0" height="36" width=90%>
							<tr>
							</tr>
						</table>
						</marquee >
					
                    </td>
                    <td ><img src=images/top04.gif></td>
				</tr>
			</table>
			
		</td>
	</tr>

