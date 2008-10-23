<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.web.controller.board.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%
	String boardName = request.getParameter("boardName");
%>

<%@include file="../header.jsp"%>

<%
	Integer ROWSIZE = BoardController.ROWSIZE;
	final Integer SHOWPAGE = 10;
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	
	List<BoardItem> boardItemList = (List<BoardItem>) request.getAttribute("boardItemList");
	Integer totalCount = (Integer) request.getAttribute("boardItemCount");
	
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	
	int itemIdx = totalCount - (pIdx * ROWSIZE);
%>

<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_board.gif"></td>
	<td>
	<%=boardName.equals("user")?"게시물을 작성하고, 중요 내용을 확인 할 수 있습니다.":"1:1 고객센터 입니다. 문의사항 및 건의사항을 적어주세요."%>
	</td></td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">


<link rel='stylesheet' href='common/board.css'><script language='JavaScript' src='common/board.js'></script><br><table align='center' width='95%' cellpadding='0' cellspacing='0' style='margin-top:7px;'><tr align='center'><td width='10'><img src='images/title_left.gif'></td><td width='50'  background='images/title_bg.gif'>번호</td><td width='*'   background='images/title_bg.gif'>제목</td><td width='100' background='images/title_bg.gif'>작성자</td><td width='100' background='images/title_bg.gif'>작성일</td><td width='50'  background='images/title_bg.gif'>조회수</td><td width='10'><img src='images/title_right.gif'></td></tr>
	

<%
	if (boardItemList != null) {
		for (BoardItem boardItem : boardItemList) {
			if (boardItem.getType().equals(Code.BOARDITEM_TYPE_NOTICE)) {
%>
	<tr height='32' align="center">
		<td>&nbsp;</td>
		<td style='border-bottom:1 #b4b4b4 solid;color:#45BCD7' class='board_list'><b><%=Code.getValue(boardItem.getType())%></td>
		<td style='border-bottom:1 #b4b4b4 solid;color:#45BCD7' class='board_list' align="left">
			<span style="width:100%;color:#45BCD7;height:15;overflow:hidden;">
				<b><a class="board_list" style="color:#45BCD7;" href="board.aspx?mode=viewBoardDetail&boardName=<%=boardName%>&id=<%=boardItem.getId()%>">
				<%=boardItem.getTitle()%>&nbsp;&nbsp;[<%=boardItem.getCommentCount()%>]
				</a></b>
			</span>
		</td>
		<td style='border-bottom:1 #b4b4b4 solid;color:#45BCD7' class='board_list'><b><%=boardItem.getNickName()%></td>
		<td style='border-bottom:1 #b4b4b4 solid;color:#45BCD7' class='board_list'>&nbsp;</td>
		<td style='border-bottom:1 #b4b4b4 solid;color:#45BCD7' class='board_list'>&nbsp;</td>
		<td>&nbsp;</td>

	</tr>
<%
			} else {
%>
	<tr height='32' align="center">
    <td>&nbsp;</td>
    <td style='border-bottom:1 #b4b4b4 solid;' class='board_list'><%=itemIdx--%></td>
    <td style='border-bottom:1 #b4b4b4 solid;' class='board_list' align="left">
		<span style="width:100%;height:15;overflow:hidden;">
		<a class="board_list" href="board.aspx?mode=viewBoardDetail&boardName=<%=boardName%>&id=<%=boardItem.getId()%>&pageIndex=<%=pageIndex%>"><%=boardItem.getTitle()%><b>&nbsp;&nbsp;[<%=boardItem.getCommentCount()%>]</b></a>
		</span>
	</td>
    <td style='border-bottom:1 #b4b4b4 solid;' class='board_list'><b><%=boardItem.getNickName()%></b></td>
    <td style='border-bottom:1 #b4b4b4 solid;' class='board_list'><b><%=XwinUtil.getBoardItemDate(boardItem.getDate())%></b></td>
    <td style='border-bottom:1 #b4b4b4 solid;' class='board_list'><%=boardItem.getReadCount()%></td>
    <td>&nbsp;</td>
</tr>
<%
			}
		}
	}
%>
	

</table>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="95%" style="padding-top:8px">
<tr><td width="50%" height="30">
    </td>

    <td width="50%" height="30" align="right">
		
        &nbsp;&nbsp;<br><br>
		<%if ((boardName.equals("user") && Admin.DENY_BOARD.equals("Y")) || boardName.equals("qna") && Admin.DENY_QNA.equals("Y")) {%>
        <a href="board.aspx?mode=viewBoardWriteForm&boardName=<%=boardName%>"><img src="images/btn_write.gif" border="0"></a>
		<%} %>
    </td></tr>
</table>

<table width="95%" height="41" align='center' cellpadding='0' cellspacing='0'>
<tr><td width="*" style="padding-left:20;" align='center'>

    <!-----[ 페이징 ]--------------------------------------------/-->
    
   <%
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
    </td>
    </tr>
</table>




</td></tr>
</table>

<script>
function goPage(pageIndex)
{
	location.href="board.aspx?mode=viewBoard&boardName=<%=boardName%>&pageIndex=" + pageIndex;
}
</script>
<%@include file="../footer.jsp"%>