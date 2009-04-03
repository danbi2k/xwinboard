<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   int titleSize = 68;
   String bar = "&nbsp;&nbsp;&nbsp;&nbsp;";
   String tablename = request.getParameter("tablename");
   if (tablename == null) {
       tablename = "";
   }
   boolean loadFormat = Boolean.valueOf(request.getParameter("loadFormat")).booleanValue();
   String controller = request.getParameter("controller");
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/login.css>
<TITLE>DB Cruiser PDF Report Format</TITLE>
<script type="text/javascript" SRC="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
</HEAD>
<BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>" OnLoad="setValues();">
<CENTER>
<FONT SIZE=+2 FACE=Arial COLOR="#006633"><B>PDF Report Format</B></FONT>
<p>
<FORM NAME=inputForm METHOD=POST ACTION="<%=actionPath%>/<%=controller%>">
<INPUT TYPE="hidden" NAME="connId" value=<%=connId%>>
<INPUT TYPE="hidden" NAME="type" value="pdf">
<INPUT TYPE="hidden" NAME="range" value=<%=request.getParameter("range")%>>
<INPUT TYPE="hidden" NAME="from" value=<%=request.getParameter("from")%>>
<INPUT TYPE="hidden" NAME="to" value=<%=request.getParameter("to")%>>
<INPUT TYPE="hidden" NAME="tablename" value=<%=tablename%>>
<INPUT TYPE=hidden NAME=preview value=false>
<% if (message != null) { %>
       <%=message%>
<% } %>
<table border=0>
<% if (controller != null && controller.equals("SaveResult")) { %>
<tr>
<td><nobr>TITLE&nbsp;&nbsp;<INPUT TYPE="text" NAME="title" size=<%=titleSize%>></nobr></td>
</tr>
<% } else { %>
<INPUT TYPE="hidden" NAME="title" value="Special Report">
<% } %>
<tr><td colspan=4>
<table style="border:1px solid #282828;width:100%;" CELLPADDING="0" CELLSPACING="0">
<tr><td>

<table border="0">
<tr>
<td><B>Title Position</B></td>
<td valign=bottom>
<SELECT name=title_text_postion style="width:100">
<option>CENTER
<option>LEFT
<option>RIGHT
</SELECT>
</td>
<td><nobr><%=bar%>
<B>Font Style</B></nobr></td>
<td valign=bottom>
<SELECT name=titleFontStyle style="width:100">
<jsp:include page="/jsp/inc/font_style.html" flush="true" />
</SELECT>
</td>
</tr>
<tr>
<td><nobr><B>Title Font Size</B>&nbsp;</nobr></td>
<td>
<SELECT name=title_font_size style="width:100">
<%=PublicAPI.fontSizeList()%>
</SELECT>
</td>
<td><nobr><%=bar%>
<B>Title Font</B></nobr></td>
<td>
<SELECT name=title_font style="width:150">
<jsp:include page="/jsp/inc/pdf_font.html" flush="true" />
</SELECT>
</td></tr>
</table>
</td></tr></table>
</td>
</tr>
<tr><td colspan=4>HEADER</td></tr>
<tr>
<td colspan=4>
<table style="border:1px solid #282828;width:100%;" CELLPADDING="0" CELLSPACING="0">
<tr><td>

<table border="0">
<tr>
<td><nobr><B>Text Font Style</B></nobr></td>
<td valign=bottom>
<SELECT name=headerFontStyle style="width:100">
<jsp:include page="/jsp/inc/font_style.html" flush="true" />
</SELECT>
</td>
<td align=right>&nbsp;</td>
<td>
&nbsp;
</td>
</tr>
<tr>
<td><B>Text Font Size</B></td>
<td>
<SELECT name=header_text_font_size  style="width:100">
<%=PublicAPI.fontSizeList()%>
</SELECT>
</td>
<td><nobr><%=bar%><B>Text Font</B>&nbsp;</nobr></td>
<td>
<SELECT name=header_text_font style="width:150">
<jsp:include page="/jsp/inc/pdf_font.html" flush="true" />
</SELECT>
</td>
</tr>
</table>

</td></tr></table>

<tr>
<td colspan=4>BODY</td></tr>
<tr>
<td colspan=4>
<table style="border:1px solid #282828;width:100%;" CELLPADDING="0" CELLSPACING="0">
<tr><td>

