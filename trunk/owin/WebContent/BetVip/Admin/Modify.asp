<!--	#include virtual="/Admin/top.asp"					-->
<%
	strId		= Request("Id")
	Sect		= Request("Sect")
	CurPage		= Request("CurPage")
	CurBlock	= Request("CurBlock")
	KeyField	= Request("KeyField")
	KeyWord		= Request("KeyWord")
	Flag		= Request("flag")
	Ordno		= Request("Ordno")
	Sect		= Request("Sect")
	
	Set objAdo = New AdoHelp
	If Flag = "DELETE" Then

		objAdo.RunSQL("DELETE FROM Orders_TB WHERE ordno='"& Ordno &"'")
		objAdo.RunSQL("DELETE FROM OrderDetail_TB WHERE ordno='"& Ordno &"'")
		Call CloseDB()
		Call descment("�����Ǿ����ϴ�.","List.asp?CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If
		
	SQL = "SELECT o.Product, o.Unit, o.Price, p.Imgs, SUM(o.Price*o.Unit), d.TransPrice, o.Sect, o.Color, o.RefIdx, o.OrderDay "
	SQL = SQL &" FROM Orders_TB o,Products_TB p ,OrderDetail_TB d WHERE o.RefIdx=p.Idx and d.ordno=o.ordno And o.ordno='"& Ordno &"'"
	SQL = SQL &" GROUP BY o.Product,o.Unit,o.Price,p.Imgs,d.TransPrice, o.Sect, o.Color, o.RefIdx, o.OrderDay Order By o.RefIdx"	
'	Response.Write sql &"<br><br>"
	Set objRs = objAdo.RunSQLReturnRs(SQL)
	If Not objRs.EOF or Not objRs.BOF Then arrRs = objRs.GetRows() : arrRsCnt = Ubound(arrRs,2)
	objRs.Close

	SQL = "SELECT * FROM OrderDetail_TB WHERE Ordno='"& Ordno &"'"
	Set objRs = objAdo.RunSQLReturnRs(SQL)
	If Not objRs.EOF or Not objRs.BOF Then
		ordno		= objRs("ordno")		: Id			= objRs("Id")			: bName			= objRs("bName")			: btel			= objRs("btel")				: bcell			= objRs("bcell")
		bmail		= objRs("bmail")		: rName			= objRs("rName")		: rtel			= objRs("rtel")				: rcell			= objRs("rcell")			: rmail			= objRs("rmail")
		rZipcode	= objRs("rZipcode")		: rAddr			= objRs("rAddr")		: Comment		= objRs("Comment")		: TransNo		= objRs("TransNo")		: Transstate= objRs("Transstate")
		CashType	= objRs("CashType")		: Bankname		= objRs("Bankname")		: Depositor		= objRs("Depositor")	: Incashbank= objRs("Incashbank") : Inbank		= objRs("Inbank")
		pointstate	= objRs("pointstate")	: CompleteDay	= objRs("CompleteDay")	: AdminMemo		= objRs("AdminMemo")
		TaxType		= objRs("TaxType")		: BusNum		= objRs("BusNum")		: busName		= objRs("busName")
		CoName		= objRs("CoName")		: busaddr		= objRs("busaddr")		: busType		= objRs("busType")
		busSub		= objRs("busSub")		: busmail		= objRs("busmail")
	End If
'	Response.Write sql

	Call CloseDB()
%>
<script language='javascript' src=/common/js/common.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gOn, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["OrdNo"]		= gOn;
		getQuery["Sect"]		= '<%=Sect%>';
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
						<td><font color="#ffffff" size="4"><b>[�ֹ�����]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td><br>
			
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					<form name=frm method=post action="Modify_Prc.asp" onsubmit="return DefaultFormValidation(this)">
					<input type=HIDDEN name=Ordno value="<%=OrdNo%>">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;�ֹ���ǰ ����</td></tr>
				    <TR align=middle height=30 bgColor=#5d97d3 >
						<TD width=350 bgcolor="#e0e0e0">���Ż�ǰ</FONT></A></TD>
				        <TD width=100 bgcolor="#e0e0e0">�ǸŰ���</FONT></A></TD>
				        <TD width=100 bgcolor="#e0e0e0">��������</FONT></A></TD>
				        <TD width=70 bgcolor="#e0e0e0">�հ� ��</FONT></A></TD>
					<TR align=middle>
<%
				  			
				  	If Not isNone(arrRsCnt) Then
			  			For i=0 To arrRsCnt			  					
%>
				  	<TR bgColor=#ffffff style="padding-left:5pt;">
				  		<TD <%If arrRs(6,i)=0 Then%> bgcolor=EFEFEF<%End IF%>>
							<table height=50 border=0 cellpadding=0 cellspacing=0>
								<tr>
									<td  width=70 ><%If Not isNone(getInfo(arrRs(3,i),2,chr(13)&chr(10))) Then%><%If arrRs(6,i)=0 Then%> <img src=<%=CONF_PRODUCTIMGVIEW_PATH%><%=getInfo(arrRs(3,i),2,chr(13)&chr(10))%> height=50 align=absmiddle><%End If%><%End If%></td>
									<td><b><%=arrRs(0,i)%><%If arrRs(6,i)=0 Then%> &nbsp;&nbsp;[<%=arrRs(7,i)%>]<%End IF%></td>
								</tr>
							</table>				  		
				  		</TD>
				  		<TD <%If arrRs(6,i)=0 Then%> bgcolor=EFEFEF<%End IF%> align=right><%=formatnumber(arrRs(2,i),0)%>&nbsp;</TD>
				  		<TD <%If arrRs(6,i)=0 Then%> bgcolor=EFEFEF<%End IF%> align=center>
<%
							If arrRs(6,i)=0 Then
								Response.Write arrRs(1,i) &" ��"
								TaxProName = TaxProName &"^"& arrRs(0,i)
								TaxQty = TaxQty &"^"& arrRs(1,i)
							Else
								If arrRs(6,i)=1 Then
									Response.Write "�����ǰ"
								ElseIf arrRs(6,i)=2 Then
									Response.Write "�߰���ǰ"
								End If
							End If
							pc = 0
%>				  		
				  		</TD>
				  		<TD <%If arrRs(6,i)=0 Then%> bgcolor=EFEFEF<%End IF%> align=right ><%=formatnumber(arrRs(4,i),[])%>��&nbsp;</TD>
				  	</TR>
<%
					If arrRs(6,i)=0 Then
						pc = pc+1
						Set objAdo = New ADOHelp
						Set objRs = objAdo.RunSQLReturnRs("SELECT * FROM Products_TB WHERE Idx='"& arrRs(8,i) &"'")
						If Not objRs.EOF or Not objRs.BOF Then
%>				  	
				  	<tr bgColor=#ffffff style="padding-left:5pt;" >
				  		<td colspan=10>
							<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
								<tr >
									<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;����� </td>
									<td width="40%" bgcolor="#FFFFFF"><%=objRs("DefMot")%></td>
									<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;���μ���</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefPro")%></td>
								</tr>
								
								<tr >
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;�޸�&nbsp;</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefMem")%></td>
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;��</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefCol")%></td>
								</tr>
								
								<tr >
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;���κ���</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefMai")%></td>
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;�׷���</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefGro")%></td>
								</tr>
								
								<tr >
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;���̽�</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefCas")%></td>
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;�Ŀ�</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefPow")%></td>
								</tr>
								
								<tr >
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;����</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefSou")%></td>
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;��ī��</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefLanK")%></td>
								</tr>
								
								<tr >
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;HDD&nbsp;</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefHdd")%></td>
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;CD/DVD</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefCdDvd")%></td>
								</tr>
								
								<tr >
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;TVī��</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefTvC")%></td>
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;Ű����</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefKeyB")%></td>
								</tr>
								
								<tr >
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;���콺</td>
									<td bgcolor="#FFFFFF"><%=objRs("DefMou")%> </td>
									<td  bgcolor="#e0e0e0">&nbsp;&nbsp;�ü��</td>
									<td bgcolor="#FFFFFF"><%=objRs("Opers")%></td>
								</tr>
							</table>
				  		</td>
				  	</tr>
<%
						CloseDB()
						End If
					End If
					  	ToPrice = ToPrice + arrRs(4,i)
						TransPrice	= reInt(arrRs(5,0),0)
						OrderDay = arrRs(9,i)
						If pc=0 And isInt(ToPrice) Then DanGa1 = ToPrice						If pc=1 And isInt(ToPrice) Then DanGa2 = ToPrice						If pc=2 And isInt(ToPrice) Then DanGa3 = ToPrice						If pc=3 And isInt(ToPrice) Then DanGa4 = ToPrice						
				  		Next 
				  	End If 				  	If Not isNone(DanGa1) Then DanGa = DanGa1&"^"				  	If Not isNone(DanGa2) Then DanGa = DanGa&DanGa2&"^"				  	If Not isNone(DanGa3) Then DanGa = DanGa&DanGa3&"^"				  	If Not isNone(DanGa4) Then DanGa = DanGa&DanGa4
%>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<TABLE width=770 cellSpacing=5 cellPadding=0 align=center border=0 bgcolor="#e0e0e0" >
					<TR><TD height=5></TD></TR>
					<TR><TD align=right>�ѱ��� �ݾ� : <font color=red><b><%=formatnumber(ToPrice+TransPric,0)%> ��</b> </TD></TR>
					<TR><TD height=5></TD></TR>
				</table>			
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;�ֹ�������</td></tr>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;�ֹ���ȣ</td>
						<td bgcolor="#FFFFFF"><%=Ordno%></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;���̵�</td>
						<td bgcolor="#FFFFFF"><% If right(Id,2) = "-1" Then %> ��ȸ�� ���� <% eLSE %> ȸ������(<%=Id%>)<% End If %></TD>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�� ��</td>
						<td bgcolor="#FFFFFF"><%=bname%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;����ó</td>
						<td bgcolor="#FFFFFF"><%=btel%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�޴���</td>
						<td bgcolor="#FFFFFF"><%=bcell%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�̸���</td>
						<td bgcolor="#FFFFFF"><%=bmail%></td>
					</tr>

				</table>
			</td>
		</tr>
		
		
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;����������</td></tr>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;����</td>
						<td bgcolor="#FFFFFF"><%=rname%></td>
					</tr>
					
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;����ó</td>
						<td bgcolor="#FFFFFF"><%=rtel%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�޴���</td>
						<td bgcolor="#FFFFFF"><%=rcell%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;������ �ּ�</td>
						<td bgcolor="#FFFFFF">[ <%=rzipcode%> ] <%=getInfo(rAddr,0,"@")%>&nbsp;<%=getInfo(rAddr,1,"@")%></td>
					</tr>
					<!--
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�̸���</td>
						<td bgcolor="#FFFFFF"><%=rmail%></td>
					</tr>
					-->
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��Ÿ��û����</td>
						<td bgcolor="#FFFFFF"><%=Comment%></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;��������</td></tr>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;���� Ÿ��</td>
						<td bgcolor="#FFFFFF"><% If CashType = 0 Then %> ������ �Ա� <% ElseIf CashType=1 Then%> ī����� <% End If %></td>
					</tr>
<%

					If CashType = 0 Then
%>					
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�Ա�����</td>
						<td bgcolor="#FFFFFF"><%=Bankname%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�Ա��ڸ�</td>
						<td bgcolor="#FFFFFF"><%=Depositor%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�Աݿ�����</td>
						<td bgcolor="#FFFFFF"><%=Incashbank%> </td>
					</tr>
<%
					End If
%>					
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;���ݰ�꼭 �߱�</td></tr>
					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;�����û ����</td>
						<td bgcolor="#FFFFFF"><% If TaxType = 0 Then %> ��û���� <% Else%> ��û <% End If %></td>
					</tr>
<%

					If TaxType = 1 Then
%>					
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;����� ��Ϲ�ȣ</td>
						<td bgcolor="#FFFFFF"><%=BusNum%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��ȣ(���θ�)</td>
						<td bgcolor="#FFFFFF"><%=busName%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��ǥ�ڸ�</td>
						<td bgcolor="#FFFFFF"><%=CoName%> </td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;����� �ּ�</td>
						<td bgcolor="#FFFFFF"><%=busaddr%> </td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��������</td>
						<td bgcolor="#FFFFFF"><%=busType%> </td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;����</td>
						<td bgcolor="#FFFFFF"><%=busSub%> </td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;�̸���</td>
						<td bgcolor="#FFFFFF"><%=busmail%> </td>
					</tr>
					
<%
					End If
%>					
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;�������</td></tr>
					<tr>	
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;�����ȣ</td>
						<td bgcolor="#FFFFFF"><input type=text name=TransNo value="<%=TransNo%>" size=20 class=input></td>
					</tr>
					<tr>	
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;��۷�</td>
						<td bgcolor="#FFFFFF"><%=formatnumber(TransPrice,0)%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;��۴ܰ�</td>
						<td bgcolor="#FFFFFF">
							<select name=Transstate style="WIDTH:150;BACKGROUND: #CE5D5D; COLOR: #ffffff; FONT: 9pt;">
								<option value=0 <%=gSelection(Transstate,0,"selected")%>>�Ա�Ȯ����</option>
								<option value=1 <%=gSelection(Transstate,1,"selected")%>>�Ա�Ȯ��</option>
								<option value=2 <%=gSelection(Transstate,2,"selected")%>>��ǰ�غ���</option>
								<option value=3 <%=gSelection(Transstate,3,"selected")%>>��ǰ�����</option>
								<option value=4 <%=gSelection(Transstate,4,"selected")%>>��ۿϷ�</option>
								<!--<option value=4 <%=gSelection(Transstate,4,"selected")%>>��ȯ��</option>-->
								<!--<option value=5 <%=gSelection(Transstate,5,"selected")%>>��ȯ�Ϸ�</option>-->
								<!--<option value=6 <%=gSelection(Transstate,6,"selected")%>>ȯ��</option>-->
								<!--<option value=7 <%=gSelection(Transstate,7,"selected")%>>�ֹ����</option>-->
							</select>						
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						<td ><input type=submit value="�� ��" ></td>
						<td ><input type=button value="����Ʈ" onclick="MovePage('','List.asp','<%=flag%>','','');" id=button2 name=button2></td>
						<td ><input type=button value="�� ��" onclick="if(confirm('������ �ڷ�� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){MovePage('<%=Ordno%>','Modify.asp','DELETE','','');}" id=button1 name=button1></td>
						<td ><input type=button value="����Ʈ"  onclick="MM_winopen('print.asp?Ordno=<%=Ordno%>','PO','width=800,height=600,scrollbars=1');"></td>
						<% If TaxType = 1 Then %><td ><input type=button value="���ݰ�꼭 ����Ʈ"  onclick="MM_winopen('taxprint.asp?Ordno=<%=Ordno%>&Toprice=<%=ToPrice%>&TaxProName=<%=TaxProName%>&TaxQty=<%=TaxQty%>&DanGa=<%=DanGa%>','TxP','width=630,height=600,scrollbars=1');" id=button3 name=button3></td><%End If%>					</tr>
					<tr>
						<td colspan=3><input type=button value="�ŷ���ǥ(������) ����Ʈ"  onclick="MM_winopen('ordprint.asp?flag=1&Ordno=<%=Ordno%>&OrderDay=<%=OrderDay%>&ToPrice=<%=ToPrice%>','ORP','width=640,height=600,scrollbars=1');" id=button3 name=button3></td>
						<td colspan=2><input type=button value="�ŷ���ǥ(���޹޴���) ����Ʈ"  onclick="MM_winopen('ordprint.asp?Ordno=<%=Ordno%>&OrderDay=<%=OrderDay%>&ToPrice=<%=ToPrice%>','ORP','width=640,height=600,scrollbars=1');" id=button3 name=button3></td>
					</tr>

				</table>
			</td>
		</tr>
		</form>
	</table>
</body>
</html>
<%
Call CloseDB()
%>
	