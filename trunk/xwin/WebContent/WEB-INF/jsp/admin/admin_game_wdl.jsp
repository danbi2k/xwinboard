<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@include file="admin_header.jsp"%>

<h3>Game List</h3>
<a href="adminGame.aspx?mode=registerGameForm&type=wdl">게임등록</a>
 <div id="gameListDiv"></div>
 
 <script>
 var gameType = "wdl";
 var gameStatus = "GS001";
 AdminGame.GetGameList(gameType, gameStatus); 
 </script>
 <%@include file="admin_footer.jsp"%>