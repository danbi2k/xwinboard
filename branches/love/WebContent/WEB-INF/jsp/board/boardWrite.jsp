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

			<tr><td><img src="img/<%=boardName.equals("user")?"menu04":"menu05"%>.jpg" border="0"></td></tr>
		    <tr><td><img src="img/bbs01.jpg" border="0"></td></tr>
            </table>

<%
if (betting != null) {
%>
<table align="center" cellpadding="0" cellspacing="0" width="771">
   
    <tr>
        <td width="771" background="img/minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="771" background="img/minit_02.jpg" valign="top" style="padding:20">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="30"><font color="yellow">※ 배팅내역은 게시물에 자동 첨부 됩니다</font></td>
</tr>
<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0">
				<tbody><tr>
					<td>
						<table bgcolor="#424142" border="0" cellpadding="0" cellspacing="1" width="100%">
							<tbody><tr bgcolor="#212021" height="27">
								<td align="center" width="70"><font color="#ffffff"><b><nobr>배팅일시</nobr></b></font></td>
								<td align="center" width="70"><font color="#ffffff"><b><nobr>경기날짜</nobr></b></font></td>
								<td align="center" width="180"><font color="#ffffff"><b><nobr>(승)홈 팀</nobr></b></font></td>
								<td align="center" width="75"><font color="#ffffff"><b><nobr>무/핸디캡</nobr></b></font></td>								
								<td align="center" width="180"><font color="#ffffff"><b><nobr>(패)원정팀</nobr></b></font></td>
								<td align="center" width="50"><font color="#ffffff"><b><nobr>배팅팀</nobr></b></font></td>
								<td align="center" width="60"><font color="#ffffff"><b><nobr>경기결과</nobr></b></font></td>
								<td align="center" width="50"><font color="#ffffff"><b><nobr>적중유무</nobr></b></font></td>
							</tr>
							
<%
	List<BetGame> betGameList = betting.getBetGameList();
	if (betGameList != null) {
		int betGameCount = betGameList.size();
		int count = 0;
		for (BetGame betGame : betGameList) {
%>
							<tr bgcolor="#000000" height="25">
								<td align="center"><nobr><font color="#ffffff"><%=XwinUtil.getBoardItemDate(betting.getDate())%></font></nobr></td>
								<td align="center"><nobr><font color="#ffffff"><%=XwinUtil.getBoardItemDate(betGame.getGameDate())%></font></nobr></td>
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
</td>
	</tr>
	<tr>
        <td width="771" background="img/minit_03.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
<%
}
%>
		

<form name="boardfrm" action="board.aspx" method="post">
<input type="hidden" name="mode" value="writeBoardItem">
<input type="hidden" name="boardName" value="<%=boardName%>">
<%if (betting != null) { %>
<input type="hidden" name="bettingId" value="<%=betting.getId()%>">
<%} %>     
<table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
   
    <tr>
        <td width="771" height="37" background="img/minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="771" height="132" background="img/minit_02.jpg" valign="top" style="padding:20">
           <table border=0 cellspacing=0 cellpadding=0 width=731>

<col width=60></col>
<col width=7></col>
<col width=500></col>



 

<tr>
 <td align=right class=menubar>작성자</td>
 <td></td>
 <td><%=member.getNickName()%></td>
</tr>


<tr>
 <td align=right class=menubar>제목</td>
 <td></td>
 <td> <input type=text name=title maxlength=200 class=input2 style=width:90%;> </td>
</tr>

<tr>
 <td align=right class=menubar>내용</td>
 <td></td>
 <td><textarea name=context rows=15 class=textarea></textarea></td>
</tr>

</table>
</form>
        </td>
    </tr>
    <tr>
        <td width="771" height="44" background="img/minit_03.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
          <table align="center" cellpadding="0" cellspacing="0" width="771" height="40">
	        <tr>
			    <td width="671" height="40" align="left"><img src="img/list.jpg" border="0" align="absmiddle" onclick='history.back()'>
			    </td>
			    <td width="100" height="40" align="right"><img src="img/write.jpg" border="0" align="absmiddle" onclick='check_frm()'>
				</td>
			</tr>
		    
     </table>

<script>
function check_frm(){
	var frm = document.boardfrm;
	if (havingSqlKeyword(frm.title.value)) { alert("제목에 사용할수 없는 문자열이 있습니다"); frm.title.focus(); return false; }
	if (havingSqlKeyword(frm.context.value)) { alert("내용에 사용할수 없는 문자열이 있습니다"); frm.context.focus(); return false; }
	
    if(frm.title.value   ==""){ alert("제목을 입력하세요!");   frm.title.focus();    return false; }
    if(frm.name.value    ==""){ alert("작성자를 입력하세요!"); frm.name.focus();     return false; }
    if(frm.context.value==""){ alert("내용을 입력하세요!");   frm.context.focus(); return false; }

    frm.submit();
}
</script>

<%@include file="../footer.jsp"%>


</body>
</html>