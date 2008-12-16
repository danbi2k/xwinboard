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
			alert("금액은 만원단위로 입력하십시오.");
			frms.cash.focus();
			return;
		}

		if(frms.cash.value > <%=reInt(Session("UPoint"),0)%>) {
			alert("환전금액은 보유금액이하로 입력하십시오.");
			frms.cash.focus();
			return;
		}
		if(confirm("환전 신청하시겠습니까?"))
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
																				<td><input type=button class="btn11" value="캐쉬환전 요청" >&nbsp;</td>
																				<td><input type=button class="btn13" value="캐쉬환전 내역" onclick="location.href='ReCashList.asp';"  id=button2 name=button2></td>
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
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>주의 사항&nbsp;&nbsp;</td>
																				<td  ><br>
																				※24시간 자유롭게 입.출금이 가능하며 최장3분소요 단 23:00부터24:30분까지는 타행이체불가 
																				<br>&nbsp;&nbsp;환전은 신청즉시 아이디에서 차감됩니다<br>
																				※10분이상 입금이 지연될시 회원님 계좌정보를 잘못 기입한 경우가 많습니다 그럴경우 상단메뉴 
																				<br>&nbsp;&nbsp;고객센타로 계좌정보를 정확히 보네주세요.
																				<br>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>보유 금액&nbsp;&nbsp;</td>
																				<td ><b><%=formatnumber(reInt(Session("UPoint"),0),[])%> 원</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  >
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>환전 금액&nbsp;&nbsp;</td>
																				<td  ><font color=000000>
																					<input name="cash" type="text" size="30" class=input11 validator="num" kname="환전 금액">&nbsp;
																					<font color="#FFFFFF">원</font><font color="#FFC602"> ( 최저 10,000 원 부터 만원 단위만 환전 가능 )</font>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr  height=100>
																				<td bgcolor="484848" align=right><font color=FFFFFF><b>입금 받으실 계좌&nbsp;&nbsp;</td>
																				<td  >
																					&nbsp;&nbsp;- 거래은행&nbsp;&nbsp; </font>
																					<select class=select1 name="bank01"  class=input5 validator="nn" kname="거래은행">
																					<option value="" selected>선택</option>
																					<option value="신한">신한</option>
																					<option value="국민">국민</option>
																					<option value="주택">주택</option>
																					<option value="농협중앙">농협중앙</option>
																					<option value="단위농협">단위농협</option>
																					<option value="우리">우리</option>
																					<option value="조흥">조흥</option>
																					<option value="외환">외환</option>
																					<option value="하나">하나</option>
																					<option value="한미">한미</option>
																					<option value="제일">제일</option>
																					<option value="서울">서울</option>
																					<option value="기업">기업</option>
																					<option value="평화">평화</option>
																					<option value="우체국">우체국</option>
																					<option value="경남">경남</option>
																					<option value="광주">광주</option>
																					<option value="대구">대구</option>
																					<option value="부산">부산</option>
																					<option value="산업">산업</option>
																					<option value="수협">수협</option>
																					<option value="전북">전북</option>
																					<option value="제주">제주</option>
																					<option value="씨티">씨티</option>
																					<option value="암로">암로</option>
																					<option value="도이치">도이치</option>
																					<option value="HSBC">HSBC</option>
																					<option value="상와">상와</option>
																					<option value="BOA">BOA</option>
																					<option value="새마을">새마을</option>
																					<option value="신용협동">신용협동</option>
																					<option value="상호저축">상호저축</option>
																					</select>
																						&nbsp;&nbsp; ※ 입금 받으실 계좌의 은행을 선택 할 수 있습니다<br>
																						&nbsp; - 계좌번호&nbsp;&nbsp; </font> 
																					<input name="bank02" type="text" size="30" class=input11 validator="nn" kname="계좌번호">
																					&nbsp; <font color="#FFC602">※ 본인 명의의 계좌번호를 입력하세요</font><br>
																					
																					&nbsp; - 예금주 &nbsp;&nbsp;&nbsp;&nbsp; 
																					<input name="Depos" type="text" size="30" class=input11 validator="nn" kname="예금주">
																					&nbsp; <font color="#FFC602">※ 예금주의 이름을 정확히 입력하셔야 합니다</font>
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
																		<input type=button class="btn6" value="확 인" onclick="frmsSubmit();" >
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
<!--	#include virtual=/common/asp/bottom.asp	-->										