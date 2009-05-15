<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.*" %>

 				</div>
			</div>   
		</div>
		<div id="function" class="boxed" align="center" bgcolor="white">
			<input type="button" value="로그아웃" onclick="logOut()"/>
		</div>
		<div id="board" class="boxed">
			<h2 class="heading">papan administrasi</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminQna.aspx?mode=viewQnaList&grade=1">pusat langganan</a></li>
					<!-- li class="first"><a href="adminQna.aspx?mode=viewQnaList&grade=10">Pusat langganan (VIP)</a></li -->
					<li><a href="adminBoard.aspx?mode=viewBoardList&grade=1">papan</a></li>
					<!-- li><a href="adminBoard.aspx?mode=viewBoardList&grade=10">게시판 (VIP)</a></li -->
					<li><a href="admin.aspx?mode=viewPopup">berita darurat</a></li>
					<li><a href="admin.aspx?mode=viewNotice">berita umum</a></li>
					<li><a href="adminReuse.aspx?mode=viewReuseCommentList&type=<%=Code.REUSE_COMMENT_QNA%>">balasan administrasi</a></li>
				</ul>
			</div>
		</div>
		<div id="money" class="boxed">
			<h2 class="heading">충환전관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminAccount.aspx?mode=viewMoneyInList&status=MC001">meminta pengisian</a></li>
					<li><a href="adminAccount.aspx?mode=viewMoneyOutList&status=ME001">meminta pentukaran</a></li>
					<li><a href="adminAccount.aspx?mode=viewMoneyInOutList&status=002">sejarah pengisian dan pertukaran</a></li>
					<li><a href="adminAccount.aspx?mode=viewMoneyInOutList&status=004">sejarah deduksi pengisian langsung</a></li>
					<li><a href="adminTran.aspx?mode=viewTransactionList">sejarah uang masuk dan keluar</a></li>
				</ul>
			</div>
		</div>
		<div id="betting" class="boxed">
			<h2 class="heading">배팅관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminBetting.aspx?mode=viewBettingList">kondisi taruhan pemakai</a></li>
					<li><a href="adminBetting.aspx?mode=viewBettingMoneyList">kondisi taruhan pertandingan</a></li>
				</ul>
			</div>
		</div>
		<div id="game" class="boxed">
			<h2 class="heading">pertandingan administrasi</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminGame.aspx?mode=viewGameList&type=wdl&grade=<%=Code.USER_GRADE_NORMAL%>">menang-seri-kalah</a></li>
					<li><a href="adminGame.aspx?mode=viewGameList&type=handy&grade=<%=Code.USER_GRADE_NORMAL%>">rintangan</a></li>
					<li><a href="adminGame.aspx?mode=viewGameList&type=mix&grade=<%=Code.USER_GRADE_VIP%>">special</a></li>
					<li><a href="adminToto.aspx?mode=viewTotoList">undian</a></li>
					<li><a href="adminGame.aspx?mode=viewEndGameList&type=wdl&grade=<%=Code.USER_GRADE_NORMAL%>">akibat pertandingaan(menag-seri-kalah)</a></li>
					<li><a href="adminGame.aspx?mode=viewEndGameList&type=handy&grade=<%=Code.USER_GRADE_NORMAL%>">akibat pertandingaan(rintangan)</a></li>
					<li><a href="adminGame.aspx?mode=viewEndGameList&type=mix&grade=<%=Code.USER_GRADE_VIP%>">akibat pertandingaan(special)</a></li>
					<li><a href="adminToto.aspx?mode=viewEndTotoList">akibat pertandingaan(undian)</a></li>
					<li><a href="adminLeague.aspx?mode=viewLeagueList">liga administrasi</a></li>
					<li><a href="adminReuse.aspx?mode=viewReuseCommentList&type=<%=Code.REUSE_COMMENT_GAME%>">berita administrasi</a></li>
				</ul>
			</div>
		</div>
		<div id="member" class="boxed">
			<h2 class="heading">kondisi pemasuk komputer</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminMember.aspx?mode=viewAdminMember&status=US001">jadwal anggota</a></li>
					<li><a href="adminMember.aspx?mode=viewAccessList">rekor masuk</a></li>
				</ul>
			</div>
		</div>
		<div id="stat" class="boxed">
			<h2 class="heading">melihat statis</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminStat.aspx?mode=viewDailyBettingMoneySummary">sejarah terhitung sehari</a></li>
					<li><a href="adminStat.aspx?mode=viewDailyMemberMoneySummary">uang mempunyai oleh pemakai sehari</a></li>
					<li><a href="adminStat.aspx?mode=viewMoneyOutStat">sjarah deposito pertukaran</a></li>
					<li><a href="adminStat.aspx?mode=viewMemberStat">kondisi anggota</a></li>
					<li><a href="adminStat.aspx?mode=viewMemberLogin">kondisi pemasuk komputer</a></li>
				</ul>
			</div>
		</div>
		<div id="server" class="boxed">
			<h2 class="heading">server administrasi</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="adminInfo.aspx?mode=viewSecurity">mengadakan keamanan</a></li>
					<li><a href="admin.aspx?mode=viewMaintanance">mengatur penapungan data</a></li>
					<li><a href="adminInfo.aspx?mode=viewBonus">mengatur bonus</a></li>
					<li><a href="adminInfo.aspx?mode=viewAdminInfo">info tentang pengatur</a></li>
					<li><a href="admin.aspx?mode=viewBankBookList">mengatur buku simpanan</a></li>
					<li><a href="adminSms.aspx?mode=viewSendSms">kirim SMS</a></li>
					<li><a href="adminLog.aspx?mode=viewHackingLog">mencari memarang</a></li>
					<!--li><a href="#">기본값관리</a></li -->
					<!--li><a href="#">아이피차단</a></li  -->
				</ul>
			</div>
		</div>
	</div>
	<div id="footer">
		<BR><BR><BR>
		<!-- p>Copyright &copy; 2008 <%=SiteConfig.SITE_NAME%></strong></a></p -->
	</div>
</div>
<script>
function logOut()
{
	if (confirm("ingin logout?")) {
		location.href='adminLogin.aspx?mode=processLogout';
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