<table border="0">
<tr>
<td><B>Text Font Style</B></td>
<td>
<SELECT name=resultFontStyle style="width:100">
<jsp:include page="/jsp/inc/font_style.html" flush="true" />
</SELECT>
</td>
<td>&nbsp;</td>
<td>
&nbsp;
</td>
</tr>
<tr>

<td><B>Text Font Size</B></td>
<td>
<SELECT name=result_text_font_size  style="width:100">
<%=PublicAPI.fontSizeList()%>
</SELECT>
</td>
<td><nobr><%=bar%><B>Text Font</B>&nbsp;</nobr></td>
<td>
<SELECT name=result_text_font  style="width:150">
<jsp:include page="/jsp/inc/pdf_font.html" flush="true" />
</SELECT>
</td>
</tr>
</table>
</td></tr>
</table>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td><nobr>
<B>Layout</B>
<SELECT name=orientation>
<option value=portrait>Portrait
<option value=landscape>Landscape
</SELECT>
&nbsp;&nbsp;
<B>Page Size</B>
<SELECT name=pageSize>
<option value=11X17>11X17
<option value=LEGAL>LEGAL
<option value=LETTER>LETTER
<option value=A0>A0
<option value=A1>A1
<option value=A2>A2
<option value=A3>A3
<option value=A4>A4
<option value=A5>A5
<option value=A6>A6
<option value=A7>A7
<option value=A8>A8
<option value=A9>A9
<option value=A10>A10
<option value=B0>B0
<option value=B1>B1
<option value=B2>B2
<option value=B3>B3
<option value=B4>B4
<option value=B5>B5
<option value=ARCH_A>ARCH_A
<option value=ARCH_B>ARCH_B
<option value=ARCH_C>ARCH_C
<option value=ARCH_D>ARCH_D
<option value=ARCH_E>ARCH_E
<option value=FLSA>FLSA
<option value=FLSE>FLSE
<option value=LEDGER>LEDGER
<option value=NOTE>NOTE
</SELECT>
&nbsp;&nbsp;
<B>Display</B>
<SELECT name=displayDate>
<option value=nodate>NO DATE</option>
<option value=date>DATE</option>
<option value=timestamp>TIMESTAMP</option>
</SELECT>
</nobr></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<div id="actcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;Back&nbsp;&nbsp;</a></li>
<% if (browser.indexOf("MSIE") > 0) { %>
   <li><input type="file" name="filename" style="width:150px;font-size:9px;"></li>
<% } else {%>
   <li><input type="file" name="filename" style="font-size:9px;" size="12"></li>
<% } %>
<li><a href="javascript:uploadFormat();" title="Load previous format setting from a file">&nbsp;&nbsp;Load Format&nbsp;&nbsp;</a></li>
<li><a href="javascript:saveToFile();" title="Save the format setting to a file for future use">&nbsp;&nbsp;Save Format&nbsp;&nbsp;</a></li>
<% if (controller != null && controller.equals("SaveResult")) { %>
   <li><a href="javascript:preview();" title="Preview the report quickly - only preview the current page">&nbsp;&nbsp;Preview&nbsp;&nbsp;</a></li>
<% } else { %>
   <li><a href="javascript:dhtmlwindow.close(window.parent.savewin);" title="Close this window">&nbsp;&nbsp;Close&nbsp;&nbsp;</a></li>
<% } %>
<li><a href="javascript:checkFields();" style="color:#ffffff;background-color:#8080C0;" title="Generate the whole report">&nbsp;&nbsp;Generate&nbsp;&nbsp;</a></li>
</ul>
</div>
</td>
</tr>
</table>
<p>
<%=PublicAPI.copyrightStr2()%>
</CENTER></BODY>
</HTML>

<SCRIPT LANGUAGE="JavaScript">

var myForm = document.inputForm;

function checkFields() {
	check_fields();
}

function check_fields() {
	if (checkData()) {
	    setCookies();
	    document.inputForm.submit();
    }
}

function checkData() {
	if (document.inputForm.title.value == "") {
		alert("Please enter report Title.");
        document.inputForm.title.focus();
		return false;
	}
	return true;
}

