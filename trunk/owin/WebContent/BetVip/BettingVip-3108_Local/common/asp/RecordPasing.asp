<script runat=server language=vbscript> 

Class RecordPaging

	
	Function RecordPaging(	byRef rs, _
							byVal intPageSize, _
							byVal intListSize, _
							byRef intGoPage, _
							byRef intCurrentPage, _
							byRef intCurrentBlock, _
							byRef intTotalPageCount, _
							byRef intTotalBlockCount, _
							byRef intTotalRecordCount, _
							byRef intRecords )
		
		rs.PageSize=intPageSize					
		intTotalPageCount = rs.PageCount		
		intTotalRecordCount = rs.RecordCount	

		IF (intTotalPageCount Mod intListSize) = 0 Then
			intTotalBlockCount = intTotalPageCount / intListSize 
		Else
			intTotalBlockCount = Int(intTotalPageCount / intListSize) + 1
		End IF
		
		If intCurrentPage <> "" Then
			intCurrentPage = Cint(intCurrentPage)
		Else 
			intCurrentPage = 1
		End IF

		intCurrentBlock = Int((intCurrentPage - 1) / intListSize) + 1 

		IF intGoPage <> "" Then 
			IF intGoPage = "PP" Then
				intCurrentBlock = intCurrentBlock - 1
				If intCurrentBlock <= 1 Then
					intCurrentBlock = 1
				End IF
				
				intCurrentPage = intCurrentPage - intListSize
				
				IF intCurrentPage <= 1 Then 
					intCurrentPage = 1
				End IF
				
			ElseIF intGoPage = "NN" Then 
				intCurrentBlock = intCurrentBlock + 1
				If intCurrentBlock >= intTotalBlockCount Then
					intCurrentBlock = intTotalBlockCount
				End IF
				intCurrentPage = intCurrentPage + intListSize
				
				IF intCurrentPage >= intTotalPageCount Then 
					intCurrentPage = intTotalPageCount
				End IF
				
			ElseIF intGoPage = "P" Then 
				intCurrentPage = intCurrentPage - 1
				If intCurrentPage <= 1 then
					intCurrentPage = 1
				End IF
				intCurrentBlock = Int((intCurrentPage - 1)/intListSize) + 1	
			ElseIF intGoPage = "N" Then 
				intCurrentPage = intCurrentPage + 1
				If intCurrentPage >= intTotalPageCount Then
					intCurrentPage = intTotalPageCount
				End IF
				intCurrentBlock = Int((intCurrentPage - 1)/intListSize) + 1	
			Else
				intCurrentPage = cint(intGoPage)
				intCurrentBlock = Int((intCurrentPage - 1)/intListSize) + 1	
			End IF
		Else
			intCurrentPage = 1
		End IF
		

		rs.AbsolutePage = intCurrentPage 
		
		RecordPaging = rs.GetRows(intPageSize, adBookmarkCurrent) 
		
		If (intCurrentPage < intTotalPageCount) Or (rs.RecordCount Mod intPageSize = 0) Then 
			intRecords = intPageSize 
		Else 
			intRecords = rs.RecordCount Mod intPageSize 
		End If 
		
	End Function
	
