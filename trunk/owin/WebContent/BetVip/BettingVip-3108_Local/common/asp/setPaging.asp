		<table border=0 width="100%" align="center">
			<tr align="center" class="c3">
				<td>
				<!-- 첫페이지로 시작 -->
				<%If CurPage <> 1 Then%>
				<!--<a onFocus="this.blur();" href="javascript:ListPageGo('1');"><img src=/images/butten_013.gif align=absmiddle></a>-->
				<%End IF%>
				
				<!-- 첫페이지로 끝 -->

				<!-- 이전 목록 10개 -->
				<%If CurBlock <> 1 Then%>
				&nbsp;<a onFocus="this.blur();" href="javascript:ListPageGo('PP'); "><img src=/avata/images/prew.jpg align=absmiddle></a>&nbsp;
				<%End If%>
				&nbsp;
				
				<!-- 페이지 번호 리스트 각 10개씩 시작-->
				<%For intCount = 1 To intListSize%>
					<%If CurPage = ((CurBlock - 1) * intListSize + intCount) Then%>
						 <span style="font-size:9pt;"><b>[<%=(CurBlock-1)*intListSize + intCount%>]</b>
					<%Else%>
						 <a onFocus="this.blur();" href="javascript:ListPageGo('<%=(CurBlock-1)*intListSize + intCount%>'); " class="num">
						<%=(CurBlock-1)*intListSize + intCount%></a>
					<%End IF%>
					
					<% If ((CurBlock-1)*intListSize + intCount) = intTotalPageCount Then%>
						<% Exit For%>
					<% End IF%>
				<%Next%>
				<!-- 다음 목록 10개 -->
				&nbsp;
				<%If CurBlock <> intTotalBlockCount Then%>
				&nbsp;<a onFocus="this.blur();" href="javascript:ListPageGo('NN'); "><img src=//avata/images/next.jpg align=absmiddle></a>&nbsp;
				<%End IF%>
				
				<!-- 이전 페이지 -->
				<%IF CurPage <> intTotalPageCount Then%>
				<!--&nbsp;<a onFocus="this.blur();" href="javascript:ListPageGo('<%=intTotalPageCount%>'); "><img src=/images/butten_016.gif align=absmiddle></a>-->
				<%End IF%>
				</td>
			</tr>
		</table>