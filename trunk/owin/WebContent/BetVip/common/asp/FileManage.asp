<%
	Dim UploadForm
	Dim UPLOAD_COM, DEFAULT_PATH


	Function SetObjFU(comName, dirPath)
	
		UPLOAD_COM = LCase(comName)
		DEFAULT_PATH = CONF_DEFAULT_PATH

		select case UPLOAD_COM
		
			case "dextupload"
				Set UploadForm = Server.CreateObject("DEXT.FileUpload")	
				UploadForm.DefaultPath = DEFAULT_PATH
				
							
			case "sitegalaxy"
				Set UploadForm = Server.CreateObject("SiteGalaxyUpload.Form")
			
			case else
				Set UploadForm = Request			
		end select
	
	End Function
	
	
	Call SetObjFU(UPLOAD_COM, CONF_DEFAULT_PATH & TableName)	
	
					
	Function GetQuery(formName)
	
		Select Case UPLOAD_COM
		
			Case "dextupload", "abcupload4.6"
				
				GetQuery = UploadForm(formName)
						
			Case "sitegalaxy"
				GetQuery = UploadForm(formName & "")
			
			Case else
				GetQuery = UploadForm(formName)
			
		End Select
	
	End Function
	

	Function GetFile(formName)
	
		Select Case UPLOAD_COM
		
			Case "dextupload"
				GetFile = UploadForm(formName)
						
			Case "sitegalaxy"
				GetFile = UploadForm(formName & "")
			
		End Select
	
	End Function
	
	Function SaveFileRtnNames(ByVal RemotePath,_
									ByVal formName,_
									ByVal saveName,_
									ByVal FileExt,_
									ByVal MaxSize,_
									ByVal SaveFilePath,_
									ByVal oldFile,_
									ByVal UpType)
			
		If Not isNone(RemotePath) And Not isNone(formName) Then

			If Trim(FileExt) <> "none" Then
				If Not inRStr(FileExt, GetFileName(RemotePath,"ext"), ",", 1, 1) Then Call descment("File#" & GetFileName(RemotePath,"name") & "은 " & FileExt & "형식의 파일만 업로드 가능합니다","back","")
			End If

			If MaxSize < GetFileSize(formName) Then Call descment("File#" & i & "의 용량이 제한용량(" & reUnit(FileSize) & ")을 초과하였습니다.", "back","")
			If Not Server.CreateObject("Scripting.FileSystemObject").FolderExists(SaveFilePath) Then Server.CreateObject("Scripting.FileSystemObject").CreateFolder(SaveFilePath)

			If reInt(UpType,0) = 1 Then
				If Server.CreateObject("Scripting.FileSystemObject").fileExists(SaveFilePath & oldFile) then
					Call Server.CreateObject("Scripting.FileSystemObject").deleteFile(SaveFilePath & oldFile, true)
				End If
			End If
					
			Select Case UPLOAD_COM
			
				Case "dextupload"
					
					UploadForm(formName).saveAs SaveFilePath & saveName, false
					SaveFileRtnNames	=  UploadForm(formName).LastSavedFileName
					
				Case "sitegalaxy"
					UploadForm(formName & "").saveAs SaveFilePath & saveName

			End Select
				
		Else
			SaveFileRtnNames = ""
		End If
		
	End Function
	
	
	
	
	
	Function SaveFileRtnMeNames(ByVal RemotePath,_
									ByVal formName,_
									ByVal saveName,_
									ByVal FileExt,_
									ByVal MaxSize,_
									ByVal SaveFilePath,_
									ByVal oldFile,_
									ByVal UpType)
			
		If Not isNone(RemotePath) And Not isNone(formName) Then

			If Trim(FileExt) <> "none" Then
				If Not inRStr(FileExt, GetFileName(RemotePath,"ext"), ",", 1, 1) Then Call descment("File#" & GetFileName(RemotePath,"name") & "은 " & FileExt & "형식의 파일만 업로드 가능합니다","back","")
			End If

			If MaxSize < GetFileSize(formName) Then Call descment("File#" & i & "의 용량이 제한용량(" & reUnit(FileSize) & ")을 초과하였습니다.", "back","")
			If Not Server.CreateObject("Scripting.FileSystemObject").FolderExists(SaveFilePath) Then Server.CreateObject("Scripting.FileSystemObject").CreateFolder(SaveFilePath)

			If reInt(UpType,0) = 1 Then
				If Server.CreateObject("Scripting.FileSystemObject").fileExists(SaveFilePath & oldFile) then
					Call Server.CreateObject("Scripting.FileSystemObject").deleteFile(SaveFilePath & oldFile, true)
				End If
			End If
					
			Select Case UPLOAD_COM
			
				Case "dextupload"
					
					UploadForm(formName).saveAs SaveFilePath & saveName, True
					SaveFileRtnMeNames	=  UploadForm(formName).LastSavedFileName
					
				Case "sitegalaxy"
					UploadForm(formName & "").saveAs SaveFilePath & saveName

			End Select
				
		Else
			SaveFileRtnMeNames = ""
		End If
		
	End Function
	

