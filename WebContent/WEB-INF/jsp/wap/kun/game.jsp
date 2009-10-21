<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<% if (Integer.parseInt(lcdlx) >= 240) {
    response.setHeader("KTF-Page-Resolution:","240x320");
} else if (Integer.parseInt(lcdlx) >= 176) {
    response.setHeader("KTF-Page-Resolution:","176x220");
} else if (Integer.parseInt(lcdlx) >= 128) {
    response.setHeader("KTF-Page-Resolution:","128x160");
} else {
    response.setHeader("KTF-Page-Resolution:","120x160");
} %>
<html>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
<% if (javascript.equals("true")) { %>
    <script language="JavaScript" type="text/JavaScript">
        <!--
        function change_money(tobj)
        {
        }
        
        function select_game(tobj)
    	{
    		var money = document.game_form.money.value;
    		if (money == undefined || money < 0)
    			money = 0;
			
    		var rate = 0.0;
    		var list = document.game_form.game_list;
    		var sel_count = 0;
    		
    		for (var x = 0 ; x < list.length ; x++) {
    			if (list[x].value != undefined && list[x].value != 0) {
    				sel_count ++;
    				var t = list[x].value.split("_");
    				if (rate == 0.0)
    					rate = t[2];
    				else
    					rate *= t[2];
    			}
    		}

    		if (sel_count > 2) {
    			tobj.value = 0;
    			alert('10 폴더를 초과하였습니다');
    			return;
    		}
    		
    		var rate_digit2 = digit2(rate);
    		var expect = getInt(rate_digit2 * money)
    		
    		if (expect > 3000000) {
        		tobj.value = 0;
    			alert('예상 배당금은 3,000,000캐쉬 이하만 허용 됩니다');
    			return;
    		}
    		
    		document.game_form.rate.value = rate_digit2;
    		document.game_form.expect.value = expect;
    	}

        function digit2(value)
        {
        	if (value == 0)
        		value = "0.0";
        	var str = "" + value;
        	if (str.indexOf(".") < 0)
        		str += "."
        	str = str + "000";
        	var num = str.split(".");
        	var frag = num[1].substr(0, 2);
        	
        	var ret = num[0] + "." + frag;
        	
        	return ret;
        }
	
        function getInt(value)
        {
        	if (value == 0)
        		value = "0";
        	var str = "" + value;
        	var num = str.split(".");

        	return num[0];
        }
        -->
    </script>
<% } %>
    </head>
    <body>
        <% if (network.equals("wcdma")) { %><a href='#' accesskey='#'></a><% } %>
<% if (weblike.equals("true")) { %>
    <script language="JavaScript" type="text/JavaScript">
        <!--
        var anyvx=null;
        function vx_contents(content)
        {
            var obj = document.getElementById(content);
            if(obj.getAttribute("style")=="display:none") {
                obj.setAttribute("style","");
                if(anyvx != null && anyvx != obj) {
                    anyvx.setAttribute("style","display:none");
                }
                anyvx = obj;
            } else {
                obj.setAttribute("style","display:none");
            }
        }
        -->
    </script>
<% } %>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" color="#000000"/>
<%
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
%>
        <div><form name="game_form" method="post" action="bet.wap">
<%
	String type = request.getParameter("type");
	Map<String, List<Game>> gameListMap = (Map<String, List<Game>>) request.getAttribute("gameListMap");
	Collection<List<Game>> gameListCol = gameListMap.values();
