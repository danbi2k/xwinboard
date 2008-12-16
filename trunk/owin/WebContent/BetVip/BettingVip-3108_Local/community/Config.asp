<%
	Dim MaxSize, Dpath, Moutcolor, Movercolor, LineBg
	Dim TrBg, TbackGround, TbWidth, TableName, bTitle
'	Response.CacheControl = "no-cache" 
'	Response.AddHeader "Pragma", "no-cache" 
'	Response.Expires = -1 
'	Dim Connect
	
	Sect						= reInt(Request("Sect"),0)
	TableName					= LCase(Request("TableName"))
	
	CONF_FILE_CNT				= 0
	CONF_FILE_DIRPATH			= server.MapPath("/")&"\FILES\"
	CONF_USEEXT					= "none"
	CONF_UPMAXSIZE				= 1024*1024*100
	
	Select Case Sect
		Case 1	: bTitle	= "공지사항"	: bTitleImg	= "title_notice.gif"	: bbgImg = "coti_sub01.gif"
		Case 2	: bTitle	= "자유게시판"		: bTitleImg	= "title_free.gif"	: bbgImg = "coti_sub02.gif"
		Case 3	: bTitle	= "고객센터"		: bTitleImg	= "title_cus.gif"	: bbgImg = "coti_sub03.gif"
	End Select
	If Sect = 1 Then
		CONF_READONLY				= 1
		CONF_USECOMMENT				= 1
		CONF_USEREPLY				= 0
	ElseIf Sect = 3 Then
		CONF_READONLY				= 0
		CONF_USECOMMENT				= 1
		CONF_USEREPLY				= 0
	Else
		CONF_READONLY				= 0
		CONF_USECOMMENT				= 1
		CONF_USEREPLY				= 1
	End If
%>

	