Function SaveFileRtnMeNamesTempConv(ByVal RemotePath,_
									ByVal formName,_
									ByVal saveName,_
									ByVal FileExt,_
									ByVal MaxSize,_
									ByVal SaveFilePath,_
									ByVal oldFile,_
									ByVal UpType)
			
		If Not isNone(RemotePath) And Not isNone(formName) Then

			If Trim(FileExt) <> "none" Then
				If Not inRStr(FileExt, GetFileName(RemotePath,"ext"), ",", 1, 1) Then Call descment("File#" & GetFileName(RemotePath,"name") & "은 " & FileExt & "형식의 파일만 업로드 가능합니다","back","")
			End If

			If MaxSize < GetFileSize(formName) Then Call descment("File#" & i & "의 용량이 제한용량(" & reUnit(FileSize) & ")을 초과하였습니다.", "back","")
			If Not Server.CreateObject("Scripting.FileSystemObject").FolderExists(SaveFilePath) Then Server.CreateObject("Scripting.FileSystemObject").CreateFolder(SaveFilePath)

			If reInt(UpType,0) = 1 Then
				If Server.CreateObject("Scripting.FileSystemObject").fileExists(SaveFilePath & oldFile) then
					Call Server.CreateObject("Scripting.FileSystemObject").deleteFile(SaveFilePath & oldFile, true)
				End If
			End If
					
			Select Case UPLOAD_COM
			
				Case "dextupload"
					
'					UploadForm(formName).saveAs SaveFilePath & saveName, True
'					SaveFileRtnMeNamesTemp	=  UploadForm(formName).LastSavedFileName
'					SourceFile	=  UploadForm(formName).LastSavedFileName
'					FilePath	= SaveFilePath&SourceFile
									
					Set objImage =server.CreateObject("DEXT.ImageProc")
					If True = objImage.SetSourceFile(uploadform.TempFilePath) then
						
'						UploadForm(formName).saveAs SaveFilePath & saveName, True
'						SourceFileName	= UploadForm(formName).LastSavedFileName
'						FileName1 = GetFileName(SourceFileName,"name") &".jpg"
						
						
						SourceFileName = UploadForm(formName).FileNameWithoutExt
						FileName1 = GetFileName(saveName,"name") &".jpg"
						ConverImg = objImage.ConvertImageFormat("image/bmp",SaveFilePath & FileName1 ,false)
'						ConverImg = objImage.ConvertImageFormat("image/jpg",SF ,true)
						
'						Response.End
'						WrFilePath = SaveFilePath&GetFileName(SourceFile, "name") &"_WR."&GetFileName(SourceFile, "ext")
						WIFilePath = SaveFilePath&GetFileName(ConverImg, "name") &"_WI."&GetFileName(ConverImg, "ext")
				
						WISaveName = objImage.SaveAsWatermarkImage("/FILES/Wr.gif",WIFilePath,-8,-5,false)
						'SaveFileRtnMeNamesTemp = objImage.SaveAsWatermarkText("부동산 베이",WrFilePath,70,100,50,false)
						SaveFileRtnMeNamesTemp = GetFileName(ConverImg, "name")&"."&GetFileName(ConverImg, "ext")
						
					End If					
					
				Case "sitegalaxy"
					UploadForm(formName & "").saveAs SaveFilePath & saveName

			End Select
				
		Else
			SaveFileRtnMeNamesTemp = ""
		End If
		
	End Function
	
	
	
	
	
	
		
	Function SaveFileRtnMeNamesTemp(ByVal RemotePath,_
									ByVal formName,_
									ByVal saveName,_
									ByVal FileExt,_
									ByVal MaxSize,_
									ByVal SaveFilePath,_
									ByVal oldFile,_
									ByVal UpType)
			
		If Not isNone(RemotePath) And Not isNone(formName) Then

			If Trim(FileExt) <> "none" Then
				If Not inRStr(FileExt, GetFileName(RemotePath,"ext"), ",", 1, 1) Then Call descment("File#" & GetFileName(RemotePath,"name") & "은 " & FileExt & "형식의 파일만 업로드 가능합니다","back","")
			End If

			If MaxSize < GetFileSize(formName) Then Call descment("File#" & i & "의 용량이 제한용량(" & reUnit(FileSize) & ")을 초과하였습니다.", "back","")
			If Not Server.CreateObject("Scripting.FileSystemObject").FolderExists(SaveFilePath) Then Server.CreateObject("Scripting.FileSystemObject").CreateFolder(SaveFilePath)

			If reInt(UpType,0) = 1 Then
				If Server.CreateObject("Scripting.FileSystemObject").fileExists(SaveFilePath & oldFile) then
					Call Server.CreateObject("Scripting.FileSystemObject").deleteFile(SaveFilePath & oldFile, true)
				End If
			End If
					
			Select Case UPLOAD_COM
			
				Case "dextupload"
					
					UploadForm(formName).saveAs SaveFilePath & saveName, True
					SourceFile		= UploadForm(formName).LastSavedFileName
					FilePath		= SaveFilePath&SourceFile
				
					Set objImage =server.CreateObject("DEXT.ImageProc")
					If true = objImage.SetSourceFile(FilePath) Then
						
											
						WrFilePath = SaveFilePath & GetFileName(SourceFile, "name") &"_WR."&GetFileName(SourceFile, "ext")
						WIFilePath = SaveFilePath & GetFileName(SourceFile, "name") &"_WI.jpg"
						     
						SourceFileName = UploadForm(formName).FileNameWithoutExt
