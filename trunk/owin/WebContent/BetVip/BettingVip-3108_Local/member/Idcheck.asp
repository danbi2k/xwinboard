<%
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.expires = -1
Response.buffer = true
%>	
<META http-equiv="Pragma" content="no-cache">
<!--	#include virtual="/common/asp/config.asp"			-->
<!--	#include virtual="/common/asp/connect.asp"			-->
<!--	#include virtual="/common/asp/UtilityClass.asp"		-->

<script language="javascript">
<!--
var opener = window.dialogArguments;
function controlParent(option) {
/*
	if(option == "1") {
		opener.document.regfrm.id.value = ''
		self.close();
		
	} else if(option == "2") {
//		opener.document.regfrm.id.value = ''
//		opener.document.regfrm.idchecked.value = opener.document.regfrm.idchecked.value = '1'
//		opener.document.regfrm.idchecked.checked = opener.document.regfrm.idchecked.checked ? false : true;
		self.close();
	}
	*/
	self.close();
}
//-->
</script>
<%
	Dim strUserId
	Dim SQL
	Dim msg

	strUserId = reString(Request.QueryString("id"),"sql")
	
'	If Not isNone(IdFilter(UCASE(strUserId))) Then Call descmentPage("["& IdFilter(UCASE(strUserId))  &"] �� ������ѵ� ���̵� �Դϴ�. \n\n�ٸ� ���̵� �˻��� �ּ���", "controlParent('1')","")
	Set objRs = RunSQLReturnRs("SELECT [Id] FROM Member_TB WHERE Id = '" & strUserId & "'")
	
	If objRs.BOF or objRs.EOF Then
		
		Call CloseDB()
		Call descmentPage("["& strUserId & "] ��밡���� ���̵��Դϴ�.", "controlParent('2')","")
	Else
		
		Call CloseDB()
		Call descmentPage("["& strUserId & "] �̹� ������� ���̵��Դϴ�.", "controlParent('2')","")
	End If
	

%>

