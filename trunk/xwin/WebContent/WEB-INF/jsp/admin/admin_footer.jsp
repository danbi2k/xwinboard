<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 				</div>
			</div>   
		</div>
		<div id="function" class="boxed" align="center" bgcolor="white">
			<input type="button" value="로그아웃" onclick="logOut()"/>
		</div>
		<div id="game" class="boxed">
			<h2 class="heading">경기관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminGame.aspx?mode=viewGameList&type=wdl">승무패</a></li>
					<li><a href="adminGame.aspx?mode=viewGameList&type=handy">핸디캡</a></li>
					<li><a href="adminLeague.aspx?mode=viewLeagueList">리그관리</a></li>
					<li><a href="adminGame.aspx?mode=viewEndGameList&type=wdl">경기결과(승무패)</a></li>
					<li><a href="adminGame.aspx?mode=viewEndGameList&type=handy">경기결과(핸디캡)</a></li>
				</ul>
			</div>
		</div>
		<div id="money" class="boxed">
			<h2 class="heading">충환전관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminAccount.aspx?mode=viewMoneyInList&status=MC001">충전요청</a></li>
					<li><a href="adminAccount.aspx?mode=viewMoneyOutList&status=ME001">환전요청</a></li>
					<li><a href="adminAccount.aspx?mode=viewMoneyInList&status=MC002">충전내역</a></li>
					<li><a href="adminAccount.aspx?mode=viewMoneyOutList&status=ME002">환전내역</a></li>
					<li><a href="adminAccount.aspx?mode=viewMoneyInList&status=MC004">직충전내역</a></li>
					<li><a href="adminAccount.aspx?mode=viewMoneyOutList&status=ME004">직차감내역</a></li>
				</ul>
			</div>
		</div>
		<div id="betting" class="boxed">
			<h2 class="heading">배팅관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminBetting.aspx?mode=viewBettingList">사용자배팅현황</a></li>
					<li><a href="adminBetting.aspx?mode=viewBettingMoneyList">경기별배팅현황</a></li>
				</ul>
			</div>
		</div>
		<div id="stat" class="boxed">
			<h2 class="heading">통계보기</h2>
			<div class="content">
				<ul>
					<li><a href="adminStat.aspx?mode=viewDailyBettingMoneySummary">일일정산내역</a></li>
					<li><a href="adminStat.aspx?mode=viewDailyMemberMoneySummary">일일유저보유액</a></li>
				</ul>
			</div>
		</div>
		<div id="member" class="boxed">
			<h2 class="heading">회원관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminMember.aspx?mode=viewAdminMember">회원목록</a></li>
					<li><a href="adminMember.aspx?mode=viewAccessList">접속기록</a></li>
				</ul>
			</div>
		</div>
		<div id="board" class="boxed">
			<h2 class="heading">게시판관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminQna.aspx?mode=viewQnaList">고객센터</a></li>
					<li><a href="adminBoard.aspx?mode=viewBoardList">게시판</a></li>
					<li><a href="admin.aspx?mode=viewPopup">긴급공지</a></li>
					<li><a href="admin.aspx?mode=viewNotice">Notice</a></li>
				</ul>
			</div>
		</div>
		<div id="server" class="boxed">
			<h2 class="heading">서버관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminInfo.aspx?mode=viewAdminInfo">관리자정보</a></li>
					<li><a href="admin.aspx?mode=viewBankBookList">통장관리</a></li>
					<li><a href="adminSms.aspx?mode=viewSendSms">SMS전송</a></li>
					<!--li><a href="#">기본값관리</a></li -->
					<!--li><a href="#">아이피차단</a></li  -->
				</ul>
			</div>
		</div>
	</div>
	<div id="footer">
		<BR><BR><BR>
		<!-- p>Copyright &copy; 2008 Bwin-Kor.</strong></a></p -->
	</div>
</div>
<script>
function logOut()
{
	if (confirm("로그아웃 하시겠습니까?")) {
		location.href='adminLogin.aspx?mode=processLogout';
	}
}

checkIndi();
setInterval("checkIndi()", 10000);
</script>
</body>
</html>