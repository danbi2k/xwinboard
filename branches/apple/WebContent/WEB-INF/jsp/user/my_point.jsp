<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<%
	final Integer ROWSIZE = 15;
	final Integer SHOWPAGE = 10;
	List<Point> pointList = (List<Point>) request.getAttribute("pointList");
	Integer totalCount = (Integer) request.getAttribute("pointCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>

<div class='sub_ti1'>
		<img src='img/sub_myapple_ti.gif' alt='애플' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 애플 지급/전환 내역 입니다.</div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='myBet.aspx?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='applelist'>

				<div class='tab'>
				<a href="myMoney.aspx?mode=viewMyPointList"><img src='img/sub_apple_on_ti.gif'></a>
				<a href="myMoney.aspx?mode=viewMyMoneyList"><img src='img/sub_cashlist_off_ti.gif' class='img_bt'></a>

				</div>
				<div class='box tabbox list_box'>
			
					<table>
					<tr>
						<th class='t1'>거래일자</th>
						<th class='t2'>기애플</th>
						<th class='t3'>입출애플</th>
						<th class='t4'>잔여애플</th>
						<th class='t5'>비고</th>
					</tr>
	<%
	if (pointList != null && pointList.size() > 0) {
		for (Point point : pointList) {
	%>
	<tr>
	<td><%=point.getDateStr()%></td>
	<td><%=XwinUtil.comma3(point.getOldBalance())%></td>
	<td><%=XwinUtil.comma3(point.getMoney())%></td>
	<td><%=XwinUtil.comma3(point.getBalance())%></td>
	<td></td>
	</tr>
	<%
		}
	}
	%>
					</table><br>

				</div>
				
<!-----[ 페이징 ]--------------------------------------------/-->
				<div class='paginate'>    
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
	if (startPage > 0) {
%>
		<span class='pre'><a href='javascript:goPage(<%=startPage - 1%>)'><img src='img/list_prev_bt.gif' alt='이전'></a></span>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<span class='txt'><strong><%=i+1%></strong></span>
<%
		} else {
%>		
			<span class='txt'><a href='javascript:goPage(<%=i%>)'><%=i+1%></a></span>
<%			
		}
	}
	if (i < pageNum) {
%>		
		<span class='next'><a href='javascript:goPage(<%=i%>)''><img src='img/list_next_bt.gif' alt='다음' class='next'></a></span>
<%
	}
%>
				</div>		
				

			</div>
			<!-- end cashlist -->
		</div>
		<!-- sub_content1 -->

<script>
function goPage(index)
{
	location.href="myMoney.aspx?mode=viewMyPointList&pageIndex=" + index;
}
</script>
<%@include file="../footer.jsp"%>