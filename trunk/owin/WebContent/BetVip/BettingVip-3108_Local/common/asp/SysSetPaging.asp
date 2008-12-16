		<table width="100%" align="center">
			<tr align="center" >
				<td >
				<!-- 첫페이지로 시작 -->
				<%If CurPage <> 1 Then%>
				<a href="javascript:ListPageGo('1');"> <b><span class=num3>[처음]</span></b> </a>
				<%End IF%>
				<!-- 첫페이지로 끝 -->

				<!-- 이전 목록 10개 -->
				<%If CurBlock <> 1 Then%>
				<a href="javascript:ListPageGo('PP'); "> <b><span class=num3>[이전 <%=intListSize%>]</span></b></a>&nbsp;
				<%End If%>
				
				<!-- 페이지 번호 리스트 각 10개씩 시작-->
				<%For intCount = 1 To intListSize%>
					<%If CurPage = ((CurBlock - 1) * intListSize + intCount) Then%>
						 <b>[<%=(CurBlock-1)*intListSize + intCount%>]</b>
					<%Else%>
						 <a href="javascript:ListPageGo('<%=(CurBlock-1)*intListSize + intCount%>'); " class="num3">
						<%=(CurBlock-1)*intListSize + intCount%></a>
					<%End IF%>
					
					<% If ((CurBlock-1)*intListSize + intCount) = intTotalPageCount Then%>
						<% Exit For%>
					<% End IF%>
				<%Next%>
				<!-- 다음 목록 10개 -->
				&nbsp;
				<%If CurBlock <> intTotalBlockCount Then%>
				<a href="javascript:ListPageGo('NN'); "> <b><span class=num3>[다음 <%=intListSize%>]</b></a>
				<%End IF%>
				
				<!-- 이전 페이지 -->
				<%IF CurPage <> intTotalPageCount Then%>
				<a href="javascript:ListPageGo('<%=intTotalPageCount%>'); "> <b><span class=num3>[끝]</a>
				<%End IF%>
				
				</td>
			</tr>
		</table>