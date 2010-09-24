<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.common.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	List<ReuseComment> reuseCommentList = (List<ReuseComment>) request.getAttribute("reuseCommentList");
	String type = XwinUtil.nvl(request.getParameter("type"));	
%>

<div class="title"><%=Code.getValue(type)%>관리</div>

<form name="cmt">
<table class="list">
<tr>
	<th width="10%">댓글</th>
	<td width="*"><textarea name="comment" style='width=100%;height=50px'></textarea></td>
	<td width="10%"><input type="button" value="댓글입력" onclick="writeReuseComment()"></td>
</tr>
<%
if (reuseCommentList != null) {
	for (ReuseComment reuseComment : reuseCommentList) {
%>
<tr>
	<th width="20"><%=reuseComment.getId()%></th>
	<td width="*">
	<%
		String comment = StringEscapeUtils.escapeHtml(reuseComment.getComment());
		comment = comment.replaceAll("\n", "<BR>");
		out.print(comment);
	%>
	</td>
	<td width="20"  align=center><img src="images/btn_coment_del.gif" onclick="deleteReuseComment(<%=reuseComment.getId()%>)"></td>
</tr>
<%
	}
}
%>
</table>
</form>
<script>

function writeReuseComment()
{
	if (havingSqlKeyword(document.cmt.comment.value)) {
		alert("내용에 사용할수 없는 문자열이 있습니다"); document.cmt.comment.focus(); return false;
	}
	
	var query = "mode=writeReuseComment";
	query += "&comment=" + Xwin.Escape(document.cmt.comment.value);
	query += "&type=<%=type%>";
	var http = new JKL.ParseXML("adminReuse.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();	
}

function deleteReuseComment(id)
{
	if (confirm("삭제하시겠습니까?")) {
		var query = "mode=deleteReuseComment";
		query += "&id=" + id;
		var http = new JKL.ParseXML("adminReuse.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0)
			location.reload();	
	}
}
</script>

<%@ include file="../admin_footer.jsp"%>