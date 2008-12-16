<%
	Dim MaxSize, Dpath, Moutcolor, Movercolor, LineBg
	Dim TrBg, TbackGround, TbWidth, TableName, bTitle
'	Response.CacheControl = "no-cache" 
'	Response.AddHeader "Pragma", "no-cache" 
'	Response.Expires = -1 
'	Dim Connect
		
	Sect						= Request("Sect")
	TableName					= LCase(Request("TableName"))
	
	If Sect=1 or Sect=5 Then
	CONF_FILE_CNT				= 2
	Else
	CONF_FILE_CNT				= 0
	End If

	CONF_FILE_DIRPATH			= server.MapPath("/")&"\FILES\"
	CONF_USEEXT					= "none"
	CONF_UPMAXSIZE				= 1024*1024*100
	CONF_USECOMMENT				= 0
	
	Select Case Sect
		Case 1	: bTitle	= "공지사항": bTitleImg ="/admin/admin_img/tit_03menu.gif"'''''''''''''''''''c
		Case 2	: bTitle	= "자유게시판": bTitleImg ="/admin/admin_img/tit_04menu.gif"	'''''''''''''''''''
		Case 3	: bTitle	= "고객센터"
		Case 4	: bTitle	= "HOTNEWS"

	End Select

	If Sect=1 Then
		CONF_READONLY			= 0
		CONF_USECOMMENT			= 1
		CONF_USEREPLY			= 0
	Else
		CONF_READONLY			= 0
		CONF_USECOMMENT			= 1
		CONF_USEREPLY			= 1
	
	End If
%>
	