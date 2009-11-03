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
    <title>?<%=request.getParameter("type").equals("wdl")?"승무패(최신폰)":"핸디캡(최신폰)"%>?</title>
        <meta name="generator" content="AnyBuilder VX" />
<% if (javascript.equals("true")) { %>
    <script language="JavaScript" type="text/JavaScript">
        <!--
	function change_money(tobj) {
		if (tobj.value == undefined || tobj.value < 5000) {
			alert("5,000캐쉬 이상 배팅 하셔야 합니다");
			tobj.value = 5000;
		}
	
		var rate = 0.0;
		var list = toArray(document.game_form.game_list);
		var sel_count = 0;
		for ( var x = 0; x < list.length; x++) {
			if (list[x].value != undefined && list[x].value != 0) {
				sel_count++;
				var t = list[x].value.split("_");
				if (rate == 0.0)
					rate = t[2];
				else
					rate *= t[2];
			}
		}

		var rate_digit2 = digit2(rate);
		var expect = getInt(rate_digit2 * tobj.value)
	
		if (expect > 3000000) {
			tobj.value = 5000;
			expect = getInt(rate_digit2 * 5000);
			alert('예상 배당금은 3,000,000캐쉬 이하만 허용 됩니다');
		}
	
		document.game_form.rate.value = rate_digit2;
		document.game_form.expect.value = expect;
	}
	
	function select_game(tobj) {
		var money = document.game_form.money.value;
		if (money == undefined || money < 0)
			money = 0;
	
		var rate = 0.0;
		var list = toArray(document.game_form.game_list);
		var sel_count = 0;
		for ( var x = 0; x < list.length; x++) {
			if (list[x].value != undefined && list[x].value != 0) {
				sel_count++;
				var t = list[x].value.split("_");
				if (rate == 0.0)
					rate = t[2];
				else
					rate *= t[2];
			}
		}
	
		if (sel_count > 10) {
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

		//vx_contents(anyvx.id);
	
		document.game_form.rate.value = rate_digit2;
		document.game_form.expect.value = expect;

		var svalue = tobj.value.split("_");
		var homeTeam = document.getElementById("W_"+svalue[1]).innerHTML;
		var awayTeam = document.getElementById("L_"+svalue[1]).innerHTML;

		var guess = "";
		if (svalue[0] == "W")
			guess = "승";
		else if (svalue[0] == "D")
			guess = "무";
		else
			guess = "패";

		alert(homeTeam + " vs " + awayTeam + "\n" + guess + " " + svalue[2]);
	}
	
	function digit2(value) {
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
	
	function getInt(value) {
		if (value == 0)
			value = "0";
		var str = "" + value;
		var num = str.split(".");
	
		return num[0];
	}

	function toArray(data) {
		if (data == undefined)
			data = [];
		else if (data.length == undefined || data.name == 'game_list') {
			var tmp = [data];		
			return tmp;
		}
		
		return data;
	}
	
	function betting() {
		var sel_count = 0
		var list = toArray(document.game_form.game_list);
		for ( var x = 0; x < list.length; x++) {
			if (list[x].value != undefined && list[x].value != 0) {
				sel_count++;
			}
		}
		if (sel_count <= 0) {
			alert("선택하신 게임이 없습니다");
			return;
		}	
		var msg = "배팅하시겠습니까? \n";
		msg += summary();
		if (confirm(msg))
			document.game_form.submit();
	}

	function summary() {
		var msg = "";
		var list = toArray(document.game_form.game_list);
		for ( var x = 0; x < list.length; x++) {
			if (list[x].value != undefined && list[x].value != 0) {
				var svalue = list[x].value.split("_");
				var homeTeam = document.getElementById("W_"+svalue[1]).innerHTML;
				var awayTeam = document.getElementById("L_"+svalue[1]).innerHTML;

				var guess = "";
				if (svalue[0] == "W")
					guess = "승";
				else if (svalue[0] == "D")
					guess = "무";
				else
					guess = "패";

				msg += homeTeam + " vs " + awayTeam + " " + guess + " " + svalue[2] + "\n" ;
			}
		}
		msg += "\n배당 : " + document.game_form.rate.value + "\n예상 : " + document.game_form.expect.value;
		
		return msg;
	}

	function select_league() {
		var leagueId = document.game_form.league_name.value;
		if (leagueId < 0 && anyvx != undefined)
			vx_contents(anyvx.id);
		else
			vx_contents(leagueId);
	}
        -->
    </script>
<% } %>
    </head>
    <body id ="card1">
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?<%=request.getParameter("type").equals("wdl")?"승무패(최신폰)":"핸디캡(최신폰)"%>?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
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
if (weblike.equals("true")) {
%>
        <div><span style="color:#CC00FF;">※ 8시간 이내 경기만 표시됨</span></div>
        <div><form name="game_form" method="post" action="play.wap">
<%
	String type = request.getParameter("type");
	Map<String, List<Game>> gameListMap = (Map<String, List<Game>>) request.getAttribute("gameListMap");
	Collection<List<Game>> gameListCol = gameListMap.values();
%>
            <div><input type="hidden" name="token" value="<%=token%>" /></div>
            <div style="display:none;"><input type="submit" value="배팅"/></div>
            <div><input type="hidden" name="mode" value="betting" /></div>
            <div><input type="hidden" name="type" value="<%=type%>" /></div>
            <div>
            <table width="100%" style="background-color:#FFFFBB;border-width:0;border-color:#0000FF;border-collapse:collapse;">
                <tr>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div>금액</div>
                    </td>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div><input type="text" name="money" value="5000" format="N*N" emptyok="true" onchange="change_money(this)" /></div>
                    </td>
                </tr>
                <tr>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div>배당</div>
                    </td>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div><input type="text" name="rate" value="0.00" format="x*x" emptyok="true" disabled /></div>
                    </td>
                </tr>
                <tr>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div>예상</div>
                    </td>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div><input type="text" name="expect" value="0" format="x*x" emptyok="true" disabled /></div>
                    </td>
                </tr>
            </table>
            </div>
            <div style="display:inline;"><select name="league_name" onchange="javascript:select_league();">
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
            <div style="display:inline;"><input type="button" value="선택확인" onclick="javascript:alert(summary());"/></div>
            <div style="display:inline;"><input type="button" name="bet_button" value="배팅" onclick="javascript:betting();"/></div>
<%
	for (List<Game> gameList : gameListCol) {
		int i = 0;
		Game tgame = gameList.get(0);
		String leagueId = tgame.getLeagueId();
		String leagueName = tgame.getLeagueName();
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
                                    <div id="W_<%=game.getId()%>"><%=game.getHomeTeam()%></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="border-width:1;border-style:solid;">
<%
out.print(game.getType().equals("wdl")?"(무) ":"(핸디) ");
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
                                    <div id="L_<%=game.getId()%>"><%=game.getAwayTeam()%></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="border-width:1;border-style:solid;">
                                    <div style="display:inline;"><select name="game_list" onchange="javascript:select_game(this)">
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
                                    <div style="display:inline;"><input type="button" value="선택확인" onclick="javascript:alert(summary());"/></div>
                                    <div style="display:inline;"><input type="button" value="배팅" onclick="javascript:betting();"/></div>
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
        </form></div>
<%
} else {
%>
        <div>회원님의 휴대전화에서는 배팅 서비스가 지원되지 않습니다. 최신기종의 휴대전화로 교체하신후 사용해 주세요</div>
<%
}
%>
        <wml:do type="vnd.up" label="상위"><wml:go href="main.wap?token=<%=token%>"/></wml:do>
    </body>
</html>

