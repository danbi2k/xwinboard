
<!--	#include virtual=/common/asp/connect.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<%
'**************************************************************************************
'  SOURCE NAME	: MessageSend02.asp
'  GUIDANCE			: V1.21	
'
'  Copyright ⓒ 2005-2008 SMSGO 좋은소식. All right Reserved.
'**************************************************************************************
'
'  즉시/예약 메세지 전송 결과
'
'**************************************************************************************


ReturnCode		=  Request.Form("ReturnCode")		' 메세지 발송 여부    00 : 성공 , 그 외의 값 : 실패
TransferCnt		=  Request.Form("TransferCnt")		' 발송한 SMS 건 수 수량
ErrorCode		=  Request.Form("ErrorCode")				' 에러 코드 (에러 코드표 참조)
Process_Type	=  Request.Form("Process_Type")		' 메세지 발송 방식 0 : 즉시,  1 : 예약
UnqNumber		=  Request.Form("UnqNumber")			' 발송 메세지의 고유번호 (조회, 예약 수정및 삭제 시 필요)
RemainCash		=  Request.Form("RemainCash")		' 잔여 콜 수 
UserData1		=  Request.Form("UserData1")				' 사용자 정의 필드 1
UserData2		=  Request.Form("UserData2")				' 사용자 정의 필드 2
UserData3		=  Request.Form("UserData3")				' 사용자 정의 필드 3


SQL = "INSERT INTO Sms_TB(ReCode, TransCnt, SendType, rIdx, SumCnt, ErrCode, Content) "
SQL = SQL &" VALUES('"& ReturnCode &"','"& TransferCnt &"','"& Process_Type &"','"& UnqNumber &"','"& RemainCash &"','"& ErrorCode &"','"& UserData2 &"')"
RunSQL(SQL)
'Response.Write SQL & "<br>"

If UserData1 = "1" Then
	Call descment("발송되었습니다.","close","")
Else
	Call descment("","/Admin/Member/SmsWrite.asp","")
End If

'Response.Write ErrorCode & "<br>"
%>
