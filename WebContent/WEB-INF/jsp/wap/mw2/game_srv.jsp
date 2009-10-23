﻿<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
    <title>&nbsp; </title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=0" />
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
		var list = document.game_form.game_list;
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
		document.game_form.expect.value = comma3(expect);
	}
	
	function select_game(tobj) {
		var money = document.game_form.money.value;
		if (money == undefined || money < 0)
			money = 0;
	
		var rate = 0.0;
		var list = document.game_form.game_list;
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
		document.game_form.expect.value = comma3(expect);

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

	function comma3(value) {
		return value;
		var sMoney = "" + value;	
		var len = sMoney.length;
	
		if (sMoney.length <= 3)
			return sMoney;

		var tMoney = "";
		for (i = 0; i < len; i++) {
			if (i != 0 && ((i % 3) == (len % 3)))
				tMoney += ",";
			if (i < len)
				tMoney += sMoney.charAt(i);
		}
	
		return tMoney;
	}
	
	function getInt(value) {
		if (value == 0)
			value = "0";
		var str = "" + value;
		var num = str.split(".");
	
		return num[0];
	}
	
	function betting() {
		var sel_count = 0
		var list = document.game_form.game_list;
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
		if (confirm(msg)) {
			document.game_form.action = "play.wap";
			document.game_form.mode.value = "betting";
			document.game_form.submit();
		}
	}

	function summary() {
		var msg = "";
		var list = document.game_form.game_list;
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
		var leagueId = document.game_form.league_id.value;
		if (leagueId < 0 && anyvx != undefined)
			vx_contents(anyvx.id);
		else {
			document.game_form._rate.value = document.game_form.rate.value;
			document.game_form._expect.value = document.game_form.expect.value;
			document.game_form.action = "play.wap";
			document.game_form.mode.value = "viewGameListByLeague";
			document.game_form.submit();
		}
	}
        -->
    </script>
<% } %>
    </head>
    <body>
    <div style="width:<%=lcdlx%>px">
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
	document.game_form.bet_button.focus();
        }
        -->
    </script>
<% } %>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr style="color:#000000;width:100%;"/>
<%
if (weblike.equals("true")) {
%>
        <div><span style="color:#CC00FF;">※ 8시간 이내 경기만 표시됨</span></div>
        <div><form name="game_form" method="post">
<%
	String type = request.getParameter("type");
	String money = XwinUtil.nvl(request.getParameter("_money"), "5000");
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
            <div><input type="hidden" name="mode" value="" /></div>
            <div><input type="hidden" name="type" value="<%=type%>" /></div>
            <div><input type="hidden" name="_rate" value="" /></div>
            <div><input type="hidden" name="_expect" value="" /></div>
            <div>
            <table width="100%" style="background-color:#FFFFBB;border-width:0;border-color:#0000FF;border-collapse:collapse;">
                <tr>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div>금액</div>
                    </td>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div><input type="text" name="money" value="<%=money%>" onchange="change_money(this)" /></div>
                    </td>
                </tr>
                <tr>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div>배당</div>
                    </td>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div><input type="text" name="rate" value="<%=rate%>" disabled /></div>
                    </td>
                </tr>
                <tr>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div>예상</div>
                    </td>
                    <td style="border-width:0;border-color:#0000FF;background-color:#FFFFBB;">
                        <div><input type="text" name="expect" value="<%=expect%>" disabled /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div style="display:none;"><input type="submit" value="배팅"/></div>
                        <div style="display:inline;"><input type="button" value="선택확인" onclick="javascript:alert(summary());" style="display:inline;"/></div>
                        <div style="display:inline;"><input type="button" name="bet_button" value="배팅" onclick="javascript:betting();" style="display:inline;"/></div>
                    </td>
                </tr>
            </table>
            </div>
            <div><select name="league_id" onchange="javascript:select_league();">
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
            <div id="<%=leagueId%>">
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
                                    <div style="display:inline;"><select name="game_list" onchange="javascript:select_game(this)" style="display:inline;">
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
                                    <div style="display:inline;"><input type="button" value="선택확인" onclick="javascript:alert(summary());" style="display:inline;"/></div>
                                    <div style="display:inline;"><input type="button" value="배팅" onclick="javascript:betting();" style="display:inline;"/></div>
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
<%
	if (gameFolder != null) {
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		if (itemList != null) {
			for (GameFolderItem item : itemList) {
%>
            <div id="W_<%=item.getId()%>" style="display:none;"><%=item.getHomeTeam()%></div>
            <div id="L_<%=item.getId()%>" style="display:none;"><%=item.getAwayTeam()%></div>
            <div><input type="hidden" name="game_list" value="<%=item.getGuess() + "_" + item.getId() + "_" + item.getSelRate()%>" /></div>
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
        <div><a title="상위" href="main.wap?token=<%=token%>">상위</a></div>
    </div>
    </body>
</html>
