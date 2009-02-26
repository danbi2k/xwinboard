<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="org.apache.commons.lang.*"%>

<%@include file="../header.jsp"%>

<%
	BoardItem boardItem = (BoardItem) request.getAttribute("boardItem");
	List<BoardComment> boardCommentList = boardItem.getBoardCommentList();
	String boardName = request.getParameter("boardName");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	if (pageIndex == null)
		pageIndex = "0";
%>

<tr><td><img src="img/menu04.jpg" border="0"></td></tr>
		    <tr><td><img src="img/bbs01.jpg" border="0"></td></tr>
            </table>
     
     <table align="center" cellpadding="0" cellspacing="0" width="771" height="40" background="img/bar-.jpg">
    <tr>
        <td width="771" height="40" align="center" valign="middle" class="menubar">
           <%=boardItem.getTitle()%>
        </td>
        
    </tr>
</table>
 <table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
   
    <tr>
        <td width="771" height="37" background="img//minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="497" height="132" background="img//minit_02.jpg" valign="top" style="padding:20">
            <p>
			 <%
			    String context = boardItem.getContext();
			    context = StringEscapeUtils.escapeHtml(context);
			    context = context.replaceAll("\n", "<br>");
			    out.print(context);
		     %>
			</p>
        </td>
    </tr>
    <tr>
        <td width="771" height="44" background="img//minit_03.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
          <table align="center" cellpadding="0" cellspacing="0" width="771" height="40">
	        <tr>
			    <td width="671" height="40" align="left">
					<a href='board.aspx?mode=viewBoard&boardName=<%=boardName%>&pageIndex=<%=pageIndex%>'><img src="img/list.jpg" border="0" align="absmiddle"></a>
			    </td>
			    <td width="100" height="40" align="right">
					<a href='board.aspx?mode=viewBoardWriteForm&boardName=<%=boardName%>'><img src="img/write.jpg" border="0" align="absmiddle"></a>
				</td>
			</tr>
		    
     </table>

<%@include file="../footer.jsp"%>


</body>
</html>