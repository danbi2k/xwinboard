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
			<h2 class="heading">회원관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="dealer.aspx?mode=viewMemberList">회원관리</a></li>
					<li><a href="dealer.aspx?mode=viewInvitationForm">회원초대</a></li>
				</ul>
			</div>
		</div>
		<div id="betting" class="boxed">
			<h2 class="heading">배팅관리</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="dealer.aspx?mode=viewBettingList">회원배팅현황</a></li>
				</ul>
			</div>
		</div>
		<div id="stat" class="boxed">
			<h2 class="heading">통계보기</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="dealer.aspx?mode=viewDealerSummary">딜러비정산내역</a></li>
				</ul>
			</div>
		</div>
		<div id="server" class="boxed">
			<h2 class="heading">총판정보</h2>
			<div class="content">
				<ul>
					<li class="first"><a href="dealer.aspx?mode=viewDealerInfo">총판 정보</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="footer">
		<BR><BR><BR>
		
	</div>
</div>
<script>
function logOut()
{
	if (confirm("로그아웃 하시겠습니까?")) {
		location.href='adminLogin.aspx?mode=processLogout';
	}
}
</script>
</body>
</html>