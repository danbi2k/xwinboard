<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>
<%
	List<BetToto> betTotoList = (List<BetToto>) request.getAttribute("betTotoList");
	Toto toto = (Toto) request.getAttribute("toto");
	
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String runStatus = XwinUtil.nvl(request.getParameter("runStatus"));
	String betStatus = XwinUtil.nvl(request.getParameter("betStatus"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	
	Integer colNum = toto.getColNum();
	Integer rowNum = toto.getRowNum();
%>
<SCRIPT LANGUAGE="JavaScript">

</SCRIPT>
<div class="title">토토 결과</div>

<form method='get' name='search' action='adminToto.aspx'>
<input type='hidden' name='mode' value='viewReprocessToto'/>
<input type='hidden' name='id' value='<%=toto.getId()%>'/>
<input type='hidden' name='pageIndex'/>

상태
<select name='runStatus' onChange='this.form.submit()'>
	<option value=''>전체</option>
	<option value='<%=Code.BET_STATUS_SUCCESS%>' <%=runStatus.equals(Code.BET_STATUS_SUCCESS)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_SUCCESS)%></option>
	<option value='<%=Code.BET_STATUS_FAILURE%>' <%=runStatus.equals(Code.BET_STATUS_FAILURE)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_FAILURE)%></option>
	<option value='<%=Code.BET_STATUS_CANCEL%>' <%=runStatus.equals(Code.BET_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_CANCEL)%></option>	
 </select>
<select name='search'>
	<option value='userIdLike' <%=search.equals("userIdLike")?"selected":""%>>회원아이디</option>
	<option value='nickNameLike' <%=search.equals("nickNameLike")?"selected":""%>>회원닉네임</option>
</select>
<input type='text' name='keyword' value='<%=keyword%>'>
<input type='submit' value='검 색'>
</form>

<form name="totoFrm" action="adminToto.aspx" method="post">
<input type="hidden" name="mode" value="updateToto"/>
<input type="hidden" name="rowNum" value="<%=rowNum%>"/>
<input type="hidden" name="colNum" value="<%=colNum%>"/>
<input type="hidden" name="id" value="<%=toto.getId()%>"/>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">제목</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getTitle()%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">리그명</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getLeagueName()%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">마감시각</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.getBoardItemDate(toto.getGameDate())%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">수익비율</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getEarnRate()%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">최소구매액</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getMinMoney())%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">이월잔액</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getCarryOver())%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">총판매액</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getTotalMoney())%>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">총발매수</td>
		<td bgcolor="#FFFFFF">
			<%=toto.getTotalCount()%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">수익</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getEarnMoney()) %>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">당첨금</td>
		<td bgcolor="#FFFFFF">
			<%=XwinUtil.comma3(toto.getSuccessMoney())%>
		</td>
	</tr>
	<tr bgcolor="E7E7E7">
		<td align="center" bgcolor="E7E7E7" width="15%">상태</td>
		<td bgcolor="#FFFFFF">
			<%=Code.getValue(toto.getStatus()) %>
		</td>
		<td align="center" bgcolor="E7E7E7" width="15%">잔액</td>
		<td bgcolor="#FFFFFF">
			<%Long carry = XwinUtil.ntz(toto.getTotalMoney()) - XwinUtil.ntz(toto.getSuccessMoney()) + XwinUtil.ntz(toto.getCarryOver());%>
			<%=XwinUtil.comma3(carry)%><BR>
			<%if (carry > 0) { %>
			<font color="red" >※ 당첨자가 없어 당첨금이 이월 되었습니다.<BR>다음 토토를 등록할때  잔액 <%=XwinUtil.comma3(carry)%>원을 [이월잔액] 항목에 기입하십시오.
			<%} %>
		</td>
	</tr>
</table>
<table class="toto">
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="6" class="totoHeader"><%=j+1%> 경기</td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="2" class="totoTeam"><span id="T<%=j%>L" name="T<%=j%>L"/></span></td>
	<td align="center" colspan="2" class="totoTeam">VS</td>
	<td align="center" colspan="2" class="totoTeam"><span id="T<%=j%>R" name="T<%=j%>R"/></span></td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="3" class="totoCategory"><span id="I<%=j%>L" name="I<%=j%>L"/></span></td>
	<td align="center" colspan="3" class="totoCategory"><span id="I<%=j%>R" name="I<%=j%>R""/></span></td>
