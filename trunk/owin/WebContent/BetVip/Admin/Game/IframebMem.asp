
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include virtual=/common/asp/MemberClass.asp		-->
<%
IntIdx		= Request("Idx")
pageSize	= reInt(Request("pageSize"),10)
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")
category	= Request("category")

Hits		= Request("Hits")
strId		= Request("Id")
senum		= Request("senum")
f_date		= Request("f_date")
t_date		= Request("t_date")
rMoney		= replace(Request("rMoney"),",","")

If Flag="MODIFY" Then
	SQL = "UPDATE BetGame_TB Set rMoney="& reInt(rMoney,0) &", ResuFlag="& Request("ResuFlag") &" WHERE gCnt='"& Request("gGcnt") &"'"
'	Response.Write SQL&"<BR>"
	RunSQL(SQL)
	
	AHits	= split(Hits,"@")
	For i=0 To Ubound(AHits)
		Bgoldhits	= split(AHits(i),"|")
		If Not isNone(AHits(i)) Then
			SQL = "UPDATE BetGame_TB Set GoldHit="& Bgoldhits(1) &" WHERE Idx='"& Bgoldhits(0) &"'"
'			Response.Write SQL&"<BR>"
			RunSQL(SQL)
		End If
	Next
'	Response.End	
'	Call MileageChange(Request("Id"), reInt(rMoney,0), "2")

	If Not isNone(Request("gGcnt")) Then
		HandGame = HandGameMisPointFlag(Request("gGcnt"))
		If HandGame = 1 Then
			Call GameMisPoint(Request("gGcnt"))
		End If
	End If


	If reInt(rMoney,0) > 0 Then
		Set Rss = RunSQLReturnRs("SELECT TOP 1 Id FROM BetGame_TB WHERE gCnt='"& Request("gGcnt") &"'")
		TCash = NowMileage(Rss("Id"), "Point")
		If Not ( Rss.EOF or Rss.BOF ) Then 
			Call CashChange(Rss("Id"), reInt(rMoney,0), 3, 1, "배팅적중 적립")
		End If
		Set Rss = Nothing
	End If


	Call descment("","IframebMem.asp?CurPage="& CurPage &"&CurBlock="& CurBlock &"&goPage="& CurPage &"&KeyField="& KeyField &"&KeyWord="& KeyWord &"&Idx="& IntIdx &"&Sect="& Sect &"&Id="& strId &"&senum="& senum &"&f_date="& f_date &"&t_date="& t_date,"")
End If

order = " Order By gCnt DESC "
SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE Visbled=0 And Id='"& strId &"'"
If isInt(senum) Then SQL = SQL &" And ResuFlag='"& senum &"' " 
If isInt(Sect) Then SQL = SQL &" And Sect='"& Sect &"'"
If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" And "& KeyField &" like '%"& KeyWord &"%'"
'SQL = " exec Admin_Game_bMem '"& Sect &"','"& KeyField &"','"& KeyWord &"'"
'Response.Write sql &"<br>"
SQL = SQL & order
Set objCon = getConnection
Set Rss = getRecordSet(objCon, SQL)
If Rss.EOF or Rss.BOF Then
	rsCount = -1
Else
    Rss.PageSize = pageSize
    Rss.AbsolutePage = CurPage
    rsCount = Rss.RecordCount
    gSeq = getReverseRow(pageSize, CurPage, rsCount)    
