<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	Member member = (Member) request.getAttribute("member");
	List<Account> accountList = (List<Account>) request.getAttribute("accountList");
	Integer totalCount = (Integer) request.getAttribute("accountCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	String phone[] = null;
	if (member.getMobile() != null) {
		phone = member.getMobile().split("-");		
	}
	
	String email[] = null;
	if (member.getEmail() != null) {
		email = member.getEmail().split("@");		
	}
%>
 
<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.regist;

		var query = "mode=updateMember";
		query += "&userId=" + '<%=member.getUserId()%>';
		query += "&status=" + regist.status.value;
		query += "&grade=" + regist.grade.value;
		var http = new JKL.ParseXML("adminMember.aspx", query);
		var result = http.parse();

		if (result.resultXml.code == 0)
			alert(result.resultXml.message);
	}

	function delIT(userid) {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='member/index.php?mode=del_exe&userid='+userid+'&page=1&page_list=1&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}


	function chargeIT() {
		var d=document.charge;
		if(!d.amt.value) { alert('금액을 입력하세요'); d.amt.focus(); return false; }
		if(!d.msg.value) { alert('내역을 입력하세요'); d.msg.focus(); return false; }
		if(!confirm('금액을 충전/삭감 하시겠습니까?')) {
			return false;
		}
		else {
			d.action='member/index.php?mode=recharge&userid=ori7907&page=1&page_list=1&search=&kwd=&type=';
		}
	}
</SCRIPT>

<div class="title">회원정보</div>

<form method=post name='regist'>
<input type='hidden' name='mode' value='updateMember'/>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>회원아이디</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getUserId()%></td>
	</tr>
   	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>닉네임</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getNickName()%></td>
	</tr>
    <tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>보유금액</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=XwinUtil.comma3(member.getBalance())%> 원
	</td>
	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>등급</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<select name="grade" onchange="changeGrade()">
				<option value="<%=Code.USER_GRADE_NORMAL%>" <%=member.getGrade().equals(Code.USER_GRADE_NORMAL)?"selected":""%>><%=Code.getValue(Code.USER_GRADE_NORMAL)%></option>
				<option value="<%=Code.USER_GRADE_VIP%>" <%=member.getGrade().equals(Code.USER_GRADE_VIP)?"selected":""%>><%=Code.getValue(Code.USER_GRADE_VIP)%></option>
			</select>			
		</td>
	</tr>
    <tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>비밀번호</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getPassword()%></td>
 	</tr>
 	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>연락처</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<select class="member" name="phone1">
			<option value="010" <%="010".equals(phone[0])?"selected":""%>>010</option>
			<option value="011" <%="011".equals(phone[0])?"selected":""%>>011</option>
			<option value="016" <%="016".equals(phone[0])?"selected":""%>>016</option>
			<option value="017" <%="017".equals(phone[0])?"selected":""%>>017</option>
			<option value="018" <%="018".equals(phone[0])?"selected":""%>>018</option>
			<option value="019" <%="019".equals(phone[0])?"selected":""%>>019</option>
			</select> -
			<input name="phone2" type="text" size="4" maxlength="4" value="<%=phone[1]%>"> -
			<input name="phone3" type="text" size="4" maxlength="4" value="<%=phone[2]%>">		
			<input type="button" value="변경" onclick="changeMobile()"/>
		</td>
	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>EMAIL</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input name="email1" type="text" value="<%=email[0]%>"> @
			<input name="email2" type="text" value="<%=email[1]%>">
			<input type="button" value="변경" onclick="changeEmail()"/>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>출금비밀번호</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getPin()%></td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>가입일</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getJoinDateStr()%></td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>상태</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=Code.getValue(member.getStatus())%></td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>환전계좌번호</td>
		<td width=80% bgcolor='#ffffff' align='left'>
		은행명 :
			<select name="bankName">
			<%
			String[] bankNameList = new String[]{"국민","기업","농협","신한","조흥","외환","우체국","SC제일","하나","한국시티","한미","우리","경남","광주","대구","도이치","부산","산업","수협","전북","제주","새마을","신협","HSBC","상호저축"};
			%>
			<option value="">--선택--</option>
			<%
			for (int i = 0 ; i < bankNameList.length ; i++) {
			%>
			<option value='<%=bankNameList[i]%>' style='' <%=bankNameList[i].equals(member.getBankName())?"selected":""%>><%=bankNameList[i]%></option>
			<%
			}
			%>
			</select>
			계좌번호 : <input name="bankNumber" type="text" size="20" maxlength="20" value="<%=XwinUtil.nvl(member.getBankNumber())%>">
			예금주 : <input name="bankOwner" type="text" size="16" maxlength="16" value="<%=XwinUtil.nvl(member.getBankOwner())%>"><br>
			<input type="button" value="변경" onclick="changeBankInfo()"/>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>권한</td>
		<td width=80% bgcolor='#ffffff' align='left'>
		<input type="checkbox" name="deny_board" value="<%=Code.DENY_WRITE_BOARD%>" <%=(member.getDenyrity()&Code.DENY_WRITE_BOARD) > 0 ? "checked":""%>/> 게시판 쓰기 금지 <BR>
		<input type="checkbox" name="deny_qna" value="<%=Code.DENY_WRITE_QNA%>" <%=(member.getDenyrity()&Code.DENY_WRITE_QNA) > 0 ? "checked":""%>/> 고객센터 쓰기 금지<BR>
		<input type="button" value="변경" onclick="changeDenyrity()"/>
		</td>
 	</tr>
	<!-- 
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>회원상태</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input type='radio' name='status' value='<%=Code.USER_STATUS_NORMAL%>' <%=member.getStatus().equals(Code.USER_STATUS_NORMAL)?"checked":""%>> 정상 
			<input type='radio' name='status' value='<%=Code.USER_STATUS_SECEDE%>' <%=member.getStatus().equals(Code.USER_STATUS_SECEDE)?"checked":""%>> 탈퇴
			<input type='radio' name='status' value='<%=Code.USER_STATUS_SECEDE_REQ%>' <%=member.getStatus().equals(Code.USER_STATUS_SECEDE_REQ)?"checked":""%>> 탈퇴요청
		</td>
	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>회원종류</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input type='radio' name='grade' value='<%=Code.USER_GRADE_NORMAL%>' <%=member.getGrade().equals(Code.USER_GRADE_NORMAL)?"checked":""%>> 일반 
			<input type='radio' name='grade' value='<%=Code.USER_GRADE_VIP%>' <%=member.getGrade().equals(Code.USER_GRADE_VIP)?"checked":""%>> VIP
		</td>
	</tr>
	 -->
</table>
<BR>													
<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=100% bgcolor='#ffffff' align='left'>
			<%if (member.getStatus().equals(Code.USER_STATUS_SECEDE) == false) { %>
			<input type="button" value="회원탈퇴" onclick="secedeMember()"/>
			<%} else { %>
			<input type="button" value="회원복구" onclick="recorverMember()"/>
			<%} %>
			<!-- img src='images/admin/but_modify.gif' border=0 onclick="checkIT()" -->
			<!-- img src='images/admin/but_cancel.gif' border=0 onClick="history.back()" style="cursor:hand" -->
		</td>
	</tr>
</table>
</form>

<form name="charging">
<table id='uploadform' class="list">
	<tr>
		<th width="10%">종류</th>
		<th width="30%">금액</th>
		<th width="40%">비고</th>
		<th width="20%">기능</th>
	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=100% bgcolor='#ffffff' align='center'>직충전</td>
		<td width=100% bgcolor='#ffffff' align='center'>
			<input type="text" name="plus" size=30 onkeyup="only123(this); comma3Input(this);"/>
		</td>
		<td>
			<input type="text" name="plusNote" size=30></input>
		</td>
		<td>
			<input type="button" onclick="plus_charging()" value="직충전"></input>
		</td>
	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=100% bgcolor='#ffffff' align='center'>직차감</td>
		<td width=100% bgcolor='#ffffff' align='center'>
			<input type="text" name="minus" size=30 onkeyup="only123(this); comma3Input(this);"/>
		</td>			
		<td>
			<input type="text" name="minusNote" size=30></input>
		</td>
		<td>
			<input type="button" onclick="minus_charging()" value="직차감"></input>
		</td>
	</tr>
</table>
</form>

<form name="memo">
<table class="list">
	<tr>
		<th width="10%">쪽지</th>
		<td><textarea name="memo" style='width=100%;height=200px'></textarea></td>
	</tr>
</table>
<input type="button" value="발송" onclick="sendMemo()"/>"
</form>

<form method="get" name="search">
<input type="hidden" name="mode" value="viewMemberDetail"/>
<input type="hidden" name="pageIndex"/>
<input type="hidden" name="userId" value="<%=member.getUserId()%>"/>
<table class="list">
<tr>
	<th width=20%>거래일자</th>
	<th width=20%>기잔고</th>
	<th width=20%>입출금</th>
	<th width=20%>잔액</th>
	<th width=20%>비고</th>
</tr>
<%
if (accountList != null) {
	for (Account account : accountList) {
%>
<tr>
	<td align=center><%=account.getDateStr()%></td>
	<td align=center><%=XwinUtil.comma3(account.getOldBalance())%></td>
	<td align=center><%=XwinUtil.comma3(account.getMoney())%></td>
	<td align=center><%=XwinUtil.comma3(account.getBalance())%></td>
	<td align=center><%=Code.getValue(account.getType())%></td>
</tr>
<%
	}
}
%>		
</table>
</form>

<div class="pages">
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
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
<script>

function sendMemo()
{
	var frm = document.memo;
	var query = "mode=sendMemo";
	query += "&memo=" + Xwin.Escape(frm.memo.value);
	query += "&userId=<%=member.getUserId()%>";
	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		frm.memo.value = "";
}

function changeGrade()
{
	var frm = document.regist;	
	var query = "mode=changeGrade";
	query += "&grade=" + regist.grade.value;
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.message)
		location.reload();
}

