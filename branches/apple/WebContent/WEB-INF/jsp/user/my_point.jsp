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
		<div class='sub_ti_desc'>· 애플 환전 내역 입니다.</div>
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
						<th class='t5'>배팅한사용자</th>
						<th class='t6'>비고</th>
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
	<td><%=XwinUtil.nvl(point.getNote())%>
	<td></td>
	</tr>
	<%
		}
	}
	%>
					</table><br>

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