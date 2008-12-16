<!--	#include virtual="/Admin/top.asp"					-->
<%
	If Request("flag") ="MODIFY" Then
		RunSQL("UPDATE Admin_TB Set SPwd='"& reString(Request("pwd"),"sql") &"' WHERE sId='"& Session("SYS_ID") &"'")
		Call CloseDB()
		Call descment("수정되었습니다.","Edit.asp","")
	End If
%>
<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[비밀번호 변경]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<form name="frms" method="post" onsubmit="return DefaultFormValidation(this);" action="Edit.asp?flag=MODIFY">
					<tr>
						<td>
							<table border='0' align='center'>
								<tr>
									<td><br><br><br>
										<table width="500" align=center bgcolor="#f7f7f7" cellpadding="5" cellspacing="1" border="0">
											<tr>
												<td>
													<table width="50" align=center bgcolor="#dddddd" cellpadding="10" cellspacing="1" border="0">
														<tr>
															<td bgcolor="#ffffff">
																<table width="450" border=0 align='left'>
																	<tr>
																		<td><font class='blue'>+ 변경할 패스워드</font></td>
																	</tr>
																	<tr>
																		<td align="left">
																			<table bgcolor="#dddddd" cellpadding="5" cellspacing="1" border="0" >
																				<tr>
																					<td width="70" bgcolor="f7f7f7"><img src='/Images/Admin/icon01.gif'>&nbsp;<font color='000000'>패스워드</font></td>
																					<td width="100" bgcolor="#ffffff"><input type=text name="pwd" class='simpleform' maxlength=15 size='12' Information="Required" title="패스워드"></tD>
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
								<tr>
									<td align=center><input type=image src='/Images/Admin/button_modify.gif' border=0></a></td>
								</tr>
							</table>					
						</td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>


