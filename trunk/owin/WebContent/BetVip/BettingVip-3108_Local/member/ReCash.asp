<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<%
'Session("UPoint") = 100000
%>
<script>

	function frmsSubmit() {
		if(!validateForm(frms)) return;		
		var bb = parseInt(frms.cash.value / 10000);
		bb = bb * 10000;
		if (bb!=parseInt(frms.cash.value)) {
			alert("�ݾ��� ���������� �Է��Ͻʽÿ�.");
			frms.cash.focus();
			return;
		}

		if(frms.cash.value > <%=reInt(Session("UPoint"),0)%>) {
			alert("ȯ���ݾ��� �����ݾ����Ϸ� �Է��Ͻʽÿ�.");
			frms.cash.focus();
			return;
		}
		if(confirm("ȯ�� ��û�Ͻðڽ��ϱ�?"))
			frms.submit();
	}
</script>
	<tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 >&nbsp;</td>
					<td valign=top >
						<table width=100% border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table width=100% border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign=top >
												<table width=100% border="0" cellpadding="0" cellspacing="0" >
													<tr>
														<td valign=top>
															<table border="0" cellpadding="0" cellspacing="0" width=99%>
																<tr><td height=10></td></tr>
																<tr>
																	<td ><img src=/images/title_recashrequest.gif ></td>
																</tr>
																<tr><td height=10></td></tr>
																
																<tr>
																	<td>
																		<table border="0" cellpadding="0" cellspacing="0" >
																			<tr>
																				<td><input type=button class="btn11" value="ĳ��ȯ�� ��û" >&nbsp;</td>
																				<td><input type=button class="btn13" value="ĳ��ȯ�� ����" onclick="location.href='ReCashList.asp';"  id=button2 name=button2></td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																    <td >
																		
																		
<table border="0" cellpadding="10" cellspacing="6" width=100% bgcolor=212021>
																			<tr>
																				<td bgcolor=000000>	
																		<table width="100%" cellpadding="4" cellspacing="1" border="0" >
																		<form name=frms action="cash_Prc.asp" method=post onsubmit="return DefaultFormValidation(this);"  >
																		<input type="hidden" name="flag" value="1">
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  width=600>
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>���� ����&nbsp;&nbsp;</td>
																				<td  ><br>
																				��24�ð� �����Ӱ� ��.����� �����ϸ� ����3�мҿ� �� 23:00����24:30�б����� Ÿ����ü�Ұ� 
																				<br>&nbsp;&nbsp;ȯ���� ��û��� ���̵𿡼� �����˴ϴ�<br>
																				��10���̻� �Ա��� �����ɽ� ȸ���� ���������� �߸� ������ ��찡 �����ϴ� �׷���� ��ܸ޴� 
																				<br>&nbsp;&nbsp;����Ÿ�� ���������� ��Ȯ�� �����ּ���.
																				<br>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>���� �ݾ�&nbsp;&nbsp;</td>
																				<td ><b><%=formatnumber(reInt(Session("UPoint"),0),[])%> ��</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>ȯ�� �ݾ�&nbsp;&nbsp;</td>
																				<td  ><font color=000000>
																					<input name="cash" type="text" size="30" class=input11 validator="num" kname="ȯ�� �ݾ�">&nbsp;
																					<font color="#FFFFFF">��</font><font color="#FFC602"> ( ���� 10,000 �� ���� ���� ������ ȯ�� ���� )</font>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  height=100>
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>�Ա� ������ ����&nbsp;&nbsp;</td>
																				<td  >
																					&nbsp;&nbsp;- �ŷ�����&nbsp;&nbsp; </font>
																					<select class=select1 name="bank01"  class=input5 validator="nn" kname="�ŷ�����">
																					<option value="" selected>����</option>
																					<option value="����">����</option>
																					<option value="����">����</option>
																					<option value="����">����</option>
																					<option value="�����߾�">�����߾�</option>
																					<option value="��������">��������</option>
																					<option value="�츮">�츮</option>
																					<option value="����">����</option>
																					<option value="��ȯ">��ȯ</option>
																					<option value="�ϳ�">�ϳ�</option>
																					<option value="�ѹ�">�ѹ�</option>
																					<option value="����">����</option>
																					<option value="����">����</option>
																					<option value="���">���</option>
																					<option value="��ȭ">��ȭ</option>
																					<option value="��ü��">��ü��</option>
																					<option value="�泲">�泲</option>
																					<option value="����">����</option>
																					<option value="�뱸">�뱸</option>
																					<option value="�λ�">�λ�</option>
																					<option value="���">���</option>
																					<option value="����">����</option>
																					<option value="����">����</option>
																					<option value="����">����</option>
																					<option value="��Ƽ">��Ƽ</option>
																					<option value="�Ϸ�">�Ϸ�</option>
																					<option value="����ġ">����ġ</option>
																					<option value="HSBC">HSBC</option>
																					<option value="���">���</option>
																					<option value="BOA">BOA</option>
																					<option value="������">������</option>
																					<option value="�ſ�����">�ſ�����</option>
																					<option value="��ȣ����">��ȣ����</option>
																					</select>
																						&nbsp;&nbsp; �� �Ա� ������ ������ ������ ���� �� �� �ֽ��ϴ�<br>
																						&nbsp; - ���¹�ȣ&nbsp;&nbsp; </font> 
																					<input name="bank02" type="text" size="30" class=input11 validator="nn" kname="���¹�ȣ">
																					&nbsp; <font color="#FFC602">�� ���� ������ ���¹�ȣ�� �Է��ϼ���</font><br>
																					
																					&nbsp; - ������ &nbsp;&nbsp;&nbsp;&nbsp; 
																					<input name="Depos" type="text" size="30" class=input11 validator="nn" kname="������">
																					&nbsp; <font color="#FFC602">�� �������� �̸��� ��Ȯ�� �Է��ϼž� �մϴ�</font>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			
																		</table>
																    </td>
																</tr>
																
														</td>
													</tr>
												</table>
											</tr>																
																<tr><td height=15></td></tr>
																<tr>
																	<td align=center>
																		<input type=button class="btn6" value="Ȯ ��" onclick="frmsSubmit();" >
																		<input type=button class="btn7" value="�� ��" onclick="location.href='/';" id=button1 name=button1>
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
	<tr><td height=20></td></tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										