<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	final Integer ROWSIZE = 10;
	final Integer SHOWPAGE = 10;
	
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
	Integer totalCount = (Integer) request.getAttribute("bettingCount");
	
	String gameType = XwinUtil.nvl(request.getParameter("gameType"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String betDate = XwinUtil.nvl(request.getParameter("betDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 게임관리</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=wdl"> 경기관리 - 승무패</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=handy"> 경기관리 - 핸디캡</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=oe"> 경기관리 - 홀짝</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminBetting.aspx?mode=viewBettingList"> 배팅관리</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminLeague.aspx?mode=viewLeagueList"> 리그관리</a></td>
    </tr>
</table></td>
              </tr>
          </table>
		  <!-- 좌측 메뉴 -->
		  </td>
          <td style="padding:15" valign="top">
		  <!-- 세부 내용 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <!-- 서버 타이틀 -->
				  <tr>
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 배팅관리</td>
                  </tr>
                  <tr>
                    <td height="1" bgcolor="CDCDCD"> </td>
                  </tr>
                  <tr>
                    <td height="2" bgcolor="E7E7E7"> </td>
                  </tr>
				  <!-- 서버 타이틀 -->
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><!----컨텐츠---->
					<SCRIPT LANGUAGE="JavaScript">
	function checkIT() {
		var d=document.regist;
		if(!d.tbl_cat_idx.value) { alert('리그명을 입력하세요'); d.tbl_cat_idx.focus(); return false; }
		if(!d.gamedate.value) { alert('게시일을 선택하세요'); d.gamedate.focus(); return false; }
		if(!d.gametime.value) { alert('경기 시작 시각(일자)을 선택하세요'); d.gametime.focus(); return false; }
		if(!d.gametime2.value) { alert('경기 시작 시각(시)을 선택하세요'); d.gametime2.focus(); return false; }
		if(!d.gametime3.value) { alert('경기 시작 시각(분)을 선택하세요'); d.gametime3.focus(); return false; }
		if(!d.a1.value) { alert('홈팀명을 입력하세요'); d.a1.focus(); return false; }
		if(!d.a1_by.value) { alert('홈팀 배당률을 입력하세요'); d.a1_by.focus(); return false; }
		if(!d.x_by.value) { alert('무승부 배당률을 입력하세요'); d.x_by.focus(); return false; }
		if(!d.a2.value) { alert('원정팀명을 입력하세요'); d.a2.focus(); return false; }
		if(!d.a2_by.value) { alert('원정팀 배당률을 입력하세요'); d.a2_by.focus(); return false; }
		d.action='game/bat.php';
		d.submit();
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='game/bat.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}

	function stIT() {
		var d=document.game;
		var chk = 0;
		for(i=0;i<d.elements.length;i++) {
			if(d.elements[i].checked==true) { chk++; }
		}

		if(!chk) { alert('정산하실 배팅을 선택하세요'); return; }

		if(confirm('정산 처리 하시겠습니까?')) {
			d.action='game/bat.php?mode=update_exe';
			d.submit();
		}
		else {
			return;
		}
	}

	function allcheck() {
		var d=document.game;
		var chk = 0;
		for(i=0;i<d.elements.length;i++) {
			if(d.ac.checked==true) {
				if(d.elements[i].disabled==false) {
					d.elements[i].checked=true;
				}
			}
			else {
				if(d.elements[i].disabled==false) {
					d.elements[i].checked=false;
				}
			}
		}
	}

	function cancelIT() {
		var d=document.game;
		var chk = 0;
		for(i=0;i<d.elements.length;i++) {
			if(d.elements[i].checked==true) { chk++; }
		}

		if(!chk) { alert('취소하실 배팅을 선택하세요'); return; }

		if(confirm('취소 처리 하시겠습니까?\n\n\n\취소하시면 배팅금액은 환불됩니다.')) {
			d.action='game/bat.php?mode=cancel_exe';
			d.submit();
		}
		else {
			return;
		}
	}


</SCRIPT>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">                      
							<form method='post' name='search' action='adminBetting.aspx?mode=viewBettingList'>
						 <tr>
                          <td align='left' height=30>
						 게임종류
						<select name='gameType' onChange='this.form.submit()'>
						<option value=''>전체</option>
						<option value='wdl' <%=gameType.equals("wdl")?"selected":""%>>승무패</option>
						<option value='handy' <%=gameType.equals("handy")?"selected":""%>>핸디캡</option>
                        <option value='oe' <%=gameType.equals("oe")?"selected":""%>>홀짝</option>
						</select>

						배팅상태
						<select name='status' onChange='this.form.submit()'>
						<option value=''>전체</option>
						<option value='<%=Code.BET_STATUS_RUN%>' <%=status.equals(Code.BET_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_RUN)%></option>
						<option value='<%=Code.BET_STATUS_SUCCESS%>' <%=status.equals(Code.BET_STATUS_SUCCESS)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_SUCCESS)%></option>
						<option value='<%=Code.BET_STATUS_FAILURE%>' <%=status.equals(Code.BET_STATUS_FAILURE)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_FAILURE)%></option>
						<option value='<%=Code.BET_STATUS_NOMATCH%>' <%=status.equals(Code.BET_STATUS_NOMATCH)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_NOMATCH)%></option>
						<option value='<%=Code.BET_STATUS_CANCEL%>' <%=status.equals(Code.BET_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.BET_STATUS_CANCEL)%></option>
						</select>

						 배팅일자
						<input type='text' name='betDate' value='<%=betDate%>' size=10 readonly onClick="popUpCalendar(this, betDate,'yyyy-mm-dd');" style="cursor:hand">
				 
						 <select name='search'>
						 <option value='userId'>아이디</option>
						 <option value='nickName'>닉네임</option>
						</select> 
						<input type='text' name='keyword' value='<%=keyword%>' size=12>
						<input type='submit' value='검 색'>
						  </td>
                        </tr>  
						<tr>
							<td>
						배팅정산 : <img src="images/admin/btn_run.jpg">
						배팅취소 : <img src="images/admin/btn_cancel.jpg">	
							</td>
							</tr>
						</tr>
						</form>
						
						<form method='post' name='game'>
						<tr>
							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%>번호</td>
								<td>아이디</td>
								<td>경기시간</td>
								<td>홈팀</td>
								<td>무승부<BR>/핸디캡</td>
								<td>원정팀</td>
								<td>유저배팅</td>
								<td>경기결과</td>
								<td>상태</td>
							  </tr>
							 
			<%
				if (bettingList != null) {
					for (Betting betting : bettingList) {
						List<BetGame> betGameList = betting.getBetGameList();
						if (betGameList != null) {
							int count = 0;
							for (BetGame betGame : betGameList) {								
			%>
                              <tr align='center' bgcolor='#ffffff'>
								<%
								if (count == 0) {
								%>
								<td rowspan='<%=betting.getTotalCount()%>'><font color='#000000'><%=betting.getId()%></td>								
								<td rowspan='<%=betting.getTotalCount()%>'><font color='#000000'><%=betting.getUserId()%></a></td>
								<%
								}
								%>
								<td><font color='#000000'><%=betGame.getGameDateStr()%></td>
								<td><font color='#000000'><%=betGame.getHomeTeam()%> (<%=betGame.getWinRateStr()%>)</td>																								
								<td><font color='#000000'><%=betGame.getDrawRateStr()%></td>
								<td><font color='#000000'><%=betGame.getAwayTeam()%> (<%=betGame.getLoseRateStr()%>)</td>
								<td><font color='#000000'><%=Code.getValue(betGame.getGuess())%></td>
								<td><font color='#000000'><B></b><%=Code.getValue(betGame.getResult())%><BR></td>
								<%
								if (count++ == 0) {
								%>
								<td rowspan='<%=betting.getTotalCount()%>'><%=Code.getValue(betting.getStatus())%></td>
								<%
								}
								%>
							  </tr>
			<%
							}
						}
							
			%>
	                          <tr align='center' bgcolor='#ffffff'>
								<td width=100% colspan='6'>
								<B>
								배팅시각 : <%=betting.getDateStr()%>&nbsp; / &nbsp; 배당률 : x<%=betting.getRateStr()%><br>
								배팅금액 : <%=betting.getMoney()%> 원&nbsp; / &nbsp; 예상금액 : <%=betting.getExpect()%> 원
								</B>
								</td>
								<td colspan='3'>
									<img src="images/admin/btn_run.jpg" onclick="calculateBetting(<%=betting.getId()%>, '<%=betting.getGameType()%>')">
									<img src="images/admin/btn_cancel.jpg" onclick="cancelBetting(<%=betting.getId()%>, '<%=betting.getGameType()%>')">
								</td>
							</tr>
			<%
					}
				}
			%>

								
                          </table></td>
                        </tr>
                        <tr>
                          <td align='center' height=50>
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil(totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + 15;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'>&lt;&lt;&lt;</a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b> <%=i+1%> </b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>[ <%=i+1%> ]</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'>&gt;&gt;&gt;</a>
<%
	}
%>
						  <td align='right'>
						  </td>

                        </tr> 
						</form>
                      </table>
                      
		  <!-- 세부 내용 끝 -->
                </td>
              </tr>
          </table></td>
        </tr>
    </table></td>
  </tr>
</table>
</td></tr></table>
<script>
function calculateBetting(id, gameType)
{
	if (confirm("정산하시겠습니까?")) {
		var query = "mode=calculateBetting";
		query += "&id=" + id;
		query += "&gameType=" + gameType;
		var http = new JKL.ParseXML("adminBetting.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message)
		if (result.resultXml.code == 0) {
			location.reload(0);
		}
	}
}

function cancelBetting(id, gameType)
{
	if (confirm("취소하시겠습니까?")) {
		var query = "mode=cancelBetting";
		query += "&id=" + id;
		query += "&gameType=" + gameType;
		var http = new JKL.ParseXML("adminBetting.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message)
		if (result.resultXml.code == 0) {
			location.reload(0);
		}
	}
}
</script>
<!-- 페이지 내용 -->
<%@ include file="../admin_footer.jsp"%>
