<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@include file="admin_header.jsp"%>

<h3>Betting List</h3>
 <div id="bettingListDiv"></div>
 
 <script>
 AdminBet.GetBettingList();
 </script>
 <%@include file="admin_footer.jsp"%>