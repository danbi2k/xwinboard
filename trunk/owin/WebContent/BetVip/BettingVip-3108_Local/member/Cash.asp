<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<script>
	function input_price(event) {
		var obj=getSrcElement(event);
		frms.cash.value=MoneyFormat(obj.value);
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
																    <td ><img src=/images/title_cashrequest.gif ></td>
																</tr>
																<tr><td height=10></td></tr>
																<tr>
																	<td>
																		<table border="0" cellpadding="0" cellspacing="0" >
																			<tr>
																				<td><input type=button class="btn11" value="ĳ������ ��û"  id=button1 name=button1>&nbsp;</td>
																				<td><input type=button class="btn13" value="ĳ������ ����" onclick="location.href='CashList.asp';"  id=button2 name=button2></td>
																				<td><input type=button class="btn13" value="����Ʈ->ĳ����ȯ" style="width:120" <% If reInt(Session("APoint"),0) >= 20000 Then %> onclick="if(confirm('����Ʈ�� ĳ���� ��ȯ �Ͻðڽ��ϱ�?')){location.href='ChCash_Prc.asp';}" <% Else %> onclick="alert('����Ʈ�� ĳ���� ��ȯ�� 20,000 �̻��ϋ� ��ȯ�˴ϴ�.');" <%End If %> ></td>
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
																		<input type="hidden" name="flag" value="0">
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td width=150 bgcolor="484848" align=right><font color=FFFFFF><b>�������</td>
																				<td width=600>
																				�� �Ա��Ͻ� ���¿� PC ��ŷ, ����ŷ, ������ �Ա�, ATM���� ������� �ݾ� �� �ϳ��� �����Ͽ� �Ա��մϴ�. <br>
																				�� �Ա��Ͻ� �ݾװ� ������ �ݾ׿� üũ�ϼ���. <br>
																				�� �Ա��ڸ��� �Ա��Ͻ� ���� ������ �־� �ּ���. <br>
																				�� Ȯ�� ��ư�� Ŭ���Ͻø� ������ �Ϸ�˴ϴ�.
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>�Ա� �Ͻ� ����</td>
																				<td >
																				��&nbsp;���¹�ȣ&nbsp;:&nbsp;842401-01-460725<br>
																				��&nbsp;�Ա�����&nbsp;:&nbsp;��������<br>
																				��&nbsp;������&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;��&nbsp;��&nbsp;��<br><br>


																				��&nbsp;���¹�ȣ&nbsp;:&nbsp;842401-01-460725<br>
																				��&nbsp;�Ա�����&nbsp;:&nbsp;��������<br>
																				��&nbsp;������&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;��&nbsp;��&nbsp;��<br><br>


																				��&nbsp;���¹�ȣ&nbsp;:&nbsp;842401-01-460725<br>
																				��&nbsp;�Ա�����&nbsp;:&nbsp;��������<br>
																				��&nbsp;������&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;��&nbsp;��&nbsp;��
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>���� �ݾ� ����</td>
																				<td >
																				<table id="table1" border="0" cellpadding="0" cellspacing="0" width="100%">
																						<tbody><tr>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="10000" name="price" checked="checked" type="radio"> 
																							10,000 ��&nbsp;</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="30000" name="price" type="radio"> 
																							30,000 ��</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="50000" name="price" type="radio"> 
																							50,000 ��</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="100000" name="price" type="radio"> 
																							100,000 ��</td>
																						</tr>
																						<tr>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="300000" name="price" type="radio"> 
																							300,000 ��</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="500000" name="price" type="radio"> 
																							500,000 ��</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="700000" name="price" type="radio"> 
																							700,000 ��</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="1000000" name="price" type="radio"> 
																							1,000,000 ��</td>
																						</tr>
																						<tr>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="3000000" name="price" type="radio"> 
																							3,000,000 �� </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="5000000" name="price" type="radio"> 
																							5,000,000 �� </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="10000000" name="price" type="radio"> 
																							10,000,000 �� </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="20000000" name="price" type="radio"> 
																							20,000,000 ��</td>
																						</tr>
																						<tr>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="30000000" name="price" type="radio"> 
																							30,000,000 �� </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="50000000" name="price" type="radio"> 
																							50,000,000 �� </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="70000000" name="price" type="radio"> 
																							70,000,000 ��</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="90000000" name="price" type="radio"> 
																							90,000,000 ��</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>���� �ݾ�</td>
																				<td >
																					<input name="cash" size="17" type="text" value="10,000" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value)" Information="Required" title="�����ݾ�" class=input11>&nbsp;<font color="#FFC602">","�� ���ڸ� �Է� �ϼ���
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>�Ա��� �̸�</td>
																				<td >
																				<input name="Depos" size="17" type="text" Information="Required" title="�Ա��� �̸�" class=input11>&nbsp;<font color="#FFC602">�� �Ա��� �̸��� Ʋ���� �Ա� Ȯ���� �Ҽ� �� ������ �����ϼ���</font>
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
																	<td align=center>
																		<input type=submit class="btn6" value="Ȯ ��" onclick="frmsSubmit();"  id=button3 name=button3>
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