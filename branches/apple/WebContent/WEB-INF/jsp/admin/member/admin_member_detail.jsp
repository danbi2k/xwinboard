<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.join.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	Member member = (Member) request.getAttribute("member");
	List<Account> accountList = (List<Account>) request.getAttribute("accountList");
	Integer totalCount = (Integer) request.getAttribute("accountCount");
	
	Long chargeSum = (Long) request.getAttribute("chargeSum");
	Long exchangeSum = (Long) request.getAttribute("exchangeSum");
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
	
	Integer childCount = (Integer) request.getAttribute("childCount");
	List<Member> childList = (List<Member>) request.getAttribute("childList");
	
	List<Invitation> noJoinList = (List<Invitation>) request.getAttribute("noJoinList");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	String type = XwinUtil.nvl(request.getParameter("type"));
	String money = XwinUtil.nvl(request.getParameter("money"));
	
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
<BR>
<span style='font-size:18'>충전 : <%=XwinUtil.comma3(chargeSum)%> 환전 : <%=XwinUtil.comma3(exchangeSum)%> 합계 : <%=XwinUtil.comma3(chargeSum - exchangeSum)%></span>
<form method=post name='regist'>
<input type='hidden' name='mode' value='updateMember'/>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>회원아이디</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<a href='adminBetting.aspx?mode=viewBettingList&focusSearch=userId&keyword=<%=member.getUserId()%>'><%=member.getUserId()%></a>
		</td>
	</tr>
   	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>닉네임</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input name="nickName" type="text" value="<%=member.getNickName()%>"/>
			<input type="button" value="변경" onclick="changeNickName()"/>
		</td>
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
		<td width=80% bgcolor='#ffffff' align='left'>
			<input name="password" type="text" value="<%=member.getPassword()%>"/>
			<input type="button" value="변경" onclick="changePassword()"/>
		</td>
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
			<BR>
			SMS수신 <input type="checkbox" name="smsCheck" <%=member.getGetSms().equals("Y")?"checked":""%> onclick="changeGetSms()"/>
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
		<td width=20%>환전비밀번호</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<input name="pin" type="text" value="<%=member.getPassword()%>"/>
			<input type="button" value="변경" onclick="changePin()"/>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>가입일</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=member.getJoinDateStr()%>:<%=member.getMemberId()%></td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>상태</td>
		<td width=80% bgcolor='#ffffff' align='left'><%=Code.getValue(member.getStatus())%></td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>추천장</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<%=member.getIntroLetter()%> 장
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="text" name="introLetter" value="1" size="2" maxLength="2"/>
			<input type="button" value="추천장지급" onclick="giveIntroLetter()"/>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>미사용추천장</td>
		<td width=80% bgcolor='#ffffff' align='left'>
		<table class="prettytable">
		<%
		if (noJoinList != null) {
		%>
		<tr>
			<th>추천장</th>
			<th>휴대폰</th>
			<th>발송일</th>
		</tr>
		<%
			for (Invitation invitation : noJoinList) {
		%>
			<tr>
			<td><%=invitation.getInviteKey()%></a>	</td>
			<td><%=invitation.getMobile()%></td>
			<td><%=XwinUtil.toDateStr(invitation.getSendDate(), 1)%></td>
			</tr>
		<%
			}
		}
		%>
		</table>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>추천해준회원</td>
		<td width=80% bgcolor='#ffffff' align='left'>
			<a href='javascript:goMemberDetail("<%=XwinUtil.nvl(member.getIntroducerId())%>")'><%=XwinUtil.nvl(member.getIntroducerId())%></a>
			<%=XwinUtil.nvl(member.getNickName())%>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>추천한회원</td>
		<td width=80% bgcolor='#ffffff' align='left'>
		<table class="prettytable">
		<%
		if (childList != null) {
		%>
		<tr>
			<th>아이디</th>
			<th>닉네임</th>
			<th>가입일</th>
			<th>상태</th>
		</tr>
		<%
			for (Member child : childList) {
		%>
			<tr>
			<td><a href='javascript:goMemberDetail("<%=child.getUserId()%>")'><%=child.getUserId()%></a>	</td>
			<td><%=child.getNickName()%></td>
			<td><%=XwinUtil.toDateStr(child.getJoinDate(), 1)%></td>
			<td><%=Code.getValue(child.getStatus())%></td>
			</tr>
		<%
			}
		}
		%>
		</table>
		</td>
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
			등록일 : <%=XwinUtil.toDateStr(member.getBankDate(), 1)%>
			<input type="button" value="변경" onclick="changeBankInfo()"/>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>이전 계좌 번호</td>
		<td width=80% bgcolor='#ffffff' align='left'>
		<table class="prettytable">
		<%
		if (bankBookList != null && bankBookList.size() > 0) {
		%>
		<tr>
			<th>은행명</th>
			<th>계좌번호</th>
			<th>예금주</th>
			<th>등록일</th>
		</tr>
		<%
			for (BankBook bankBook : bankBookList) {
		%>
		<tr>
			<td><%=bankBook.getBankName()%></td>
			<td><%=bankBook.getNumber()%></td>
			<td><%=bankBook.getName()%></td>
			<td><%=XwinUtil.toDateStr(bankBook.getDate(), 1)%></td>
		</tr>
		<%
			}
		}
		%>		
		</table>
		</td>
 	</tr>
	<tr align="center" bgcolor="#E4E4E4" height=20>
		<td width=20%>권한</td>
		<td width=80% bgcolor='#ffffff' align='left'>
		<table width=100%>
		<tr>
		<td colspan="3"><input type="checkbox" name="expireCheck" <%=member.getPasswordExpire().equals("Y")?"checked":""%> onclick="changePasswordExpire()"/> 비밀번호의무변경</td>
		</tr>
		<tr>
		<td><input onclick="resetBoardDenyDate(this)" type="checkbox" name="deny_board" value="<%=Code.DENY_WRITE_BOARD%>" <%=(member.getDenyrity()&Code.DENY_WRITE_BOARD) > 0 ? "checked":""%>/> 게시판 쓰기 금지</td>
		<td>
			<span onclick="setBoardDenyDate(5)">5일</span>&nbsp;&nbsp;
			<span onclick="setBoardDenyDate(10)">10일</span>&nbsp;&nbsp;
			<span onclick="setBoardDenyDate(15)">15일</span>&nbsp;&nbsp;
		</td>
		<td>금지해제일 : <input type='text' name='board_deny_date' value='<%=XwinUtil.toDateStr(member.getBoardDenyDate(), 2)%>' size=10 readonly onClick="popUpCalendar(this,board_deny_date,'yyyy-mm-dd');" style="cursor:hand"></td>
		</tr>
		<tr>
		<td><input onclick="resetQnaDenyDate(this)" type="checkbox" name="deny_qna" value="<%=Code.DENY_WRITE_QNA%>" <%=(member.getDenyrity()&Code.DENY_WRITE_QNA) > 0 ? "checked":""%>/> 고객센터 쓰기 금지</td>
		<td>
			<span onclick="setQnaDenyDate(5)">5일</span>&nbsp;&nbsp;
			<span onclick="setQnaDenyDate(10)">10일</span>&nbsp;&nbsp;
			<span onclick="setQnaDenyDate(15)">15일</span>&nbsp;&nbsp;
		</td>
		<td>금지해제일 : <input type='text' name='qna_deny_date' value='<%=XwinUtil.toDateStr(member.getQnaDenyDate(), 2)%>' size=10 readonly onClick="popUpCalendar(this,qna_deny_date,'yyyy-mm-dd');" style="cursor:hand"></td>
		</tr>		
		</table>
		<input type="button" value="변경" onclick="changeDenyrity()"/> ※ 금지 해제일을 넣지 않으면 수동으로 금지 해제 하셔야 합니다.
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
			<input type="text" name="plus" size=30 />
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
			<input type="text" name="minus" size=30 />
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
<input type="button" value="발송" onclick="sendMemo()"/>
</form>

