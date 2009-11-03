<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1" title="<%=request.getParameter("type").equals("wdl")?"�¹���":"�ڵ�ĸ"%>">
        <p mode="wrap">�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</p>
        <p>----------------</p>
<%
if (weblike.equals("true")) {
%>
        <p mode="wrap">�� 8�ð� �̳� ��⸸ ǥ�õ�</p>
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
        <p mode="nowrap"><do type="accept" label="����" name="submit1">
            <go href="" method="post">
                <postfield name="token" value="<%=token%>"/>
            </go>
        </do></p>
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
        <p mode="wrap">�ݾ�</p>
        <p><input type="text" name="money" value="<%=money%>" format="N*N" emptyok="true" /></p>
        <p mode="wrap">���</p>
        <p><input type="text" name="rate" value="<%=rate%>" format="x*x" emptyok="true" /></p>
        <p mode="wrap">����</p>
        <p><input type="text" name="expect" value="<%=expect%>" format="x*x" emptyok="true" /></p>
        <p><select name="league_id" ivalue="2">
            <option value="-1" >���׸������ϼ���</option>
<%
	Set<String> keySet = leagueListMap.keySet();
	for (String leagueId : keySet) {
		String leagueName = leagueListMap.get(leagueId);
%>
            <option value="<%=leagueId%>" ><%=leagueName%></option>
<%
	}
%>
        </select></p>
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
        <p mode="wrap"><%=XwinUtil.getBoardItemDate(game.getGameDate())%></p>
        <p mode="wrap"><%=game.getLeagueName()%></p>
        <p mode="wrap">(��) x<%=game.getWinRateStr()%></p>
        <p mode="wrap"><%=game.getHomeTeam()%></p>
<%
out.print(game.getType().equals("wdl")?"(��) ":"(�ڵ�) ");
if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
        <p mode="wrap">(��) x<%=game.getLoseRateStr()%></p>
        <p mode="wrap"><%=game.getAwayTeam()%></p>
        <p><select name="game_list" ivalue="2;3;4">
            <option value="0" >����</option>
<%
if (game.getWinDeny().equals("Y")) {
	String optVal = "W_" + game.getId() + "_" + game.getWinRateStr();
%>
            <option value="<%=optVal%>" >��</option>
<%
}
%>
<%
if (game.getType().equals("wdl") && game.getDrawDeny().equals("Y") && game.getDrawRate() != 0.0) {
	String optVal = "D_" + game.getId() + "_" + game.getDrawRateStr();
%>
            <option value="<%=optVal%>" >��</option>
<%
}
%>
<%
if (game.getLoseDeny().equals("Y")) {
	String optVal = "L_" + game.getId() + "_" + game.getLoseRateStr();
%>
            <option value="<%=optVal%>" >��</option>
<%
}
%>
        </select></p>
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
        <p mode="wrap"><%=item.getHomeTeam()%></p>
        <p mode="wrap"><%=item.getAwayTeam()%></p>
        <p><select name="game_list" ivalue="1">
            <option value="<%=item.getGuess() + "_" + item.getId() + "_" + item.getSelRate()%>" >����</option>
        </select></p>
<%
			}
		}
	}		
%>
<%
} else {
%>
        <p mode="wrap">ȸ������ �޴���ȭ������ ���� ���񽺰� �������� �ʽ��ϴ�. �ֽű����� �޴���ȭ�� ��ü�Ͻ��� ����� �ּ���</p>
<%
}
%>
        <do type="vnd.up" label="����"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>

