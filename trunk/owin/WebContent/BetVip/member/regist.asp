<!--	#include virtual=/common/asp/top.asp	-->
<%
rCode = MemRandomCode()
%>
	<tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 >&nbsp;</td>
					<td valign=top >
						<table border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign=top >
												<table border="0" cellpadding="0" cellspacing="0" >
													<tr>
														<td valign=top>
															<table border="0" cellpadding="3" cellspacing="2" width=97%>
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
																			<form name=regfrms method=post action="Register_Prc.asp" onsubmit="return DefaultFormValidation(this);" >
																			<input type=hidden name=hrcode value="<%=rCode%>">
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td width=150 bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>���̵�&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=text name=id Information="Required" MaxBytes="15" title="���̵�" class=input11> 
																				<input type=button class="btn6" value="�ߺ�Ȯ��" onclick="javascript:checkIds();">
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>�̸�&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=text name="name" Information="Required" MaxBytes="15" title="�̸�" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>��й�ȣ&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=password name=pwd Information="Required" MaxBytes="15" title="��й�ȣ" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>��й�ȣ Ȯ��&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=password name=repwd Information="Required" MaxBytes="15" title="��й�ȣȮ��" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>�޴��� ��ȣ&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=text size=4 name=cell01 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11> <font color=FFFFFF>- <input type=text size=4 name=cell02 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11> - <input type=text size=4 name=cell03 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11></td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>�̸���&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=text name="mail01" Information="Required" MaxBytes="30" title="�̸���" size=12 class=input11> <font color=FFFFFF>@ <input type=text size=12 Information="Required" MaxBytes="50" title="�̸���" name="mail02" class=input11>  
																				
																				<select class=select1 onchange="regfrm.mail02.value=this.value" name="mail03">
																					<option value="" selected>�����Է�</option>
																					<option value="naver.com">���̹�</option>
																					<option value="nate.com">����Ʈ</option>
																					<option value="dreamwiz.com">�帲����</option>
																					<option value="yahoo.co.kr">�����ڸ���</option>
																					<option value="empal.com">���Ľ�</option>
																					<option value="orgio.net">��������</option>
																					<option value="weppy.com">����</option>
																					<option value="unitel.co.kr">������</option>
																					<option value="chollian.net">õ����</option>
																					<option value="korea.com">�ڸ��ƴ���</option>
																					<option value="freechal.com">����ç</option>
																					<option value="hitel.net">������</option>
																					<option value="hotmail.com">�ָ���</option>
																				</select>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>�ڵ����� �����ڵ�&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=text name=rcode Information="Required" MaxBytes="15" title="�ڵ����� �����ڵ�" class=input11> &nbsp;<font color=red><b><%=rCode%></b></td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr>
																				<td colspan=3 align=center height=45>
																					<input type=submit class="btn6" value="ȸ������">
																					<input type=button class="btn7" value="�������" onclick="location.href='/';">
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