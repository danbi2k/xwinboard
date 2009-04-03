<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   String fieldname = request.getParameter("fieldname");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<TITLE>Choose Color</TITLE>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/login.css>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
</HEAD>
<BODY OnLoad="setTimeout('window.close()', 300000)">
<FORM NAME="setupForm" METHOD="POST">
<img src="<%=imagePath%>/colormaps.gif" border=0 usemap="#color_maps" ismap WIDTH=191 HEIGHT=96><BR>
<TABLE WIDTH="191" BORDER="0" CELLPADDING="0" CELLSPACING="0"><TR>
<TD ID="colorPreviewPanel"><IMG SRC="images/blank.gif" WIDTH=1 HEIGHT=10 ALT="" BORDER=0></TD>
</TR></TABLE>
<TABLE WIDTH="191" BORDER="0" CELLPADDING="0" CELLSPACING="0"><TR>
<TD><INPUT TYPE="text" NAME="colorcode" VALUE="#FFFFFF" SIZE="9" MAXLENGTH=7></TD>
<TD ALIGN=RIGHT><A HREF="javascript:openPopup2('color_table.html', 'rgb_color_table', 650);window.close();" TARGET=_self>more colors ...</A></TD>
</TR></TABLE><BR>
<map name="color_maps">
  <area shape="rect" coords="1,1,11,12" href="javascript:lock_color('#FF0000')" 
  onmouseover="display_color('#FF0000'); return true" onclick="pick();">
  <area shape="rect" coords="12,1,23,12" href="javascript:lock_color('#FFFF00')" 
  onmouseover="display_color('#FFFF00'); return true" onclick="pick();">
  <area shape="rect" coords="24,1,35,12" href="javascript:lock_color('#00FF00')" 
  onmouseover="display_color('#00FF00'); return true" onclick="pick();">
  <area shape="rect" coords="36,1,47,12" href="javascript:lock_color('#00FFFF')" 
  onmouseover="display_color('#00FFFF'); return true" onclick="pick();">
  <area shape="rect" coords="48,1,59,12" href="javascript:lock_color('#0000FF')" 
  onmouseover="display_color('#0000FF'); return true" onclick="pick();">
  <area shape="rect" coords="60,1,71,12" href="javascript:lock_color('#FF00FF')" 
  onmouseover="display_color('#FF00FF'); return true" onclick="pick();">
  <area shape="rect" coords="72,1,83,12" href="javascript:lock_color('#FFFFFF')" 
  onmouseover="display_color('#FFFFFF'); return true" onclick="pick();">
  <area shape="rect" coords="84,1,95,12" href="javascript:lock_color('#E6E6E6')" 
  onmouseover="display_color('#E6E6E6'); return true" onclick="pick();">
  <area shape="rect" coords="96,1,107,12" href="javascript:lock_color('#D9D9D9')" 
  onmouseover="display_color('#D9D9D9'); return true" onclick="pick();">
  <area shape="rect" coords="108,1,119,12" href="javascript:lock_color('#CCCCCC')" 
  onmouseover="display_color('#CCCCCC'); return true" onclick="pick();">
  <area shape="rect" coords="120,1,131,12" href="javascript:lock_color('#BFBFBF')" 
  onmouseover="display_color('#BFBFBF'); return true" onclick="pick();">
  <area shape="rect" coords="132,1,143,12" href="javascript:lock_color('#B3B3B3')" 
  onmouseover="display_color('#B3B3B3'); return true" onclick="pick();">
  <area shape="rect" coords="144,1,155,12" href="javascript:lock_color('#A6A6A6')" 
  onmouseover="display_color('#A6A6A6'); return true" onclick="pick();">
  <area shape="rect" coords="156,1,167,12" href="javascript:lock_color('#999999')" 
  onmouseover="display_color('#999999'); return true" onclick="pick();">
  <area shape="rect" coords="168,1,179,12" href="javascript:lock_color('#8C8C8C')" 
  onmouseover="display_color('#8C8C8C'); return true" onclick="pick();">
  <area shape="rect" coords="180,1,191,12" href="javascript:lock_color('#808080')" 
  onmouseover="display_color('#808080'); return true" onclick="pick();">
  
  <area shape="rect" coords="1,13,11,24" href="javascript:lock_color('#C40026')" 
  onmouseover="display_color('#C40026'); return true" onclick="pick();">
  <area shape="rect" coords="12,13,23,24" href="javascript:lock_color('#FFEB00')" onmouseover="display_color('#FFEB00'); return true" onclick="pick();">
  <area shape="rect" coords="24,13,35,24" href="javascript:lock_color('#008740')" onmouseover="display_color('#008740'); return true" onclick="pick();">
  <area shape="rect" coords="36,13,47,24" href="javascript:lock_color('#00A1DC')" onmouseover="display_color('#00A1DC'); return true" onclick="pick();">
  <area shape="rect" coords="48,13,59,24" href="javascript:lock_color('#1C0B5A')" onmouseover="display_color('#1C0B5A'); return true" onclick="pick();">
  <area shape="rect" coords="60,13,71,24" href="javascript:lock_color('#C50067')" onmouseover="display_color('#C50067'); return true" onclick="pick();">
  <area shape="rect" coords="72,13,83,24" href="javascript:lock_color('#737373')" onmouseover="display_color('#737373'); return true" onclick="pick();">
  <area shape="rect" coords="84,13,95,24" href="javascript:lock_color('#666666')" onmouseover="display_color('#666666'); return true" onclick="pick();">
  <area shape="rect" coords="96,13,107,24" href="javascript:lock_color('#595959')" onmouseover="display_color('#595959'); return true" onclick="pick();">
  <area shape="rect" coords="108,13,119,24" href="javascript:lock_color('#4D4D4D')" onmouseover="display_color('#4D4D4D'); return true" onclick="pick();">
  <area shape="rect" coords="120,13,131,24" href="javascript:lock_color('#404040')" onmouseover="display_color('#404040'); return true" onclick="pick();">
  <area shape="rect" coords="132,13,143,24" href="javascript:lock_color('#333333')" onmouseover="display_color('#333333'); return true" onclick="pick();">
  <area shape="rect" coords="144,13,155,24" href="javascript:lock_color('#262626')" onmouseover="display_color('#262626'); return true" onclick="pick();">
  <area shape="rect" coords="156,13,167,24" href="javascript:lock_color('#1A1A1A')" onmouseover="display_color('#1A1A1A'); return true" onclick="pick();">
  <area shape="rect" coords="168,13,179,24" href="javascript:lock_color('#0D0D0D')" onmouseover="display_color('#0D0D0D'); return true" onclick="pick();">
  <area shape="rect" coords="180,13,191,24" href="javascript:lock_color('#000000')" onmouseover="display_color('#000000'); return true" onclick="pick();">
  
  <area shape="rect" coords="1,25,11,36" href="javascript:lock_color('#F09A76')" 
  onmouseover="display_color('#F09A76'); return true" onclick="pick();">
  <area shape="rect" coords="12,25,23,36" href="javascript:lock_color('#F6B280')" 
  onmouseover="display_color('#F6B280'); return true" onclick="pick();">
  <area shape="rect" coords="24,25,35,36" href="javascript:lock_color('#FDCA8A')" 
  onmouseover="display_color('#FDCA8A'); return true" onclick="pick();">
  <area shape="rect" coords="36,25,47,36" href="javascript:lock_color('#FFF09E')" 
  onmouseover="display_color('#FFF09E'); return true" onclick="pick();">
  <area shape="rect" coords="48,25,59,36" href="javascript:lock_color('#D1DF9C')" 
  onmouseover="display_color('#D1DF9C'); return true" onclick="pick();">
  <area shape="rect" coords="60,25,71,36" href="javascript:lock_color('#B3D39B')" 
  onmouseover="display_color('#B3D39B'); return true" onclick="pick();">
  <area shape="rect" coords="72,25,83,36" href="javascript:lock_color('#96C79A')" 
  onmouseover="display_color('#96C79A'); return true" onclick="pick();">
  <area shape="rect" coords="84,25,95,36" href="javascript:lock_color('#94CAC7')" 
  onmouseover="display_color('#94CAC7'); return true" onclick="pick();">
  <area shape="rect" coords="96,25,107,36" href="javascript:lock_color('#8ECDF0')" 
  onmouseover="display_color('#8ECDF0'); return true" onclick="pick();">
  <area shape="rect" coords="108,25,119,36" href="javascript:lock_color('#8FA7D1')" onmouseover="display_color('#8FA7D1'); return true" onclick="pick();">
  <area shape="rect" coords="120,25,131,36" href="javascript:lock_color('#8F92C0')" onmouseover="display_color('#8F92C0'); return true" onclick="pick();">
  <area shape="rect" coords="132,25,143,36" href="javascript:lock_color('#8E7FB0')" onmouseover="display_color('#8E7FB0'); return true" onclick="pick();">
  <area shape="rect" coords="144,25,155,36" href="javascript:lock_color('#A586B3')" onmouseover="display_color('#A586B3'); return true" onclick="pick();">
  <area shape="rect" coords="156,25,167,36" href="javascript:lock_color('#BE8EB5')" onmouseover="display_color('#BE8EB5'); return true" onclick="pick();">
  <area shape="rect" coords="168,25,179,36" href="javascript:lock_color('#ED9DB9')" onmouseover="display_color('#ED9DB9'); return true" onclick="pick();">
  <area shape="rect" coords="180,25,191,36" href="javascript:lock_color('#EF9C99')" onmouseover="display_color('#EF9C99'); return true" onclick="pick();">
  
  <area shape="rect" coords="1,37,11,48" href="javascript:lock_color('#E16745')" 
  onmouseover="display_color('#E16745'); return true" onclick="pick();">
  <area shape="rect" coords="12,37,23,48" href="javascript:lock_color('#ED8F4E')" 
  onmouseover="display_color('#ED8F4E'); return true" onclick="pick();">
  <area shape="rect" coords="24,37,35,48" href="javascript:lock_color('#F7B357')" 
  onmouseover="display_color('#F7B357'); return true" onclick="pick();">
  <area shape="rect" coords="36,37,47,48" href="javascript:lock_color('#FFEC67')" 
  onmouseover="display_color('#FFEC67'); return true" onclick="pick();">
  <area shape="rect" coords="48,37,59,48" href="javascript:lock_color('#B8D26B')" 
  onmouseover="display_color('#B8D26B'); return true" onclick="pick();">
  <area shape="rect" coords="60,37,71,48" href="javascript:lock_color('#8CC06C')" 
  onmouseover="display_color('#8CC06C'); return true" onclick="pick();">
  <area shape="rect" coords="72,37,83,48" href="javascript:lock_color('#5AAD6D')" 
  onmouseover="display_color('#5AAD6D'); return true" onclick="pick();">
  <area shape="rect" coords="84,37,95,48" href="javascript:lock_color('#57B1AF')" 
  onmouseover="display_color('#57B1AF'); return true" onclick="pick();">
  <area shape="rect" coords="96,37,107,48" href="javascript:lock_color('#4CB5E8')" 
  onmouseover="display_color('#4CB5E8'); return true" onclick="pick();">
  <area shape="rect" coords="108,37,119,48" href="javascript:lock_color('#5984BD')" onmouseover="display_color('#5984BD'); return true" onclick="pick();">
  <area shape="rect" coords="120,37,131,48" href="javascript:lock_color('#5C6AA6')" onmouseover="display_color('#5C6AA6'); return true" onclick="pick();">
  <area shape="rect" coords="132,37,143,48" href="javascript:lock_color('#5D4D8D')" onmouseover="display_color('#5D4D8D'); return true" onclick="pick();">
  <area shape="rect" coords="144,37,155,48" href="javascript:lock_color('#815490')" onmouseover="display_color('#815490'); return true" onclick="pick();">
  <area shape="rect" coords="156,37,167,48" href="javascript:lock_color('#A35B92')" onmouseover="display_color('#A35B92'); return true" onclick="pick();">
  <area shape="rect" coords="168,37,179,48" href="javascript:lock_color('#E06897')" onmouseover="display_color('#E06897'); return true" onclick="pick();">
  <area shape="rect" coords="180,37,191,48" href="javascript:lock_color('#E16871')" onmouseover="display_color('#E16871'); return true" onclick="pick();">
  
  <area shape="rect" coords="1,49,11,60" href="javascript:lock_color('#DC143C')" 
  onmouseover="display_color('#DC143C'); return true" onclick="pick();">
  <area shape="rect" coords="12,49,23,60" href="javascript:lock_color('#DC6000')" 
  onmouseover="display_color('#DC6000'); return true" onclick="pick();">
  <area shape="rect" coords="24,49,35,60" href="javascript:lock_color('#EC9800')" 
  onmouseover="display_color('#EC9800'); return true" onclick="pick();">
  <area shape="rect" coords="36,49,47,60" href="javascript:lock_color('#FFEB00')" 
  onmouseover="display_color('#FFEB00'); return true" onclick="pick();">
  <area shape="rect" coords="48,49,59,60" href="javascript:lock_color('#92C000')" 
  onmouseover="display_color('#92C000'); return true" onclick="pick();">
  <area shape="rect" coords="60,49,71,60" href="javascript:lock_color('#4DA619')" 
  onmouseover="display_color('#4DA619'); return true" onclick="pick();">
  <area shape="rect" coords="72,49,83,60" href="javascript:lock_color('#008740')" 
  onmouseover="display_color('#008740'); return true" onclick="pick();">
  <area shape="rect" coords="84,49,95,60" href="javascript:lock_color('#008F93')" 
  onmouseover="display_color('#008F93'); return true" onclick="pick();">
  <area shape="rect" coords="96,49,107,60" href="javascript:lock_color('#00A0DD')" 
  onmouseover="display_color('#00A0DD'); return true" onclick="pick();">
  <area shape="rect" coords="108,49,119,60" href="javascript:lock_color('#0063A4')" onmouseover="display_color('#0063A4'); return true" onclick="pick();">
  <area shape="rect" coords="120,49,131,60" href="javascript:lock_color('#003D84')" onmouseover="display_color('#003D84'); return true" onclick="pick();">
  <area shape="rect" coords="132,49,143,60" href="javascript:lock_color('#1C0B5A')" onmouseover="display_color('#1C0B5A'); return true" onclick="pick();">
  <area shape="rect" coords="144,49,155,60" href="javascript:lock_color('#53005D')" onmouseover="display_color('#53005D'); return true" onclick="pick();">
  <area shape="rect" coords="156,49,167,60" href="javascript:lock_color('#7C0060')" onmouseover="display_color('#7C0060'); return true" onclick="pick();">
  <area shape="rect" coords="168,49,179,60" href="javascript:lock_color('#C50067')" onmouseover="display_color('#C50067'); return true" onclick="pick();">
  <area shape="rect" coords="180,49,191,60" href="javascript:lock_color('#C5004C')" onmouseover="display_color('#C5004C'); return true" onclick="pick();">

  <area shape="rect" coords="1,61,11,72" href="javascript:lock_color('#800019')" 
  onmouseover="display_color('#800019'); return true" onclick="pick();">
  <area shape="rect" coords="12,61,23,72" href="javascript:lock_color('#903F01')" 
  onmouseover="display_color('#903F01'); return true" onclick="pick();">
  <area shape="rect" coords="24,61,35,72" href="javascript:lock_color('#9A6400')" 
  onmouseover="display_color('#9A6400'); return true" onclick="pick();">
  <area shape="rect" coords="36,61,47,72" href="javascript:lock_color('#AA9D00')" 
  onmouseover="display_color('#AA9D00'); return true" onclick="pick();">
  <area shape="rect" coords="48,61,59,72" href="javascript:lock_color('#5F7D00')" 
  onmouseover="display_color('#5F7D00'); return true" onclick="pick();">
  <area shape="rect" coords="60,61,71,72" href="javascript:lock_color('#326C11')" 
  onmouseover="display_color('#326C11'); return true" onclick="pick();">
  <area shape="rect" coords="72,61,83,72" href="javascript:lock_color('#00582A')" 
  onmouseover="display_color('#00582A'); return true" onclick="pick();">
  <area shape="rect" coords="84,61,95,72" href="javascript:lock_color('#005D60')" 
  onmouseover="display_color('#005D60'); return true" onclick="pick();">
  <area shape="rect" coords="96,61,107,72" href="javascript:lock_color('#006890')" 
  onmouseover="display_color('#006890'); return true" onclick="pick();">
  <area shape="rect" coords="108,61,119,72" href="javascript:lock_color('#00416B')" onmouseover="display_color('#00416B'); return true" onclick="pick();">
  <area shape="rect" coords="120,61,131,72" href="javascript:lock_color('#002856')" onmouseover="display_color('#002856'); return true" onclick="pick();">
  <area shape="rect" coords="132,61,143,72" href="javascript:lock_color('#13053B')" onmouseover="display_color('#13053B'); return true" onclick="pick();">
  <area shape="rect" coords="144,61,155,72" href="javascript:lock_color('#36003D')" onmouseover="display_color('#36003D'); return true" onclick="pick();">
  <area shape="rect" coords="156,61,167,72" href="javascript:lock_color('#51003F')" onmouseover="display_color('#51003F'); return true" onclick="pick();">
  <area shape="rect" coords="168,61,179,72" href="javascript:lock_color('#810043')" onmouseover="display_color('#810043'); return true" onclick="pick();">
  <area shape="rect" coords="180,61,191,72" href="javascript:lock_color('#810032')" onmouseover="display_color('#810032'); return true" onclick="pick();">

  <area shape="rect" coords="1,73,11,84" href="javascript:lock_color('#5B0012')" 
  onmouseover="display_color('#5B0012'); return true" onclick="pick();">
  <area shape="rect" coords="12,73,23,84" href="javascript:lock_color('#672D01')" 
  onmouseover="display_color('#672D01'); return true" onclick="pick();">
  <area shape="rect" coords="24,73,35,84" href="javascript:lock_color('#6E4700')" 
  onmouseover="display_color('#6E4700'); return true" onclick="pick();">
  <area shape="rect" coords="36,73,47,84" href="javascript:lock_color('#797000')" 
  onmouseover="display_color('#797000'); return true" onclick="pick();">
  <area shape="rect" coords="48,73,59,84" href="javascript:lock_color('#445900')" 
  onmouseover="display_color('#445900'); return true" onclick="pick();">
  <area shape="rect" coords="60,73,71,84" href="javascript:lock_color('#244D0C')" 
  onmouseover="display_color('#244D0C'); return true" onclick="pick();">
  <area shape="rect" coords="72,73,83,84" href="javascript:lock_color('#003F1E')" 
  onmouseover="display_color('#003F1E'); return true" onclick="pick();">
  <area shape="rect" coords="84,73,95,84" href="javascript:lock_color('#004345')" 
  onmouseover="display_color('#004345'); return true" onclick="pick();">
  <area shape="rect" coords="96,73,107,84" href="javascript:lock_color('#004A67')" 
  onmouseover="display_color('#004A67'); return true" onclick="pick();">
  <area shape="rect" coords="108,73,119,84" href="javascript:lock_color('#002E4D')" onmouseover="display_color('#002E4D'); return true" onclick="pick();">
  <area shape="rect" coords="120,73,131,84" href="javascript:lock_color('#001D3E')" onmouseover="display_color('#001D3E'); return true" onclick="pick();">
  <area shape="rect" coords="132,73,143,84" href="javascript:lock_color('#0D052A')" onmouseover="display_color('#0D052A'); return true" onclick="pick();">
  <area shape="rect" coords="144,73,155,84" href="javascript:lock_color('#27002B')" onmouseover="display_color('#27002B'); return true" onclick="pick();">
  <area shape="rect" coords="156,73,167,84" href="javascript:lock_color('#3A002D')" onmouseover="display_color('#3A002D'); return true" onclick="pick();">
  <area shape="rect" coords="168,73,179,84" href="javascript:lock_color('#5C0030')" onmouseover="display_color('#5C0030'); return true" onclick="pick();">
  <area shape="rect" coords="180,73,191,84" href="javascript:lock_color('#5C0023')" onmouseover="display_color('#5C0023'); return true" onclick="pick();">
  
  <area shape="rect" coords="1,85,11,96" href="javascript:lock_color('#C9B49A')" 
  onmouseover="display_color('#C9B49A'); return true" onclick="pick();">
  <area shape="rect" coords="12,85,23,96" href="javascript:lock_color('#9C8772')" 
  onmouseover="display_color('#9C8772'); return true" onclick="pick();">
  <area shape="rect" coords="24,85,35,96" href="javascript:lock_color('#736152')" 
  onmouseover="display_color('#736152'); return true" onclick="pick();">
  <area shape="rect" coords="36,85,47,96" href="javascript:lock_color('#504139')" 
  onmouseover="display_color('#504139'); return true" onclick="pick();">
  <area shape="rect" coords="48,85,59,96" href="javascript:lock_color('#322926')" 
  onmouseover="display_color('#322926'); return true" onclick="pick();">
  <area shape="rect" coords="60,85,71,96" href="javascript:lock_color('#C79F6D')" 
  onmouseover="display_color('#C79F6D'); return true" onclick="pick();">
  <area shape="rect" coords="72,85,83,96" href="javascript:lock_color('#A67E4E')" 
  onmouseover="display_color('#A67E4E'); return true" onclick="pick();">
  <area shape="rect" coords="84,85,95,96" href="javascript:lock_color('#896235')" 
  onmouseover="display_color('#896235'); return true" onclick="pick();">
  <area shape="rect" coords="96,85,107,96" href="javascript:lock_color('#6E4A20')" 
  onmouseover="display_color('#6E4A20'); return true" onclick="pick();">
  <area shape="rect" coords="108,85,119,96" href="javascript:lock_color('#56350D')" onmouseover="display_color('#56350D'); return true" onclick="pick();">
  <area shape="rect" coords="120,85,131,96" href="javascript:lock_color('#FFCCFF')" onmouseover="display_color('#FFCCFF'); return true" onclick="pick();">
  <area shape="rect" coords="132,85,143,96" href="javascript:lock_color('#CCCCFF')" onmouseover="display_color('#CCCCFF'); return true" onclick="pick();">
  <area shape="rect" coords="144,85,155,96" href="javascript:lock_color('#CCCC99')" onmouseover="display_color('#CCCC99'); return true" onclick="pick();">
  <area shape="rect" coords="156,85,167,96" href="javascript:lock_color('#E7EDFE')" onmouseover="display_color('#E7EDFE'); return true" onclick="pick();">
  <area shape="rect" coords="168,85,179,96" href="javascript:lock_color('#0000CC')" onmouseover="display_color('#0000CC'); return true" onclick="pick();">
  <area shape="rect" coords="180,85,191,96" href="javascript:lock_color('#000080')" onmouseover="display_color('#000080'); return true" onclick="pick();">
</map>
</form>
</BODY>
</HTML>
<%=PublicAPI.chooseColorScript(fieldname)%>
