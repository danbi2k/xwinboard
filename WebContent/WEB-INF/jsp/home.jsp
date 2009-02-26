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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<body bgcolor="#1a1a1a" topmargin="0" leftmargin="0" marginwidth='0' marginheight='0'>
<map name="ImageMap1">
<area shape="rect" coords="25, 22, 65, 42" href="provision.aspx" onfocus="this.blur()">
<area shape="rect" coords="86, 23, 128, 41" href="rules.aspx" onfocus="this.blur()">
<area shape="rect" coords="153, 21, 203, 41" href="aboutHandy.aspx" onfocus="this.blur()">
<area shape="rect" coords="232, 22, 383, 43" href="http://www.kofree.net/DNSFree/Setup.exe" onfocus="this.blur()">
</map>
<center>
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
					                <img src="img/login/out.jpg" border="0">&nbsp;<img src="img/login/info.jpg" border="0">&nbsp;<img src="img/login/sp.jpg" border="0">
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
			<script>mEmbed('src=img/menu.swf','width=931','height=60','wmode=#ffffff','menu=false','quality=high','bgcolor=#ffffff');</script> 
		</td>
	</tr>
	<tr>
		<td colspan="3" width="958" height="309" align="center" valign="top" background="img/m_04.jpg" style="padding-top:8;padding-left:2">
			<script>mEmbed('src=img/img.swf','width=929','height=300','wmode=#ffffff','menu=false','quality=high','bgcolor=#ffffff');</script>
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
</script>

</center></body>

</html>