<!--	#include virtual="/common/asp/UtilityClass.asp"	-->
<%
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.expires = -1
Response.buffer = true
%>	
<META http-equiv="Pragma" content="no-cache">
<script language="javascript">
<!--
//var opener = window.dialogArguments;
function controlParent(option) {
//	opener.document.regfrm.id.value = ''
	opener.location.replace('http://www.okbet-vip.com/index.asp');
//	self.close();
}
//-->
</script>
<%
	Call descmentPage("vip 회원으로 승급되심을 축하드립니다.", "controlParent('2')","")
	
%>

