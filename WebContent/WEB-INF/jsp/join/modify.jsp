<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*"%>

<%@include file="../header.jsp"%>
<%
	String phone[] = null;
	String email[] = null;
	
	String _mobile = member.getMobile();
	String _email = member.getEmail();
	if (_mobile != null) {
		phone = _mobile.split("-");		
	}
	if (_email != null) {
		email = _email.split("@"); 
	} 
	
	boolean needBank = member.getBankName() == null || member.getBankName().length() == 0;
	boolean needExpire = member.getPasswordExpire().equals("Y");
%>

			<tr><td><img src="img/menu14.jpg" border="0"></td></tr>
            </table>
     
     <table align="center" cellpadding="0" cellspacing="0" width="771" height="40" background="img/bar-.jpg">
    <tr>
        <td width="771" height="40" align="center" valign="middle" class="menubar">
           회원정보수정 
        </td>
        
    </tr>
</table>
	<form name="frm_mem">
	<input type="hidden" name="userId" value="<%=member.getUserId()%>">
	<input type="hidden" name="phone1" value="<%=phone[0]%>"/>
	<input type="hidden" name="phone2" value="<%=phone[1]%>"/>
	<input type="hidden" name="phone3" value="<%=phone[2]%>"/>
	<input type="hidden" name="email1" value="<%=email[0]%>"/>
	<input type="hidden" name="email2" value="<%=email[1]%>">
	<table width="800" style="margin-top:10">
 <table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
   
    <tr>
        <td width="771" height="37" background="img/minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="771" height="132" background="img/minit_02.jpg" valign="top" style="padding:20">
           <table border=0 cellspacing=0 cellpadding=0 width=700 align="center">

<col width=100></col>
<col width=7></col>
<col width=500></col>



 

<tr>
 <td align=right class=menubar>회원아이디</td>
 <td></td>
 <td><%=member.getUserId()%></td>
</tr>


<tr>
 <td align=right class=menubar>새비밀번호</td>
 <td></td>
 <td> <input type=password name=password1 maxlength=200 class=input2 > </td>
</tr>

<tr>
 <td align=right class=menubar>새 비밀번호 확인</td>
 <td></td>
 <td><input type=password name=password2 maxlength=200 class=input2 ></td>
</tr>
<tr>
 <td align=right class=menubar>닉네임</td>
 <td></td>
 <td><%=member.getNickName()%></td>
</tr>
<tr>
 <td align=right class=menubar>휴대폰번호</td>
 <td></td>
 <td><%=member.getMobile()%>
</td>
</tr>
<tr>
 <td align=right class=menubar>이메일</td>
 <td></td>
 <td><%=member.getEmail()%></td>
</tr>
<tr>
 <td align=right class=menubar>환전계좌번호</td>
 <td></td>
 <td><%=member.getBankName()%> <%=member.getBankNumber()%> <%=member.getBankOwner()%></td>
</tr>
<tr>
 <td align=right class=textpoint>새 환전비밀번호</td>
 <td></td>
 <td><input type=password name=pin maxlength=200 class=input2 ></td>
</tr>
<tr>
 <td></td>
 <td></td>
 <td class=textpoint>[사이트 해킹방지용
비밀번호입니다]</td>
</tr>
<tr>


</table>

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
			    <td width="771" height="40" align="center"><img onclick="FnMemModify(frm_mem);" src="img/edit.jpg" border="0" align="absmiddle">&nbsp;<img src="img/back.jpg" onclick="location.reload();" border="0" align="absmiddle">
				</td>
			</tr>
		    
     </table>


	      <table align="center" cellpadding="0" cellspacing="0" width="771" height="40" background="img/bar-.jpg">
    <tr>
        <td width="771" height="40" align="center" valign="middle" class="menubar">
           탈퇴신청 
        </td>
        
    </tr>
</table>
 <table align="center" cellpadding="0" cellspacing="0" width="771" height="50">
   
    <tr>
        <td width="771" height="37" background="img/minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="771" height="30" background="img/minit_02.jpg" valign="top" style="padding:20" class="menubar">
         
   탈퇴신청을 하시면, 관리자가 확인후 탈퇴를 처리해 드립니다.<br>
   머니 잔액이 있을경우 환전 요청을 먼저 하시기 바랍니다. 
  

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
			    <td width="771" height="40" align="center"><img src="img/bye.jpg" onclick="FnMemOut();" border="0" align="absmiddle">
				</td>
			</tr>
		    
     </table>
</form>

<script>
<%
if (needBank) {
%>
alert("환전계좌를 등록해 주십시오\n환전업무는 등록된 환전계좌로만 가능하며 환전계좌 변경시에는\n고객센터로 문의해주시면 본인인증절차를 거쳐 변경해드립니다");
<%
}
%>

<%
if (needExpire) {
%>
alert("비밀번호가 만료되었습니다\n비밀번호를 변경해 주십시오\n");
<%
}
%>

function sendAuthNumber(){
	var f = document.frm_mem;
	if (!f.phone2.value && f.phone2.value.length < 3) {
		alert("전화번호를 확인하시고 다시 넣어주세요");
		return;
	}

	if (!f.phone3.value && f.phone3.value.length < 4) {
		alert("전화번호를 확인하시고 다시 넣어주세요");
		return;
	}
	
	var query = "mode=sendAuthNumber";
	query += "&phone=" + f.phone1.value + "-" + f.phone2.value + "-" + f.phone3.value;
	
	var http = new JKL.ParseXML("member.aspx", query);
	var result = http.parse();

	alert(result.resultXml.message); 
}
</script>

<%@include file="../footer.jsp"%>