End If
g_pageCount = getPageSize(pageSize, rsCount)
If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//정렬방식 순서 변경
%>
<script language='javascript' src=/common/js/Calendar.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Id"]			= '<%=strId%>';
		getQuery["category"]	= '<%=category%>';
		getQuery["senum"]		= '<%=senum%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';
		getQuery["pageSize"]	= '<%=pageSize%>';
		
		getQuery["Idx"]			= gId;
		getQuery["cIdx"]		= gSe;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}

	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';	
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["SortColumn"]	= SortColumn;
		getQuery["Sort"]		= Sort;
		action('',window.location.pathname);
	}	
	
	function ListPageGo(PageIndex) {
		getQuery["CurPage"]		= PageIndex;
		getQuery["CurBlock"]	= '<%=CurBlock%>';	
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';	
		getQuery["KD1"]			= '<%=KD1%>';
		getQuery["KD2"]			= '<%=KD2%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["Id"]			= '<%=strId%>';
		getQuery["category"]	= '<%=category%>';
		getQuery["senum"]		= '<%=senum%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';
		getQuery["pageSize"]	= '<%=pageSize%>';
		action();
	}
	
	function UpdateGoldhit() {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Id"]			= '<%=strId%>';
		getQuery["category"]	= '<%=category%>';
		getQuery["senum"]		= '<%=senum%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';
		getQuery["pageSize"]	= '<%=pageSize%>';
		getQuery["ThisPage"]	= 'IiFramebMem.asp';
		
		getQuery["flag"]		= 'HITUPDATE';
		formLens();
		action('frmsgod','bMem_Prc.asp');
	}
	
	function ResuSubmit( ansno, sc1, sc2 ) {
		var f	= document.forms["reSultFrom_" + sc2];
		var fs	= document.forms["reSultFroms_" + sc1];
		var fss	= document.frmsgod;
		var ResuFlagVal = 0
		var goldHitVals = "";
		rMoney = fs.rMoney.value;
		goldHitVals = fss.goldhits.value;
		if (fs.ResuFlag[0].checked) {
			ResuFlagVal = 0
		} else {
			ResuFlagVal = 1
		}
			f.flag.value = "MODIFY";
			f.gGcnt.value = ansno;
			f.ResuFlag.value = ResuFlagVal;
			f.rMoney.value = rMoney;
			f.Hits.value = goldHitVals;
			f.action='IframebMem.asp';
			f.submit();
	}
	
	function allformSubmit(f) {
		var TmpAllBetVal	= "";
		var TmpallrSult		= "";
		var frml	= document.forms.length;
		var rMon = '';
		var gCnt = '';
		var Result = '';
		
		for(var i=1; i<=frml-1;i++) {

			var FFormName = document.forms[i].name;
			var atpoint = FFormName.indexOf('_'); 
			var SubFormName = FFormName.substring(0,atpoint);

			if (SubFormName == 'reSultFroms') {	
				rMon	= document.forms[i].rMoney.value;	
				gCnt	= document.forms[i].HidgCnt.value;
				if (document.forms[i].ResuFlag[0].checked) {
					Result = 0
				} else {
					Result = 1
				}
				
				TmpAllBetVal = TmpAllBetVal +'@'+gCnt+'|'+rMon;
				TmpallrSult = TmpallrSult +'@'+gCnt+'|'+Result;		
//				alert(Result)
			}			
		}
//		alert(frmsgod.goldhits.value)
		document.frmsgod.allrMoney.value = TmpAllBetVal;
		document.frmsgod.allrSult.value = TmpallrSult;
		document.frmsgod.flag.value = f;
		
	}
	
	
	function addResult(val) {
		
		var resu = document.frmsgod.goldhits.value;
		if (resu=="") {
			document.frmsgod.goldhits.value = val;
		} else {
			document.frmsgod.goldhits.value = resu+'@'+val;
		}
//		alert(document.frmsgod.goldhits.value);
	}
	
	function addGoldhit(val) {
		
		var goldhits = document.frmsgod.goldhits.value;
		if (goldhits=="") {
			document.frmsgod.goldhits.value = val;
		} else {
			document.frmsgod.goldhits.value = goldhits+'@'+val;
		}
//		alert(document.frmsgod.goldhits.value);
	}
	function delBet() {
		mdf = "";
		if(confirm('삭제 하시겠습니까?')) {
			if (document.all.md.checked) {
				mdf = ",UHiden = 1"
			} 
//			alert(mdf);return;
			location.href = 'List_Prc.asp?KeyWord=<%=KeyWord%>&KeyField=<%=KeyField%>&Sect='+document.all.Sect.value+'&f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&flag=BMEMDELETE'+'&Mdflag='+mdf;
		}
	}
	
function seArch() {
	var fdate = document.all.f_date.value;
	var tdate = document.all.t_date.value;
	var category = document.all.category.value;
	var senum = document.all.senum.value;
	alert(fdate);return;
	location.href = window.location.pathname+'?f_date='+fdate+'&t_date='+tdate+'&Id=<%=strId%>&category='+category+'&senum='+senum;
}
		
</script>

