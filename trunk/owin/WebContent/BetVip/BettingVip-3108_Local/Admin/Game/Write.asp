<!--	#include virtual="/Admin/top.asp"					-->
<%
	IntIdx		= Request("Idx")
	KeyField	= Request("KeyField")
	KeyWord		= Request("KeyWord")
	CurPage		= Request("CurPage")
	CurBlock	= Request("CurBlock")
	Sect		= Request("Sect")
	flag		= Request("flag")
	ScFlag		= Request("ScFlag")
	League		= Request("League")
	hcont		= Request("hCont")
	vcont		= Request("vCont")
	gName		= Request("gName")
	
'	Response.Write hcont &"<BR>"
'	Response.Write vcont &"<BR>"
	
	bName		= "���"
	ltitle		= "��/�ڵ�ĸ"
	
	goPage = "List.asp"
If ScFlag = "2" Then 
	Titles = "�������"
	goPage = "CloseList.asp"
Else
Select Case Sect
	Case "1" : Titles = "�߱�(�ڵ�) " : gName = "�߱�"
	Case "2" : Titles = "�౸(�ڵ�) " : gName = "�౸"
	Case "3" : Titles = "��(�ڵ�) " : gName = "��"
	Case "4" : Titles = "�ڵ�ĸ"
	Case "5" : Titles = "�¹���" : ltitle = "��"
	Case "6" : Titles = "��Ÿ(�ڵ�)" : gName = "��"
	Case Else Titles = "All "
End Select

End If

	Set objCon = getConnection

	If flag = "MODIFY" Then
		bName		= "����"
		SQL = "SELECT * FROM Game_TB WHERE Idx='"& IntIdx &"' "	
		Set objRs = getRecordSet(objCon, SQL)
		If objRs.EOF or objRs.BOF Then 
			Call CloseDB() : Call descment("�߸��� ��û�Դϴ�","back","")
		Else
			Sect		= objRs("Sect")				: gName			= objRs("gName")
			gsDate		= objRs("gsDate")			: League		= objRs("League")
			hTname		= objRs("hTname")			: hAllot		= objRs("hAllot")
			hCap		= objRs("hCap")				: HcapAllotl	= objRs("HcapAllotl")
			vTname		= objRs("vTname")			: vAllot		= objRs("vAllot")
			rtel		= objRs("rtel")				: hcont			= objRs("hcont")
			Status		= objRs("Status")			: WriteDay		= objRs("WriteDay")
			vcont		= objRs("vcont")			: Upflag		= objRs("Upflag")
			UpAllot		= objRs("UpAllot")			: events		= objRs("event")
			gResult		= objRs("gResult")
		End If
		objRs.Close
	End If
	
%>
<script language='javascript' src=/common/js/common.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["Idx"]			= gId;
		getQuery["senum"]		= gSe;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}


</script>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#FFFEF6" size="4"><b>[<%=Titles%> ����]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>

		<tr>
			<td>				
				
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					
					<form name=regfrm method=post onsubmit="return DefaultFormValidation(this);" action="Write_Prc.asp" >
					<input type=HIDDEN name="CurPage" value="<%=CurPage%>">
					<input type=HIDDEN name="CurBlock" value="<%=CurBlock%>">
					<input type=HIDDEN name="KeyField" value="<%=KeyField%>">
					<input type=HIDDEN name="KeyWord" value="<%=KeyWord%>">
					<input type=HIDDEN name="Idx" value="<%=IntIdx%>">
					<input type=HIDDEN name="flag" value="<%=flag%>">				
					<input type=HIDDEN name="ScFlag" value="<%=ScFlag%>">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;��� ����</td></tr>

					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;����Ͻ�</td>
						<td colspan=4 bgcolor="#FFFFFF">
							<select name="year" Information="Required" title="�⵵" >
								<option value="">==�⵵==</option>
								
								
<%
							For i=Year(now()) To Year(now())+3
%>								
								<option <%=gSelection(Left(gsDate,4),i,"selected")%> value="<%=i%>"><%=i%></option>
<%
							Next
%>
							</select >��&nbsp;

							<select name="mon" Information="Required" title="��" >
								<option  value="">==��==</option>
<%
							For i=1 To 12
%>								
								<option <%If Not isNone(gsDate) Then %><%=gSelection(mid(gsDate,6,2),right("0"&i,2),"selected")%><%End If%> value="<%=right("0"&i,2)%>"><%=right("0"&i,2)%></option>
