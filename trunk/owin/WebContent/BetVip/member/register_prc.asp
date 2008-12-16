
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/BbsTransaction.asp	-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->

<%
	Dim arrName(32), arrValue(32)
	
	rUIp	= GetIp
	If Request("flag") = "MODIFY" Then
		If isNone(Session("UId")) Then Call descment("","/","")	
		arrName(1)		= "Pwd"			: arrValue(1)	= reString(Request("Pwd"),"sql")
		arrName(2)		= "Name"		: arrValue(2)	= reString(Request("Name"),"sql")
		arrName(4)		= "mail"		: arrValue(4)	= reString(Request("mail01"),"sql") &"@"& reString(Request("mail02"),"sql")
		arrName(5)		= "zipcode"		: arrValue(5)	= reString(Request("zipcode01"),"sql") &"-"& reString(Request("zipcode02"),"sql")
		arrName(6)		= "Addr"		: arrValue(6)	= reString(Request("Addr"),"sql") &"@"&reString(Request("addradd"),"sql")
		arrName(7)		= "Birth"		: arrValue(7)	= reString(Request("Birth01"),"sql")&"-"&reString(Request("Birth02"),"sql")&"-"&reString(Request("Birth03"),"sql")
		arrName(8)		= "Cell"		: arrValue(8)	= reString(Request("cell01"),"sql") &"-"& reString(Request("cell02"),"sql") &"-"& reString(Request("cell03"),"sql")
		arrName(10)		= "gMail"		: arrValue(10)	= reString(Request("gmail"),"sql")
		arrName(12)		= "tel"			: arrValue(12)	= reString(Request("tel01"),"sql") &"-"& reString(Request("tel02"),"sql") &"-"& reString(Request("tel03"),"sql")
		arrName(13)		= "BirthTy"		: arrValue(13)	= reString(Request("BirthTy"),"sql")
		arrName(15)	= "CDepos"			: arrValue(15)	= reString(Request("CDepos"),"sql")
		arrName(16) = "BankN"			: arrValue(16)	= reString(Request("BankN"),"sql")
		arrName(17) = "BankNum"			: arrValue(17)	= reString(Request("BankNum"),"sql")
		arrName(18) = "RDepos"			: arrValue(18)	= reString(Request("RDepos"),"sql")
		arrName(19) = "gSms"			: arrValue(19)	= reString(Request("gSms"),"sql")
		Session("UName")		= arrValue(2)
		If isNone(arrValue(1)) or isNone(arrValue(2)) or isNone(arrValue(15)) or isNone(arrValue(16)) or isNone(arrValue(17)) or isNone(arrValue(18)) Then Call descment("필수입력 사항이 입력되지 않았습니다.","back","") 
		SQL = updateDB("Member_TB", arrName, arrValue) & " WHERE [Id]='"& Session("UId") &"'"
'		Response.Write SQL
		RunSQL(SQL)