<%
	}
%>
</tr>
<%
	for (int i = 0 ; i < rowNum ; i++) {
%>
<tr>
<%
		for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" class="totoBody left"><img src="img/check_blank.gif" id="<%=j%>A<%=i%>" name="<%=j%>A"/></td>
	<td align="center" class="totoBody mid"><span id="C<%=j%>L<%=i%>" name="C<%=j%>L<%=i%>"/></span></td>
	<td align="center" class="totoBody right"><img src="img/check_blank.gif" id="<%=j%>B<%=i%>" name="<%=j%>B"/></td>
	<td align="center" class="totoBody left"><img src="img/check_blank.gif" id="<%=j%>C<%=i%>" name="<%=j%>C"/></td>
	<td align="center" class="totoBody mid"><span id="C<%=j%>R<%=i%>" name="C<%=j%>R<%=i%>"/></span></td>
	<td align="center" class="totoBody right"><img src="img/check_blank.gif" id="<%=j%>D<%=i%>" name="<%=j%>D"/></td>
<%		
		}
%>
</tr>
<%
	}
%>
</table>
</form>

<table class="prettytable">
		<tr>
		<th width=5%>번호</th>
		<th>아이디 (닉네임)</th>
		<th>구매일</th>
		<th>구매액</th>
		<th>당첨액</th>
		<th>상태</th>
  	</tr>

	<%
	if (betTotoList != null) {
		for (BetToto betToto : betTotoList) {
			String color = betToto.getRunStatus().equals(Code.BET_STATUS_SUCCESS)?"yellow":betToto.getRunStatus().equals(Code.BET_STATUS_FAILURE)?"red":"black";
			
	%>
		<tr>
		<td width=5%><a href="adminToto.aspx?mode=viewBetTotoDetail&id=<%=betToto.getId()%>"><%=betToto.getId()%></a></td>
		<td width=15% align='left'>&nbsp;<a href='javascript:goMemberDetail("<%=betToto.getUserId()%>")'><%=betToto.getUserId()%></a> (<%=betToto.getNickName()%>)
		<td width=15%><%=XwinUtil.getBoardItemDate(betToto.getDate())%></td>
		<td><%=XwinUtil.comma3(betToto.getMoney())%></td>
		<td><%=XwinUtil.comma3(betToto.getExpect())%></td>
		<td><font color="<%=color%>"><%=Code.getValue(betToto.getRunStatus())%></font></td>
	<%
		}
	}
	%>
</table>

<script>
var selected = [];
var rowNum = <%=rowNum%>;
var colNum = <%=colNum%>;

var spot = [];
spot[0] = "A";
spot[1] = "B";
spot[2] = "C";
spot[3] = "D";

function loadCard(formString)
{
	var formList = formString.split("|");
	for (var i = 0 ; i < formList.length ; i++) {
		var keyValue = formList[i].split("=");
		if (keyValue[0].length == 0)
			continue;
		var tobj = document.getElementById(keyValue[0]);
		if (tobj != null)	
			tobj.innerHTML = keyValue[1];
	}
}

function loadMarking(markString)
{
	var markId = markString.split("-");
	for (var i = 0 ; i < markId.length ; i++) {
		var iobj = document.getElementById(markId[i]);
		iobj.src = "img/check_check.gif";
	}
}

function loadResult(resultString)
{
	var resultId = resultString.split("-");
	for (var i = 0 ; i < resultId.length ; i++) {
		var iobj = document.getElementById(resultId[i]);
		iobj.src = "img/check_check_red.gif";
	}
}

loadCard('<%=toto.getCardString()%>');
<%if (toto.getResultString() != null) {%>
loadResult('<%=toto.getResultString()%>');
<%}%>
</script>
<div id="_debug"></div>
<%@ include file="../admin_footer.jsp"%>
