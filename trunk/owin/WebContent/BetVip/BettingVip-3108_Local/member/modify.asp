<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<%
	Set objRs = RunSQLReturnRs("SELECT * FROM Member_TB WHERE Id='"& Session("UId") &"'")
	If objRs.EOF Then Call descment("�߸��� ��û�Դϴ�.","/member/LogOut.asp","")
%>  
	<tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 >&nbsp;</td>
					<td valign=top >
						<table width=100% border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table border="0" cellpadding="0" cellspacing="0" width=100% >
										<tr>
											<td valign=top >
												<table width=100% border="0" cellpadding="0" cellspacing="0" >
													<tr>
														<td valign=top>
															<table border="0" cellpadding="0" cellspacing="2" width=97%>
																<tr><td height=10></td></tr>
																<tr><td ><img src=/images/mem01.gif ></td></tr>
																<tr><td height=5></td></tr>
																<tr>
																	<td >
																		
																		<table border="0" cellpadding="3" cellspacing="2" width=97% bgcolor=212021>
																			<tr>
																				<td>
																					
																					<table border="0" cellpadding="3" cellspacing="2" width=100% bgcolor=000000>
																						<tr>
																							<td>
																							1. ȸ���� ȸ�����Խ� �ʼ������� �ݵ�� �Է��ؾ� �մϴ�.<br>
																							2. ���̵�� ��й�ȣ�� ���� �н� å���� ȸ�� �ڽſ��� �ֽ��ϴ�.<br>
																							3. ���ñ����� ��߳� ���� ������ ����� ����ϴ� ȸ���� �� ���ؿ� ���� ���� å���� ������ �����ڿ� ���� ���� ��ġ�� ���� �� �ֽ��ϴ�.<br>
																							4. ���񽺸� �����ϴ� ȸ��� �Ϻ��� ���񽺸� �� �Ǻΰ� ������, �������α׷��� ���� ������ å���� �ֽ��ϴ�.<br>
																							</td>
																						</tr>
																					</table>
																		
																		
																				</td>
																			</tr>
																		</table>
																			
																	</td>
																</tr>
																<tr><td height=15></td></tr>
																<tr>
																	<td >
																		<table border="0" cellpadding="0" cellspacing="0" width=100% >
																			<tr>
																				<td>
																				<font color=red>* ǥ�ô´� �ʼ� �Է����� �Դϴ�.
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																    <td >
																		<table border=0 width=97% cellpadding=0 cellspacing=0 >
																			<form name=regfrm method=post action="Register_Prc.asp" onsubmit="return DefaultFormValidation(this);" >
																			<input type=hidden name=flag value="MODIFY">
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td width=150 bgcolor="484848" align=right><font color=FFFFFF><b>���̵�&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<b><%=Session("UId")%></td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>�̸�&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=text name="name" Information="Required" MaxBytes="15" title="�̸�" value="<%=objRs("Name")%>" class=input11 readonly> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>��й�ȣ&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=password name=pwd value="<%=objRs("Pwd")%>" Information="Required" MaxBytes="15" title="��й�ȣ" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>��й�ȣ Ȯ��&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=password name=repwd value="<%=objRs("Pwd")%>" Information="Required" MaxBytes="15" title="��й�ȣȮ��" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>�޴��� ��ȣ&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=text size=4 value="<%=getInfo(objRs("Cell"),0,"-")%>" name=cell01 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11> - <input type=text size=4 value="<%=getInfo(objRs("Cell"),1,"-")%>" name=cell02 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11> - <input type=text size=4 value="<%=getInfo(objRs("Cell"),2,"-")%>" name=cell03 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11></td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>�̸���&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=text value="<%=getInfo(objRs("mail"),0,"@")%>" name="mail01" Information="Required" MaxBytes="30" title="�̸���" size=12 class=input11> @ <input type=text size=12 Information="Required" MaxBytes="50" title="�̸���" value="<%=getInfo(objRs("mail"),1,"@")%>" name="mail02" class=input11>  
																				
																				<select class=select1 onchange="regfrm.mail02.value=this.value" name="mail03">
																					<option value="" selected>�����Է�</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"naver.com","selected")%> value="naver.com">���̹�</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"nate.com","selected")%> value="nate.com">����Ʈ</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"dreamwiz.com","selected")%> value="dreamwiz.com">�帲����</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"yahoo.com","selected")%> value="yahoo.co.kr">�����ڸ���</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"empal.com","selected")%> value="empal.com">���Ľ�</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"orgio.com","selected")%> value="orgio.net">��������</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"weppy.com","selected")%> value="weppy.com">����</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"unitel.com","selected")%> value="unitel.co.kr">������</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"chollian.com","selected")%> value="chollian.net">õ����</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"korea.com","selected")%> value="korea.com">�ڸ��ƴ���</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"freechal.com","selected")%> value="freechal.com">����ç</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"hitel.com","selected")%> value="hitel.net">������</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"hotmail.com","selected")%> value="hotmail.com">�ָ���</option>
																				</select>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<% If Not isNone(objRs("BankN")) Then %> <input type=hidden name=BankN value="<%=objRs("BankN")%>"> <%End If%>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>��,ȯ������&nbsp;&nbsp;</td>
																				<td>&nbsp;<font color=FFFFFF>���� �� �Ա��� ��:<input type=text name=CDepos <% If Not isNone(objRs("CDepos")) Then %> readonly <%End If%> value="<%=objRs("CDepos")%>" Information="Required" MaxBytes="15" title="���� �� �Ա��� ��" class=input11> &nbsp;<font color=red><b>������ �Ա��ڸ� �� ȯ���� �����ڸ��� �����ؾ� �մϴ�.</b><br>
																					&nbsp;<font color=FFFFFF>ȯ�� �� ��������:
																					<select class=select1 name="BankN"  <% If Not isNone(objRs("BankN")) Then %> disabled <%End If%>  class=input5 Information="Required" title="�ŷ�����">
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
																					���¹�ȣ : <input type=text name=BankNum <% If Not isNone(objRs("BankNum")) Then %> readonly <%End If%> value="<%=objRs("BankNum")%>" Information="Required" MaxBytes="25" title="���¹�ȣ" size=30 class=input11> &nbsp;
																					������ : <input type=text name=RDepos <% If Not isNone(objRs("RDepos")) Then %> readonly <%End If%> value="<%=objRs("RDepos")%>" Information="Required" MaxBytes="15" title="������" size=10 class=input11> &nbsp;
																				
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>SMS ���ſ���&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=radio name=gSms title="SMS ���ſ���" value=1 <%=gSelection(objRs("gSms"),1,"checked")%>> &nbsp;<font color=FFFFFF> SMS ����&nbsp;&nbsp;<input type=radio name=gSms title="SMS ���ſ���" value=0 <%=gSelection(objRs("gSms"),0,"checked")%>> &nbsp;<font color=FFFFFF> SMS �ź�</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			
																			<tr>
																				<td colspan=3 align=center height=45>
																					<input type=submit class="btn6" value="��������" id=submit1 name=submit1>
																					<input type=button class="btn7" value="�������" onclick="location.href='/';" id=button1 name=button1>
																				</td>
																			</tr>
																			</form>
																		</table>
																    </td>
																</tr>
																
															</table>
														
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>							
			</table>
		</td>
	</tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										