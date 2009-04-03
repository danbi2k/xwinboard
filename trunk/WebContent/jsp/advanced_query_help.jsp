<%@ page import="java.util.*, com.maththinking.dbcruiser.*" %>
<% 
   ConfigBean info = ConfigBean.getInstance();
   String contextPath = request.getContextPath();
   String jsp_prefix  = info.get("jsp_prefix");
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<TITLE>DB Cruiser: Query Builder Help</TITLE>
<META content="MSHTML 5.00.2314.1000" name=GENERATOR>
<SCRIPT LANGUAGE="JavaScript">
window.focus();
</SCRIPT>
</HEAD>
<body>
<center>
<font FACE="Helvetica,Arial" size=+2 color="#0000CC"><b>DB Cruiser: Query Builder Help</b></font><p>
<table border=0 width=70%>
<tr><td colspan=2>
<font color="#0000CC"><b>Query Builder</b></font> <font color=darkgreen><b> can help you build complex queries with minimum or without typing.</b></font>
</td>
</tr><tr>
<td>&nbsp;</td></tr><tr><td colspan=2>
<font color=darkgreen><b>Currently,</b></font> <font color="#0000CC"><b>Query Builder</b></font> <font color=darkgreen><b>can only build the following type of queries:</b></font>
</td>
</tr><tr>
<td colspan=2>
<nobr><font color="#0000CC">SELECT col_1, col_2, ..., col_n FROM table WHERE (conditions) ORDER BY col_k1, col_k2, ..., col_km</font></nobr>
</td>
</tr><tr><tr>
<td>&nbsp;</td></tr>
<tr>
<td colspan=2>
<font color=darkgreen><b>For more complicated queries, please use</b></font> <font color="#0000CC"><b>SQL Work Sheet.</b></font>
</td></tr>
</table>
<FORM>
<table border=1 width=70%>
<tr>
<td valign=top align=center><input type=button value="  <--  ">&nbsp;<input type=button value="  -->  "></td>
<td> Select or De-Select columns to view or to order by.<br>
     <nobr>You may select multiple columns by pressing and holding Ctrl or Shift key.</nobr></td>
</tr>
<tr>
<td valign=top align=center><input type=button value=" <<-- ">&nbsp;<input type=button value=" -->> "></td>
<td> Select or De-Select all columns to view or to order by</td>
</tr>
<tr>
<td valign=top align=center><input type=button value="Up">&nbsp;<input type=button value="Down"></td>
<td> Move selcted columns up or down</td>
</tr>
<tr>
<td valign=top align=center><input type=button value="Clear"></td>
<td> Clear WHERE area.</td>
</tr>
<tr>
<td valign=top align=center><input type=button value="Get Columns"></td>
<td> <nobr>Select columns from SELECT, TABLE COLUMNS or ORDER BY boxes,</nobr><br>
     then click "Get Columns",
     <nobr>the columns names selected will appear in WHERE area.</nobr><br> 
     You may select multiple columns by pressing and holding Ctrl or Shift key. </td>
</tr>
<tr>
<td valign=top align=center><input type=button value=" = ">&nbsp;<input type=button value=" > ">&nbsp;<input type=button value=" Is Null "><br><b>....</b></td>
<td valign=top> <nobr>Click these functional buttons. their symbol or operation will appear in WHERE area.</nobr>
</td>
</tr>
</table>
</FORM>
<%=PublicAPI.copyrightStr()%>
</center>
</BODY>
</HTML>
