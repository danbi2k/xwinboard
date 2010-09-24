<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../header.jsp"%>

<%
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	request.setAttribute("isIndex", Boolean.TRUE);
	String type = request.getParameter("type");
	String grade = request.getParameter("grade");
	String img = grade.equals("10")?"3":type.equals("wdl")?"1":"2";
	boolean show = member.getMemberId().equals(1);
%>

<script>
var gameType = '<%=type%>'

function thisReload()
{
	location.reload();
}

setInterval(thisReload, 900000);
</script>
			<tr><td><img src="images/menu0<%=img%>1.jpg" border="0"></td></tr>
		
</table>
       <table align="center" cellpadding="0" cellspacing="0" width="887" height="40"  background="images/bar1.gif">
   		 <tr>
        <td width="90" height="40" font color="#1a1a1a" align="center" valign="middle" class="menubar">
            <p><strong>경기일시</strong></p>
        </td>
        <td width="135" height="40" align="center" valign="middle" class="menubar">
            <p><strong>리그</strong></p>
        </td>
        <td width="250" height="40" align="center" valign="middle" class="menubar">
            <p><strong>승(홈팀)</strong></p>
        </td>
        <td width="80" height="40" align="center" valign="middle" class="menubar">
            <p><strong><%=type.equals("mix")?"무/핸디":type.equals("wdl")?"무":"핸디" %></strong></p>
        </td>
        <td width="250" height="40" align="center" valign="middle" class="menubar">
            <p><strong>패(원정팀)</strong></p>
        </td>
        <td width="40" height="40" align="center" valign="middle" class="menubar">
            <p><strong>상태</strong></p>
        </td>
        <td width="42" height="40" align="center" valign="middle" class="menubar">
            <p><strong>공지</strong></p>
        </td>
    </tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" class="table887">
<%
if (gameList != null) {
	for (Game game : gameList) {
		boolean accept = game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT);
		int x = accept?1:3;
		int y = accept?2:4;
%>

    <tr>
        <td width="90" class="tablebg3" align="center" valign="middle">
            <p><%=XwinUtil.getBoardItemDate(game.getGameDate())%></p>
        </td>
        <td width="135" class="tablebg4" align="left" valign="middle">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;<img width=22 height=14 src="images/league/<%=game.getLeagueImage()%>"> <%=game.getLeagueName()%></p>
        </td>
        <td width="250" class='<%=game.getWinDeny().equals("Y")?"tablebg"+x:"tablebg3"%>' align="right" valign="middle" onClick="FnGameBet(this, <%=game.getId()%>, '<%=type%>', 'W')" id="checkW<%=game.getId()%>">
            <p><%=show?"("+XwinUtil.comma3(game.getWinMoney())+") ":""%><%=game.getHomeTeam()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=game.getWinRateStr()%>&nbsp;</p>
        </td>
        <td width="80" class='<%=game.getType().equals("handy")||game.getType().equals("wdl")&&(game.getDrawRate()==0||game.getDrawDeny().equals("N"))?"tablebg4":"tablebg"+y%>' align="center" valign="middle" onClick="FnGameBet(this, <%=game.getId()%>, '<%=type%>', 'D')" id="checkD<%=game.getId()%>">
            <p><%
				if (game.getType().equals("wdl")) {
					if (game.getDrawRate()==0||game.getDrawDeny().equals("N"))
						out.print("x");
					else
						out.print(game.getDrawRateStr());
				} else {
					if (game.getDrawRate() > 0)
						out.print("+");
					out.print(game.getDrawRate());
				}
					
			%><%=show&&type.equals("wdl")?"<br>("+XwinUtil.comma3(game.getDrawMoney())+")":""%></p>
        </td>
        <td width="250" class='<%=game.getLoseDeny().equals("Y")?"tablebg"+x:"tablebg3"%>' align="left" valign="middle" onClick="FnGameBet(this, <%=game.getId()%>, '<%=type%>', 'L')" id="checkL<%=game.getId()%>">
            <p>&nbsp;&nbsp;&nbsp;<%=game.getLoseRateStr()%>&nbsp;&nbsp;&nbsp;<%=game.getAwayTeam()%><%=show?" ("+XwinUtil.comma3(game.getLoseMoney())+")":""%></p>
        </td>
        <td width="40" class="tablebg<%=y%>" align="center" valign="middle">
            <p><%=Code.getValue(game.getBetStatus())%></p>
        </td>
        <td width="40" class="tablebg<%=x%>" align="center" valign="middle">
            <p>
			<%if (game.getNote() != null && game.getNote().length() > 0) { %>
			<span onclick="getNote(<%=game.getId()%>)">공지</span>
			<%} %>
			</p>
        </td>
    </tr>
<%
	}
}
%>
</table>

    <table align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="40" >
           
        </td>
    </tr>
   
  </table>

  <div align="center">
  <table align="center" cellpadding="0" cellspacing="0" width="569">
    <tr>
        <td width="569" align="right" height="40" background="images/carthead1.jpg">
            <a href='cart.php?mode=viewBettingCart'><img src="images/cartview.gif" border="0" align="absbottom"></a>&nbsp;
			<img src="images/alldelete.gif" border="0" align="absbottom" onclick="FnDeleteFolder('<%=type%>')">&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td width="569" align="center">
		<div id="gameFolderDiv">
		</div>
        </td>
    </tr>
    <tr>
        <td width="569">
		   <table cellpadding="0" cellspacing="0" width="569" height="91" border="0">
			    <tr>
			        <td width="100" height="30">
			            <p>배당율</p>
			        </td>
			        <td width="299" height="30">
			            <p id='rateDiv'>0.00</p>
			        </td>
			        <td width="70" height="30">
			            <p>&nbsp;<img src="images/cart.jpg" width="67" height="25" border="0" alt="cart.jpg" onclick="FnAddBettingCart()"></p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="31">
			            <p>배팅금액</p>
			        </td>
			        <td width="299" height="31">
			            <p><input id='moneyDiv' name="m_id" type="text" class="input3" id="11" value='5,000' onkeyup='FnCalcFolder()'></p>
			        </td>
			        <td width="70" height="31">
			            <p>&nbsp;<img src="images/bett.jpg" width="67" height="25" border="0" alt="bett.jpg" onclick="FnBetting()"></p>
			        </td>
			    </tr>
			    <tr>
			        <td width="100" height="30">
			            <p>예상적중액</p>
			        </td>
			        <td width="299" height="30">
			            <p id='expectDiv'>0</p>
			        </td>
			        <td width="70" height="30">
			            <p>&nbsp;</p>
			        </td>
			    </tr>
		  </table>
        </td>
    </tr>
  </table>
  </div>

<%@include file="../footer.jsp"%>