<form name="note">
<table class="list">
	<tr>
		<th width="10%">메모</th>
		<td><textarea name="note" style='width=100%;height=200px'><%=XwinUtil.nvl(member.getNote())%></textarea></td>
	</tr>
</table>
<input type="button" value="저장" onclick="saveNote()"/>
</form>
<BR>
<a name="result"></a>

<form method="get" name="search">
<input type="hidden" name="mode" value="viewMemberDetail"/>
<input type="hidden" name="pageIndex"/>
<input type="hidden" name="userId" value="<%=member.getUserId()%>"/>
종류
	<select name='type' onchange='this.form.submit()'>
		<option value='' <%=type.equals("")?"selected":""%>>전체</option>
 		<option value='AT001' <%=type.equals("AT001")?"selected":""%>><%=Code.getValue("AT001")%></option>
 		<option value='AT002' <%=type.equals("AT002")?"selected":""%>><%=Code.getValue("AT002")%></option>
		<option value='AT003' <%=type.equals("AT003")?"selected":""%>><%=Code.getValue("AT003")%></option>
		<option value='AT004' <%=type.equals("AT004")?"selected":""%>><%=Code.getValue("AT004")%></option>
		<option value='AT010' <%=type.equals("AT005")?"selected":""%>><%=Code.getValue("AT010")%></option>
 	</select>
