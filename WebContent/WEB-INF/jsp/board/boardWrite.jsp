<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%
	String boardName = request.getParameter("boardName");
	Betting betting = (Betting) request.getAttribute("betting");
%>

<%@include file="../header.jsp"%>

<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_<%=boardName.equals("user")?"board":"customer"%>.gif"></td><td>
		<%=boardName.equals("user")?"게시물을 작성하고, 중요 내용을 확인 할 수 있습니다.":"1:1 고객센터 입니다. 문의사항 및 건의사항을 적어주세요."%>
	</td></td>
	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">


<link rel='stylesheet' href='/board/skin_board/board.css'><script language='JavaScript' src='/board/skin_board/board.js'></script>
<script>
function list(){
    location.href="/board/board.asp?idx=board";
}
function check_frm(){
	if (havingSqlKeyword(frm.title.value)) { alert("제목에 사용할수 없는 문자열이 있습니다"); frm.title.focus(); return false; }
	if (havingSqlKeyword(frm.name.value)) { alert("작성자에 사용할수 없는 문자열이 있습니다"); frm.name.focus(); return false; }
	if (havingSqlKeyword(frm.context.value)) { alert("내용에 사용할수 없는 문자열이 있습니다"); frm.context.focus(); return false; }
	
    if(frm.title.value   ==""){ alert("제목을 입력하세요!");   frm.title.focus();    return false; }
    if(frm.name.value    ==""){ alert("작성자를 입력하세요!"); frm.name.focus();     return false; }
    if(frm.context.value==""){ alert("내용을 입력하세요!");   frm.context.focus(); return false; }
    return true;
}
</script>

<%
if (betting != null) {
%>
<table border="0" cellpadding="0" cellspacing="0" width="900">
<tr>
<td height="30"><font color="yellow">※ 배팅내역은 게시물에 자동 첨부 됩니다</font></td>
</tr>
<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tbody><tr>
					<td>
						<table bgcolor="#424142" border="0" cellpadding="0" cellspacing="1" width="100%">
							<tbody><tr bgcolor="#212021" height="27">
								<td align="center" width="110"><font color="#ffffff"><b><nobr>배팅일시</nobr></b></font></td>
								<td align="center" width="110"><font color="#ffffff"><b><nobr>경기날짜</nobr></b></font></td>
								<td align="center" width="270"><font color="#ffffff"><b><nobr>(승)홈 팀</nobr></b></font></td>
								<td align="center" width="85"><font color="#ffffff"><b><nobr>무/핸디캡</nobr></b></font></td>
								
								<td align="center" width="270"><font color="#ffffff"><b><nobr>(패)원정팀</nobr></b></font></td>
								<td align="center" width="60"><font color="#ffffff"><b><nobr>배팅팀</nobr></b></font></td>
								<td align="center" width="95"><font color="#ffffff"><b><nobr>경기결과</nobr></b></font></td>
								<td align="center" width="80"><font color="#ffffff"><b><nobr>적중유무</nobr></b></font></td>
							</tr>
							
<%
	List<BetGame> betGameList = betting.getBetGameList();
	if (betGameList != null) {
		int betGameCount = betGameList.size();
		int count = 0;
		for (BetGame betGame : betGameList) {
%>
							<tr bgcolor="#000000" height="25">
								<td align="center"><nobr><font color="#ffffff"><%=betting.getDateStr() %></font></nobr></td>
								<td align="center"><nobr><font color="#ffffff"><%=betGame.getGameDateStr()%></font></nobr></td>
								<td align="right"><nobr>
									<font color="#ffffff">
									<%=betGame.getHomeTeam()%>&nbsp;<%=betGame.getWinRateStr()%>&nbsp;</font>
									</nobr></td>
								<td align="center"><nobr>
									<font color="#ffffff"><%=betGame.getType().equals("wdl")?"무 " + betGame.getDrawRateStr():"핸디 " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>
								</font></nobr></td>
								
								<td><nobr>&nbsp;
									<font color="#ffffff">
									<%=betGame.getLoseRateStr()%>&nbsp;<%=betGame.getAwayTeam()%></font></nobr></td>
								<td align="center"><nobr><font color="#ffffff"><%=Code.getValue(betGame.getGuess())%></font></nobr></td>
								<td align="center"><nobr>&nbsp;<font color="#ffffff">
								<%=Code.getValue(betGame.getResult())%>
								<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%>
								</font></nobr></td>
								<td align="center"><nobr>
									<font color="#ffffff">
									<B><%=Code.getValue(betGame.getResultStatus())%></B></font></nobr>
								</td>
							</tr>
<%
		}	
	}		
%>				
					
						</tbody></table>		
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr>
					<td align="center">배당율 : <%=betting.getRateStr()%> / 배팅금액 : <%=XwinUtil.comma3(betting.getMoney())%>원 / 예상적중금액 : <%=XwinUtil.comma3(betting.getExpect())%>원 /
					적중금액 :
					<%
					if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
						out.print("<font color='#FFC602'>" + XwinUtil.comma3(betting.getExpect()) + "</font>");
					else
						out.print(0);							
					%>
					 원
					</td>
				</tr>
				</tbody></table>
			</td>
		</tr>
	<tr><td height="10"></td>
	</tr>
</table>
<%
}
%>

<table width="95%" border="0" align="center" bgcolor="#d9d8d6" cellpadding="3" cellspacing="1" style="margin-top:7px;">
<colgroup>
<col height="31" width="10%" align="center">
<col height="31" width="90%" align="center">
</colgroup>
<form name="frm" action="board.aspx" method="post" onsubmit="return check_frm();">
<input type="hidden" name="mode" value="writeBoardItem">
<input type="hidden" name="boardName" value="<%=boardName%>">
<%if (betting != null) { %>
<input type="hidden" name="bettingId" value="<%=betting.getId()%>">
<%} %>
<tr bgcolor="#0a0a0a">
	<td bgcolor="#222222" style="color:white;"><b>작성자</td>
    <td align="left"><input type="text" name="name" readonly style="background-color:#0a0a0a;border:0;color:white" value="<%=member.getNickName()%>" style="width:100;"></td>
<tr bgcolor="#0a0a0a">
	<td bgcolor="#222222" style="color:white;"><b>제&nbsp;목</td>
    <td align="left"><input type="text" name="title" class="board" value="" style="width:100%;background-color:#4f4f4f;color:#FFFFFF">
	</td></tr>
<tr bgcolor="#0a0a0a">
	<td bgcolor="#222222" style="color:white;"><b>내&nbsp;용</td>
	<td align="left"><textarea name="context" class="board" style="width:100%;height:300;background-color:#4f4f4f;color:#FFFFFF"></textarea></td></tr>
</table>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="95%" style="margin-top:5;">
<tr><td width="50%" height="30"><div align="left">
        <a href="javascript:history.back()"><img src="images/btn_list.gif" border="0"></a>
    </td>
    <td width="50%" height="30"  align="right">
		<input type="image" src="images/btn_write.gif" style="cursor:hand">
    </td></tr>
</form>
</table>


</td></tr>
</table>

<%@include file="../footer.jsp"%>


</body>
</html>