
<!--	#include virtual=/common/asp/connect.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<%
'**************************************************************************************
'  SOURCE NAME	: MessageSend02.asp
'  GUIDANCE			: V1.21	
'
'  Copyright �� 2005-2008 SMSGO �����ҽ�. All right Reserved.
'**************************************************************************************
'
'  ���/���� �޼��� ���� ���
'
'**************************************************************************************


ReturnCode		=  Request.Form("ReturnCode")		' �޼��� �߼� ����    00 : ���� , �� ���� �� : ����
TransferCnt		=  Request.Form("TransferCnt")		' �߼��� SMS �� �� ����
ErrorCode		=  Request.Form("ErrorCode")				' ���� �ڵ� (���� �ڵ�ǥ ����)
Process_Type	=  Request.Form("Process_Type")		' �޼��� �߼� ��� 0 : ���,  1 : ����
UnqNumber		=  Request.Form("UnqNumber")			' �߼� �޼����� ������ȣ (��ȸ, ���� ������ ���� �� �ʿ�)
RemainCash		=  Request.Form("RemainCash")		' �ܿ� �� �� 
UserData1		=  Request.Form("UserData1")				' ����� ���� �ʵ� 1
UserData2		=  Request.Form("UserData2")				' ����� ���� �ʵ� 2
UserData3		=  Request.Form("UserData3")				' ����� ���� �ʵ� 3


SQL = "INSERT INTO Sms_TB(ReCode, TransCnt, SendType, rIdx, SumCnt, ErrCode, Content) "
SQL = SQL &" VALUES('"& ReturnCode &"','"& TransferCnt &"','"& Process_Type &"','"& UnqNumber &"','"& RemainCash &"','"& ErrorCode &"','"& UserData2 &"')"
RunSQL(SQL)
'Response.Write SQL & "<br>"

If UserData1 = "1" Then
	Call descment("�߼۵Ǿ����ϴ�.","close","")
Else
	Call descment("","/Admin/Member/SmsWrite.asp","")
End If

'Response.Write ErrorCode & "<br>"
%>