<%
							Next
%>
							</select >��&nbsp;

							<select name="day" Information="Required" title="��" >
								<option value="">==��==</option>
<%
							For i=1 To 31
%>								
								<option <%If Not isNone(gsDate) Then %><%=gSelection(mid(gsDate,9,2),right("0"&i,2),"selected")%><%End If%>  value="<%=right("0"&i,2)%>"><%=right("0"&i,2)%></option>
<%
							Next
%>
							</select >��&nbsp;

							<select name="hour" Information="Required" title="��">
								<option value="">==��==</option>
								<option <%=gSelection(mid(gsDate,12,2),"00","selected")%> value="00">00</option>
<%
							For i=1 To 24
%>								
								<option <%=gSelection(mid(gsDate,12,2),right("0"&i,2),"selected")%> value="<%=right("0"&i,2)%>"><%=right("0"&i,2)%></option>
<%
							Next
%>
							</select >��&nbsp;
							
							<select name="min" Information="Required" title="��">
								<option value="">==��==</option>
								<option <%=gSelection(mid(gsDate,15,2),"00","selected")%> value="00">00</option>
<%
							For i=1 To 59
%>								
								<option <%=gSelection(mid(gsDate,15,2),right("0"&i,2),"selected")%> value="<%=right("0"&i,2)%>"><%=right("0"&i,2)%></option>
<%
							Next
