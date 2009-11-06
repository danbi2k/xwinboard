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
    <title>��<%=request.getParameter("type").equals("wdl")?"�¹���":"�ڵ�ĸ"%>��</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center><a href>��<%=request.getParameter("type").equals("wdl")?"�¹���":"�ڵ�ĸ"%>��</a></center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
<%
if (weblike.equals("true")) {
%>
        <div><font color="#CC00FF">�� 12�ð� �̳� ��⸸ ǥ�õ�</font></div>
<%
	String type = request.getParameter("type");
	String money = XwinUtil.nvl(request.getParameter("money"), "5000");
	String rate =  XwinUtil.nvl(request.getParameter("_rate"), "0.00");
	String expect =  XwinUtil.nvl(request.getParameter("_expect"), "0");
	String league_id = XwinUtil.nvl(request.getParameter("league_id"));
	String[] game_list = (String[]) request.getParameterValues("game_list");
	Map<String, String> leagueListMap = (Map<String, String>) request.getAttribute("leagueListMap");
	Map<String, List<Game>> gameListMap = (Map<String, List<Game>>) request.getAttribute("gameListMap");
	GameFolder gameFolder = (GameFolder) request.getAttribute("gameFolder");
	Collection<List<Game>> gameListCol = gameListMap.values();
%>
<%!
	private String isSelected(String[] list, String val) {
		String retVal = "";
		if (list == null)
			return retVal;
		
		for (int i = 0 ; i < list.length ; i++) {
			if (list[i].equals(val))
				retVal = "selected";
		}
		return retVal;
	}
%>
            <div><input type="hidden" name="mode" /></div>
            <div><input type="hidden" name="type" value="<%=type%>" /></div>
            <div><input type="hidden" name="_rate" /></div>
            <div><input type="hidden" name="_expect" /></div>
        <div>�ݾ�</div>
        <div><input type="text" name="money" value="<%=money%>" format="1" /></div>
        <div>���</div>
        <div><input type="text" name="rate" value="<%=rate%>" format="a" /></div>
        <div>����</div>
        <div><input type="text" name="expect" value="<%=expect%>" format="a" /></div>
            <div><select name="league_id">
                <option value="-1" >���׸������ϼ���</option>
<%
	Set<String> keySet = leagueListMap.keySet();
	for (String leagueId : keySet) {
		String leagueName = leagueListMap.get(leagueId);
%>
                <option value="<%=leagueId%>" <%=league_id.equals(leagueId)?"selected":""%> ><%=leagueName%></option>
<%
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
	String optVal = "W_" + game.getId() + "_" + game.getWinRateStr();
%>
            <option value="<%=optVal%>" <%=isSelected(game_list, optVal)%> >��</option>
<%
}
%>
<%
if (game.getType().equals("wdl") && game.getDrawDeny().equals("Y") && game.getDrawRate() != 0.0) {
	String optVal = "D_" + game.getId() + "_" + game.getDrawRateStr();
%>
            <option value="<%=optVal%>" <%=isSelected(game_list, optVal)%> >��</option>
<%
}
%>
<%
if (game.getLoseDeny().equals("Y")) {
	String optVal = "L_" + game.getId() + "_" + game.getLoseRateStr();
%>
            <option value="<%=optVal%>" <%=isSelected(game_list, optVal)%> >��</option>
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
<%
	if (gameFolder != null) {
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		if (itemList != null) {
			for (GameFolderItem item : itemList) {
				if (item.getLeagueId().equals(league_id))
					continue;
%>
            <div><%=item.getHomeTeam()%></div>
            <div><%=item.getAwayTeam()%></div>
            <div><select name="game_list">
                <option value="<%=item.getGuess() + "_" + item.getId() + "_" + item.getSelRate()%>" selected >����</option>
            </select></div>
<%
			}
		}
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

