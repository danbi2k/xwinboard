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
    <title>【<%=request.getParameter("type").equals("wdl")?"승무패":"핸디캡"%>】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center><a href>【<%=request.getParameter("type").equals("wdl")?"승무패":"핸디캡"%>】</a></center></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
<%
if (weblike.equals("true")) {
%>
        <div><font color="#CC00FF">※ 12시간 이내 경기만 표시됨</font></div>
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
        <div>금액</div>
        <div><input type="text" name="money" value="<%=money%>" format="1" /></div>
        <div>배당</div>
        <div><input type="text" name="rate" value="<%=rate%>" format="a" /></div>
        <div>예상</div>
        <div><input type="text" name="expect" value="<%=expect%>" format="a" /></div>
            <div><select name="league_id">
                <option value="-1" >리그를선택하세요</option>
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
        <div>(승) x<%=game.getWinRateStr()%></div>
        <div><%=game.getHomeTeam()%></div>
<%
out.print(game.getType().equals("wdl")?"(무) ":"(핸디) ");
if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
        <div>(패) x<%=game.getLoseRateStr()%></div>
        <div><%=game.getAwayTeam()%></div>
        <div><select name="game_list">
            <option value="0" >선택</option>
<%
if (game.getWinDeny().equals("Y")) {
	String optVal = "W_" + game.getId() + "_" + game.getWinRateStr();
%>
            <option value="<%=optVal%>" <%=isSelected(game_list, optVal)%> >승</option>
<%
}
%>
<%
if (game.getType().equals("wdl") && game.getDrawDeny().equals("Y") && game.getDrawRate() != 0.0) {
	String optVal = "D_" + game.getId() + "_" + game.getDrawRateStr();
%>
            <option value="<%=optVal%>" <%=isSelected(game_list, optVal)%> >무</option>
<%
}
%>
<%
if (game.getLoseDeny().equals("Y")) {
	String optVal = "L_" + game.getId() + "_" + game.getLoseRateStr();
%>
            <option value="<%=optVal%>" <%=isSelected(game_list, optVal)%> >패</option>
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
                <option value="<%=item.getGuess() + "_" + item.getId() + "_" + item.getSelRate()%>" selected >선택</option>
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
        <div>회원님의 휴대전화에서는 배팅 서비스가 지원되지 않습니다. 최신기종의 휴대전화로 교체하신후 사용해 주세요</div>
<%
}
%>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

