
<!--	#include virtual="/common/asp/connect.asp"		-->
<!--	#include virtual="/common/asp/UtilityClass.asp"	-->
<!--	#include virtual="/common/asp/MemberClass.asp"	-->
<%
	strId		= reString(Request("fid"),"sql")
	strPwd		= reString(Request("fpwd"),"sql")
	strRefPage	= Request("refPage")
'	GetIp = Call GetIp()
	
	IntCkvalue		=  LoginCheck(strId, strPwd, IntUType , blnEOF)

'	Response.Write strId
'	Response.Write strPwd
'	Response.End
	Select Case blnEOF
		Case 1 : Call descMent("입력하신 정보를 회원 정보에서 찾을 수 없습니다."& VbCrLf & VbCrLf &"다시확인해 확인해 주세요.","back","")
		Case 2 : Call descMent("입력하신 정보를 회원 정보에서 찾을 수 없습니다."& VbCrLf & VbCrLf &"다시확인해 확인해 주세요.","back","")
		Case 3 : Call descMent("입력하신 정보를 회원 정보에서 찾을 수 없습니다."& VbCrLf & VbCrLf &"다시확인해 확인해 주세요.","back","")
		Case 4 : Call descMent("입력하신 정보를 회원 정보에서 찾을 수 없습니다."& VbCrLf & VbCrLf &"다시확인해 확인해 주세요.","back","")
		Case 0

			Call descMent("","/","")

	End Select


'kec8339
'cylilo6054
'125.149.100.190
%>
