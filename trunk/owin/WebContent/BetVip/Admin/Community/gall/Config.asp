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
		Case 1	: bTitle	= "����&�ֹ����"
		Case 2	: bTitle	= "ī�ٷα�/����"
		Case 3	: bTitle	= "������ �þ�"
		Case 4	: bTitle	= "�ΰ� ���ý�"
		Case 5	: bTitle	= "�ΰ����� ������"
		Case 6	: bTitle	= "��ǰ���"
		Case 7	: bTitle	= "�̿��ı� �ٹ�"
		Case 8	: bTitle	= "��������"
		Case 9	: bTitle	= "�����ϴ� ����"
		Case 10	: bTitle	= "�����Խ���"
		Case 11	: bTitle	= "�����ȸ"
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
	