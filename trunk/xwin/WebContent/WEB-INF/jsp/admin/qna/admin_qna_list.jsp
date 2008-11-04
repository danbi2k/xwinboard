<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.board.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	int ROWSIZE = 30;
	int SHOWPAGE = 20;
	
	List<BoardItem> qnaList = (List<BoardItem>) request.getAttribute("qnaList");
	Integer totalCount = (Integer) request.getAttribute("qnaCount");
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String fromDate = XwinUtil.nvl(request.getParameter("fromDate"));
	String toDate = XwinUtil.nvl(request.getParameter("toDate"));
	
	String grade = XwinUtil.nvl(request.getParameter("grade"));
%>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>

<div class="title"><%=grade.equals(Code.USER_GRADE_VIP)?"고객센터 (VIP)":"고객센터" %></div>

<form name='search' method='get' action='adminQna.aspx'>
<input type='hidden' name='mode' value='viewQnaList'/>
<input type='hidden' name='grade' value='<%=grade%>'/>
<input type='hidden' name='pageIndex'/>
<select name='search'>
	<option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
	<option value='nickName' <%=search.equals("nickName")?"selected":""%>>회원닉네임</option>
</select>
<input type='text' name='keyword' value='<%=keyword%>'>
작성일
<input type='text' name='fromDate' value='<%=fromDate%>' size=10 readonly onClick="popUpCalendar(this,fromDate,'yyyy-mm-dd');" style="cursor:hand"> ~
<input type='text' name='toDate' value='<%=toDate%>' size=10 readonly onClick="popUpCalendar(this,toDate,'yyyy-mm-dd');" style="cursor:hand">
<input type='submit' value='검 색'>
</form> 

<form name="qnaList">
<table class="list">
	<tr>
		<th width=5%></th>
		<th width=5%>번호</th>
		<th width=10%>아이디 (닉네임)</th>
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
		<td width=20% align='left'>&nbsp;<a href='javascript:goMemberDetail("<%=boardItem.getUserId()%>")'><%=boardItem.getUserId()%></a> (<%=boardItem.getNickName()%>)
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

<div class="pages">
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
	
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
	</div>

<script>
function goPage(index)
{
	var frm = document.search;
	frm.pageIndex.value = index;
	frm.submit();
}
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