<body style="margin:0">
	<table width="980" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[<%=strId%>회원 배팅내역]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=frmses method=post action="IframebMem.asp">
					<input type=hidden name=Id value="<%=strId%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=senum>
								<option value="" >전체보기</option>
								<option value="0" <%=gSelection(senum,"0","selected")%>>정산전 내역</option>
								<option value="1" <%=gSelection(senum,"1","selected")%>>정산완료 내역</option>
								
							</select>
							&nbsp;&nbsp;&nbsp;
							<select name=Sect>
								<option value="" >전체보기</option>
								<option value="5" <%=gSelection(Sect,"5","selected")%>>승무패</option>
								<option value="1" <%=gSelection(Sect,"1","selected")%>>야구(핸디)</option>
								<option value="2" <%=gSelection(Sect,"2","selected")%>>축구(핸디)</option>
								<option value="3" <%=gSelection(Sect,"3","selected")%>>농구(핸디)</option>
								<option value="6" <%=gSelection(Sect,"6","selected")%>>기타(핸디)</option>
							</select>
							&nbsp;&nbsp;&nbsp;
							<input type="text" name="f_date" size="10" value="<%=f_date%>" maxlength="10" class="input10" onchange="ValidateDatetime(this.form, this.name);"> 
							<a href="javascript:Calendar_D(frmses.f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
							~
							<input type="text" name="t_date" size="10" value="<%=t_date%>" maxlength="10" class="input10" onchange="ValidateDatetime(this.form, this.name);"> 
							<a href="javascript:Calendar_D(frmses.t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
							&nbsp;&nbsp;&nbsp;
							<input type=submit value="검 색" class="btn2"  >
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type=button value="전체목록" class="btn4"  onclick="location.href=window.location.pathname+'?Id=<%=StrId%>';"  id=button8 name=button8>
						</td>
					</tr>
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:10pt">
						<td>
							<input type=button value="오늘" onfocus="this.blur();" onclick="BeforeDay(frmses,0);" class=btn1  >
							<input type=button value="어제" onfocus="this.blur();" onclick="BeforeDay(frmses,1);" class=btn1  >
							<input type=button value="3일간" onfocus="this.blur();" onclick="BeforeDay(frmses,3);" class=btn1  >
							<input type=button value="7일간" onfocus="this.blur();" onclick="BeforeDay(frmses,7);" class=btn1  >
							<input type=button value="10일간" onfocus="this.blur();" onclick="BeforeDay(frmses,10);" class=btn1 >
							<input type=button value="20일간" onfocus="this.blur();" onclick="BeforeDay(frmses,20);" class=btn1 >
							<input type=button value="30일간" onfocus="this.blur();" onclick="BeforeDay(frmses,31);" class=btn1 >
							<input type=button value="60일간" onfocus="this.blur();" onclick="BeforeDay(frmses,61);" class=btn1 >
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
							
						</td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
		
		<tr>
			<td>
					<table width="100%" border="0" cellspacing="1" cellpadding="0" align=center>
						<tr height="30" align="center" >
							
							<td>
<%
				If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
				Else
				    count = 0
				    Do Until Rss.EOF Or count >= pageSize
				AllbMoney	= 0
				AllrbMoney	= 0
				AllAllot	= 0
				AllhMoney	= 0

																	
				order = " ORDER BY Idx DESC"
				SQL = "SELECT Idx, Sect, Id, gName, convert(varchar(16),gsDate,120 ) As gsDat, hTname, hAllot, hCap, "
				SQL = SQL &" HcapAllotl, vTname, vAllot, gbTem, convert(varchar(16),WriteDay,120 ) As WriteDay, bMoney, "
				SQL = SQL &" ResuFlag, rMoney, goldhit, rtel, UHiden "
				'SQL = SQL &" FROM BetGame_TB b, Game_TB g WHERE g.Status=0 And g.Idx=b.gIdx And b.Id='"& Session("UId") &"' "
				SQL = SQL &" FROM BetGame_TB WHERE gCnt='"& Rss(0) &"' "
'				If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
				SQL = SQL & order
'				Response.Write sql &"<br>"
				Set objRs = RunSQLReturnRs(SQL)