function setCookies() {
	var today   = new Date();
    var expires = new Date();
    expires.setTime(today.getTime() + 60*60*24*365*1000);
	setCookie("title", document.inputForm.title.value,expires);
	/*
	setCookie("titleColor", document.inputForm.titleColor.value,expires);
	setCookie("headerBgcolor", document.inputForm.headerBgcolor.value,expires);
	setCookie("headerTextColor", document.inputForm.headerTextColor.value,expires);
	setCookie("resultBgcolor1", document.inputForm.resultBgcolor1.value,expires);
	setCookie("resultBgcolor2", document.inputForm.resultBgcolor2.value,expires);
	setCookie("resultTextColor", document.inputForm.resultTextColor.value,expires);
	setCookie("reportBgcolor", document.inputForm.reportBgcolor.value,expires);
	setCookie("titleTextPostionIndex", document.inputForm.title_text_postion.selectedIndex,expires);
	setCookie("titleFontSizeIndex", document.inputForm.title_font_size.selectedIndex,expires);
	setCookie("titleFontIndex", document.inputForm.title_font.selectedIndex,expires);
	setCookie("headerTextFontSizeIndex", document.inputForm.header_text_font_size.selectedIndex,expires);
	setCookie("headerTextFontIndex", document.inputForm.header_text_font.selectedIndex,expires);
	setCookie("resultTextFontIndex", document.inputForm.result_text_font.selectedIndex,expires);
	setCookie("resultTextFontSizeIndex", document.inputForm.result_text_font_size.selectedIndex,expires);
	setCookie("displayDateIndex", document.inputForm.displayDate.selectedIndex,expires);
    */
}