End Class



    Function getPrintPaging(pageSize, pageNo, rsCount)
        Dim result, pageCount, startPage, endPage, loopPage
		pageNo = Clng(pageNo)
        pageSize = Clng(pageSize)
        rsCount = Clng(rsCount)
        pageCount = ((rsCount - 1) \ pageSize) + 1
        startPage = blockSize * ((pageNo - 1) \ blockSize) + 1
        endPage = startPage + blockSize - 1
        loopPage = startPage

        If pageCount <= endPage Then
			endPage = pageCount
        End If
			result = "<table border=0><tr>"
			result = result &"<td align=""right"" height=""30"">" & vbCrLf

        If pageNo = 1 Then
            result = result &"<font color=""#999999"" class=""txt01"">[처음]</font>&nbsp;" & vbCrLf
        Else
            result = result &"<a href=""javascript:ListPageGo(1);""><font color=""#a1c1ee"" class=""txt01"">[처음]</font></a>&nbsp;" & vbCrLf
        End If

		If startPage > 1 Then
            result = result &"<a href=""javascript:ListPageGo(" & startPage - blockSize & ");""><font color=""#a1c1ee"" class=""txt01"">[이전]</font></a>&nbsp;" & vbCrLf
        Else
            result = result &"<font color=""#999999"" class=""txt01"">[이전]</font>&nbsp;" & vbCrLf
        End If

        Do While loopPage <= endPage
            If loopPage = pageNo Then
                result = result & "&nbsp;<b><font color=""#CC3300"" class=""num3"">[" & loopPage & "]</font></b>&nbsp;" & vbCrLf
            Else
                result = result & "&nbsp;<a href=""javascript:ListPageGo(" & loopPage & ");""><b><font class=""num3"">" & loopPage & "</font></b></a>&nbsp;" & vbCrLf
            End If
            loopPage = loopPage + 1
        Loop

        If endPage >= pageCount Then
            result = result & "&nbsp;<font color=""#999999"" class=""txt01"">[다음]</font>&nbsp;" & vbCrLf
        Else
            result = result & "<a href=""javascript:ListPageGo(" & startPage + blockSize & ");""><font color=""#a1c1ee"" class=""txt01"">[다음]</font></a>" & vbCrLf
        End If

        If pageNo = pageCount Then
            result = result & "<font color=""#999999"" class=""txt01"">[끝]</font>" & vbCrLf
        Else
            result = result & "<a href=""javascript:ListPageGo(" & pageCount & ");""><font color=""#a1c1ee"" class=""txt01"">[끝]</font></a>" & vbCrLf
        End If

        result = result & "</td>" & vbCrLf
		result = result &"</tr></table >"
        getPrintPaging = result
    End Function
    

    Function getPrintPagingProduct(pageSize, pageNo, rsCount)
        Dim result, pageCount, startPage, endPage, loopPage

        pageNo = Clng(pageNo)
        pageSize = Clng(pageSize)
        rsCount = Clng(rsCount)
        pageCount = ((rsCount - 1) \ pageSize) + 1
        startPage = blockSize * ((pageNo - 1) \ blockSize) + 1
        endPage = startPage + blockSize - 1
        loopPage = startPage

        If pageCount <= endPage Then
            endPage = pageCount
        End If
			result = "<table cellspacing= cellpadding=0 border=0 class=p_table>"
			result = result &"<tr align=center><td>"

		If pageNo = 1 Then
'			result = result & "<span class=""style1"">◀ </span>&nbsp;" & vbCrLf
		Else
'			result = result & "<a href=""javascript:ListPageGo(1);""><span class=""style1"">◀ </span></a>&nbsp;" & vbCrLf
		End If

		If startPage > 1 Then
			result = result & "<a href=""javascript:ListPageGo(" & startPage - blockSize & ");""><img src=""/images/icon_arr3.gif "" align=absmiddle ></a>| "
		Else
			result = result & "<img src=""/images/icon_arr3.gif"" align=absmiddle >| "
		End If

        Do While loopPage <= endPage
            If loopPage = pageNo Then
				result = result & "<font color=C61415><b>" & loopPage & "</font></b>&nbsp;|"
            Else
				result = result & "&nbsp;<a href=""javascript:ListPageGo(" & loopPage & ");"">"& loopPage & "</a>&nbsp;|"
            End If
            loopPage = loopPage + 1
        Loop

		If endPage >= pageCount Then
			result = result & "<img src=""/images/icon_arr4.gif"" align=absmiddle>" & vbCrLf
		Else
			result = result & "<a href=""javascript:ListPageGo(" & startPage + blockSize & ");""><img src=""/images/icon_arr4.gif"" align=absmiddle></a>&nbsp;" & vbCrLf
		End If

		If pageNo = pageCount Then
'			result = result & "<span class=""style1"">▶</span>" & vbCrLf
		Else