%>		
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" >
						<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
								<tr height="30" align="center" bgcolor="#e0e0e0">
									<!--<td width="70"><nobr>Sect</td>-->
									<td width="90"><nobr>gCnt</td>
									<td width="90"><nobr>아이디</td>
									<td width="135"><nobr>베팅일시</td>
									<td width="135"><nobr>경기날짜</td>
									<td width="80"><nobr>종목</td>
									
									<td width="160"><nobr>승(홈팀)</td>
									<td width="75"><nobr>무/핸드캡</td>
									
									<td width="160"><nobr>(패)원정팀</td>
									<td width="50"><nobr>배팅팀</td>
									<td width="75"><nobr>경기결과</td>
									<td width="230"><nobr>적중유무</td>
									<!--<td width="100">배팅금액</td>
									<td width="60">삭제</td>-->
								</tr>

			<%

								If Not (objRs.EOF or objRs.BOF) Then
								    Do Until objRs.EOF
			%>
								<form  name="reSultFrom_<%=objRs("Idx")%>" >
								<input type=hidden name="Idx" value="<%=IntIdx%>">
								<input type=hidden name="KeyWord" value="<%=KeyWord%>">
								<input type=hidden name="KeyField" value="<%=KeyField%>">
								<input type=hidden name="flag" >
								<input type=hidden name="Sect" value="<%=Sect%>">
								<input type=hidden name=CurPage value="<%=CurPage%>">
								<input type=hidden name=CurBlock value="<%=CurBlock%>">
								<input type=hidden name=gGcnt value="<%=Rss("gCnt")%>">
								<input type=hidden name=Id value="<%=strId%>">
								<input type=hidden name=senum value="<%=senum%>">
								<input type=hidden name=f_date value="<%=f_date%>">
								<input type=hidden name=t_date value="<%=t_date%>">
								<input type=hidden name=ResuFlag >
								<input type=hidden name=rMoney >
								<input type=hidden name=Hits >
								
								<tr height="20" align=center <% If objRs("UHiden") Then %> bgcolor="#FFDCFF" <%Else%> bgcolor="#FFFFFF" <%End If%> onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
									<!--<td ><nobr><%=objRs("Sect")%></td>-->
									<td ><nobr><%=Rss(0)%></td>
									<td ><nobr><%=objRs("Id")%></td>
									<td ><nobr><%=objRs("WriteDay")%></td>
									<td ><nobr><%=objRs("gsDat")%></td>
									<td align=left ><nobr><%=objRs("gName")%></td>
									
									<td align="right"><nobr><%=objRs("hTname")%>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>
									<td ><nobr><%If objRs("Sect")=5 Then %>무&nbsp;<%=IfElse(objRs("HcapAllotl"),"0.00")%><%Else%><%=objRs("hCap")%><%End If %></td>
									<td align=left><nobr>&nbsp;<%=objRs("vAllot")%>&nbsp;<%=objRs("vTname")%></td>
									<td ><nobr><%If objRs("gbTem")=1 Then %>홈팀<%ElseIf objRs("gbTem")=2 Then%>원정팀<%Else%>무<%End If%></td>
									<td ><nobr><%=objRs("rtel")%></td>
									<td ><nobr><input type="radio" name="goldhit_<%=objRs("Idx")%>" value=0 onclick="addGoldhit('<%=objRs("Idx")%>|0');" <%=gSelection(objRs("goldhit"),0,"checked")%>>대기중&nbsp;<input type="radio" name="goldhit_<%=objRs("Idx")%>" value=2 onclick="addGoldhit('<%=objRs("Idx")%>|2');" <%=gSelection(objRs("goldhit"),2,"checked")%>>미적중&nbsp;<input type="radio" name="goldhit_<%=objRs("Idx")%>" value=1 onclick="addGoldhit('<%=objRs("Idx")%>|1');" <%=gSelection(objRs("goldhit"),1,"checked")%>>적중</td>
									
									<!--<td align="right"><%=formatnumber(objRs("bMoney"),[])%>&nbsp;</td>
									<td ><input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=objRs("Idx")%>','bMem_Prc.asp','DELETE','',''); }" ></td>-->
									</form>
								</tr>
<%


										AllbMoney	= AllbMoney+reInt(objRs("bMoney"),0)
										AllrbMoney	= reInt(objRs("rMoney"),0)

										betmoney	= objRs("bMoney")				
										Id		 = objRs("Id")
										rMoney	 = objRs("rMoney")
										ResuFlag = objRs("ResuFlag")
										sIdx = objRs("Idx")
									
										ThisGcnt = Rss(0)
										objRs.MoveNext
									Loop
									
										AllAllot	= getToAlot(ThisGcnt)
										AllhMoney	= Int(AllAllot*betmoney)
									End IF									
