		<table width="100%" align="center">
			<tr align="center" >
				<td >
				<!-- ù�������� ���� -->
				<%If CurPage <> 1 Then%>
				<a href="javascript:ListPageGo('1');"> <b><span class=num3>[ó��]</span></b> </a>
				<%End IF%>
				<!-- ù�������� �� -->

				<!-- ���� ��� 10�� -->
				<%If CurBlock <> 1 Then%>
				<a href="javascript:ListPageGo('PP'); "> <b><span class=num3>[���� <%=intListSize%>]</span></b></a>&nbsp;
				<%End If%>
				
				<!-- ������ ��ȣ ����Ʈ �� 10���� ����-->
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
				<!-- ���� ��� 10�� -->
				&nbsp;
				<%If CurBlock <> intTotalBlockCount Then%>
				<a href="javascript:ListPageGo('NN'); "> <b><span class=num3>[���� <%=intListSize%>]</b></a>
				<%End IF%>
				
				<!-- ���� ������ -->
				<%IF CurPage <> intTotalPageCount Then%>
				<a href="javascript:ListPageGo('<%=intTotalPageCount%>'); "> <b><span class=num3>[��]</a>
				<%End IF%>
				
				</td>
			</tr>
		</table>