'			result = result & "<a href=""javascript:ListPageGo(" & pageCount & ");""><span class=""style1"">▶</span></a>" & vbCrLf
		End If

		result = result & "</td>" & vbCrLf
		result = result &"</tr></table >"
        getPrintPagingProduct = result
    End Function	
    
	
	
	 Function getPrintPagingProductCmt(pageSize, pageNo, rsCount)
        Dim result, pageCount, startPage, endPage, loopPage

        pageNo = Clng(pageNo)
        pageSize = Clng(pageSize)
        rsCount = Clng(rsCount)
        pageCount = ((rsCount - 1) \ pageSize) + 1
        startPage = blockSize * ((pageNo - 1) \ blockSize) + 1
        endPage = startPage + blockSize - 1
        loopPage = startPage

        If pageCount <= endPage Then
            endPage = pageCount
        End If
			result = "<table cellspacing= cellpadding=0 border=0 class=p_table>"
			result = result &"<tr align=center><td>"

		If pageNo = 1 Then
			result = result & "<span class=""style1""><img src='/images/review13.gif' ></span>&nbsp;" & vbCrLf
		Else
			result = result & "<a href=""javascript:ListPageGo(1);""><span class=""style1""><img src='/images/review13.gif' ></span></a>&nbsp;" & vbCrLf
		End If

		If startPage > 1 Then
			result = result & "<a href=""javascript:ListPageGo(" & startPage - blockSize & ");""><img src=""/images/review14.gif"" width=""14"" height=""11""></a>&nbsp;"
		Else
			result = result & "<img src=""/images/review14.gif"" width=""14"" height=""11"">&nbsp;"
		End If

        Do While loopPage <= endPage
            If loopPage = pageNo Then
				result = result & "&nbsp;<span class=""style2""><b>" & loopPage & "</span>&nbsp;" & vbCrLf
            Else
				result = result & "&nbsp;<a href=""javascript:ListPageGo(" & loopPage & ");"">"& loopPage & "</a>&nbsp;" & vbCrLf
            End If
            loopPage = loopPage + 1
        Loop

		If endPage >= pageCount Then
			result = result & "<img src='/images/review15.gif' >" & vbCrLf
		Else
			result = result & "&nbsp;<a href=""javascript:ListPageGo(" & startPage + blockSize & ");""><img src='/images/review15.gif' ></a>&nbsp;" & vbCrLf
		End If

		If pageNo = pageCount Then
			result = result & "<span class=""style1""><img src='/images/review16.gif' ></span>" & vbCrLf
		Else
			result = result & "<a href=""javascript:ListPageGo(" & pageCount & ");""><span class=""style1""><img src='/images/review16.gif' ></span></a>" & vbCrLf
		End If

		result = result & "</td>" & vbCrLf
		result = result &"</tr></table >"
        getPrintPagingProductCmt = result
    End Function
    
    
    
    Function getPrintPagingBoard(pageSize, pageNo, rsCount)
        Dim result, pageCount, startPage, endPage, loopPage

        pageNo = Clng(pageNo)
        pageSize = Clng(pageSize)
        rsCount = Clng(rsCount)
        pageCount = ((rsCount - 1) \ pageSize) + 1
        startPage = blockSize * ((pageNo - 1) \ blockSize) + 1
        endPage = startPage + blockSize - 1
        loopPage = startPage

        If pageCount <= endPage Then
            endPage = pageCount
        End If
			result = "<table cellspacing= cellpadding=0 border=0 class=p_table>"
			result = result &"<tr align=center><td>"

		If pageNo = 1 Then
'			result = result & "<span class=""style1""><img src=/images/btn_board_first.gif border=0 align=absmiddle></span>&nbsp;" & vbCrLf
		Else
