<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<html>
    <head>
    <title>��<%=request.getParameter("type").equals("wdl")?"�¹���(�ֽ���)":"�ڵ�ĸ(�ֽ���)"%>��</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center><a href>��<%=request.getParameter("type").equals("wdl")?"�¹���(�ֽ���)":"�ڵ�ĸ(�ֽ���)"%>��</a></center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
<%
if (weblike.equals("true")) {
%>
        <div><font color="#CC00FF">�� 12�ð� �̳� ��⸸ ǥ�õ�</font></div>
        <div><form name="game_form" method="post" action="play.wap">
<%
	String type = request.getParameter("type");
	Map<String, List<Game>> gameListMap = (Map<String, List<Game>>) request.getAttribute("gameListMap");
	Collection<List<Game>> gameListCol = gameListMap.values();
%>
            <div><input type="hidden" name="token" value="<%=token%>" /></div>
            <div><input type="submit" value="����"/></div>
            <div><input type="hidden" name="mode" value="betting" /></div>
            <div><input type="hidden" name="type" value="<%=type%>" /></div>
        <div>�ݾ�</div>
        <div><input type="text" name="money" value="5000" format="1" /></div>
        <div>���</div>
        <div><input type="text" name="rate" value="0.00" format="a" /></div>
        <div>����</div>
        <div><input type="text" name="expect" value="0" format="a" /></div>
            <div><select name="league_name">
                <option value="-1" >���׸������ϼ���</option>
<%
	for (List<Game> gameList : gameListCol) {
		int i = 0;
		Game tgame = gameList.get(0);
		String leagueId = tgame.getLeagueId();
		String leagueName = tgame.getLeagueName();
		if (i == 0) {
%>
                <option value="<%=leagueId%>" ><%=leagueName%></option>
<%
		}
	}
%>
            </select></div>
<%
	for (List<Game> gameList : gameListCol) {
		int i = 0;
		Game tgame = gameList.get(0);
		String leagueId = tgame.getLeagueId();
		String leagueName = tgame.getLeagueName();
%>
<%
if (gameList != null) {
	for (Game game : gameList) {
%>
        <div><%=XwinUtil.getBoardItemDate(game.getGameDate())%></div>
        <div><%=game.getLeagueName()%></div>
        <div>(��) x<%=game.getWinRateStr()%></div>
        <div><%=game.getHomeTeam()%></div>
<%
out.print(game.getType().equals("wdl")?"(��) ":"(�ڵ�) ");
if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
        <div>(��) x<%=game.getLoseRateStr()%></div>
        <div><%=game.getAwayTeam()%></div>
        <div><select name="game_list">
            <option value="0" >����</option>
<%
if (game.getWinDeny().equals("Y")) {
%>
            <option value="W_<%=game.getId()%>_<%=game.getWinRateStr()%>" >��</option>
<%
}
%>
<%
if (game.getType().equals("wdl") && game.getDrawDeny().equals("Y") && game.getDrawRate() != 0.0) {
%>
            <option value="D_<%=game.getId()%>_<%=game.getDrawRateStr()%>" >��</option>
<%
}
%>
<%
if (game.getLoseDeny().equals("Y")) {
%>
            <option value="L_<%=game.getId()%>_<%=game.getLoseRateStr()%>" >��</option>
<%
}
%>
        </select></div>
<%
	}
}
%>
<%
	i++;
}
%>
        </form></div>
<%
} else {
%>
        <div>ȸ������ �޴���ȭ������ ���� ���񽺰� �������� �ʽ��ϴ�. �ֽű����� �޴���ȭ�� ��ü�Ͻ��� ����� �ּ���</div>
<%
}
%>
        <btn name="����" href="main.wap?token=<%=token%>">
    </body>
</html>

