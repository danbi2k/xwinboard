<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title> 우편번호 검색 </title>
<link href="/common/css/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #f2f2f2;
}
.style1 {	color: #006699;
	font-weight: bold;
}
.style2 {color: #FF6600}
-->
</style>
<script language='javascript'>
	function doSearch() {
		if(zlfm.dong.value=='') {
			alert('검색하실 동을 입력하세요')
			zlfm.dong.focus();
			return false;
		}
	}
</script>

</head>
<body onload="zlfm.dong.focus();" style="margin:0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr><td valign="middle" bgcolor="F2F2F2">&nbsp;</td></tr>
    <tr> 
        <td valign="middle" bgcolor="F2F2F2"> 
            <table width="401" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                    <td><img src="/images/bg_03.gif" width="401" height="11"></td>
                </tr>
                <tr> 
                    <td height="25" background="/images/bg_04.gif"><img src="/images/title_15.gif" width="117" height="14"></td>
                </tr>
                <tr> 
                    <td><img src="/images/bg_05.gif" width="401" height="6"></td>
                </tr>
                <tr> 
                    <td background="/images/bg_06.gif"> 
                        <table width="320" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr><td>&nbsp;</td></tr>
                            <tr> 
                                <td>검색결과에서 찾으시는 주소링크를 선택하시면 자동으로 입력됩니다</td>
                            </tr>
                            <tr><td >&nbsp;</td></tr>
                            <tr> 
                                <td> 
                                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
										<FORM name="zlfm" method="post" onsubmit="return doSearch();" action="zipcode_process.asp" Target="zippro">
										<input type=hidden name=fn value="<%=Request("fn")%>">
										<input type=hidden name=n1 value="<%=Request("n1")%>">
										<input type=hidden name=z1 value="<%=Request("z1")%>">
										<input type=hidden name=z2 value="<%=Request("z2")%>">
                                        <tr> 
                                            <td height="1" bgcolor="#1A9BD4"></td>
                                            <td height="1" bgcolor="#1A9BD4"></td>
                                            <td height="1" bgcolor="#57B6DF"></td>
                                            <td height="1" bgcolor="#57B6DF"></td>
                                        </tr>
                                        <tr> 
                                            <td width="100" height="50" bgcolor="F2F8FB">
                                                <div align="center">주소입력</div>
                                            </td>
                                            <td width="10" height="50" bgcolor="F2F8FB">&nbsp;</td>
                                            <td width="140" height="50" bgcolor="FCFCFC">
                                                <input name="dong" type="text" class="input" size="16">
                                            </td>
                                            <td height="50" bgcolor="FCFCFC"><input type=image src="/images/but_11.gif" width="37" height="18"></td>
                                        </tr>
                                        <tr> 
                                            <td height="1" bgcolor="#DCDCDC"></td>
                                            <td height="1" bgcolor="#DCDCDC"></td>
                                            <td height="1" bgcolor="#DCDCDC"></td>
                                            <td height="1" bgcolor="#DCDCDC"></td>
                                        </tr>
                                        </form>
                                    </table>
                                </td>
                            </tr>
                            <tr> 
                                <td height="200"> 
								<!-- 검색 후 리스트 뿌려지는 테이블 시작 -->
		     					<!-----------------------------------------  IFrame start  ----------------------------------------->	
								<IFRAME align="center" valign="top" frameBorder=0 marginHeight=0 marginWidth=0 name=zippro scrolling=auto src="zipcode_process.asp?fn=<%=Request("fn")%>&z1=<%=Request("z1")%>&z2=<%=Request("z2")%>&n1=<%=Request("n1")%>" width="390" height="139"></IFRAME>
								<!----------------------------------------- IFrame end  -------------------------------------------->
								<!-- 검색 후 리스트 뿌려지는 테이블 끝 -->	                                
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr> 
                    <td><img src="/images/bg_02.gif" width="401" height="7"></td>
                </tr>
                
            </table>
        </td>
    </tr>
</table>
</body>
</html>
