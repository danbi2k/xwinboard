<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>    
<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%
	List<BoardItem> noticeList = (List<BoardItem>) request.getAttribute("noticeList");
	List<BoardItem> userList = (List<BoardItem>) request.getAttribute("userList");
	request.setAttribute("isIndex", Boolean.TRUE);
%>

<%@include file="header.jsp"%>

		<div class='lside'>
		<%if (login) { %>
			<div class='m_login'>
				<div class='login_after_txt'>
					<div class='name'><%=member.getNickName()%></div> 님 반갑습니다.<br>
					<div class='cash'>· 캐쉬:</div> <div class='val'><%=XwinUtil.comma3(member.getBalance())%> <span>원</span></div>
					<div class='apple'>· 애플:</div> <div class='val2'><%=XwinUtil.comma3(member.getPoint())%> <span>ap</span></div>
					<div class='link'><a href='myBet.aspx?mode=viewMyBettingList' target='_self'>배팅내역</a> | <a href='member.aspx?mode=viewModifyForm'>정보변경</a></div>
				</div>
			</div>
		<%} else { %>
			<div class='m_login'>
				<form name='login'>
				<table>
				<tr>
				<td><label class='mr5'><img src='img/login_id_lb.gif'></label></td>
				<td class='pb3'><input type='text' class='input_text w90' name='userId'></td>
				</tr>

				<tr>
				<td><label class='mr5'><img src='img/login_pass_lb.gif'></label></td>
				<td><input type='password' class='input_text w90' name='password' class=''></td>
				</tr>
				</table>
				<span class='fl ml6 mt14'><img src='img/login_do_bt.gif' alt='login' onclick="user_login(document.login)"></span>
				</form>

				<div class='idpw'>
				<a href='join.aspx?mode=viewJoinForm'>회원가입</a> |
				<a>추천가입</a>
				</div>
			</div>
			<%} %>
			<div class='m_banner_body'>
			<img class='ml8 mb5' src='img/banner1.gif' alt='분대스리가'>
			<img class='ml8 mb5' src='img/banner2.gif' alt='프리메라리가'>
			<img class='ml8 mb5' src='img/banner3.gif' alt='세리에리그'>
			<img class='ml8 mb5'src='img/banner4.gif' alt='프리미어리그'>
			</div>
			<div class='m_banner_bottom'></div>
		</div>
		<div class='m_flash'><!-- <img src='img/tmp_flash.jpg' width='445' height='413' alt='메인플래시임시'> -->
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="445" height="418" id="main" align="middle">
	<param name="allowScriptAccess" value="sameDomain" />
	<param name="allowFullScreen" value="false" />
	<param name="movie" value="./swf/main.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" />	<embed src="./swf/main.swf" quality="high" bgcolor="#ffffff" width="445" height="418" name="main" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer" />
	</object></div>
		<div class='rside'>

			<div class='m_latest_notice_top'><a href=''><img src='img/latest_more_bt.gif' alt='공지사항 더보기'></a></div>
			<div class='m_latest_notice_body'>
			<!-- 공지사항내용 -->
			<ul>
<%
	if (noticeList != null) {
		for (BoardItem notice : noticeList) {
			String title = notice.getTitle();
			if (title.length() > 12)
				title = title.substring(0, 12) + "..";
%>
			<li><a href=''>· <%=title%></a></li>
<%
		}
	}
%>
			</ul>

			</div>
			<div class='m_latest_notice_bottom'></div>

			<div class='m_latest_board_top'><a href=''><img src='img/latest_more_bt.gif' alt='게시판 더보기'></a></div>
			<div class='m_latest_board_body'>
			<!-- 게시판내용 -->
			<ul>
<%
	if (userList != null) {
		for (BoardItem user : userList) {
			String title = user.getTitle();
			if (title.length() > 12)
				title = title.substring(0, 12) + "..";
%>
			<li><a href=''>· <%=title%></a></li>
<%
		}
	}
%>
			</ul>
			</div>
			<div class='m_latest_board_bottom'></div>
		</div>

<%@include file="footer.jsp"%>