금액
 	<input type='text' name='money' value='<%=money%>'>
일자
	<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
	<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">		
 	<input type='submit' value='검 색'/>
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
function giveIntroLetter()
{
	var query = "mode=giveIntroLetter";
	query += "&userId=<%=member.getUserId()%>";
	query += "&number=" + document.regist.introLetter.value;
	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();	
}

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

function saveNote()
{
	var frm = document.note;
	var query = "mode=saveNote";
	query += "&note=" + Xwin.Escape(frm.note.value);
	query += "&userId=<%=member.getUserId()%>";
	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
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
	if (result.resultXml.code == 0)
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
	if (result.resultXml.code == 0)
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
	if (result.resultXml.code == 0)
		location.reload();
}

function changeNickName()
{
	var frm = document.regist;	
	var query = "mode=changeNickName";
	query += "&nickName=" + regist.nickName.value;
	query += "&orgNickName=<%=member.getNickName()%>";
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}

function changeDenyrity()
{
	var frm = document.regist;	
	var query = "mode=changeDenyrity";
	if (frm.deny_board.checked) {
		query += "&deny_board=" + frm.deny_board.value;
		query += "&board_deny_date=" + frm.board_deny_date.value;
	}
	if (frm.deny_qna.checked) {
		query += "&deny_qna=" + frm.deny_qna.value;
		query += "&qna_deny_date=" + frm.qna_deny_date.value;
	}
	
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
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
	if (result.resultXml.code == 0)
		location.reload();
	else if (result.resultXml.code == -2) {
		var dupList = Xwin.ToArray(result.resultXml.object.member);
		var dupId = "중복아이디목록 : ";
		for (var i in dupList) {
			if (dupList[i].userId == '<%=member.getUserId()%>')
				continue;
			dupId = dupId + dupList[i].userId + " ";
		}
		alert(dupId);
	}
}

function changePassword()
{
	var frm = document.regist;
	if (frm.password != undefined) {
		if (!frm.password.value) {
			alert("비밀번호를 입력해 주십시오");
			return;
		}
	}
	
	var query = "mode=changePassword";
	query += "&password=" + frm.password.value;
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}

function changePin()
{
	var frm = document.regist;
	if (frm.pin!= undefined) {
		if (!frm.pin.value) {
			alert("환전비밀번호를 입력해 주십시오");
			return;
		}
	}
	
	var query = "mode=changePin";
	query += "&pin=" + frm.pin.value;
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();
}

function changeGetSms()
{
	var frm = document.regist;
		
	var query = "mode=changeGetSms";
	if (frm.smsCheck.checked)
		query += "&getSms=Y";
	else
		query += "&getSms=N";
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	location.reload();
}

function changePasswordExpire()
{
	var frm = document.regist;
		
	var query = "mode=changePasswordExpire";
	if (frm.expireCheck.checked)
		query += "&passwordExpire=Y";
	else
		query += "&passwordExpire=C";
	query += "&userId=<%=member.getUserId()%>";

	var http = new JKL.ParseXML("adminMember.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
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

function resetBoardDenyDate(tobj)
{
	var frm = document.regist;
	if (tobj.checked == false)
		frm.board_deny_date.value = "";
}

function resetQnaDenyDate(tobj)
{
	var frm = document.regist;
	if (tobj.checked == false)
		frm.qna_deny_date.value = "";
}

function setBoardDenyDate(duration)
{
	var frm = document.regist;
	var today = new Date();
	var endDate = new Date();
	endDate.setDate(today.getDate() + duration);
	document.regist.board_deny_date.value = (endDate.getYear()) + "-" + (endDate.getMonth()+1) + "-" + endDate.getDate();
}

function setQnaDenyDate(duration)
{
	var frm = document.regist;
	var today = new Date();
	var endDate = new Date();
	endDate.setDate(today.getDate() + duration);
	document.regist.qna_deny_date.value = (endDate.getYear()) + "-" + (endDate.getMonth()+1) + "-" + endDate.getDate();
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
		query += "&note=" + Xwin.Escape(f.plusNote.value);
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
		query += "&note=" + Xwin.Escape(f.minusNote.value);
		var http = new JKL.ParseXML("adminAccount.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		location.reload();
	}
}
</script>

<%@ include file="../admin_footer.jsp"%>