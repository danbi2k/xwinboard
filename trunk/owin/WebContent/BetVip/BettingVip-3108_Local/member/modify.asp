<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<%
	Set objRs = RunSQLReturnRs("SELECT * FROM Member_TB WHERE Id='"& Session("UId") &"'")
	If objRs.EOF Then Call descment("잘못된 요청입니다.","/member/LogOut.asp","")
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
																							1. 회원은 회원가입시 필수정보를 반드시 입력해야 합니다.<br>
																							2. 아이디와 비밀버호에 대한 분실 책임은 회원 자신에게 있습니다.<br>
																							3. 배팅규정에 어긋난 여러 부정한 방법을 사용하는 회원은 그 피해에 대한 보든 책임이 있으며 관리자에 의해 제재 조치를 받을 수 있습니다.<br>
																							4. 서비스를 제공하는 회사는 완벽한 서비스를 할 의부가 있으며, 오류프로그램에 대한 보상을 책임이 있습니다.<br>
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
																				<font color=red>* 표시는는 필수 입력정보 입니다.
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
																				<td width=150 bgcolor="484848" align=right><font color=FFFFFF><b>아이디&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<b><%=Session("UId")%></td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>이름&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=text name="name" Information="Required" MaxBytes="15" title="이름" value="<%=objRs("Name")%>" class=input11 readonly> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>비밀번호&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=password name=pwd value="<%=objRs("Pwd")%>" Information="Required" MaxBytes="15" title="비밀번호" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>비밀번호 확인&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=password name=repwd value="<%=objRs("Pwd")%>" Information="Required" MaxBytes="15" title="비밀번호확인" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>휴대폰 번호&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=text size=4 value="<%=getInfo(objRs("Cell"),0,"-")%>" name=cell01 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11> - <input type=text size=4 value="<%=getInfo(objRs("Cell"),1,"-")%>" name=cell02 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11> - <input type=text size=4 value="<%=getInfo(objRs("Cell"),2,"-")%>" name=cell03 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11></td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>이메일&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=text value="<%=getInfo(objRs("mail"),0,"@")%>" name="mail01" Information="Required" MaxBytes="30" title="이메일" size=12 class=input11> @ <input type=text size=12 Information="Required" MaxBytes="50" title="이메일" value="<%=getInfo(objRs("mail"),1,"@")%>" name="mail02" class=input11>  
																				
																				<select class=select1 onchange="regfrm.mail02.value=this.value" name="mail03">
																					<option value="" selected>직접입력</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"naver.com","selected")%> value="naver.com">네이버</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"nate.com","selected")%> value="nate.com">네이트</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"dreamwiz.com","selected")%> value="dreamwiz.com">드림위즈</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"yahoo.com","selected")%> value="yahoo.co.kr">야후코리아</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"empal.com","selected")%> value="empal.com">엠파스</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"orgio.com","selected")%> value="orgio.net">오르지오</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"weppy.com","selected")%> value="weppy.com">웹피</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"unitel.com","selected")%> value="unitel.co.kr">유니텔</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"chollian.com","selected")%> value="chollian.net">천리안</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"korea.com","selected")%> value="korea.com">코리아닷컴</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"freechal.com","selected")%> value="freechal.com">프리챌</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"hitel.com","selected")%> value="hitel.net">하이텔</option>
																					<option <%=gSelection(getInfo(objRs("mail"),1,"@"),"hotmail.com","selected")%> value="hotmail.com">핫메일</option>
																				</select>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<% If Not isNone(objRs("BankN")) Then %> <input type=hidden name=BankN value="<%=objRs("BankN")%>"> <%End If%>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>충,환전정보&nbsp;&nbsp;</td>
																				<td>&nbsp;<font color=FFFFFF>충전 시 입금자 명:<input type=text name=CDepos <% If Not isNone(objRs("CDepos")) Then %> readonly <%End If%> value="<%=objRs("CDepos")%>" Information="Required" MaxBytes="15" title="충전 시 입금자 명" class=input11> &nbsp;<font color=red><b>충전시 입금자명 과 환전시 예금자명이 동일해야 합니다.</b><br>
																					&nbsp;<font color=FFFFFF>환전 시 계좌정보:
																					<select class=select1 name="BankN"  <% If Not isNone(objRs("BankN")) Then %> disabled <%End If%>  class=input5 Information="Required" title="거래은행">
																					<option value="" selected>선택</option>
																					<option <%=gSelection(objRs("BankN"),"신한","selected")%> value="신한">신한</option>
																					<option <%=gSelection(objRs("BankN"),"국민","selected")%> value="국민">국민</option>
																					<option <%=gSelection(objRs("BankN"),"주택","selected")%> value="주택">주택</option>
																					<option <%=gSelection(objRs("BankN"),"농협중앙","selected")%> value="농협중앙">농협중앙</option>
																					<option <%=gSelection(objRs("BankN"),"단위농협","selected")%> value="단위농협">단위농협</option>
																					<option <%=gSelection(objRs("BankN"),"우리","selected")%> value="우리">우리</option>
																					<option <%=gSelection(objRs("BankN"),"조흥","selected")%> value="조흥">조흥</option>
																					<option <%=gSelection(objRs("BankN"),"외환","selected")%> value="외환">외환</option>
																					<option <%=gSelection(objRs("BankN"),"하나","selected")%> value="하나">하나</option>
																					<option <%=gSelection(objRs("BankN"),"한미","selected")%> value="한미">한미</option>
																					<option <%=gSelection(objRs("BankN"),"제일","selected")%> value="제일">제일</option>
																					<option <%=gSelection(objRs("BankN"),"서울","selected")%> value="서울">서울</option>
																					<option <%=gSelection(objRs("BankN"),"기업","selected")%> value="기업">기업</option>
																					<option <%=gSelection(objRs("BankN"),"평화","selected")%> value="평화">평화</option>
																					<option <%=gSelection(objRs("BankN"),"우체국","selected")%> value="우체국">우체국</option>
																					<option <%=gSelection(objRs("BankN"),"경남","selected")%> value="경남">경남</option>
																					<option <%=gSelection(objRs("BankN"),"광주","selected")%> value="광주">광주</option>
																					<option <%=gSelection(objRs("BankN"),"대구","selected")%> value="대구">대구</option>
																					<option <%=gSelection(objRs("BankN"),"부산","selected")%> value="부산">부산</option>
																					<option <%=gSelection(objRs("BankN"),"산업","selected")%> value="산업">산업</option>
																					<option <%=gSelection(objRs("BankN"),"수협","selected")%> value="수협">수협</option>
																					<option <%=gSelection(objRs("BankN"),"전북","selected")%> value="전북">전북</option>
																					<option <%=gSelection(objRs("BankN"),"제주","selected")%> value="제주">제주</option>
																					<option <%=gSelection(objRs("BankN"),"씨티","selected")%> value="씨티">씨티</option>
																					<option <%=gSelection(objRs("BankN"),"암로","selected")%> value="암로">암로</option>
																					<option <%=gSelection(objRs("BankN"),"도이치","selected")%> value="도이치">도이치</option>
																					<option <%=gSelection(objRs("BankN"),"HSBC","selected")%> value="HSBC">HSBC</option>
																					<option <%=gSelection(objRs("BankN"),"상와","selected")%> value="상와">상와</option>
																					<option <%=gSelection(objRs("BankN"),"BOA","selected")%> value="BOA">BOA</option>
																					<option <%=gSelection(objRs("BankN"),"새마을","selected")%> value="새마을">새마을</option>
																					<option <%=gSelection(objRs("BankN"),"신용협동","selected")%> value="신용협동">신용협동</option>
																					<option <%=gSelection(objRs("BankN"),"상호저축","selected")%> value="상호저축">상호저축</option>
																					</select>
																					계좌번호 : <input type=text name=BankNum <% If Not isNone(objRs("BankNum")) Then %> readonly <%End If%> value="<%=objRs("BankNum")%>" Information="Required" MaxBytes="25" title="계좌번호" size=30 class=input11> &nbsp;
																					예금주 : <input type=text name=RDepos <% If Not isNone(objRs("RDepos")) Then %> readonly <%End If%> value="<%=objRs("RDepos")%>" Information="Required" MaxBytes="15" title="예금주" size=10 class=input11> &nbsp;
																				
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>SMS 수신여부&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=radio name=gSms title="SMS 수신여부" value=1 <%=gSelection(objRs("gSms"),1,"checked")%>> &nbsp;<font color=FFFFFF> SMS 수신&nbsp;&nbsp;<input type=radio name=gSms title="SMS 수신여부" value=0 <%=gSelection(objRs("gSms"),0,"checked")%>> &nbsp;<font color=FFFFFF> SMS 거부</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			
																			<tr>
																				<td colspan=3 align=center height=45>
																					<input type=submit class="btn6" value="정보수정" id=submit1 name=submit1>
																					<input type=button class="btn7" value="수정취소" onclick="location.href='/';" id=button1 name=button1>
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