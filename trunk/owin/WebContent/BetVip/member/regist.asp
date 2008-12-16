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
																			<form name=regfrms method=post action="Register_Prc.asp" onsubmit="return DefaultFormValidation(this);" >
																			<input type=hidden name=hrcode value="<%=rCode%>">
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td width=150 bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>아이디&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=text name=id Information="Required" MaxBytes="15" title="아이디" class=input11> 
																				<input type=button class="btn6" value="중복확인" onclick="javascript:checkIds();">
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>이름&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=text name="name" Information="Required" MaxBytes="15" title="이름" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>비밀번호&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=password name=pwd Information="Required" MaxBytes="15" title="비밀번호" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>비밀번호 확인&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=password name=repwd Information="Required" MaxBytes="15" title="비밀번호확인" class=input11> </td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>휴대폰 번호&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=text size=4 name=cell01 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11> <font color=FFFFFF>- <input type=text size=4 name=cell02 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11> - <input type=text size=4 name=cell03 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11></td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>이메일&nbsp;&nbsp;</td>
																				<td>&nbsp;<input type=text name="mail01" Information="Required" MaxBytes="30" title="이메일" size=12 class=input11> <font color=FFFFFF>@ <input type=text size=12 Information="Required" MaxBytes="50" title="이메일" name="mail02" class=input11>  
																				
																				<select class=select1 onchange="regfrm.mail02.value=this.value" name="mail03">
																					<option value="" selected>직접입력</option>
																					<option value="naver.com">네이버</option>
																					<option value="nate.com">네이트</option>
																					<option value="dreamwiz.com">드림위즈</option>
																					<option value="yahoo.co.kr">야후코리아</option>
																					<option value="empal.com">엠파스</option>
																					<option value="orgio.net">오르지오</option>
																					<option value="weppy.com">웹피</option>
																					<option value="unitel.co.kr">유니텔</option>
																					<option value="chollian.net">천리안</option>
																					<option value="korea.com">코리아닷컴</option>
																					<option value="freechal.com">프리챌</option>
																					<option value="hitel.net">하이텔</option>
																					<option value="hotmail.com">핫메일</option>
																				</select>
																				</td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr height=30>
																				<td bgcolor="484848" align=right><font color=red>*</font> <font color=FFFFFF><b>자동가입 방지코드&nbsp;&nbsp;</td>
																				
																				<td>&nbsp;<input type=text name=rcode Information="Required" MaxBytes="15" title="자동가입 방지코드" class=input11> &nbsp;<font color=red><b><%=rCode%></b></td>
																			</tr>
																			<tr><td colspan=3 height=1 bgcolor=383838></td></tr>
																			<tr>
																				<td colspan=3 align=center height=45>
																					<input type=submit class="btn6" value="회원가입">
																					<input type=button class="btn7" value="가입취소" onclick="location.href='/';">
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