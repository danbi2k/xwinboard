<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.board.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%
	String boardName = request.getParameter("boardName");
%>

<%@include file="../header.jsp"%>

			<tr><td><img src="img/menu04.jpg" border="0"></td></tr>
		    <tr><td><img src="img/bbs01.jpg" border="0"></td></tr>
            </table>
<form name="boardfrm" action="board.aspx" method="post">
<input type="hidden" name="mode" value="writeBoardItem">
<input type="hidden" name="boardName" value="<%=boardName%>">     
<table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
   
    <tr>
        <td width="771" height="37" background="img//minit_01.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="771" height="132" background="img//minit_02.jpg" valign="top" style="padding:20">
           <table border=0 cellspacing=0 cellpadding=0 width=731>

<col width=60></col>
<col width=7></col>
<col width=500></col>



 

<tr>
 <td align=right class=menubar>작성자</td>
 <td></td>
 <td><%=member.getNickName()%></td>
</tr>


<tr>
 <td align=right class=menubar>제목</td>
 <td></td>
 <td> <input type=text name=title maxlength=200 class=input2 style=width:90%;> </td>
</tr>

<tr>
 <td align=right class=menubar>내용</td>
 <td></td>
 <td><textarea name=context rows=15 class=textarea></textarea></td>
</tr>

</table>
</form>
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
			    <td width="671" height="40" align="left"><img src="img/list.jpg" border="0" align="absmiddle" onclick='history.back()'>
			    </td>
			    <td width="100" height="40" align="right"><img src="img/write.jpg" border="0" align="absmiddle" onclick='check_frm()'>
				</td>
			</tr>
		    
     </table>

<script>
function check_frm(){
	var frm = document.boardfrm;
	if (havingSqlKeyword(frm.title.value)) { alert("제목에 사용할수 없는 문자열이 있습니다"); frm.title.focus(); return false; }
	if (havingSqlKeyword(frm.context.value)) { alert("내용에 사용할수 없는 문자열이 있습니다"); frm.context.focus(); return false; }
	
    if(frm.title.value   ==""){ alert("제목을 입력하세요!");   frm.title.focus();    return false; }
    if(frm.name.value    ==""){ alert("작성자를 입력하세요!"); frm.name.focus();     return false; }
    if(frm.context.value==""){ alert("내용을 입력하세요!");   frm.context.focus(); return false; }

    frm.submit();
}
</script>

<%@include file="../footer.jsp"%>


</body>
</html>