function setValues() {
<% if (loadFormat) { Properties reportFormat = (Properties)session.getAttribute("reportFormat"); %>
	document.inputForm.title.value = "<%=reportFormat.getProperty("title")%>";
    //document.inputForm.titleColor.value = "<%=reportFormat.getProperty("titleColor")%>";
	//document.inputForm.headerBgcolor.value = "<%=reportFormat.getProperty("headerBgcolor")%>";
	//document.inputForm.headerTextColor.value = "<%=reportFormat.getProperty("headerTextColor")%>";
	//document.inputForm.resultBgcolor1.value = "<%=reportFormat.getProperty("resultBgcolor1")%>";
	//document.inputForm.resultBgcolor2.value = "<%=reportFormat.getProperty("resultBgcolor2")%>";
	//document.inputForm.resultTextColor.value = "<%=reportFormat.getProperty("resultTextColor")%>";
	//document.inputForm.reportBgcolor.value = "<%=reportFormat.getProperty("reportBgcolor")%>";
    for (var i=0; i<myForm.title_text_postion.length; i++) {
		 if (myForm.title_text_postion.options[i].text == "<%=reportFormat.getProperty("title_text_postion")%>") {
             myForm.title_text_postion.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.titleFontStyle.length; i++) {
		 if (myForm.titleFontStyle.options[i].text == "<%=reportFormat.getProperty("titleFontStyle")%>") {
             myForm.titleFontStyle.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.title_font_size.length; i++) {
		 if (myForm.title_font_size.options[i].value == "<%=reportFormat.getProperty("title_font_size")%>") {
             myForm.title_font_size.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.title_font.length; i++) {
		 if (myForm.title_font.options[i].value == "<%=reportFormat.getProperty("title_font")%>") {
             myForm.title_font.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.header_text_font_size.length; i++) {
		 if (myForm.header_text_font_size.options[i].value == "<%=reportFormat.getProperty("header_text_font_size")%>") {
             myForm.header_text_font_size.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.header_text_font.length; i++) {
		 if (myForm.header_text_font.options[i].value == "<%=reportFormat.getProperty("header_text_font")%>") {
             myForm.header_text_font.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.result_text_font.length; i++) {
		 if (myForm.result_text_font.options[i].value == "<%=reportFormat.getProperty("result_text_font")%>") {
             myForm.result_text_font.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.result_text_font_size.length; i++) {
		 if (myForm.result_text_font_size.options[i].value == "<%=reportFormat.getProperty("result_text_font_size")%>") {
             myForm.result_text_font_size.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.displayDate.length; i++) {
		 if (myForm.displayDate.options[i].value == "<%=reportFormat.getProperty("displayDate")%>") {
             myForm.displayDate.options[i].selected = true;
		 }
    }
	for (var i=0; i<myForm.orientation.length; i++) {
		 if (myForm.orientation.options[i].value == "<%=reportFormat.getProperty("orientation")%>") {
             myForm.orientation.options[i].selected = true;
		 }
    }
}
<% } else { %>
	document.inputForm.title.value = getCookie("title")?getCookie("title"):"My Special Report";
	//document.inputForm.titleColor.value = getCookie("titleColor")?getCookie("titleColor"):"#0000CC";
	//document.inputForm.headerBgcolor.value = getCookie("headerBgcolor")?getCookie("headerBgcolor"):"<%=info.get("header_color").toUpperCase()%>"; 
	//document.inputForm.headerTextColor.value = getCookie("headerTextColor")?getCookie("headerTextColor"):"#0000CC";
	//document.inputForm.resultBgcolor1.value = getCookie("resultBgcolor1")?getCookie("resultBgcolor1"):"WHITE";
	//document.inputForm.resultBgcolor2.value = getCookie("resultBgcolor2")?getCookie("resultBgcolor2"):"<%=info.get("result_bgcolor").toUpperCase()%>";
	//document.inputForm.resultTextColor.value = getCookie("resultTextColor")?getCookie("resultTextColor"):"NAVY";
	//document.inputForm.reportBgcolor.value = getCookie("reportBgcolor")?getCookie("reportBgcolor"):"WHITE";
	document.inputForm.title_text_postion.selectedIndex = getCookie("titleTextPostionIndex")?getCookie("titleTextPostionIndex"):"0";
	document.inputForm.title_font_size.selectedIndex = getCookie("titleFontSizeIndex")?getCookie("titleFontSizeIndex"):"19";
	document.inputForm.titleFontStyle.selectedIndex = getCookie("titleFontStyleIndex")?getCookie("titleFontStyleIndex"):"1";
	document.inputForm.title_font.selectedIndex = getCookie("titleFontIndex")?getCookie("titleFontIndex"):"4";
	document.inputForm.header_text_font_size.selectedIndex = getCookie("headerTextFontSizeIndex")?getCookie("headerTextFontSizeIndex"):"9";
	document.inputForm.headerFontStyle.selectedIndex = getCookie("headerFontStyleIndex")?getCookie("headerFontStyleIndex"):"1";
	document.inputForm.header_text_font.selectedIndex = getCookie("headerTextFontIndex")?getCookie("headerTextFontIndex"):"4";
	document.inputForm.result_text_font.selectedIndex = getCookie("resultTextFontIndex")?getCookie("resultTextFontIndex"):"4";
	document.inputForm.resultFontStyle.selectedIndex = getCookie("resultFontStyleIndex")?getCookie("resultFontStyleIndex"):"0";
	document.inputForm.result_text_font_size.selectedIndex = getCookie("resultTextFontSizeIndex")?getCookie("resultTextFontSizeIndex"):"7";
	document.inputForm.displayDate.selectedIndex = getCookie("displayDateIndex")?getCookie("displayDateIndex"):"0";
	document.inputForm.pageSize.selectedIndex = getCookie("pageSize")?getCookie("pageSize"):"7";
	document.inputForm.orientation.selectedIndex = getCookie("orientation")?getCookie("orientation"):"0";
}
<% } %>
function saveToFile() {
	document.inputForm.action="<%=actionPath%>/SaveReportFormat";
    document.inputForm.submit();
	document.inputForm.action="<%=actionPath%>/SaveResult";
}
function uploadFormat() {
	if (document.inputForm.filename.value == "") {
        alert("No format file specified.\n\nUse \"Browse...\" button to select a format file.");
        document.inputForm.filename.focus();
    } else {
        document.inputForm.target = "_self";
		document.inputForm.action="<%=actionPath%>/LoadReportFormat";
        document.inputForm.encoding = "multipart/form-data";
		document.inputForm.submit();
	}
}
function preview() {
	document.inputForm.action="<%=actionPath%>/SaveResult";
	document.inputForm.preview.value="true";
	document.inputForm.target = "_blank";
    document.inputForm.submit();
    document.inputForm.preview.value="false";
    document.inputForm.target = "_self";
}
</SCRIPT>
<%=PublicAPI.reportFormatScript(jspPath)%>