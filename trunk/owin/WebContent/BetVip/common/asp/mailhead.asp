<%
Const cdoSendUsingMethod = "http://schemas.microsoft.com/cdo/configuration/sendusing" 
Const cdoSendUsingPort = 2 
Const cdoSMTPServer = "http://schemas.microsoft.com/cdo/configuration/smtpserver" 
Const cdoSMTPServerPort = "http://schemas.microsoft.com/cdo/configuration/smtpserverport" 
Const cdoSMTPConnectionTimeout = "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout" 
Const cdoSMTPAccountName = "http://schemas.microsoft.com/cdo/configuration/smtpaccountname" 
Const cdoSMTPAuthenticate = "http://schemas.microsoft.com/cdo/configuration/smtpauthenticate" 
Const cdoBasic = 1 
Const cdoSendUserName = "http://schemas.microsoft.com/cdo/configuration/sendusername" 
Const cdoSendPassword = "http://schemas.microsoft.com/cdo/configuration/sendpassword" 

Dim objConfig ' As CDO.Configuration 
Dim objMessage ' As CDO.Message 
Dim Fields ' As ADODB.Fields 

' Get a handle on the config object and it's fields 
Set objConfig = Server.CreateObject("CDO.Configuration") 
Set Fields = objConfig.Fields 

' Set config fields we care about 
With Fields 
.Item(cdoSendUsingMethod) = cdoSendUsingPort 
.Item(cdoSMTPServer) = "mw-001.cafe24.com" 
.Item(cdoSMTPServerPort) = 25 
.Item(cdoSMTPAuthenticate) = cdoBasic 
.Item(cdoSendUserName) = "master@puzzlemall.net" 
.Item(cdoSendPassword) = "1111" 

.Update 
End With 
%>