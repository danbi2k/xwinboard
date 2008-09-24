<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_board.gif"></td><td>게시물을 작성하고, 중요 내용을 확인 할 수 있습니다.</td></td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">


<link rel='stylesheet' href='/board/skin_board/board.css'><script language='JavaScript' src='/board/skin_board/board.js'></script>

<script>
function img_resize(obj,max_width){
    obj.style.display='';
    if(obj.width>max_width){
        var wid = obj.width;
        var hei =max_width * obj.height / wid;
        obj.width = max_width;
        obj.height = hei;
    }
}
</script>

<table align="center" width="95%" cellpadding="0" cellspacing="0" style="margin-top:7px;">
<tr align="center">
<td width="10"><img src="images/title_left.gif"></td>
<td width="*" background="images/title_bg.gif"><b style="color:white">★ 필독사항 ★ 회원님의 소중한 정보유출방지를 위한 안내</td>

<td width="10"><img src="images/title_right.gif"></td>
</tr>
</table>

<table width="95%" border="0" align="center"  cellpadding="3" cellspacing="1" style="margin-top:7px;border:1 solid #4a4a4a;">
<tr height="200" valign="top"><td style="padding:13px;" bgcolor="#f5f5f5" style="color:black;">

    회원님의 소중한 정보보호를 위해 현재 사용중이신 아이디와 비밀번호는 유사사이트에서 사용중이신 비밀번호와 반드시<br><br>다르게 변경해주시기 바랍니다.<br><br>일부가 타 사이트에서 유출되어 타사이트의 아이디와 비번으로 로그인 시도하는  불순한 부류들이 활동한다는 &#52449;보가  들어왔읍니다  <br><br>부디 회원여러분들은   자신의 아이디와  비번 관리를   철저히하셔서 피&#54700;를 보시는일이 없으시기 바랍니다.<br><br>저희는 회원님의 소중한 정보보호를 위해 출금비밀번호를 운영하고 있습니다.<br><br>설령 아이디와  비밀번호가 노출되어도 출금 비밀번호가 노출되지않으면 출금이 되지 않사오니 출금비밀번호는 반드시 타인에게 유출되지<br><br>않도록 하시기 바랍니다.<br><br>출금 비밀번호가 유출되어 생기는 불상사에 대해서는 저희는 어떠한 보상도 이루어지지 않습니다.<br><br>이점 유념하시어 비밀번호 및 아이디에 보안에 신경써주시기 바랍니다.


</td></tr>
<tr><td bgcolor="#525252">
    <table width="100%" style="color:#8b8b8b;">
    <tr>
        <td width="33%"><b style="color:black">작성자 : <b>관리자</b></td>
        <td width="33%" align="center"><b style="color:black">2008-08-08 오전 1:30:22</td>
        <td width="33%" align="right"><b style="color:black">Read : 744</td>
    </tr></table>

</td></tr>
</table>



<table align="center" border="0" cellpadding="0" cellspacing="0" width="95%" style="padding-top:8px">
<tr><td width="50%" height="30">
        <img src="images/btn_list.gif" onclick="list();" style="cursor:hand;">
        &nbsp;&nbsp;
        <img src="images/btn_prev.gif" onclick="pre_go();" style="cursor:hand;">
        <img src="images/btn_next.gif" onclick="next_go();" style="cursor:hand;">
    </td>

    <td width="50%" height="30" align="right">
		
        &nbsp;&nbsp;
        <a href="board/board.asp?idx=board&m=w"><img src="images/btn_write.gif" border="0"></a>
    </td></tr>
</table>


<script>
function list(){
    location.href="board/board.asp?idx=board";
}
function pre_go(){
    
        location.href="board/board.asp?idx=board&no=13";
    
}
function next_go(){
    
        location.href="board/board.asp?idx=board&no=15";
    
}
function edit(no){
    if(confirm("수정하시겠습니까?")){
        location.href="board/board.asp?idx=board&m=e&no="+ no;
    }
}
function del(no){
    location.href="board/board.asp?idx=board&m=d&no="+ no;
}
</script>


<!--############################################################################################//-->

