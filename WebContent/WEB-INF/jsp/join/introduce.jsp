<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="com.xwin.domain.join.*" %>
<%@ page import="com.xwin.domain.*" %>

<%@include file="../header.jsp"%>

<%
	int ROWSIZE = 15;
	int SHOWPAGE = 10;
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
	Integer totalCount = (Integer) request.getAttribute("bettingCount");
	Integer noJoinCount = (Integer) request.getAttribute("noJoinCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
%>
			<tr><td><img src="img/menu16.jpg" border="0"></td></tr>
		   
            </table>
<table width="771" style="margin-top:10">
<tr><td><b>추천장이용약관</b></td></tr>
</table>
 <table align="center" cellpadding="0" cellspacing="0" width="771">
    <tr>
        <td width="497" background="img/minit_02.jpg" valign="top" style="padding:20">
            <span style="width:100%;height:120;OVERFLOW:auto">
				<b style='color:white'>1.</b> <%=SiteConfig.SITE_NAME%>(이하 회사)은 안전한 신규회원 모집을 위해 '추천장' 시스템을 적용하고 있습니다.<br>
				<b style='color:white'>2.</b> 회원님은 가까운 지인의 핸드폰으로 추천장을 문자로 발송하여 신규회원 가입을 권유 할 수 있습니다.<br>
				<b style='color:white'>3.</b> 회원님은 본인이 추천한 회원이 배팅을 하였을 경우 배팅금액의 3%를 포인트로 적립 받습니다.<br>
				<b style='color:white'>4.</b> 포인트는 배팅이 결과처리 된 후에 자동 적립 됩니다. (취소된 배팅은 적립되지 않습니다)<br>
				<b style='color:white'>5.</b> 추천장은 회원님의 배팅 실적에 따라 주기적으로 지급됩니다.<br>
				<b style='color:white'>6.</b> 추천장은 5자의 무작위 문자열로 구성되며 추천장과 소개인 ID를 사용하여 접속한 후 회원가입을 진행 합니다.<br>
				<b style='color:white'>7.</b> 보다 안전하고 발전적인 사이트 운영을 위해 적극적인 활용을 부탁드립니다.<br>
			</span>
        </td>
    </tr>
</table>

<form name="intro">
<table width="771" style="margin-top:10">
<tr><td><b>추천정보입력</b></td>
	<td>※ 추천장이 필요하신 회원님은 고객센터로 문의하십시오.<BR>
		※ 발송이 되었지만 가입하지 않은 추천장은 미가입 추천장 수를 확인하십시오.</td></tr>
</table>

<table width="771" bgcolor="#111111" cellpadding="5" style="border:1 solid #909090;">
<colgroup>
<col width="150" align="center">
<col width="650">

</colgroup>
<tr>
	<td colspan=2>
	<table cellpadding="0" cellspacing="0" width=100%>
		<tr>
			<td>남은 추천장 수</td>
			<td><%=member.getIntroLetter()%> 장</td>					
			<td width=25%>&nbsp;</td>
			<td>미가입 추천장 수</td>
			<td><a href="javascript:openNoJoinList()"><%=noJoinCount%> 장</a></td>
			<td width=25%>&nbsp;</td>
		</tr>
	</table>
	</td>
</tr>
<tr>
	<td colspan=2>
	<table cellpadding="0" cellspacing="0" width=100%>
		<tr>
			<td>추천할 휴대폰번호</td>
			<td><select class="input2" name="phone1">
				<option value="010" >010</option>
				<option value="011" >011</option>
				<option value="016" >016</option>
				<option value="017" >017</option>
				<option value="018" >018</option>
				<option value="019" >019</option>
				</select> -
				<input class="input2" name="phone2" type="text" size="3" maxlength="4" value="" style='IME-MODE: inactive'> -
				<input class="input2" name="phone3" type="text" size="3" maxlength="4" value="" style='IME-MODE: inactive'>
				추천장을 발송할 휴대폰 번호를 입력하십시오
				</td>
		</tr>
	</table>
	</td>
</tr>
</table>

<table width="771" style="margin-top:10">
<tr><td align="center">
	<input type="button" onclick="introduce()" value="추천하기" style='background-color:#09314A'>
</td></tr>
</table>

</form>


<table width="771" style="margin-top:10">
<tr><td><b>추천내역보기</b>&nbsp;&nbsp;&nbsp;※ 총추천인수를 클릭하시면 회원님께 추천받으신분들 목록이 나옵니다.</td></tr>
</table>

<table width="771" bgcolor="#111111" cellpadding="5" style="border:1 solid #909090;">
<tr>
	<td>총추천인</td>
	<td><a href="javascript:openIntroduceList()"><%=member.getIntroduceCount()%> 명</a></td>
	<td>총추천인배팅횟수</td>
	<td><%=member.getIntroduceBettingCount()%> 번</td>
	<td>총추천인배팅금액</td>
	<td><%=XwinUtil.comma3(member.getIntroduceBettingMoney())%> 원</td>
</tr>
<tr>
	<td>총추천인포인트</td>
	<td><%=XwinUtil.comma3(member.getIntroduceBettingPoint())%> 원</td>
	<td>현보유포인트</td>
	<td><a href="myMoney.aspx?mode=viewMyPointList"><%=XwinUtil.comma3(member.getPoint())%> 원</a></td>
	<td colspan="2"><input type="button" value="머니전환" onclick="exchangePoint(<%=member.getPoint()%>)" style='background-color:#09314A'/></td>
</tr>
</table>
<br><br>

<form method='get' name='search'>
<input type='hidden' name='pageIndex'/>
<input type='hidden' name='mode' value='viewIntroduceForm'/>
</form>
<table width="771" style="margin-top:10">
<tr><td><b>배팅내역보기</b></td></tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771"
	height="40" background="img/bar-.jpg">
	<tr>
		<td width="131" height="40" align="center" valign="middle"
			class="menubar">
		<p>번호</p>
		</td>
		<td width="209" height="40" align="center" valign="middle"
			class="menubar">
		<p>닉네임(아이디)</p>
		</td>
		<td width="100" height="40" align="center" valign="middle"
			class="menubar">
		<p>배팅일자</p>
		</td>
		<td width="100" height="40" align="center" valign="middle"
			class="menubar">
		<p>배팅금액</p>
		</td>
		<td width="100" height="40" align="center" valign="middle"
			class="menubar">
		<p>배당율</p>
		</td>
		<td width="131" height="40" align="center" valign="middle"
			class="menubar">
		<p>예상금액</p>
		</td>
	</tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="771" border="0">
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
<tr>
		<td width="131" class="tablebg1" align="center" valign="middle">
		<%=betting.getId()%>
		</td>
		<td width="209" class="tablebg2" align="center" valign="middle">
		<%=betting.getNickName()%> (<%=betting.getUserId()%>)
		</td>
		<td width="100" class="tablebg1" align="center" valign="middle">
		<%=betting.getDateStr()%>
		</td>
		<td width="100" class="tablebg2" align="center" valign="middle">
		<%=XwinUtil.comma3(betting.getMoney())%>
		</td>
		<td width="100" class="tablebg1" align="center" valign="middle">
		<%=betting.getRateStr()%>
		</td>
		<td width="131" class="tablebg2" align="center" valign="middle">
		<%=XwinUtil.comma3(betting.getExpect())%>
		</td>
</tr>
<%
	}
} else {
%>
<tr bgcolor='black'><td colspan='7' height='150' align='center' bgcolor='black'>배팅 내역이 없습니다.</td></tr>
<%
}
%>
</table>
<BR>
<div class="pages">
<%
int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
int nextPage = startPage + SHOWPAGE;

