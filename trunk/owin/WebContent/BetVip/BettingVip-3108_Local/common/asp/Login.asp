<%
	Session("UMoney") = NowMileage(Session("UId"), "gMoney")
	Session("UMileage") = NowMileage(Session("UId"), "Mileage")
	Session("Nname") = NowMileage(Session("UId"), "nicName")
	
%>
<table width="220" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                    <td align="center">
						<% If isNone(Session("UId")) Then%>
                        <table width="206" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td><img src="../images/login01.jpg" width="206" height="43"></td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="206" border="0" cellspacing="0" cellpadding="0">
										<form name=llogs method=post action="/member/Login_Prc.asp" onsubmit="return DefaultFormValidation(this);">
										
                                        <tr>
                                            <td width="18"><img src="../images/login03.jpg" width="18" height="99"></td>
                                            <td>
                                                <table width="171" border="0" cellpadding="0" cellspacing="0" bgcolor="#F3F8FC">
                                                    <tr>
                                                        <td>
                                                            <table width="171" border="0" cellspacing="0" cellpadding="0">
                                                                <tr> 
                                                                    <td><img src="../images/login05.jpg" width="9" height="5"></td>
                                                                    <td width="5">&nbsp;</td>
                                                                    <td width="5"> 
																		<input type="text" name="idd" tabindex=1 size="12" style="border:1px solid #D4D4D4;" Information="Required" MaxBytes="20" title="아이디">    
																	</td>
                                                                    <td width="4">&nbsp;</td>
                                                                    <td width="52" rowspan="3"><input type=image src="/images/login07.jpg" tabindex=3 width="52" height="43" id=image1 name=image1></td>
                                                                </tr>
                                                                <tr> 
                                                                    <td height="3"> </td>
                                                                    <td height="3"> </td>
                                                                    <td height="3"> </td>
                                                                    <td height="3"> </td>
                                                                </tr>
                                                                <tr> 
                                                                    <td width="11"><img src="../images/login06.jpg" width="11" height="5"></td>
                                                                    <td>&nbsp;</td>
                                                                    <td width="5">
																		<input type="password" name="pwdd" size="12" style="border:1px solid #D4D4D4;" tabindex=2 Information="Required" MaxBytes="15" title="비밀번호">    
																	</td>
                                                                    <td>&nbsp;</td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr><td height="2"> </td></tr>
                                                    <tr>
                                                        <td>
                                                            <table width="168" border="0" cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td width="82"><a href="/member/id_find.asp"><img src="../images/login08.jpg" width="82" height="23" border="0"></a></td>
                                                                    <td>&nbsp;</td>
                                                                    <td width="82"><a href="/member/pw_find.asp"><img src="../images/login09.jpg" width="82" height="23" border="0"></a></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr><td height="3"> </td></tr>
                                                    <tr>
                                                        <td><a href="/member/agreement.asp"><img src="../images/login10.jpg" width="167" height="22" border="0"></a></td>
                                                    </tr>
                                                </table>
												
											</td>
											    <td width="17" background="../images/login04.jpg" width="17" height="99"></td>
										</tr>
                                        </form>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td><img src="../images/login02.jpg" width="206" height="22"></td>
                            </tr>
                        </table>
                        <% Else%>
                        <table width="206" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                                <td><img src="../images/login_out01.jpg" width="206" height="12"></td>
                            </tr>
                            <tr> 
                                <td>
                                
                                    <table width="206" border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                            <td width="9"><img src="../images/login_out02.jpg" width="9" height="143"></td>
                                            <td>
                                                <table width="190" border="0" cellspacing="0" cellpadding="0">
                                                    <tr> 
                                                        <td>
                                                            <table width="88" border="0" cellspacing="0" cellpadding="0">
                                                                <tr> 
                                                                    <td width="88"><img src="/images/avata/<%=MyViewAvata(Session("UId"))%>" width="88" height="130"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            <table width="102" border="0" cellspacing="0" cellpadding="0">
                                                                <tr> 
                                                                    <td>
                                                                        <table width="102" border="0" cellspacing="0" cellpadding="0">
                                                                            <tr> 
                                                                                <td>
                                                                                    <table width="102" border="0" cellspacing="0" cellpadding="0">
                                                                                        <tr> 
                                                                                            <td>
                                                                                                <table width="102" border="0" cellspacing="0" cellpadding="0">
                                                                                                    <tr> 
                                                                                                        <td width="15" valign="top">+</td>
                                                                                                        <td><%=Session("UId")%><br>[<%=Session("Nname")%>]</td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr> 
                                                                                <td><img src="../images/login_out05.jpg" width="100" height="1"></td>
                                                                            </tr>
                                                                            <tr> 
                                                                                <td>
                                                                                    <table width="102" border="0" cellspacing="0" cellpadding="0">
                                                                                        <tr> 
                                                                                            <td width="15">+ </td>
                                                                                            <td width="14"><img src="../images/login_out06.jpg" width="12" height="12"></td>
                                                                                            <td width="5">&nbsp;</td>
                                                                                            <td height="20"> 
                                                                                                <table width="65" border="0" cellspacing="3" cellpadding="0">
                                                                                                    <tr>
                                                                                                        <td>: <%=formatnumber(Session("UMoney"),[])%> 콩</td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr> 
                                                                                <td><img src="../images/login_out05.jpg" width="100" height="1"></td>
                                                                            </tr>
                                                                            <tr> 
                                                                                <td>
                                                                                    <table width="102" border="0" cellspacing="0" cellpadding="0">
                                                                                        <tr> 
                                                                                            <td width="15">+</td>
                                                                                            <td width="14"><img src="../images/login_out07.jpg" width="9" height="9"></td>
                                                                                            <td width="5">&nbsp;</td>
                                                                                            <td height="20"> 
                                                                                                <table width="65" border="0" cellspacing="3" cellpadding="0">
                                                                                                    <tr>
                                                                                                        <td>: <%=Session("UMileage")%> 점</td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr> 
                                                                                <td><img src="../images/login_out05.jpg" width="100" height="1"></td>
                                                                            </tr>
                                                                            <!--
                                                                            <tr> 
                                                                                <td>
                                                                                    <table width="102" border="1" cellspacing="0" cellpadding="0">
                                                                                        <tr>
                                                                                            <td width="15">+</td>
                                                                                            <td width="14"><img src="../images/login_out08.jpg" width="14" height="14"></td>
                                                                                            <td width="5">&nbsp;</td>
                                                                                            <td height="23"> 
                                                                                                <table width="65" border="0" cellspacing="3" cellpadding="0">
                                                                                                    <tr>
                                                                                                        <td>: 0&Agrave;&aring;</td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            -->
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr> 
                                                                    <td align="center"> 
                                                                        <table width="98" border="0" cellspacing="0" cellpadding="0">
                                                                            <tr>
                                                                                <td height="4"> </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="/myinfo/myinfo.asp"><img src="../images/login_out09.jpg" width="98" height="15"></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td height="3"> </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="/member/Logout.asp"><img src="../images/login_out10.jpg" width="98" height="15"></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="7"><img src="../images/login_out03.jpg" width="7" height="143"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr> 
                                <td><img src="../images/login_out04.jpg" width="206" height="10"></td>
                            </tr>
                        </table>
                        
                        
                        <% End If%>
                        
                    </td>
                </tr>
            </table>