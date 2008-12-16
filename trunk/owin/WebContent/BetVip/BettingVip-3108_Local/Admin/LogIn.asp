
<HTML>
<HEAD>
<TITLE>관리자모드</TITLE>
<META http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<SCRIPT language='javascript' src=/common/js/common.js></SCRIPT>
<LINK href="/common/CSS/Admin.css" type=text/css rel=stylesheet>
</HEAD>
<BODY leftMargin=0 background="/images/Admin/bg_1.gif" topMargin=0 marginheight="0" marginwidth="0" onload="document.frms.Idd.focus();">
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
	<TR><TD background="/images/Admin/top1_bg.gif" height=30></TD></TR>
	<TR><TD ALIGN="CENTER" bgColor=#18415a height=30><IMG src="/images/Admin/bar_main.gif"></TD></TR>
	<TR><TD height=50></TD></TR>
	<TR>
		<TD>
			<TABLE cellSpacing=1 cellPadding=5 width=350 align=center bgColor=#eeeeee border=0>
				<TR>
					<TD>
						<TABLE cellSpacing=1 cellPadding=5 width=350 align=center bgColor=#cccccc border=0>
							<FORM name=frms onsubmit="return DefaultFormValidation(this);" action="LoginProcess.asp" method=post>
							<TR>
								<TD bgColor=#ffffff>
									<TABLE cellSpacing=0 cellPadding=0 width=250 align=center border=0>
										<TR bgColor=#ffffff>
											<TD align=right width=80 height=30><B>아이디</B></TD>
											<TD align=center><INPUT size=15 class=simpleform name=Idd Information="Required" title="아이디"></TD>
										</TR>
										<TR bgColor=#ffffff>
											<TD align=right width=80 height=30><B>비밀번호</B></TD>
											<TD align=center><INPUT type=password class=simpleform size=15 name=pwdd Information="Required" title="비밀번호"></TD>
										</TR>
										<TR><TD colSpan=2 height=10></TD></TR>
										<TR><TD bgColor=#e5e5e5 colSpan=2 height=1></TD></TR>
										<TR><TD colSpan=2 height=10></TD></TR>
										<TR>
											<TD ALIGN="CENTER" colSpan=2 height=40><INPUT type=image src="/images/Admin/button_login.gif"></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							</FORM>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>
</BODY>
</HTML>