if (startPage > 0) {
%>
	<a href='javascript:goPage(<%=startPage - 1%>)'>&lt;&lt;&lt;</a>
<%
}
int i = 0, c = 0;
for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
	if (i == pIdx) {
%>
		<b> <%=i+1%> </b>
<%
	} else {
%>		
		<a href='javascript:goPage(<%=i%>)'>[ <%=i+1%> ]</a>
<%			
	}
}
if (i < pageNum) {
%>
	<a href='javascript:goPage(<%=i%>)'>&gt;&gt;&gt;</a>
<%
}
%>
</div>


        </td>
    </tr>


 <tr>
        <td width="929" height="49" colspan="2">
            <p><img src="img/table_03.jpg" width="929" height="49" border="0" alt="table_03.jpg"></p>
        </td>

<script>
function openIntroduceList()
{
	window.open("introduce.aspx?mode=introduceDetail","추천인내역","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=0, width=600, height=250");
}

function openNoJoinList()
{
	window.open("introduce.aspx?mode=noJoinDetail","미가입추천장내역","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=0, width=600, height=250");
}

function introduce()
{
	var frm = document.intro;
	if (frm.phone1.value == "" || frm.phone2.value == "" || frm.phone3.value == "") {
		alert("휴대폰 번호를 입력하세요");
		return;
	}

	var query = "mode=introduce";
	query += "&mobile=" + frm.phone1.value + frm.phone2.value + frm.phone3.value;
	var http = new JKL.ParseXML("introduce.aspx", query);
	var result = http.parse();

	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();	
}
</script>
<script>
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
</script>

<%@include file="../footer.jsp"%>