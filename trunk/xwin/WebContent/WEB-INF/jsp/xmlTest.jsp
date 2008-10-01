<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>admin</h3>
<a href="admin/adminGame.aspx?mode=getLeagueList">getLeagueList</a><br>
<h3>board</h3>
<a href="board.aspx?mode=createBoardItem&type=free">createBoardItem</a><br>
<a href="board.aspx?mode=getBoardItemList&type=free">getBoardItemList</a><br>
<a href="board.aspx?mode=getBoardItem&id=9">getBoardItem</a><br>
<h3>betting</h3>
<h3>mybet</h3>
<a href="myBet.aspx?mode=getMyBettingList">getMyBettingList</a><br>
<h3>account</h3>
<a href="moneyIn.aspx?mode=moneyOutRequest&money=100">moneyOutRequest</a><br>
<a href="moneyIn.aspx?mode=moneyInRequest&money=100">moneyInRequest</a><br>
<a href="moneyIn.aspx?mode=getAccountInfo">getAccountInfo</a><br>
</body>
</html>