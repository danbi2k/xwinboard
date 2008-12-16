<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.infra.util.*" %>

 				</div>
			</div>   
		</div>
		<div id="function" class="boxed" align="center" bgcolor="white">
			<input type="button" value="로그아웃" onclick="logOut()"/>
		</div>
		<div id="board" class="boxed">
			<h2 class="heading">게시판관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminQna.php?mode=viewQnaList&grade=1">고객센터</a></li>
					<li><a href="adminQna.php?mode=viewQnaList&grade=10">고객센터 (VIP)</a></li>
					<li><a href="adminBoard.php?mode=viewBoardList&grade=1">게시판</a></li>
					<li><a href="adminBoard.php?mode=viewBoardList&grade=10">게시판 (VIP)</a></li>
					<li><a href="admin.php?mode=viewPopup">긴급공지</a></li>
					<li><a href="admin.php?mode=viewNotice">Notice</a></li>
				</ul>
			</div>
		</div>
		<div id="money" class="boxed">
			<h2 class="heading">충환전관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminAccount.php?mode=viewMoneyInList&status=MC001">충전요청</a></li>
					<li><a href="adminAccount.php?mode=viewMoneyOutList&status=ME001">환전요청</a></li>
					<li><a href="adminAccount.php?mode=viewMoneyInOutList&status=002">충환전내역</a></li>
					<li><a href="adminAccount.php?mode=viewMoneyInOutList&status=004">직충전차감내역</a></li>
					<li><a href="adminTran.php?mode=viewTransactionList">입출금내역</a></li>
				</ul>
			</div>
		</div>
		<div id="betting" class="boxed">
			<h2 class="heading">배팅관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminBetting.php?mode=viewBettingList">사용자배팅현황</a></li>
					<li><a href="adminBetting.php?mode=viewBettingMoneyList">경기별배팅현황</a></li>
				</ul>
			</div>
		</div>
		<div id="game" class="boxed">
			<h2 class="heading">경기관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminGame.php?mode=viewGameList&type=wdl&grade=<%=Code.USER_GRADE_NORMAL%>">승무패</a></li>
					<li><a href="adminGame.php?mode=viewGameList&type=handy&grade=<%=Code.USER_GRADE_NORMAL%>">핸디캡</a></li>
					<li><a href="adminGame.php?mode=viewGameList&type=wdl&grade=<%=Code.USER_GRADE_VIP%>">이벤트</a></li>
					<li><a href="adminGame.php?mode=viewEndGameList&type=wdl&grade=<%=Code.USER_GRADE_NORMAL%>">경기결과(승무패)</a></li>
					<li><a href="adminGame.php?mode=viewEndGameList&type=handy&grade=<%=Code.USER_GRADE_NORMAL%>">경기결과(핸디캡)</a></li>
					<li><a href="adminGame.php?mode=viewEndGameList&type=wdl&grade=<%=Code.USER_GRADE_VIP%>">경기결과(이벤트)</a></li>
					<li><a href="adminLeague.php?mode=viewLeagueList">리그관리</a></li>
				</ul>
			</div>
		</div>
		<div id="member" class="boxed">
			<h2 class="heading">회원관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminMember.php?mode=viewAdminMember&status=US001">회원목록</a></li>
					<li><a href="adminMember.php?mode=viewAccessList">접속기록</a></li>
				</ul>
			</div>
		</div>
		<div id="stat" class="boxed">
			<h2 class="heading">통계보기</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminStat.php?mode=viewDailyBettingMoneySummary">일일정산내역</a></li>
					<li><a href="adminStat.php?mode=viewDailyMemberMoneySummary">일일유저보유액</a></li>
					<li><a href="adminStat.php?mode=viewMoneyOutStat">환전계좌내역</a></li>
					<li><a href="adminStat.php?mode=viewMemberStat">회원현황</a></li>
					<li><a href="adminStat.php?mode=viewMemberLogin">로그인현황</a></li>
				</ul>
			</div>
		</div>
		<div id="server" class="boxed">
			<h2 class="heading">서버관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminInfo.php?mode=viewSecurity">보안설정</a></li>
					<li><a href="adminInfo.php?mode=viewBonus">보너스설정</a></li>
					<li><a href="adminInfo.php?mode=viewAdminInfo">관리자정보</a></li>
					<li><a href="admin.php?mode=viewBankBookList">통장관리</a></li>
					<li><a href="adminSms.php?mode=viewSendSms">SMS전송</a></li>
					<li><a href="adminLog.php?mode=viewHackingLog">해킹탐지</a></li>
					<!--li><a href="#">기본값관리</a></li -->
					<!--li><a href="#">아이피차단</a></li  -->
				</ul>
			</div>
		</div>
	</div>
	<div id="footer">
		<BR><BR><BR>
		<!-- p>Copyright &copy; 2008 No1Bet</strong></a></p -->
	</div>
</div>
<script>
function logOut()
{
	if (confirm("로그아웃 하시겠습니까?")) {
		location.href='adminLogin.php?mode=processLogout';
	}
}

function reload()
{
	location.reload();
}

checkIndi();
setInterval("checkIndi()", 10000);
setInterval("reload()", 600000);
</script>
</body>
</html>