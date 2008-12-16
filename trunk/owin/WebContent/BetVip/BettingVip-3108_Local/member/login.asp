<!--	#include virtual=/common/asp/top.asp	-->
    <tr>
        <td width="866" height="13">

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="237" valign="top">
                        <!--	#include virtual=/common/asp/left.asp	-->
					</td>
                    <td valign="top" style="padding-left:8pt">
                        <table border="0" cellpadding="0" cellspacing="0" width=700>
                            <tr>
                                <td height=30><img src=/images/icon_arr.gif><font color=898989>현재위치 : <a href="/">메인화면</a> > <font color=6C6C6C><b>로그인</td>
                            </tr>
                            <tr>
                                <td height=1 bgcolor=DADADA></td>
                            </tr>
                            <tr>
								<td>
									<table border="0" cellpadding="0" cellspacing="0" width=700>
										<tr>
											<td><img src=/images/mem03.gif></td>
										</tr>
										<tr>
											<td background=/images/mem06.gif style="padding-left:115pt">
												<table width=300 border="0" cellpadding="0" cellspacing="0" >
												<form name=regfrm method=post action="Login_Prc.asp" onsubmit="return DefaultFormValidation(this);" >
												<input type=hidden name="refPage" value="<%=Request("refPage")%>">
													<tr>
														<td align=center>
															<table border="0" cellpadding="0" cellspacing="0" >
																<tr><td height=15></td></tr>
																<tr>
																	<td><img src=/images/mem04.gif></td>
																	<td>
																		<input type=text size=15 name=fid Information="Required" MaxBytes="15" title="아이디"  class=input7>
																	</td>
																	<td rowspan=2>&nbsp;<input type=image src=/images/btn_login.gif></td>
																</tr>
																<tr>
																	<td><img src=/images/mem05.gif></td>
																	<td>
																		<input type=password size=15 class=input7 name=fpwd Information="Required" MaxBytes="15" title="비밀번호" >
																	</td>
																</tr>
																</form>
															</table>
														</td>
													</tr>
													<tr><td height=30></td></tr>
													<tr><td height=1 colspan=3 bgcolor=DEDEDE></td></tr>
												</table>
											
											</td>
										</tr>
										<tr>
											<td><img src=/images/mem07.gif></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr><td height=50></td></tr>
							<tr>
								<td>
									<table width=300 border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td align=center>
												<img src=/images/mem08.gif>
											</td>
											<td align=center>
												<a href="/member/agree.asp"><img src=/images/btn_reg.gif></a>
											</td>
											<td align=center>
												<img src=/images/mem09.gif>
											</td>
											<td align=center>
												<a href="/member/idpw.asp"><img src=/images/btn_fid2.gif>
											</td>
										</tr>
										<tr>
											<td align=center colspan=2>
												<img src=/images/mem10.gif>
											</td>
											<td align=center colspan=2>
												<img src=/images/mem11.gif>
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