'		Response.End
		Call CloseDB() : Call descment("수정되었습니다.","/","")
	Else
	strIp	= Request.ServerVariables("REMOTE_ADDR")
	hrcode	= Request("hrcode")
	rcode	= Request("rcode")

	If isNone(strIp) Then Call descment("","/","")	
	If isNone(rcode) Then Call descment("자동가입 방지 코드를 입력하세요.","back","")	
	If isNone(hrcode) Then Call descment("","/","")	
	If hrcode<>rcode Then Call descment("잘못된 자동가입 방지 코드 입니다.","back","")	
	
		arrName(0)	= "Id"				: arrValue(0)	= reString(Request("Id"),"sql")
		arrName(1)	= "Pwd"				: arrValue(1)	= reString(Request("Pwd"),"sql")
		arrName(2)	= "Name"			: arrValue(2)	= reString(Request("Name"),"sql")
		arrName(3)	= "Jumin"			: arrValue(3)	= reString(Request("Jumin01"),"sql") &"-"& reString(Request("Jumin02"),"sql")
		arrName(4)	= "mail"			: arrValue(4)	= reString(Request("mail01"),"sql") &"@"& reString(Request("mail02"),"sql")
		arrName(5)	= "zipcode"			: arrValue(5)	= reString(Request("zipcode01"),"sql") &"-"& reString(Request("zipcode02"),"sql")
		arrName(6)	= "Addr"			: arrValue(6)	= reString(Request("Addr"),"sql") &"@"&reString(Request("addradd"),"sql")
		arrName(7)	= "Birth"			: arrValue(7)	= reString(Request("Birth01"),"sql")&"-"&reString(Request("Birth02"),"sql")&"-"&reString(Request("Birth03"),"sql")
		arrName(8)	= "Cell"			: arrValue(8)	= reString(Request("cell01"),"sql") &"-"& reString(Request("cell02"),"sql") &"-"& reString(Request("cell03"),"sql")
		arrName(10)	= "BirthTy"			: arrValue(10)	= reString(Request("BirthTy"),"sql")
		arrName(11)	= "Point"			: arrValue(11)	= 0
		arrName(12)	= "tel"				: arrValue(12)	= reString(Request("tel01"),"sql") &"-"& reString(Request("tel02"),"sql") &"-"& reString(Request("tel03"),"sql")
		arrName(13)	= "Content"			: arrValue(13)	= reString(Request("Content"),"sql")
		arrName(14)	= "Writeip"			: arrValue(14)	= strIp
		arrName(15)	= "CDepos"			: arrValue(15)	= reString(Request("CDepos"),"sql")
		arrName(16) = "BankN"			: arrValue(16)	= reString(Request("BankN"),"sql")
		arrName(17) = "BankNum"			: arrValue(17)	= reString(Request("BankNum"),"sql")
		arrName(18) = "RDepos"			: arrValue(18)	= reString(Request("RDepos"),"sql")
		arrName(19) = "gSms"			: arrValue(19)	= reString(Request("gSms"),"sql")
		
		If isIDPwd(arrValue(0), 4, 10) = false Then Call descment("아이디는 영문숫자 4자이상 10자 미만 가능합니다.","back","")
		If isNone(arrValue(0)) or isNone(arrValue(1)) or isNone(arrValue(2)) or isNone(arrValue(15)) or isNone(arrValue(16)) or isNone(arrValue(17)) or isNone(arrValue(18)) Then Call descment("필수입력 사항이 입력되지 않았습니다.","back","") 
		If Len(arrValue(0)) < 4 or Len(arrValue(0)) > 10 Then  Call descment("아이디는 영문숫자 4자이상 10자 미만 가능합니다.","back","")
		If MemRegIp(rUIp) Then  Call descment("현재 "& rUIp &" 는 이미 가입된 아이피 입니다. 동일 IP 1개의 아이디만 가입할수 있습니다.","back","") 

		isId = isDupliMemberData("Id", arrValue(0), blnEOF)
		If blnEOF=False Then  Call DescMent("이미등록된 아이디 입니다.\n\n다시 확인해주시기 바랍니다.","back","")
	
'		isId = isDupliMemberData("jumin", arrValue(3), blnEOF)
'		If blnEOF=False Then Call DescMent("이미등록된 주민등록번호 입니다.\n\n다시 확인해주시기 바랍니다.","back","")
		
		
		SQL = insertDB("Member_TB", arrName, arrValue)	
'		Response.Write SQL :Response.End
'		RunSQL(SQL)
	
'		session.Timeout			= 60
'		Session("UId")			= arrValue(0)
'		Session("UName")		= arrValue(2)
'		Session("UPoint")		= 0
'		
'		Response.Cookies("member")("name")	= arrValue(2)
'		Response.Cookies("member")("mail")	= arrValue(4)
'		Response.Cookies("member")("cell")	= arrValue(8)
'		Response.Cookies("member")("tel")	= arrValue(9)
'		Response.Cookies("member").Expires = now()+1
		Call CloseDB() : Call descment("감사합니다. 회원가입 완료되었습니다.","/","")
	
	End IF
%>