function changeEmail()
{
	var frm = document.regist;	
	var query = "mode=changeEmail";
	query += "&email=" + regist.email1.value + "@" + regist.email2.value;
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.message)
		location.reload();
}

function changeMobile()
{
	var frm = document.regist;	
	var query = "mode=changeMobile";
	query += "&mobile=" + regist.phone1.value + "-" + regist.phone2.value + "-" + regist.phone3.value;
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.message)
		location.reload();
}

function changeDenyrity()
{
	var frm = document.regist;	
	var query = "mode=changeDenyrity";
	if (frm.deny_board.checked)
		query += "&deny_board=" + frm.deny_board.value;
	if (frm.deny_qna.checked)
		query += "&deny_qna=" + frm.deny_qna.value;
	
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.message)
		location.reload();
}

function changeBankInfo()
{
	var frm = document.regist;
	if (frm.bankName != undefined) {
		if (!frm.bankName.value || !frm.bankNumber.value || !frm.bankOwner.value) {
			alert("환전계좌정보를 입력해 주십시오");
			return;
		}
	}
	
	var query = "mode=changeBankInfo";
	query += "&bankName=" + frm.bankName.value;
	query += "&bankNumber=" + frm.bankNumber.value;
	query += "&bankOwner=" + frm.bankOwner.value;
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.message)
		location.reload();
}

