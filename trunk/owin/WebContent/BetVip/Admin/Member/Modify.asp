<!--	#include virtual="/Admin/top.asp"						-->
<!--	#include virtual="/common/asp/MemberClass.asp"			-->
<%
	strId		= Request("Id")
	Sect		= Request("Sect")
	CurPage		= Request("CurPage")
	CurBlock	= Request("CurBlock")
	KeyField	= Request("KeyField")
	KeyWord		= Request("KeyWord")
	Flag		= Request("flag")
	refPage		= IfElse(Request("refPage"),"MemberList.asp")
	If Flag = "MODIFY" Then
		Cash	= replace(Request("Point"),",","")
		TCash	= NowMileage(strId, "Point") '���ϸ��� ����
		If reInt(Cash,0) <> reInt(TCash,0) Then
		SQL1 = "INSERT INTO Cash_TB (Id,RCash,TCash,ResultCash,Comment,Status,Type,InDay) VALUES('"& strId &"','"& Cash &"','"& TCash &"','"& Cash &"','������ ĳ������',1,8,getDate())"
		RunSQL(SQL1)
		End If
		SQLs = "UPDATE Member_TB Set Name='"& reString(Request("Names"),"sql") &"', Point = '"& Cash &"',Seceid = '"& Request("Seceid") &"',CDepos = '"& reString(Request("CDepos"),"sql") &"',BankN = '"& reString(Request("BankN"),"sql") &"',BankNum = '"& reString(Request("BankNum"),"sql") &"',RDepos = '"& reString(Request("RDepos"),"sql") &"' WHERE Id='"& strId &"'"
		RunSQL(SQLs)
		
		Call CloseDB()
		Call descment("�����Ǿ����ϴ�.","Modify.asp?Id="&strId&"&CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If
	
	If Flag = "MODIFYSC" Then
		RunSQL("UPDATE Member_TB Set Seceid='"& replace(Request("senum"),",","") &"' WHERE Id='"& strId &"'")
		Call CloseDB()
		Call descment("�����Ǿ����ϴ�.","Modify.asp?Id="&strId&"&CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If

	If Flag = "DELETE" Then
		Call MemberDel(strId)
		Call CloseDB()
		Call descment("�����Ǿ����ϴ�.","MemberList.asp?CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If
		
	SQL = "SELECT * FROM Member_TB WHERE Id='"& strId &"'"
	Set objRs = RunSQLReturnRs(SQL)
	If objRs.EOF or objRs.BOF Then
		Call CloseDB()
		Call descment("������ ȸ�������Դϴ�.","back","")		
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
		getQuery["Id"]			= gId;
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
						<td><font color="#ffffff" size="4"><b>[ȸ������]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
	
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;ȸ������</td></tr>
					<form name=frms method=post action="Modify.asp" onsubmit="return DefaultFormValidation(this);" >
					<input type=hidden name=flag value="MODIFY">
					<input type=hidden name=CurPage value="<%=CurPage%>">
					<input type=hidden name=CurBlock value="<%=CurBlock%>">
					<input type=hidden name=KeyField value="<%=KeyField%>">
					<input type=hidden name=KeyWord value="<%=KeyWord%>">
					<input type=hidden name=id value="<%=strId%>">

					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;���̵�</td>
						<td bgcolor="#FFFFFF"><%=strId%></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�� ��</td>
						<td bgcolor="#FFFFFF"><input type=text name=Names size=10 class=input4 value="<%=objRs("Name")%>" Information="Required" MaxBytes="10" title="����"  ></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��й�ȣ</td>
						<td bgcolor="#FFFFFF"><%=objRs("Pwd")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�̸���</td>
						<td bgcolor="#FFFFFF"><%=objRs("mail")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�޴��ȣ</td>
						<td bgcolor="#FFFFFF"><%=objRs("cell")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��,ȯ�� ����</td>
						<td bgcolor="#FFFFFF">
							<table border=0 cellpadding=0 cellspacing=2>
								<tr>
									<td>������ �Ա��ڸ�&nbsp;</td>
									<td><input type=text name=CDepos value="<%=objRs("CDepos")%>" Information="Required" MaxBytes="15" title="���� �� �Ա��� ��" class=input4> </td>
								</tr>
								<tr>
									<td>ȯ���� ��������&nbsp;</td>
									<td>
									<select name="BankN"  Information="Required" title="�ŷ�����">
										<option value="" selected>����</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"�����߾�","selected")%> value="�����߾�">�����߾�</option>
										<option <%=gSelection(objRs("BankN"),"��������","selected")%> value="��������">��������</option>
										<option <%=gSelection(objRs("BankN"),"�츮","selected")%> value="�츮">�츮</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"��ȯ","selected")%> value="��ȯ">��ȯ</option>
										<option <%=gSelection(objRs("BankN"),"�ϳ�","selected")%> value="�ϳ�">�ϳ�</option>
										<option <%=gSelection(objRs("BankN"),"�ѹ�","selected")%> value="�ѹ�">�ѹ�</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"���","selected")%> value="���">���</option>
										<option <%=gSelection(objRs("BankN"),"��ȭ","selected")%> value="��ȭ">��ȭ</option>
										<option <%=gSelection(objRs("BankN"),"��ü��","selected")%> value="��ü��">��ü��</option>
										<option <%=gSelection(objRs("BankN"),"�泲","selected")%> value="�泲">�泲</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"�뱸","selected")%> value="�뱸">�뱸</option>
										<option <%=gSelection(objRs("BankN"),"�λ�","selected")%> value="�λ�">�λ�</option>
										<option <%=gSelection(objRs("BankN"),"���","selected")%> value="���">���</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"����","selected")%> value="����">����</option>
										<option <%=gSelection(objRs("BankN"),"��Ƽ","selected")%> value="��Ƽ">��Ƽ</option>
										<option <%=gSelection(objRs("BankN"),"�Ϸ�","selected")%> value="�Ϸ�">�Ϸ�</option>
										<option <%=gSelection(objRs("BankN"),"����ġ","selected")%> value="����ġ">����ġ</option>
										<option <%=gSelection(objRs("BankN"),"HSBC","selected")%> value="HSBC">HSBC</option>
										<option <%=gSelection(objRs("BankN"),"���","selected")%> value="���">���</option>
										<option <%=gSelection(objRs("BankN"),"BOA","selected")%> value="BOA">BOA</option>
										<option <%=gSelection(objRs("BankN"),"������","selected")%> value="������">������</option>
										<option <%=gSelection(objRs("BankN"),"�ſ�����","selected")%> value="�ſ�����">�ſ�����</option>
										<option <%=gSelection(objRs("BankN"),"��ȣ����","selected")%> value="��ȣ����">��ȣ����</option>
									</select>
										&nbsp;&nbsp;���¹�ȣ
										<input type=text name=BankNum value="<%=objRs("BankNum")%>" Information="Required" MaxBytes="25" title="���¹�ȣ" size=30 class=input4>
										&nbsp;&nbsp;������
										<input type=text name=RDepos value="<%=objRs("RDepos")%>" Information="Required" MaxBytes="15" title="������" size=10 class=input4>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;SMS���ſ���</td>
						<td bgcolor="#FFFFFF"><%If objRs("gSMS")="1" Then%>����<%Else%>�ź�<%End If%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;������</td>
						<td bgcolor="#FFFFFF"><%=objRs("WriteDay")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���Դ�� ������</td>
						<td bgcolor="#FFFFFF"><%=objRs("Writeip")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���� �α���</td>
						<td bgcolor="#FFFFFF"><%=objRs("Flogin")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���ʷα��� ������</td>
						<td bgcolor="#FFFFFF"><%=objRs("FloginIp")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;������ �α���</td>
						<td bgcolor="#FFFFFF"><%=objRs("Llogin")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;������ ������</td>
						<td bgcolor="#FFFFFF"><%=objRs("LloginIp")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�湮Ƚ��</td>
						<td bgcolor="#FFFFFF"><%=formatnumber(objRs("Visitnum"),[])%> ȸ</td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;ȸ������</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name="Seceid" value="0" <%=gSelection(objRs("Seceid"),0,"checked")%> >����
							<input type=radio name="Seceid" value="1" <%=gSelection(objRs("Seceid"),1,"checked")%> >�̿�����
							<input type=radio name="Seceid" value="2" <%=gSelection(objRs("Seceid"),2,"checked")%> >IP����
						
						</td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;ȸ��������</td>
						<td bgcolor="#FFFFFF"><%=objRs("VipFlag")%></td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���纸�� ĳ��</td>
						<td bgcolor="#FFFFFF"><input type=text name=Point size=10 class=input4 value="<%=formatnumber(objRs("Point"),[])%>" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value)"  Information="Required" MaxBytes="10" title="���纸��ĳ��"  OnKeydown="onlyNumber();"  >��</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���纸�� ����Ʈ</td>
						<td bgcolor="#FFFFFF"><%=formatnumber(objRs("APoint"),[])%> ��&nbsp;&nbsp;<!--<input type=button value="�������� ��������" class="btn1"  onclick="MM_winopen('../Game/MisPGameList.asp?Id=<%=strId%>','MPGL','width=980,height=400,scrollbars=1');" >--></td>
					</tr>					
				</table>
			</td>
		</tr>
		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						<td ><input type=submit value="����"  id=submit1 name=submit1></td>
						<td ><input type=button value="����Ʈ" onclick="MovePage('','<%=refPage%>','','','');"></td>
						<td ><input type=button value="�� ��" onclick="MovePage('<%=strId%>','Modify.asp','MODIFYSC',1,'');" ></td>
						<td ><input type=button value="��������" onclick="MovePage('<%=strId%>','Modify.asp','MODIFYSC',0,'');"  id=button2 name=button2></td>
						<td ><input type=button value="�� ��" onclick="if(confirm('������ ȸ���� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){MovePage('<%=strId%>','Modify.asp','DELETE','','');}" id=button1 name=button1></td>
					</tr>
				</form>
				</table>
			</td>
		</tr>
		<tr>
			<td >
				<iframe id="member" name="member" src="SubModifyList.asp?CurPage=1&Id=<%=strId%>" width="800" height="50" frameborder="1" marginwidth="0" marginheight="0" scrolling="no" ></iframe>
			</td>
		</tr>
		<tr><td height=50></td></tr>
		<tr>
			<td >
				<iframe id="mplist" name="mplist" src="SubMPList.asp?CurPage=1&Id=<%=strId%>" width="800" height="50" frameborder="1" marginwidth="0" marginheight="0" scrolling="no" ></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
<%
Call CloseDB()
%>
	