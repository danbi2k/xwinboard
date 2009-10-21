<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/wml20.dtd">
<html>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
<% if (javascript.equals("true")) { %>
    <script language="JavaScript" type="text/JavaScript">
        <!--
    function change_money(tobj)
       {
            if (tobj.value == undefined || money < 5000) {
                alert("5,000캐쉬 이상 배팅 하셔야 합니다");
                tobj.value = 5000;
            }

            select_game();
       }
	function select_game(tobj)
	{
		var rate = 0.0;
		var list = document.game_form.game_list;
		for (var x = 0 ; x < list.length ; x++) {
			if (list[x].value != undefined && list[x].value != 0) {
				var t = list[x].value.split("_");
				if (rate == 0.0)
					rate = t[2];
				else
					rate *= t[2];
			}
		}

		var money = document.game_form.money.value;
		if (money == undefined || money < 0)
			money = 0;
		
		var rate_digit2 = digit2(rate);
		var expect = getInt(rate_digit2 * money)
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
    <body id ="card1">
        <div><b><span style="color:#FF3333;">배팅서비스는 아직 준비중입니다</span></b></div>
<% if (weblike.equals("true")) { %>
    <script language="JavaScript" type="text/JavaScript">
        <!--
        var anyvx=null;
        function vx_contents(content)
        {
            var obj = document.getElementById(content);
            if(obj.style.display=="none") {
                obj.style.display = "";
                if(anyvx != null && anyvx != obj) {
                    anyvx.style.display = "none";
                }
                anyvx = obj;
            } else {
                obj.style.display = "none";
            }
        }
        -->
    </script>
<% } %>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
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
                        <div><input type="text" name="money" value="5000" format="N*N" emptyok="true" /></div>
                    </td>
                </tr>
                <tr>
                    <td style="border-width:1;border-style:solid;">
                        <div>배당</div>
                    </td>
                    <td style="border-width:1;border-style:solid;">
                        <div><input type="text" name="rate" value="" format="N*N" emptyok="true" disabled /></div>
                    </td>
                </tr>
                <tr>
                    <td style="border-width:1;border-style:solid;">
                        <div>예상</div>
                    </td>
                    <td style="border-width:1;border-style:solid;">
                        <div><input type="text" name="expect" value="" format="N*N" emptyok="true" disabled /></div>
                        <div><input type="button" value="배팅"/></div>
                    </td>
                </tr>
            </table>
            </div>
<%
	for (List<Game> gameList : gameListCol) {
		int i = 0;
		Game tgame = gameList.get(0);
		String leagueId = tgame.getLeagueId();
		String leagueName = tgame.getLeagueName();
%>
<%
	if (i == 0) {
%>
            <div><a title="확인" href="javascript:vx_contents('<%=leagueId%>')"><%=leagueName%></a></div>
<%
}
%>
            <div id="<%=leagueId%>" style="display:none">
            <table width="100%" style="border-width:0;">
                <tr>
                    <td style="border-width:0;">
<%
if (gameList != null) {
	for (Game game : gameList) {
%>
                        <div>
                        <table width="100%" style="border-width:1;border-style:solid;">
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
                                <td colspan="2" style="border-width:1;border-style:solid;">
<%
out.print(type.equals("wdl")?"무":"핸디");
if (game.getType().equals("wdl")) {
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
                                    <div><select name="game_list" onchange="javascript:select_game(this)">
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
	i++;
}
%>
            <div><input type="hidden" name="token" value="<%=token%>" /></div>
            <div><input type="submit" value="전송"/></div>
        </form></div>
<%
if (pIdx > 0) {
%>
        <div><a title="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx-1%>&amp;token=<%=token%>" accesskey="2">이전</a></div>
<%
}
%>
        <div><a title="확인" href="play.wap?mode=viewGameLis&type=<%=type%>&pageIndex=<%=pIdx+1%>&amp;token=<%=token%>" accesskey="3">다음</a></div>
        <wml:do type="vnd.up" label="상위"><wml:go href="main.wap?token=<%=token%>"/></wml:do>
    </body>
</html>