%>
								
							</table>
						</td>
					</tr>
					<tr>
						<td align=center bgcolor=FFFFFF>
							<table >
								<form  name="reSultFroms_<%=count%>" >
								<input type=hidden name=HidgCnt value="<%=Rss("gCnt")%>" >
								<input type=hidden name=Sect value="<%=Sect%>" >
								<tr>
						<%If senum="0" Then %>
							
									<td>
						배당율 : <%=formatnumber(AllAllot,2)%> / 배팅금액 : <%=formatnumber(betmoney,[])%> / 예상적중금액 : <%=formatnumber(AllhMoney,[])%> / 적중금액 : <input type=text name="rMoney" value="<%=formatnumber(AllrbMoney,[])%>" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value)" size=10>
									</td>
									<td>
										<input type=radio name=ResuFlag value=0 <%=gSelection(ResuFlag,0,"checked")%> >정산전
										<input type=radio name=ResuFlag value=1 <%=gSelection(ResuFlag,1,"checked")%> >완료
									</td>
									<td ><input type=button value="적용" onclick="ResuSubmit('<%=Rss("gCnt")%>','<%=count%>','<%=sIdx%>');">
										<!--<a href="javascript:MM_winopen('TemB.asp?gCnt=<%=Rss("gCnt")%>&Sect=<%=Sect%>','B','width=990,height=500,scrollbars=1');">임시정산</font>-->
									</td>
									<!--
									<td>
										<input type=button value="실제정립" onclick="MM_winopen('CashCh.asp?Id=<%=Id%>&Idx=<%=IntIdx%>','CA','width=400,height=300');" id=button1 name=button1>
									</td>
									-->
									<td>
										<input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=ThisGcnt%>','bMem_Prc.asp','DELETE','',''); }"  id=button2 name=button2>
									</td>
									
						<%Else%>			
						<input type=hidden name=rMoney value="<%=reInt(AllrbMoney,0)%>" >
									<td>배당율 : <%=formatnumber(AllAllot,2)%> / 배팅금액 : <%=formatnumber(betmoney,[])%> / 예상적중금액 : <%=formatnumber(AllhMoney,[])%> / 적중금액 : <%=formatnumber(reInt(AllrbMoney,0),[])%></td>
									<td>
										<input type=radio name=ResuFlag value=0 <%=gSelection(ResuFlag,0,"checked")%> >정산전
										<input type=radio name=ResuFlag value=1 <%=gSelection(ResuFlag,1,"checked")%> >완료
									</td>
									<td ><input type=button value="적용" onclick="ResuSubmit('<%=Rss("gCnt")%>','<%=count%>','<%=sIdx%>');"></td>
									<td>
										<input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=ThisGcnt%>','bMem_Prc.asp','DELETE','',''); }"  id=button2 name=button2>
									</td>	
						
						<%End If%>
								</form>		
								</tr>
								
							</table>
						</td>
					</tr>
					<tr><td bgcolor=FFFFFF height=20></td></tr>
				</table>
<%
				gSeq = gSeq - 1
				count = count + 1
		       Rss.MoveNext
		   Loop
		End IF
%>
				
			</td>
		</tr>
	</table>
			</td>
		</tr>
		<form name=frmsgod method=post action="bMem_Prc.asp">
		<input type=hidden name=goldhits>
		<input type=hidden name=allrMoney>
		<input type=hidden name=allrSult>
		<input type=hidden name=CurPage value="<%=CurPage%>">
		<input type=hidden name=CurBlock value="<%=CurBlock%>">
		<input type=hidden name=SortColumn value="<%=SortColumn%>">
		<input type=hidden name=strSort value="<%=strSort%>">
		<input type=hidden name=Sect value="<%=Sect%>">
		<input type=hidden name=ScFlag value="<%=ScFlag%>">
		<input type=hidden name=KeyField value="<%=KeyField%>">
		<input type=hidden name=KeyWord value="<%=KeyWord%>">
		<input type=hidden name=Id value="<%=strId%>">
		<input type=hidden name=senum value="<%=senum%>">
		<input type=hidden name=f_date value="<%=f_date%>">
		<input type=hidden name=t_date value="<%=t_date%>">
		<input type=hidden name=flag value="HITUPDATE">
		<input type=hidden name=ThisPage value="IframebMem.asp">

		<tr><td align=center>
			<input type=submit value="정산완료유무 일괄변경" onclick="if(confirm('정산완료유무 일괄변경 하시겠습니까?')){allformSubmit('HITUPDATERESULT');}" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type=submit value="적중유무 일괄변경" onclick="if(confirm('적중유무 일괄변경 하시겠습니까?')){allformSubmit('HITUPDATE');}">
			
		</td>
		</tr>
		
		
		</form>
		<tr>
			<td height=50>
				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
					<TR>
						<TD align=middle >
							<%=getPrintPaging(pageSize, CurPage, rsCount)%>
						</TD>				
					</TR>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
		