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

<form name="frm">
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_gamelist.gif"></td><td>1~10경기까지 자유롭게 조합배팅이 가능합니다.</td></td>

	<td align="right">
		<table cellpadding="0" cellspacing="0">
		<tr><td>리그선택 : <select name="GameGroup" style="color:white;background-color:black;" onchange="GameList.location.href='game_list.asp?m=0&GameGroup='+ this.value;"><option value="">--전체--</option><option value='60' style=''>UEFA 챔피언스리그</option><option value='114' style=''>2010월드컵 예선</option><option value='45' style=''>올림픽 남자축구</option><option value='33' style=''>올림픽 여자축구</option><option value='117' style=''>국제친선[A매치]</option><option value='12' style=''>국제 Club 친선경기</option><option value='47' style=''>남미축구연맹 Copa</option><option value='178' style=''>네덜란드 1부리그</option><option value='127' style=''>네덜란드 2부리그</option><option value='187' style=''>네덜란드 Cup</option><option value='40' style=''>노르웨이 1부리그</option><option value='104' style=''>노르웨이 2부리그</option><option value='121' style=''>노르웨이 Junior U19</option><option value='152' style=''>노르웨이 여자</option><option value='10' style=''>대한민국 K리그</option><option value='165' style=''>K-리그 Cup</option><option value='116' style=''>대한민국 FA Cup</option><option value='77' style=''>덴마크 1부리그</option><option value='102' style=''>덴마크 2부리그</option><option value='79' style=''>독일 분데스리가</option><option value='90' style=''>독일 분데스리가 2부</option><option value='188' style=''>독일 Cup</option><option value='142' style=''>러시아 프리미어리그</option><option value='36' style=''>러시아 1부리그</option><option value='163' style=''>러시아 RRL</option><option value='28' style=''>러시아 Cup</option><option value='173' style=''>러시아 RPL</option><option value='119' style=''>루마니아 1부리그</option><option value='75' style=''>미국프로축구 MLS</option><option value='68' style=''>멕시코 1부리그</option><option value='158' style=''>북중미축구연맹 Champions</option><option value='31' style=''>브라질 1부 Serie A</option><option value='30' style=''>브라질 2부 Serie B</option><option value='80' style=''>벨기에 1부리그</option><option value='65' style=''>벨기에 2부리그</option><option value='14' style=''>싱가폴 1부리그</option><option value='43' style=''>스위스 1부리그</option><option value='57' style=''>스웨덴 1부리그</option><option value='73' style=''>스웨덴 Superettan</option><option value='122' style=''>스웨덴 Cup</option><option value='67' style=''>슬로바키아 1부리그</option><option value='160' style=''>슬로바키아 2부리그</option><option value='181' style=''>슬로바키아 Cup</option><option value='190' style=''>슬로베니아 1부리그</option><option value='183' style=''>슬로베니아 Cup</option><option value='66' style=''>스코틀랜드 리그컵</option><option value='81' style=''>스코틀랜드 Premier</option><option value='82' style=''>스코틀랜드 1부리그</option><option value='128' style=''>스코틀랜드 3부리그</option><option value='143' style=''>스페인 Primera</option><option value='144' style=''>스페인 2부리그</option><option value='135' style=''>스페인 Super Cup</option><option value='161' style=''>스페인 Cup</option><option value='49' style=''>아르헨티나 1부리그</option><option value='140' style=''>아르헨티나 2부리그</option><option value='184' style=''>아이슬란드 Premier</option><option value='44' style=''>아이슬란드 1부리그</option><option value='138' style=''>아일랜드 프리미어리그</option><option value='139' style=''>아일랜드 1부리그</option><option value='103' style=''>아일랜드 Cup</option><option value='182' style=''>아시아축구연맹 CL</option><option value='185' style=''>아시아축구연맹 Cup</option><option value='176' style=''>아프리카축구연맹 CL</option><option value='172' style=''>알제리 1부리그</option><option value='87' style=''>일본 J리그 1st</option><option value='137' style=''>일본 J리그 2st</option><option value='169' style=''>일본 리그 Cup</option><option value='157' style=''>일본 Nabisco Cup</option><option value='11' style=''>잉글랜드 프리미어리그</option><option value='70' style=''>잉글랜드 Conference</option><option value='159' style=''>잉글랜드 JPT</option><option value='83' style=''>잉글랜드 1부리그</option><option value='171' style=''>잉글랜드 North Premier</option><option value='129' style=''>잉글랜드 칼링컵</option><option value='131' style=''>잉글랜드 챔피언쉽</option><option value='164' style=''>웨일즈 1부리그</option><option value='155' style=''>웨일즈 Cup</option><option value='145' style=''>이탈리아 Serie A</option><option value='150' style=''>이탈리아 Serie B</option><option value='115' style=''>이탈리아 Cup</option><option value='136' style=''>이탈리아 Super Cup</option><option value='123' style=''>이란 1부리그</option><option value='125' style=''>오스트리아 Erste Liga</option><option value='174' style=''>오스트리아 Cup</option><option value='130' style=''>우크라이나 1부리그</option><option value='126' style=''>에스토니아 1부리그</option><option value='149' style=''>중국 슈퍼리그</option><option value='96' style=''>체코 1부리그</option><option value='118' style=''>체코 2부리그</option><option value='151' style=''>체코 Cup</option><option value='180' style=''>칠레 1부리그</option><option value='132' style=''>터키 1부리그</option><option value='170' style=''>터키 2부리그</option><option value='156' style=''>터키 Cup</option><option value='177' style=''>캐나다 Premier Leaue</option><option value='92' style=''>크로아티아 1부리그</option><option value='133' style=''>코스타리카 1부리그</option><option value='89' style=''>콜롬비아 1부리그</option><option value='86' style=''>프랑스 1부 리그</option><option value='94' style=''>프랑스 2부 리그</option><option value='162' style=''>프랑스 Cup</option><option value='56' style=''>핀란드 1부리그</option><option value='63' style=''>핀란드 2부리그</option><option value='120' style=''>핀란드 3부리그</option><option value='134' style=''>포르투칼 1부리그</option><option value='189' style=''>포르투칼 리그 Cup</option><option value='41' style=''>페루 1부리그</option><option value='85' style=''>폴란드 1부리그</option><option value='39' style=''>폴란드 2부리그</option><option value='153' style=''>폴란드 Cup</option><option value='175' style=''>헝가리 1부리그</option><option value='186' style=''>헝가리 Cup</option><option value='76' style=''>호주 1부리그</option><option value='166' style=''>호주 Foxtel Cup</option><option value='167' style=''>호주NSW 프리미어리그</option><option value='72' style=''>UEFA CUP</option><option value='93' style=''>UEFA U21 CHAMPIONSHIP</option><option value='141' style=''>UEFA 슈퍼컵</option><option value='147' style=''>USA  Open Cup</option><option value='9' style=''>미국 남자프로농구</option><option value='55' style=''>올림픽 남자농구</option><option value='112' style=''>올림픽 여자농구</option><option value='6' style=''>한국프로야구</option><option value='8' style=''>일본 프로야구</option><option value='58' style=''>미국 메이저리그</option><option value='61' style=''>올림픽 야구</option><option value='98' style=''>올림픽 남자배구</option><option value='113' style=''>올림픽 여자배구</option><option value='52' style=''>PGA</option><option value='88' style=''>LPGA</option><option value='54' style=''>올림픽 남자 핸드볼</option><option value='71' style=''>올림픽 여자 핸드볼</option><option value='100' style=''>올림픽 여자 하키</option><option value='124' style=''>올림픽 남자 하키</option></select></td>

			<td><img src="images/btn_reload.gif" onclick="GameList.location.href=GameList.location.href;" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>
		</tr></table>
	</td>
	</table>
</td></tr>
<tr><td valign="top" align="center">

	<table width="900" bgcolor="#d9d8d6" cellspacing="1" cellpadding="3">

	<colgroup>
		<col align="center" width="100">

		<col align="center" width="*">
		<col align="center" width="180">
		<col align="center" width="80">
		<col align="center" width="180">
		<col align="center" width="50">
	</colgroup>

	<tr bgcolor="#ce892c">
		<td height=34 style="color:white;"><b>경기일시</td>

		<td style="color:white;"><b>리그</td>
		<td style="color:white;"><b>승</td>
		
			<td style="color:white;"><b>무</td>
		
		<td style="color:white;"><b>패</td>
		<td style="color:white;"><b>상태</td>
	</tr>

	</table>

	<iframe name="GameList" src="game_list_wdl.jsp" frameborder="0" width="900" height="278"></iframe>

</tr>
<tr><td align="center" style="padding-top:10px;">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_betcart.gif"></td><td></td></td>
	</table>
</td></tr>

<tr><td align="center">

	<iframe name="GameCart" src="game_cart.jsp" frameborder="0" width="900" height="100"></iframe>

</td></tr>
</table>
</form>

<%@include file="footer.jsp"%>