function secedeMember()
{
	if (confirm("<%=member.getUserId()%>(<%=member.getNickName()%>) 회원을\n탈퇴시키시겠습니까?")) {
		var query = "mode=secedeMember";
		query += "&userId=<%=member.getUserId()%>";
		var http = new JKL.ParseXML("adminMember.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.href = "adminMember.aspx?mode=viewAdminMember&status=US001";
	}	
}

function recorverMember()
{
	if (confirm("<%=member.getUserId()%>(<%=member.getNickName()%>) 회원을\n복구시키시겠습니까?")) {
		var query = "mode=recorverMember";
		query += "&userId=<%=member.getUserId()%>";
		var http = new JKL.ParseXML("adminMember.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.href = "adminMember.aspx?mode=viewAdminMember&status=US001";
	}	
}

function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}

function plus_charging()
{
	var f = document.charging;
	if (!f.plus) {
		alert("숫자를 입력하세요");
		return false;
	}
	
	if (confirm("<%=member.getNickName()%>님께 " + f.plus.value + " 원을 직충전 하시겠습니까?")) {
		var query = "mode=directCharging";
		query += "&userId=<%=member.getUserId()%>";
		query += "&money=" + f.plus.value;
		query += "&note=" + f.plusNote.value;
		var http = new JKL.ParseXML("adminAccount.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		location.reload();
	}
}

function minus_charging()
{
	var f = document.charging;
	if (!f.minus) {
		alert("숫자를 입력하세요");
		return false;
	}
	
	if (confirm("<%=member.getNickName()%>님께 " + f.minus.value + " 원을 직차감 하시겠습니까?")) {
		var query = "mode=directMinusCharging";
		query += "&userId=<%=member.getUserId()%>";
		query += "&money=" + f.minus.value;
		query += "&note=" + f.minusNote.value;
		var http = new JKL.ParseXML("adminAccount.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		location.reload();
	}
}
</script>

<%@ include file="../admin_footer.jsp"%>