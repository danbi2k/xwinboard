<html>
<head>
<title>LeftMenu</title>
<link href="/common/CSS/Admin.css" type="text/css" rel="stylesheet">

<style>BODY {
	SCROLLBAR-FACE-COLOR: #f5f5f5; SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; SCROLLBAR-SHADOW-COLOR: #bbbbbb; SCROLLBAR-3DLIGHT-COLOR: #ffffff; SCROLLBAR-ARROW-COLOR: #666666; SCROLLBAR-TRACK-COLOR: #f5f5f5; SCROLLBAR-DARKSHADOW-COLOR: #f5f5f5
}
</style>
</head>
<body style="margin:0" >
<table cellSpacing="0" cellPadding="0" width="190" background="/Images/Admin/right_bg.gif" border="0">
	<tr>
		<td><img src="/Images/Admin/admin_title.gif"></td>
		<td><a href="Index.asp" target="_top"><img src="/Images/Admin/admin_title2.gif" border="0"></a></td></tr>
	<tr>
		<td>&nbsp;</td>
		<td vAlign="top" height="800">
			<table cellSpacing="0" cellPadding="3" width="160" align="center" border="0">

				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle"><a href="Logout.asp"><font color="#0aa0bb">로그아웃</font></a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="Edit.asp" target="mainFrame"><font color="#0aa0bb">비밀번호변경</font></a><br></td>
				</tr>
				<% If Session("SYS_Ssection")=0 Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>회원관리</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/MemberList.asp" target="mainFrame">회원 리스트</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/RainkList.asp" target="mainFrame">유저별 통계 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/SmsWrite.asp" target="mainFrame">SMS보내기 </a><br></td>
				</tr>
				<% If Session("SYS_ID")="IN" Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/SmsList.asp" target="mainFrame">SMS 내용리스트</a><br></td>
				</tr>
				<% End If %>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>중복아이피 관리</b></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/IpList.asp" target="mainFrame">아이피 리스트</a><br></td>
				</tr>
				
				<!--
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>부 운영자관리</b></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/SubAdminList.asp" target="mainFrame">부 운영자 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/SubAdminModify.asp?flag=WRITE" target="mainFrame">부 운영자 등록</a><br></td>
				</tr>
				-->
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>충전관리</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/CashList.asp?Sect=0" target="mainFrame">충전요청 리스트</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/CashList.asp?Sect=1" target="mainFrame">환전요청 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/ChCashList.asp?Sect=1" target="mainFrame">포인트전환 리스트</a><br></td>
				</tr>
				<% End If%>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>경기관리</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/LegList.asp" target="mainFrame">리그 리스트</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=5" target="mainFrame">승무패 리스트</a><br></td>
				</tr>
				<!--
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/MPList.asp" target="mainFrame">미적중포인트지급 리스트</a><br></td>
				</tr>
				-->
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=4" target="mainFrame">핸디캡 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=1" target="mainFrame">야구(핸디) 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=2" target="mainFrame">축구(핸디) 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=3" target="mainFrame">농구(핸디) 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=6" target="mainFrame">기타(핸디) 리스트</a><br></td>
				</tr>
				<% If Session("SYS_Ssection")=0 Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/CloseList.asp?ScFlag=2" target="mainFrame">마감경기 리스트</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/bMem2.asp?Sect=0" target="mainFrame">승무패 정산전배팅 리스트</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/bMem.asp?Sect=0" target="mainFrame">핸디캡 정산전배팅 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/EventbMem.asp?Sect=0" target="mainFrame">이벤트 정산전배팅 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/bMem.asp?Sect=1" target="mainFrame">정산완료 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				
				
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>배팅통계</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Sum/bSumList.asp" target="mainFrame">배팅 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Sum/bList.asp" target="mainFrame">배팅내역 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Sum/bDayList.asp" target="mainFrame">일자별 배팅내역 리스트</a><br></td>
				</tr>
				<% If Session("SYS_ID")="master" or Session("SYS_ID")="IN" Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Sum/Sum.asp" target="mainFrame">전체 통계</a><br></td>
				</tr>
				<% End If %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>게시판 관리</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/Board/List.asp?TableName=Community_TB&Sect=1" target="mainFrame">공지 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/Board/List.asp?TableName=Community_TB&Sect=2" target="mainFrame">자유게시판 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/Board/List.asp?TableName=Community_TB&Sect=3" target="mainFrame">고객센터 리스트</a><br></td>
				</tr>
				<% If Session("SYS_ID")="IN" Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/Board/InList.asp?TableName=Community_TB&Sect=3" target="mainFrame">dd</a><br></td>
				</tr>
				<% End If %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/hotnews/List.asp?TableName=Community_TB&Sect=4" target="mainFrame">HOTNEWS 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				
				
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>접속통계 관리</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countMain.asp" target="mainFrame">기본정보 </a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cmon&orderby=ASC&emptyStr=&ocolumn=cmon" target="mainFrame">월별통계 리스트</a><br></td>
				</tr>
				<!--
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cweek&orderby=ASC&emptyStr=&ocolumn=cweek" target="mainFrame">주별통계 리스트</a><br></td>
				</tr>
				-->
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cday&orderby=ASC&emptyStr=&ocolumn=cday" target="mainFrame">일별통계 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<!--
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=chour&orderby=ASC&emptyStr=&ocolumn=chour" target="mainFrame">시간대별통계 리스트</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=csite&orderby=ASC&emptyStr=즐겨찾기&ocolumn=cutCount" target="mainFrame">참조사이트통계 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=csearch&orderby=ASC&emptyStr=&ocolumn=cutCount" target="mainFrame">검색어통계 리스트</a><br></td>
				</tr>
								
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cos&orderby=ASC&emptyStr=알수없음&ocolumn=cutcount" target="mainFrame">운영체제통계 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cbrowser&orderby=ASC&emptyStr=알수없음&ocolumn=cutcount" target="mainFrame">브라우져통계 리스트</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				-->
				<% End If%>
			</table>
		</td>
	</tr>
</table>	
</body>
</html>










