<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>

<%@include file="../header.jsp"%>

<%
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
%>

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
																    <td ><img src=images/title_cashrequest.gif ></td>
																</tr>
																<tr><td height=10></td></tr>
																<tr>
																	<td>
																		<table border="0" cellpadding="0" cellspacing="0" >
																			<tr>
																				<td><input type=button class="btn11" value="캐쉬충전 요청"  id=button1 name=button1>&nbsp;</td>
																				<td><input type=button class="btn13" value="캐쉬충전 내역" onclick="location.href='CashList.asp';"  id=button2 name=button2></td>
																				<td><input type=button class="btn13" value="포인트->캐쉬전환" style="width:120"></td>
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
																				<td width=150 bgcolor="484848" align=right><font color=FFFFFF><b>결제방법</td>
																				<td width=600>
																				① 입금하실 계좌에 PC 뱅킹, 폰뱅킹, 무통장 입금, ATM등의 방법으로 금액 중 하나를 선택하여 입금합니다. <br>
																				② 입금하신 금액과 동일한 금액에 체크하세요. <br>
																				③ 입금자명에는 입금하신 분의 성함을 넣어 주세요. <br>
																				④ 확인 버튼을 클릭하시면 충전이 완료됩니다.
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>입금 하실 계좌</td>
																				<td >
																				▶&nbsp;계좌번호&nbsp;:&nbsp;842401-01-460725<br>
																				▶&nbsp;입금은행&nbsp;:&nbsp;국민은행<br>
																				▶&nbsp;예금주&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;한&nbsp;유&nbsp;진<br><br>


																				▶&nbsp;계좌번호&nbsp;:&nbsp;842401-01-460725<br>
																				▶&nbsp;입금은행&nbsp;:&nbsp;국민은행<br>
																				▶&nbsp;예금주&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;한&nbsp;유&nbsp;진<br><br>


																				▶&nbsp;계좌번호&nbsp;:&nbsp;842401-01-460725<br>
																				▶&nbsp;입금은행&nbsp;:&nbsp;국민은행<br>
																				▶&nbsp;예금주&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;한&nbsp;유&nbsp;진
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>충전 금액 선택</td>
																				<td >
																				<table id="table1" border="0" cellpadding="0" cellspacing="0" width="100%">
																						<tbody><tr>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="10000" name="price" checked="checked" type="radio"> 
																							10,000 원&nbsp;</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="30000" name="price" type="radio"> 
																							30,000 원</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="50000" name="price" type="radio"> 
																							50,000 원</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="100000" name="price" type="radio"> 
																							100,000 원</td>
																						</tr>
																						<tr>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="300000" name="price" type="radio"> 
																							300,000 원</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="500000" name="price" type="radio"> 
																							500,000 원</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="700000" name="price" type="radio"> 
																							700,000 원</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="1000000" name="price" type="radio"> 
																							1,000,000 원</td>
																						</tr>
																						<tr>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="3000000" name="price" type="radio"> 
																							3,000,000 원 </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="5000000" name="price" type="radio"> 
																							5,000,000 원 </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="10000000" name="price" type="radio"> 
																							10,000,000 원 </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="20000000" name="price" type="radio"> 
																							20,000,000 원</td>
																						</tr>
																						<tr>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="30000000" name="price" type="radio"> 
																							30,000,000 원 </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="50000000" name="price" type="radio"> 
																							50,000,000 원 </td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="70000000" name="price" type="radio"> 
																							70,000,000 원</td>
																							<td>
																							<input class="radio" onclick="input_price(event)" value="90000000" name="price" type="radio"> 
																							90,000,000 원</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>충전 금액</td>
																				<td >
																					<input name="cash" size="17" type="text" value="10,000" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value)" Information="Required" title="충전금액" class=input11>&nbsp;<font color="#FFC602">","와 숫자만 입력 하세요
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>입금자 이름</td>
																				<td >
																				<input name="Depos" size="17" type="text" Information="Required" title="입금자 이름" class=input11>&nbsp;<font color="#FFC602">※ 입금자 이름이 틀리면 입금 확인을 할수 가 없으니 주의하세요</font>
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
																		<input type=submit class="btn6" value="확 인" onclick="frmsSubmit();"  id=button3 name=button3>
																		<input type=button class="btn7" value="취 소" onclick="location.href='/';" id=button1 name=button1>
																		
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

<%@include file="../footer.jsp"%>