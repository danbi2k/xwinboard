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
           mengubahkan info anggota 
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
 <td align=right class=menubar>anggota idenditas</td>
 <td></td>
 <td><%=member.getUserId()%></td>
</tr>


<tr>
 <td align=right class=menubar>kata rahasia baru</td>
 <td></td>
 <td> <input type=password name=password1 maxlength=200 class=input2 > </td>
</tr>

<tr>
 <td align=right class=menubar>cek kata rahasia</td>
 <td></td>
 <td><input type=password name=password2 maxlength=200 class=input2 ></td>
</tr>
<tr>
 <td align=right class=menubar>nama panggilan</td>
 <td></td>
 <td><%=member.getNickName()%></td>
</tr>
<tr>
 <td align=right class=menubar>nomor telpon selular</td>
 <td></td>
 <td><%=member.getMobile()%>
</td>
</tr>
<tr>
 <td align=right class=menubar>e-mail</td>
 <td></td>
 <td><%=member.getEmail()%></td>
</tr>
<tr>
 <td align=right class=menubar>nomor deposito pertukaran</td>
 <td></td>
 <td><%=member.getBankName()%> <%=member.getBankNumber()%> <%=member.getBankOwner()%></td>
</tr>
<tr>
 <td align=right class=textpoint>kata rahasia pertukaran baru</td>
 <td></td>
 <td><input type=password name=pin maxlength=200 class=input2 ></td>
</tr>
<tr>
 <td></td>
 <td></td>
 <td class=textpoint>[kata rahasia untuk menjaga memarang website]</td>
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
          mendaftar keluar Kalau mendaftar keluar 
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
         
   pengatur akan cek dulu dan keluar akan memecahkan,<BR>kalau ada uang tersisa meminta pertukaran dulu,
 
  

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
alert("mohon daftar rekening tukar uang. pelayanan tukar uang hanya bisa dengan rekening tukar uang yang sudah di daftar dan kalau ingin ganti rekening tukar uang kasih tau servis langganan dan stelah proses pemeriksaan kita akan ganti rekening anda 
");
<%
}
%>

<%
if (needExpire) {
%>
alert("sandi anda sudah berakhir mohon ganti sandi");
<%
}
%>

function sendAuthNumber(){
	var f = document.frm_mem;
	if (!f.phone2.value && f.phone2.value.length < 3) {
		alert("cek nomor telpon dan masukan lagi");
		return;
	}

	if (!f.phone3.value && f.phone3.value.length < 4) {
		alert("cek nomor telpon dan masukan lagi");
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