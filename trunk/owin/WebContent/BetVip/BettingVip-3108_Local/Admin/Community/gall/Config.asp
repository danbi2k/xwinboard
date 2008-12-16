<%
	Dim MaxSize, Dpath, Moutcolor, Movercolor, LineBg
	Dim TrBg, TbackGround, TbWidth, TableName, bTitle
'	Response.CacheControl = "no-cache" 
'	Response.AddHeader "Pragma", "no-cache" 
'	Response.Expires = -1 
'	Dim Connect
		
	Sect						= Request("Sect")
	TableName					= LCase(Request("TableName"))
	If Sect=1 or Sect=3 or Sect=4 or Sect=5 or Sect=6 or Sect=7 or Sect=8 or Sect=9 or Sect=10 Then
	CONF_FILE_CNT				= 2
	ELse
	CONF_FILE_CNT				= 0
	End If
	CONF_FILE_DIRPATH			= server.MapPath("/")&"\FILES\"
	CONF_USEEXT					= "none"
	CONF_UPMAXSIZE				= 1024*1024*100
	CONF_USECOMMENT				= 0

	Select Case Sect
		Case 1	: bTitle	= "견적&주문상담"
		Case 2	: bTitle	= "카다로그/샘플"
		Case 3	: bTitle	= "디자인 시안"
		Case 4	: bTitle	= "로고 샘플실"
		Case 5	: bTitle	= "로고파일 보내기"
		Case 6	: bTitle	= "납품사례"
		Case 7	: bTitle	= "이용후기 앨범"
		Case 8	: bTitle	= "공지사항"
		Case 9	: bTitle	= "자주하는 질문"
		Case 10	: bTitle	= "자유게시판"
		Case 11	: bTitle	= "배송조회"
	End Select
	
	If Sect = 1 or Sect = 10 or Sect = 3 or Sect = 7 Then 
		CONF_READONLY				= 0
		CONF_USECOMMENT				= 1
		CONF_USEREPLY				= 1
	Else
		CONF_READONLY				= 0
		CONF_USECOMMENT				= 0
		CONF_USEREPLY				= 0
	End If

%>
	