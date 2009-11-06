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
    <title>【<%=request.getParameter("type").equals("wdl")?"승무패(최신폰)":"핸디캡(최신폰)"%>】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center><a href>【<%=request.getParameter("type").equals("wdl")?"승무패(최신폰)":"핸디캡(최신폰)"%>】</a></center></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
<%
if (weblike.equals("true")) {
%>
        <div><font color="#CC00FF">※ 12시간 이내 경기만 표시됨</font></div>
        <div><form name="game_form" method="post" action="play.wap">
<%
	String type = request.getParameter("type");
	Map<String, List<Game>> gameListMap = (Map<String, List<Game>>) request.getAttribute("gameListMap");
	Collection<List<Game>> gameListCol = gameListMap.values();
%>
            <div><input type="hidden" name="token" value="<%=token%>" /></div>
            <div><input type="submit" value="배팅"/></div>
            <div><input type="hidden" name="mode" value="betting" /></div>
            <div><input type="hidden" name="type" value="<%=type%>" /></div>
        <div>금액</div>
        <div><input type="text" name="money" value="5000" format="1" /></div>
        <div>배당</div>
        <div><input type="text" name="rate" value="0.00" format="a" /></div>
        <div>예상</div>
        <div><input type="text" name="expect" value="0" format="a" /></div>
            <div><select name="league_name">
                <option value="-1" >리그를선택하세요</option>
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
%>
            <option value="W_<%=game.getId()%>_<%=game.getWinRateStr()%>" >승</option>
<%
}
%>
<%
if (game.getType().equals("wdl") && game.getDrawDeny().equals("Y") && game.getDrawRate() != 0.0) {
%>
            <option value="D_<%=game.getId()%>_<%=game.getDrawRateStr()%>" >무</option>
<%
}
%>
<%
if (game.getLoseDeny().equals("Y")) {
%>
            <option value="L_<%=game.getId()%>_<%=game.getLoseRateStr()%>" >패</option>
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
        <div>회원님의 휴대전화에서는 배팅 서비스가 지원되지 않습니다. 최신기종의 휴대전화로 교체하신후 사용해 주세요</div>
<%
}
%>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

