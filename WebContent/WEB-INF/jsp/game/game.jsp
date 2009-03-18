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
%>

<script>
var gameType = '<%=type%>'

function thisReload()
{
	location.reload();
}

setInterval(thisReload, 180000);
</script>
			<tr><td><img src="img/menu0<%=img%>.jpg" border="0"></td></tr>
		
            </table>
       <table align="center" cellpadding="0" cellspacing="0" width="887" height="40" background="img/bar.jpg">
   		 <tr>
        <td width="90" height="40" align="center" valign="middle" class="menubar">
            <p>경기일시</p>
        </td>
        <td width="135" height="40" align="center" valign="middle" class="menubar">
            <p>리그</p>
        </td>
        <td width="250" height="40" align="center" valign="middle" class="menubar">
            <p>승(홈팀)</p>
        </td>
        <td width="80" height="40" align="center" valign="middle" class="menubar">
            <p><%=type.equals("mix")?"무/핸디":type.equals("wdl")?"무":"핸디" %></p>
        </td>
        <td width="250" height="40" align="center" valign="middle" class="menubar">
            <p>패(원정팀)</p>
        </td>
        <td width="40" height="40" align="center" valign="middle" class="menubar">
            <p>상태</p>
        </td>
        <td width="42" height="40" align="center" valign="middle" class="menubar">
            <p>공지</p>
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
            <p><%=game.getHomeTeam()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=game.getWinRateStr()%>&nbsp;</p>
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
					
			%></p>
        </td>
        <td width="250" class='<%=game.getLoseDeny().equals("Y")?"tablebg"+x:"tablebg3"%>' align="left" valign="middle" onClick="FnGameBet(this, <%=game.getId()%>, '<%=type%>', 'L')" id="checkL<%=game.getId()%>">
            <p>&nbsp;&nbsp;&nbsp;<%=game.getLoseRateStr()%>&nbsp;&nbsp;&nbsp;<%=game.getAwayTeam()%></p>
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
  <table align="center" cellpadding="0" cellspacing="0" width="469">
    <tr>
         <td width="569" align="right" valign="middle" height="45" background="img/cart_01.jpg">
            <a href='bettingCart.aspx?mode=viewBettingCart'><img src="img/cartview.gif" border="0" align="absbottom"></a>&nbsp;
			<img src="img/alldelete.gif" border="0" align="absbottom" onclick="FnDeleteFolder('<%=type%>')">&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
         <td width="569" align="center" valign="middle" background="cart_02.jpg">
		<div id="gameFolderDiv">
		</div>
        </td>
    </tr>
    <tr><td bgcolor="#000000" height="5"></td></tr>
    <tr>
        <td width="569" height="90" bgcolor="#0000000">
   <table cellpadding="0" cellspacing="0" width="569" height="1">
    <tr>
        <td width="84" height="31">
            <p>&nbsp;</p>
        </td>
        <td width="87" height="31">
                        <p>배팅금액</p>
        </td>
        <td width="239" height="31">
            <p><input id='moneyDiv' name="m_id" type="text" class="input3" id="11" value='5,000' onkeyup='FnCalcFolder()'></p>
        </td>
        <td width="159" height="31">
            <p>&nbsp;<img src="img/bett.jpg" width="67" height="25" border="0" alt="bett.jpg" onclick="FnBetting()"></p>
        </td>
    </tr>
    <tr>
        <td width="84" height="30">
            <p>&nbsp;</p>
        </td>
        <td width="87" height="30">
                        <p>예상배당율</p>
        </td>
        <td width="239" height="30">
            <p id='rateDiv'>0.00</p>
        </td>
        <td width="159" height="30">
            <p>&nbsp;<img src="img/cart.jpg" width="67" height="25" border="0" alt="cart.jpg" onclick="FnAddBettingCart()"></p>
        </td>
    </tr>
    <tr>
        <td width="84" height="30">
            <p>&nbsp;</p>
        </td>
        <td width="87" height="30">
                        <p>예상적중금</p>
        </td>
        <td width="239" height="30">
            <p id='expectDiv'>0</p>
        </td>
        <td width="159" height="30">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
        </td>
    </tr>
  </table>
  </div>
  <BR>
<script>
function getNote(gameId)
{
	var query = "mode=getNote";
	query += "&gameId=" + gameId;
	var http = new JKL.ParseXML("game.aspx", query);
	var result = http.parse();
	if (result.resultXml.code == 0)
		alert(result.resultXml.message);
}
</script>

<%@include file="../footer.jsp"%>