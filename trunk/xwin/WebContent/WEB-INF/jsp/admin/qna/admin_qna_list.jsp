<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	List<BoardItem> qnaList = (List<BoardItem>) request.getAttribute("qnaList");
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title">고객센터</div>

<form method='get' name='search' action='adminQna.aspx'>
	<input type='hidden' name='mode' value=''/>
 </form>

<form name="qnaList">
<table class="list">
	<tr>
		<th width=5%></th>
		<th width=5%>번호</th>
		<th width=10%>아이디</th>
		<th width=10%>닉네임</th>
		<th width=*>제목</th>
		<th width=15%>작성시각</th>
	</tr>
<%
if (qnaList != null) {
	for (BoardItem boardItem : qnaList) {
%>
	<tr>
		<th width=5%><input type="checkbox" name="checkCheck" value="<%=boardItem.getId()%>" onclick="saveQnaIsChecked(this)" <%=boardItem.getIsChecked().equals("Y")?"checked":""%>/></th>
		<td width=5% align='center'><%=boardItem.getId()%></td>
		<td width=10% align='center'><%=boardItem.getUserId()%></td>
		<td width=10% align='center'><%=boardItem.getNickName()%></td>
		<td width=*>&nbsp;&nbsp;<a href="adminQna.aspx?mode=viewQnaDetail&id=<%=boardItem.getId()%>">
			<%=boardItem.getTitle()%>&nbsp;&nbsp;[<%=boardItem.getCommentCount()%>]
		</a></td>
		<td width=15% align='center'><%=XwinUtil.toDateStr(boardItem.getDate(), 1)%></td>
	</tr>
<%
	}
}
%>							
</table>
</form>

<input type="button" onclick="deleteQnaItem()" value="삭제">

<script>
function saveQnaIsChecked(cobj)
{
	var query = "mode=saveQnaIsChecked";
	query += "&id=" + cobj.value;
	if (cobj.checked)
		query += "&isChecked=Y";
	else
		query += "&isChecked=N";
	
	var http = new JKL.ParseXML("adminQna.aspx", query);
	var result = http.parse();

	checkIndi();
}

function deleteQnaItem()
{
	var query = "mode=deleteQnaItem";
	
	var c = document.qnaList.checkCheck;
	c = Xwin.ToArray(c);
	for (var i=0; i < c.length ; i++) {
		if (c[i].checked)
			query += "&id=" + c[i].value;
	}
	
	var http = new JKL.ParseXML("adminQna.aspx", query);
	var result = http.parse();

	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();		
}
</script>

<%@ include file="../admin_footer.jsp"%>