'			result = result & "<a href=""javascript:ListPageGo(1);""><span class=""style1""><img src=/images/btn_board_first.gif border=0 align=absmiddle></span></a>&nbsp;" & vbCrLf
		End If

		If startPage > 1 Then
			result = result & "<a href=""javascript:ListPageGo(" & startPage - blockSize & ");""><font color=C6C7C6><b>[이전 10개] "
		Else
			result = result & "<font color=C6C7C6><b>[이전 10개] "
		End If

        Do While loopPage <= endPage
            If loopPage = pageNo Then
				result = result & "&nbsp;<font color=C6C7C6><b>" & loopPage & "</font></b>&nbsp;|"
            Else
				result = result & "&nbsp;<a href=""javascript:ListPageGo(" & loopPage & ");""><font color=666666>"& loopPage & "</a>&nbsp;|"
            End If
            loopPage = loopPage + 1
        Loop

		If endPage >= pageCount Then
			result = result & "&nbsp;<font color=C6C7C6><b>[다음 10개]&nbsp;" & vbCrLf
		Else
			result = result & "&nbsp;<a href=""javascript:ListPageGo(" & startPage + blockSize & ");""><font color=C6C7C6><b>[다음 10개]</a>" & vbCrLf
		End If

		If pageNo = pageCount Then
'			result = result & "<span class=""style1""><img src=/images/btn_board_end.gif border=0 align=absmiddle></span>" & vbCrLf
		Else
'			result = result & "<a href=""javascript:ListPageGo(" & pageCount & ");""><span class=""style1""><img src=/images/btn_board_end.gif border=0 align=absmiddle></span></a>" & vbCrLf
		End If

		result = result & "</td>" & vbCrLf
		result = result &"</tr></table >"
        getPrintPagingBoard = result
    End Function
    
    
    
     Function getPrintPagingBoard2(pageSize, pageNo, rsCount)
        Dim result, pageCount, startPage, endPage, loopPage

        pageNo = Clng(pageNo)
        pageSize = Clng(pageSize)
        rsCount = Clng(rsCount)
        pageCount = ((rsCount - 1) \ pageSize) + 1
        startPage = blockSize * ((pageNo - 1) \ blockSize) + 1
        endPage = startPage + blockSize - 1
        loopPage = startPage

        If pageCount <= endPage Then
            endPage = pageCount
        End If
			result = "<table cellspacing= cellpadding=0 border=0 class=p_table>"
			result = result &"<tr align=center><td>"

		If pageNo = 1 Then
'			result = result & "<span class=""style1""><img src=/images/btn_board_first.gif border=0 align=absmiddle></span>&nbsp;" & vbCrLf
		Else
'			result = result & "<a href=""javascript:ListPageGo(1);""><span class=""style1""><img src=/images/btn_board_first.gif border=0 align=absmiddle></span></a>&nbsp;" & vbCrLf
		End If

		If startPage > 1 Then
			result = result & "<a href=""javascript:ListPageGo(" & startPage - blockSize & ");""><img src=img/prev.gif border=0 align=absmiddle></a>&nbsp;" & vbCrLf
		Else
			result = result & "<img src=img/prev.gif border=0 align=absmiddle>&nbsp;" & vbCrLf
		End If

        Do While loopPage <= endPage
            If loopPage = pageNo Then
				result = result & "&nbsp;<span class=txt02><font color='#A79ACC'><b>[" & loopPage & "]</span>&nbsp;" & vbCrLf
            Else
				result = result & "&nbsp;<a href=""javascript:ListPageGo(" & loopPage & ");""><span class=txt02>["& loopPage & "]</a>&nbsp;" & vbCrLf
            End If
            loopPage = loopPage + 1
        Loop

		If endPage >= pageCount Then
			result = result & "&nbsp;<img src=img/next.gif border=0 align=absmiddle>&nbsp;" & vbCrLf
		Else
			result = result & "&nbsp;<a href=""javascript:ListPageGo(" & startPage + blockSize & ");""><img src=img/next.gif border=0 align=absmiddle></a>&nbsp;" & vbCrLf
		End If

		If pageNo = pageCount Then
'			result = result & "<span class=""style1""><img src=/images/btn_board_end.gif border=0 align=absmiddle></span>" & vbCrLf
		Else
'			result = result & "<a href=""javascript:ListPageGo(" & pageCount & ");""><span class=""style1""><img src=/images/btn_board_end.gif border=0 align=absmiddle></span></a>" & vbCrLf
		End If

		result = result & "</td>" & vbCrLf
		result = result &"</tr></table >"
        getPrintPagingBoard2 = result
    End Function
</script>