<script>
function comment_add(){
	
    if(comment_frm.name.value    ==""){ alert("이름을 입력하세요.");      comment_frm.name.focus(); return false; }
    if(comment_frm.comment.value ==""){ alert("댓글 내용을 입력하세요."); comment_frm.comment.focus(); return false; }
    //if(comment_frm.password.value==""){ alert("패스워드를 입력하세요.");  comment_frm.password.focus(); return false; }
    comment_frm.action = "?m=c";
    comment_frm.method = "post";
    comment_frm.submit();

}
function comment_del(val){

    document.all.comment_delfrm.c_del.value = val;
	if(0){
		document.all.comment_delfrm.password.value = "";
	    document.all.comment_delfrm.password.disabled = false;
		cdbox = document.getElementById("comment_delbox");
		cdbox.style.left = event.clientX-180+document.body.scrollLeft;;
		cdbox.style.top  = event.clientY+document.body.scrollTop;
		cdbox.style.visibility='visible';
		document.all.comment_delfrm.password.focus();
	}else{
		if(confirm("삭제하시겠습니까?")){ document.all.comment_delfrm.submit(); }
	}
}
function comment_submit(){
    if(document.all.comment_delfrm.password.value==""){ alert("패스워드를 입력하세요!"); comment_delfrm.password.focus(); return false; }
    comment_delfrm.submit();
}
</script>


<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;border:1 solid #4a4a4a">
<form name="comment_frm" action="?m=c" method="post" onsubmit="comment_add();return false;">
<input type="hidden" name="idx" value="board">
<input type="hidden" name="b_uid" value="14">
<input type="hidden" name="mem_id" value="huzi">

<tr bgcolor="#525252" height="30">
	<td width="120" bgcolor="#3a3a3a" align="center"><b style="color:white"><b>Comment</td>
	<td width="*" style="padding-left:15;">
	작성자 <input type="text" name="name" value="후지모토" style="width:90;height:19px;border:1 #efefef solid;background-color:#8a8a8a;" readonly>

	내용 <input type="text" name="comment" style="width:500;height:19px;border:1 #7f9db9 solid;"></td>
	<td width="100"><input type="image" src="images/btn_write.gif"  style="cursor:hand"></td>
</tr>
</table>

<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr align="center">
    <td colspan="3" bgcolor="#f5f5f5" style="border:1 #c5c5c5 solid;">


        
        <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-left:2px;margin-top:12px;margin-bottom:12px;border-top:1 #c5c5c5 dotted">
        
        <tr><td>

            <table width="100%" height="25" style="border-bottom:1 #c5c5c5 dotted">
            <tr><td width="90"  style="color:black"><b>토마토</b></td>
                <td width="*"   style="color:black">당연한..말씀~&nbsp;&nbsp;수고해주십시요~</td>
                <td width="70" title="2008-09-16 오전 1:50:02" align="center" style="color:black">09/16</td>
				
					<td width="16" align="center">&nbsp;</td>
				
             </tr>
             </table>

        </td></tr>
        
        <tr><td>
            <table width="100%" height="25" style="border-bottom:1 #c5c5c5 dotted">
            <tr><td width="90"  style="color:black"><b>한라산</b></td>
                <td width="*"   style="color:black">나두&nbsp;모싸이트&nbsp;관리자가&nbsp;내걸로자주&nbsp;들어가서&nbsp;그싸이트에서&nbsp;내아디&nbsp;정지시켜나서&nbsp;고생했슴다</td>

                <td width="70" title="2008-09-14 오후 4:28:11" align="center" style="color:black">09/14</td>
				
					<td width="16" align="center">&nbsp;</td>
				
             </tr>
             </table>
        </td></tr>
        
        <tr><td>
            <table width="100%" height="25" style="border-bottom:1 #c5c5c5 dotted">
            <tr><td width="90"  style="color:black"><b>도끼빗</b></td>

                <td width="*"   style="color:black">금융거래정보&nbsp;제공사실</td>
                <td width="70" title="2008-09-07 오전 1:33:03" align="center" style="color:black">09/07</td>
				
					<td width="16" align="center">&nbsp;</td>
				
             </tr>
             </table>
        </td></tr>
        
        </table>

        

    </td>
</tr>
</form>
</table>


<table id="comment_delbox" cellspacing="0" width="180" style="position:absolute;visibility:hidden;border:1 gray solid;">
<form name="comment_delfrm" action="?m=c" method="post">
<input type="hidden" name="idx"   value="board">
<input type="hidden" name="b_uid" value="14">
<input type="hidden" name="c_del" value="">
<tr><td bgcolor="#efefef" align="center" onclick="cdbox.style.visibility='hidden';" style="filter:gray();cursor:hand;">
    <table cellspacing="0" cellpadding="0" width="100%" height="22">
    <tr><td width="*" align="center"><b>댓글 삭제</tD>

        <td width="20" align="right"><img src="images/btn_coment_del.gif"></td>
    </tr></table>
</td></tr>
<tr><td bgcolor="white" align="center">
    패스워드 : <input type="password" name="password" size="6" maxlength="10" style="height:19px;border:1 #7f9db9 solid;"><input name="btn_comment_ok" style="height:19px;border:1 #7f9db9 solid;" type="button" value="삭제" onclick="comment_submit();">
</td></tr>
</form>
</table>

<br><br>

</td></tr>
</table>

<%@include file="footer.jsp"%>


</body>
</html>