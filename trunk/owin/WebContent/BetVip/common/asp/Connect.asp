
<script runat=server language=vbscript> 

	Function strConnect()
'		strConnect = "Provider=SQLOLEDB.1;User ID=betting;Password=betting;Persist Security Info=False;Initial Catalog=bettingVip;Data Source=.;"
		strConnect = "Provider=SQLOLEDB.1;User ID=bet888;Password=okbet88$%;Persist Security Info=False;Initial Catalog=BetVip;Data Source=.;"
	End Function 
	
	Function strConnectKor()
'		strConnect = "Provider=SQLOLEDB.1;User ID=betting;Password=betting;Persist Security Info=False;Initial Catalog=betting;Data Source=.;"
'		strConnectKor = "Provider=SQLOLEDB.1;User ID=bet888;Password=okbet88$%;Persist Security Info=False;Initial Catalog=Betting;Data Source=59.188.29.167,1438;"
		strConnectKor = "Provider=SQLOLEDB.1;User ID=bet888;Password=okbet88$%;Persist Security Info=False;Initial Catalog=BettingKOR;Data Source=64.34.111.122,1438;"
	End Function

	Public Function RunSQLReturnRS(ByVal strSQL)

		Dim rs, cmd
		Set rs = Server.CreateObject("adodb.Recordset")
		Set cmd = Server.CreateObject("adodb.Command")
		' SQL 실행
		cmd.ActiveConnection = strConnect()
		cmd.CommandText = strSQL
		cmd.CommandType = adCmdText
		cmd.Prepared = true
		
		rs.CursorLocation = adUseClient 
		rs.Open cmd, , adOpenForwardOnly, adLockReadOnly
		Set RunSQLReturnRS = rs

		Set cmd.ActiveConnection = Nothing 
		Set cmd = Nothing 
		Set rs.ActiveConnection = Nothing
	End Function
	
	Public Function RunSQLReturnRSKor(ByVal strSQL)

		Dim rs, cmd
		Set rs = Server.CreateObject("adodb.Recordset")
		Set cmd = Server.CreateObject("adodb.Command")
		' SQL 실행
		cmd.ActiveConnection = strConnectKor()
		cmd.CommandText = strSQL
		cmd.CommandType = adCmdText
		cmd.Prepared = true
		
		rs.CursorLocation = adUseClient 
		rs.Open cmd, , adOpenForwardOnly, adLockReadOnly
		Set RunSQLReturnRSKor = rs

		Set cmd.ActiveConnection = Nothing 
		Set cmd = Nothing 
		Set rs.ActiveConnection = Nothing
	End Function
	
	
	Public Function RunSQL(ByVal strSQL) 

		Dim cmd
		Set cmd = Server.CreateObject("adodb.Command") 

		cmd.ActiveConnection = strConnect() 
		cmd.CommandText = strSQL 
		cmd.CommandType = adCmdText 
		
		cmd.Execute , , adExecuteNoRecords 

		Set cmd.ActiveConnection = Nothing 
		Set cmd = Nothing 
		RunSQL = 0
	End Function 
	
	Public Function RunSQLKor(ByVal strSQL) 

		Dim cmd
		Set cmd = Server.CreateObject("adodb.Command") 

		cmd.ActiveConnection = strConnectKor() 
		cmd.CommandText = strSQL 
		cmd.CommandType = adCmdText 
		
		cmd.Execute , , adExecuteNoRecords 

		Set cmd.ActiveConnection = Nothing 
		Set cmd = Nothing 
		RunSQLKor = 0
	End Function 

	Private Sub CloseDB() 
	
		If isobject(objAdo) Then  Set objAdo = Nothing
		
		If isobject(objRs) Then 
'			objRs.Close
			Set objRs = Nothing
		End If

		If isobject(objPag) Then Set objPag = Nothing

	End Sub	
	
	
	
	Const blockSize = 10

    Dim gSeq, rsCount, g_pageCount
    Dim g_sql, g_objRs, objCon

    Set g_objRs = Nothing
    Set objCon = Nothing

    Dim pageno, searchkeytype, searchkeyfield, searchkeyword

    Function getConnection()
        Dim conn

        Set conn = Server.CreateObject("ADODB.Connection")
        conn.Open strConnect()

        Set getConnection = conn
    End Function


    Function getRecordSet(conn, sql)
        Dim rs

        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.CursorLocation = adUseClient
        rs.Open sql, conn, adOpenStatic
        Set getRecordSet = rs
    End Function

    Function closeResource(obj)
        If Not obj Is Nothing Then
            If obj.State = 1 Then
                obj.Close
                Set obj = Nothing
            End If
        End If
    End Function


    Function getRow(pageSize, pageNo)
        Dim result

        result = ((pageNo - 1) * pageSize) + 1

        getRow = result
    End Function


    Function getReverseRow(pageSize, pageNo, rsCount)
        Dim result

        result = rsCount - ((pageNo - 1) * pageSize)

        getReverseRow = result
    End Function


    Function getPageSize(pageSize, rsCount)
        Dim result

        result = ((rsCount - 1) \ pageSize) + 1

        getPageSize = result
    End Function	
</script>