%>
							</select >��&nbsp;
						</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���񱸺�</td>
						<td bgcolor="#FFFFFF">
							<select name="Sect" Information="Required" title="���񱸺�" >
								<option value="">==����==</option>
								<option <%=gSelection(Sect,5,"selected")%> value="5">�¹���</option>
								<option <%=gSelection(Sect,1,"selected")%> value="1">�߱�(�ڵ�)</option>
								<option <%=gSelection(Sect,2,"selected")%> value="2">�౸(�ڵ�)</option>
								<option <%=gSelection(Sect,3,"selected")%> value="3">��(�ڵ�)</option>
								<option <%=gSelection(Sect,6,"selected")%> value="6">��Ÿ(�ڵ�)</option>
								<!--<option <%=gSelection(Sect,4,"selected")%> value="4">�ڵ�ĸ</option>-->
							</select>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�� ��</td>
						<td bgcolor="#FFFFFF">									
							<input type=text name=gName size=20 value="<%=gName%>" Information="Required" title="����" class=text > 
						</td>
					</tr>
					<tr >
						
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�� ��</td>
						<td colspan=4 bgcolor="#FFFFFF"><input type=text name=League size=20 value="<%=League%>" Information="Required" title="����" class=text > </td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��(Ȩ��)</td>
						<td bgcolor="#FFFFFF"><input type=text name=hTname size=30 value="<%=hTname%>" Information="Required" title="��(Ȩ��)" class=text > &nbsp;&nbsp;</td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�����</td>
						<td bgcolor="#FFFFFF"><input type=text name=hAllot size=20 value="<%=hAllot%>" Information="Required" title="��(Ȩ��) �����" class=text > &nbsp;&nbsp;</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;<%=ltitle%></td>
						<td bgcolor="#FFFFFF"><input type=text name=hCap size=20 value="<%=hCap%>" title="<%=ltitle%>" MaxBytes="100" class=text></td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�����</td>
						<td bgcolor="#FFFFFF"><input type=text name=HcapAllotl size=20 value="<%=HcapAllotl%>" title="�ڵ�ĸ �����" class=text > &nbsp;&nbsp;</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��(������)</td>
						<td bgcolor="#FFFFFF"><input type=text name=vTname size=30 value="<%=vTname%>" Information="Required" title="��(������)" MaxBytes="100" class=text></td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�����</td>
						<td bgcolor="#FFFFFF"><input type=text name=vAllot size=20 value="<%=vAllot%>" Information="Required" title="��(������) �����" class=text > &nbsp;&nbsp;</td>
					</tr>
					
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;����</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name=Status value="1" <%=gSelection(reInt(Status,1),1,"checked")%> > ����
							<input type=radio name=Status value="0" <%=gSelection(Status,0,"checked")%> > ����
							<input type=radio name=Status value="2" <%=gSelection(Status,2,"checked")%> > �������
							<input type=radio name=Status value="4" <%=gSelection(Status,4,"checked")%> onclick="alert('������� ��ҷ� �����ؾ�\n\n�������߱ݾ��� ���� ���� �˴ϴ�')"> ���
							<input type=radio name=Status value="3" <%=gSelection(Status,3,"checked")%> > ����
							
						</td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�̺�Ʈ ����</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name=event value="1" <%=gSelection(events,1,"checked")%> > ��
							<input type=radio name=event value="0" <%=gSelection(reInt(events,0),0,"checked")%> > �ƴϿ�
						</td>
					</tr>
					<% If flag="MODIFY" Then %>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��纯��</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name=Upflag value="0" <%=gSelection(Upflag,0,"checked")%> > �ƴϿ�
							<input type=radio name=Upflag value="1" <%=gSelection(Upflag,1,"checked")%> > ��
						</td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���氪</td>
						<td bgcolor="#FFFFFF">
							<input type=text name=UpAllot size=30 value="<%=UpAllot%>" title="���氪" class=text > &nbsp;&nbsp;
						</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�����</td>
						<td <% If Sect<>5 Then %> colspan=4 <% End If %> bgcolor="#FFFFFF"><input type=text name=rtel size=20 value="<%=rtel%>" title="�����" MaxBytes="100" class=text></td>
						<% If Sect=5 Then %>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�����</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name=gResult size=20 value="0" <%=gSelection(reInt(gResult,0),0,"checked")%>>�����
							<input type=radio name=gResult size=20 value="1" <%=gSelection(gResult,1,"checked")%> onclick="alert('��� ����� �����ϸ�\n\n���õ� ����� ������ ���\n\n�������߱ݾ��� ���� ���� �˴ϴ�')">��
							<input type=radio name=gResult size=20 value="2" <%=gSelection(gResult,2,"checked")%> onclick="alert('��� ����� �����ϸ�\n\n���õ� ����� ������ ���\n\n�������߱ݾ��� ���� ���� �˴ϴ�')">��
							<input type=radio name=gResult size=20 value="3" <%=gSelection(gResult,3,"checked")%> onclick="alert('��� ����� �����ϸ�\n\n���õ� ����� ������ ���\n\n�������߱ݾ��� ���� ���� �˴ϴ�')">��
							<input type=radio name=gResult size=20 value="4" <%=gSelection(gResult,4,"checked")%> onclick="alert('��� ����� �����ϸ�\n\n���õ� ����� ������ ���\n\n�������߱ݾ��� ���� ���� �˴ϴ�')">���
							
						</td>
						<% End If %>
					</tr>
					<% End If %>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;Ȩ�� ����</td>
						<td bgcolor="#FFFFFF">
							<table border=0>
								<tr>
								<% For i=1 To 44 %>
									<td><input type=radio name=hcont value="<%=i%>" <%=gSelection(i,hcont,"checked")%>><img src="/flag/<%=right("0"&i,2)%>.gif" width=22 height=14></td>
								<% 
								If i mod 6=0 Then Response.Write "</tr><tr>"
								Next 
								%>
								</tr>
							</table>
						
						</td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;������ ����</td>
						<td bgcolor="#FFFFFF">
							<table border=0>
								<tr>
								<% For i=1 To 44 %>
									<td><input type=radio name=vcont value="<%=i%>" <%=gSelection(i,vcont,"checked")%>><img src="/flag/<%=right("0"&i,2)%>.gif" width=22 height=14></td>
								<% 
								If i mod 6=0 Then Response.Write "</tr><tr>"
								Next 
								%>
								</tr>
							</table>
						
						</td>
					</tr>
					

				</table>
			</td>
		</tr>	
		
		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						
						<td ><input type=submit value="<%=bName%>" ></td>
						<td ><input type=button value="����Ʈ" onclick="MovePage('','<%=goPage%>','','','');" ></td>
						<%If flag="MODIFY" Then%><td ><input type=button value="�� ��" onclick="if(confirm('������ �ڷ�� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){MovePage('<%=IntIdx%>','Write_Prc.asp','DELETE','','');}" id=button1 name=button1></td><%End If%>
					</tr>

				</table>
			</td>
		</tr>
		</form>
		<tr><td height=50></td></tr>
				<tr>

			<td >

				<iframe id="member" name="member" src="betUserList.asp?CurPage=1&KeyField=c.Id&Idx=<%=IntIdx%>" width="800" height="50" frameborder="1" marginwidth="0" marginheight="0" scrolling="no" ></iframe>

			</td>

		</tr>
		
	</table>
</body>
</html>
	