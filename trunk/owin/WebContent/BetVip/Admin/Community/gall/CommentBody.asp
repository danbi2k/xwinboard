<tr><td height="10" ></td></tr>
<script language='javascript'>
function gWriteCmt() {									
	var frms = document.cofrm
	if(strSpace(frms.cname.value)=='') {
		alert('�ۼ��ڸ� �Է��� �ּ���');
		frms.cname.focus();
		return ;

	} else if (strSpace(frms.pwd.value)=='') {
		alert('��й�ȣ�� �Է��� �ּ���');
		frms.pwd.focus();
		return ;
	} else if (strSpace(frms.comment.value)=='') {
		alert('������ �Է��� �ּ���');
		frms.comment.focus();
		return ;
	}
	
action(cofrm,'CommentProcess.asp')
}				
	</script>						
<%						
	If arrComCnt > 0 Then
%>
<tr>
	<td align=right style="word-break:break-all;">
		<table border=0 width=100% cellpadding=0 cellspacing=2>
							
<%
		Randomize 
		NanNumber	= int(rnd()*24)+1
		strPwd		= replace(left(now(),10),"-","")&NanNumber
		For i=0 To arrComCnt-1
		' arrCom(0,i) ; num
		' arrCom(1,i) ; cname
		' arrCom(2,i) ; cComment
		' arrCom(3,i) ; WriteDay
		' arrCom(4,i) ; Ip
%>
			<tr>
				<td width=30 style="word-break:break-all;"><img src=/images/bbs/memo_icon.gif></td>
				<td width=80 style="word-break:break-all;"><%=arrCom(1,i)%></td>
				<td width=400 style="word-break:break-all;"><%=arrCom(2,i)%></td>
				<td width=90 style="word-break:break-all;"><%=arrCom(4,i)%></td>
				<td width=20 style="word-break:break-all;"><a href="javascript:if(confirm('�����Ͻðڽ��ϱ�?')) { comtDelete('<%=IntIdx%>','CommentProcess.asp','comdelete','<%=arrCom(0,i)%>'); }"><img src=/images/bbs/icon_comment_del.gif ></td>
				<td width=80 style="word-break:break-all;"><%=DateViewLen(arrCom(3,i), 1,"/") %></td>
			</tr>
			<tr><td colspan=6 bgcolor="<%=TR_LINE_BG%>"></td></tr>
<%
		Next
%>
		</table>
	</td>
</tr>
<%								
	End If
%>

<tr>
	<td align=right>
		<table border=0 width=60% cellpadding=0 cellspacing=5>
			<form name=cofrm method=post action>
			<input type=hidden name="flag" value="comwrite">
			<input type=hidden name="Idx" value="<%=IntIdx%>">
			<input type=hidden name="TableName" value="<%=TableName%>">
			<input type=hidden name="KeyField" value="<%=strKeyField%>">
			<input type=hidden name="KeyWord" value="<%=strKeyWord%>">
			<input type=hidden name="SortColumn" value="<%=strSortColumn%>">
			<input type=hidden name="Sort" value="<%=strSort%>">
			<input type=hidden name="CurPage" value="<%=CurPage%>">
			<tr>
				<td>�ۼ���</td>
				<td><input type="text" name=cname size=15 class="box"></td>
				<td>��й�ȣ</td>
				<td><input type="password" name=pwd size=15 value="<%=strPwd%>" class="box"></td>
			</tr>
			<tr>
				<td colspan=4>
					<textarea name=comment rows=3 cols=36 Information="Required" title="����" ></textarea>
					<input type=button onclick="gWriteCmt(this);" value="���" style="width:67;height:50;border: solid 1" id=button1 name=button1>
				</td>
			</tr>
			</form>
		</table>
								
	</td>
</tr>
<tr><td height="10" ></td></tr>