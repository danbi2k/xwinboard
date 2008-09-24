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
	<tr><td width="100"><img src="images/title_customer.gif"></td><td>1:1 고객센터 입니다. 문의사항 및 건의사항을 적어주세요.</td>

	<td align="right">			
		<table cellpadding="0">
		<tr><td><img src="images/msn.gif"></td>
			<td><input type="text" name="msn" value="x10bet@hotmail.com" onclick="MyAddToContacts('x10bet@hotmail.com');" size=18 style="color:#efefef;background-color:black;border:0;cursor:hand;" readonly></td>
		</tr>
		</table>
	</td></tr>
	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

	<link rel='stylesheet' href='common/board.css'><script language='JavaScript' src='common/board.js'></script><br><table align='center' width='95%' cellpadding='0' cellspacing='0' style='margin-top:7px;'><tr align='center'><td width='10'><img src='images/title_left.gif'></td><td width='50'  background='images/title_bg.gif'>번호</td><td width='*'   background='images/title_bg.gif'>제목</td><td width='100' background='images/title_bg.gif'>작성자</td><td width='100' background='images/title_bg.gif'>작성일</td><td width='50'  background='images/title_bg.gif'>조회수</td><td width='10'><img src='images/title_right.gif'></td></tr>
	<tr height='23' align="center">
		<td>&nbsp;</td>
		<td style='border-bottom:1 #c5c5c5 dotted;color:orange' class='board_list'><b>공지</td>
		<td style='border-bottom:1 #c5c5c5 dotted;color:orange' class='board_list' align="left"><span style="width:100%;color:orange;height:15;overflow:hidden;"><b><a class="board_list" style="color:orange;" href="?idx=customer&no=5" title="쉬! 비밀번호는  새것으로 넣어 관리 하세요..">쉬! 비밀번호는  새것으로 넣어 관리 하세요..</span></td>

		<td style='border-bottom:1 #c5c5c5 dotted;color:orange' class='board_list'><b>관리자</td>
		<td style='border-bottom:1 #c5c5c5 dotted;color:orange' class='board_list'>08/12</td>
		<td style='border-bottom:1 #c5c5c5 dotted;color:orange' class='board_list'>252</td>
		<td>&nbsp;</td>
	</tr>
	<tr height='89'><td align='center' colspan='10' style='border-bottom:1 #c5c5c5 dotted;' class='board_list'>등록된 게시물이 없습니다.</td></tr></table>

<table width="95%" height="41" align='center' cellpadding='0' cellspacing='0'>
<tr><td width="*" style="padding-left:20;">

    <!-----[ 페이징 ]--------------------------------------------//-->
    
    <IMG src="images/icon_back_gray.gif" BORDER=0 style="margin:0 0 -2 0">
    

    &nbsp;
    <font class='page_nolink'>1</font>
    &nbsp;

    
    <IMG src="images/icon_next_gray.gif" BORDER=0 style="margin:0 0 -2 0">

    

    <!-----[ 페이징 ]--------------------------------------------//-->

    </td>
    <td align="right">
        <table align='center' width='95%' cellpadding='0' cellspacing='0' style='margin-top:10;'>
        <tr><td></td>
            <td align="right"><a href="?idx=customer&m=w"><img src="images/btn_write.gif" border="0"></td></tr>
        </table>
    </td>

    </tr>
</table>




</td></tr>
</table>



<%@include file="footer.jsp"%>




<script> 
<!-- 
function MySendIM(person){ 
   try{MsgrObj.classid="clsid:B69003B3-C55E-4B48-836C-BC5946FC3B28";} 
   catch(e){if(!(e.number && 2148139390) == 2148139390)return;} 
   if(MsgrObj.MyStatus == 1){ alert("메신저에 로그인되어 있지 않습니다."); return; } 
   MsgrObj.InstantMessage(person); 
} 

function MyAddToContacts(person) { 
   try{MsgrObj.classid="clsid:B69003B3-C55E-4B48-836C-BC5946FC3B28";} 
   catch(e){if(!(e.number && 2148139390) == 2148139390)return;} 
   if(MsgrObj.MyStatus == 1) { alert("메신저에 로그인되어 있지 않습니다."); return; } 
   try{ var contact = MsgrObj.GetContact(person,"");}   
   catch(e){
		//if((e.number && 2164261642) == 2164261642){  
			try{ MsgrObj.AddContact(0,person); }
			catch(e){ 
				var tempval=eval("document.all.msn");
				tempval.focus();
				tempval.select();
				var therange=tempval.createTextRange();
				therange.execCommand("Copy");
				alert("메신저 주소를 복사하였습니다.\nMSN 메신저에서 친구등록시 붙여넣기 하세요!\n\n※ IE 7.0의 경우 클립보드 엑세스를 허용해야만 합니다."); return; 
			}
		//} 
	} 
} 
--> 
</script>