%>
            <div><input type="hidden" name="mode" value="betting" /></div>
            <div><input type="hidden" name="type" value="<%=type%>" /></div>
            <div>
            <table width="100%">
                <tr>
                    <td style="border-width:1;border-style:solid;">
                        <div>금액</div>
                    </td>
                    <td style="border-width:1;border-style:solid;">
                        <div><input type="text" name="money" value="5000" format="1" /></div>
                    </td>
                </tr>
                <tr>
                    <td style="border-width:1;border-style:solid;">
                        <div>배당</div>
                    </td>
                    <td style="border-width:1;border-style:solid;">
                        <div><input type="text" name="rate" value="" format="1" disabled /></div>
                    </td>
                </tr>
                <tr>
                    <td style="border-width:1;border-style:solid;">
                        <div>예상</div>
                    </td>
                    <td style="border-width:1;border-style:solid;">
                        <div><input type="text" name="expect" value="" format="1" disabled /></div>
                        <div><input type="button" value="배팅"/></div>
                    </td>
                </tr>
            </table>
            </div>
<%
	for (List<Game> gameList : gameListCol) {
		Game game = gameList.get(0);
		String leagueId = game.getLeagueId();
		String leagueName = game.getLeagueName();
%>
            <div><a href="javascript:vx_contents('<%=leagueId%>')"><%=leagueName%></a></div>
<%
}
%>
<%
	for (List<Game> gameList : gameListCol) {
		Game tgame = gameList.get(0);
		String leagueId = tgame.getLeagueId();
%>
            <div id="<%=leagueId%>" style="display:none">
            <table width="100%">
                <tr>
                    <td style="border-width:0;">
<%
if (gameList != null) {
	for (Game game : gameList) {
%>
                        <div>
                        <table width="100%" border="1" style="border-width:1;border-style:solid;">
                            <tr>
                                <td style="border-width:1;border-style:solid;">
                                    <div><%=XwinUtil.getBoardItemDate(game.getGameDate())%></div>
                                </td>
                                <td style="border-width:1;border-style:solid;">
                                    <div><%=game.getLeagueName()%></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-width:1;border-style:solid;">
                                    <div>(승) x<%=game.getWinRateStr()%></div>
                                </td>
                                <td style="border-width:1;border-style:solid;">
                                    <div><%=game.getHomeTeam()%></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-width:1;border-style:solid;">
                                    <div>무/핸디캡</div>
                                </td>
                                <td style="border-width:1;border-style:solid;">
<%if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-width:1;border-style:solid;">
                                    <div>(패) x<%=game.getLoseRateStr()%></div>
                                </td>
                                <td style="border-width:1;border-style:solid;">
                                    <div><%=game.getAwayTeam()%></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="border-width:1;border-style:solid;">
                                    <div><select name="game_list" type="dropdown" onchange="javascript:select_game(this)">
                                        <option value="0" >선택하세요</option>
                                        <option value="w_<%=game.getId()%>_<%=game.getWinRateStr()%>" >WIN</option>
<%
if (game.getType().equals("wdl")) {
%>
                                        <option value="d_<%=game.getId()%>_<%=game.getDrawRateStr()%>" >DRAW</option>
<%
}
%>
                                        <option value="l_<%=game.getId()%>_<%=game.getLoseRateStr()%>" >LOSE</option>
                                    </select></div>
                                </td>
                            </tr>
                        </table>
                        </div>
<%
	}
}
%>
                    </td>
                </tr>
            </table>
            </div>
<%
}
%>
            <div><input type="hidden" name="token" value="<%=token%>" /></div>
            <div><input type="submit" value="전송"/></div>
        </form></div>
<%
if (pIdx > 0) {
%>
        <div><a href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx-1%>&token=<%=token%>" accesskey="2">이전</a></div>
<%
}
%>
        <div><a href="play.wap?mode=viewGameLis&type=<%=type%>&pageIndex=<%=pIdx+1%>&token=<%=token%>" accesskey="3">다음</a></div>
        <btn name="상위" href="main.wap?token=<%=token%>">
        <hr size="1" color="#BBBBBB">
        <table cellpadding="0" cellspacing="1">
            <tr>
                <td width="16" align="center"><img src="file:////images/magicn/number_square_0.sis"></td>
                <td><a href="main.wap?token=<%=token%>" accesskey="0"><font color="#0000FF">상위</font></a></td>
            </tr>
        </table>
    </body>
</html>