'						WISaveName = objImage.SaveAsWatermarkImage("/FILES/Wr2.bmp",WIFilePath,-150,-190,false)
						Tmp = objImage.SaveAsWatermarkText("부동산 베이 부동산 베이 부동산 베이 부동산 베이부동산 베이부동산 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이 베이부동산 베이",WrFilePath,5,-50,200,false)
						SaveFileRtnMeNamesTemp = GetFileName(Tmp,"name")&"."&GetFileName(Tmp,"ext")
						'SaveFileRtnMeNamesTemp = GetFileName(WISaveName, "name")&"."&GetFileName(WISaveName, "ext")
'						SaveFileRtnMeNamesTemp =  GetFileName(WISaveName, "name")&"."&GetFileName(WISaveName, "ext")
						
					End If					
					
				Case "sitegalaxy"
					UploadForm(formName & "").saveAs SaveFilePath & saveName

			End Select
				
		Else
			SaveFileRtnMeNamesTemp = ""
		End If
		
	End Function
	
	
	Function SaveFilesbln(ByVal RemotePath, ByRef blnEOF )
			
		If Server.CreateObject("Scripting.FileSystemObject").FileExists(RemotePath) then
			blnEOF = True
		Else
			blnEOF = False
		End If
		
	End Function
		

	Function GetFileShortName(formName)
		
		Dim fileName
		
		select case UPLOAD_COM
		
			case "dextupload"
				fileName = UploadForm(formName)
				
			case "sitegalaxy"
				fileName = UploadForm(formName & "")
			
		end select
		
		GetFileShortName = GetFileName(fileName, "all")
		
	End Function
	
	
	Function GetFileName(formName, infoType)
		Dim fileName
		fileName = mid(formName, instrRev(formName, "\") + 1)
		
		If infoType = "name" Then
			If inStrRev(fileName, ".") = 0 Then
				GetFileName = fileName
			Else
				GetFileName = mid(fileName, 1, inStrRev(fileName, ".") - 1)
			End If
			
		ElseIf infoType = "ext" Then
			If inStrRev(fileName, ".") = 0 Then
				GetFileName = ""
			Else
				GetFileName = mid(fileName, inStrRev(fileName, ".") + 1)
			End If
			
		Else
			GetFileName = fileName
		End If	
	End Function
	
	
	
	Function GetFileSize(formName)
		
		Select Case UPLOAD_COM
		
			Case "dextupload"
				GetFileSize = UploadForm(formName).fileLen
			
			Case "sitegalaxy"
				GetFileSize = UploadForm(formName & "").size
			
			Case else
				GetFileSize = -1
			
		End Select
		
	End Function
	
		
		
	Function GetFileType(formName)
		Dim fileExt, fileMime
		
		fileExt = LCase(GetFileName(formName, "ext"))		
		Select Case fileExt
		
			'이미지
			Case "bmp", "dib", "rle":
				fileMime = "bmp"
			Case "gif":
				fileMime = "gif"
			Case "ico":
				fileMime = "x-icon"
			Case "jpg", "jpeg", "jpe":
				fileMime = "jpeg"
			Case "jfif":
				fileMime = "pjpeg"
			Case "pcx":
				fileMime = "pcx"
			Case "png":
				fileMime = "png"
			Case "tif", "tiff":
				fileMime = "tiff"
			Case "xbm":
				fileMime = "x-xbitmap"
			
			'미디어
			Case "au", "snd":
				fileMime = "audio/basic"
			Case "asf", "asx":
				fileMime = "video/x-ms-asf"
			Case "avi":
				fileMime = "video/x-msvideo"
			Case "m3u":
				fileMime = "audio/mpegurl"
			Case "mid", "midi":
				fileMime = "audio/mid"
			Case "mov":
				fileMime = "video/x-msvideo"
			Case "mp2", "mp2v", "mpa", "mpe", "mpeg", "mpg", "mpv2":
				fileMime = "video/mpeg"
			Case "mp3":
				fileMime = "audio/mpeg"
			Case "wav":
				fileMime = "audio/wav"
			Case "wax":
				fileMime = "audio/x-ms-wax"
			Case "wm":
				fileMime = "video/x-ms-wm"
			Case "wma":
				fileMime = "audio/x-ms-wma"
			Case "wmp":
				fileMime = "video/x-ms-wmp"
			Case "wmv":
				fileMime = "video/x-ms-wmv"
			Case "wmx", "wvx":
				fileMime = "video/x-ms-wvx"
			Case "swf":
				fileMime = "application/x-shockwave-flash"
			
			Case Else
				fileMime = "application/unknown"
		End Select		
		GetFileType = fileMime
	End Function
							
	
%>