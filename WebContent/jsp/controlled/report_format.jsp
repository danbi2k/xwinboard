<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   int titleSize = 68;
   String bar = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
   String tablename = request.getParameter("tablename");
   if (tablename == null) {
       tablename = "";
   }
   boolean loadFormat = Boolean.valueOf(request.getParameter("loadFormat")).booleanValue();
   String type = request.getParameter("type");
   String reportType = "HTML";
   if (type.equals("xls")) {
       reportType = "EXCEL&reg;";
   }
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/login.css>
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<script type="text/javascript" SRC="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
<script type="text/javascript" SRC="<%=contextPath%>/scripts/common.js"></script>
<TITLE>DB Cruiser HTML Report Format</TITLE>
</HEAD>
<BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>" OnLoad="setValues();setTextBoxColor();">
<CENTER>
<FONT SIZE=+2 FACE=Arial COLOR="#006633"><B><%=reportType%> Report Format</B></FONT>
<p>
<FORM NAME=inputForm METHOD=POST ACTION="<%=contextPath%>/action/SaveResult">
<INPUT TYPE="hidden" NAME="connId" value="<%=connId%>">
<INPUT TYPE="hidden" NAME="type" value="<%=type%>">
<INPUT TYPE="hidden" NAME="range" value=<%=request.getParameter("range")%>>
<INPUT TYPE="hidden" NAME="from" value=<%=request.getParameter("from")%>>
<INPUT TYPE="hidden" NAME="to" value=<%=request.getParameter("to")%>>
<INPUT TYPE="hidden" NAME="tablename" value=<%=tablename%>>
<INPUT TYPE=hidden NAME=preview value=false>
<% if (message != null) { %>
       <%=message%>
<% } %>
<table border=0>
<tr>
<td><nobr>TITLE&nbsp;&nbsp;<INPUT TYPE="text" NAME="title" size=<%=titleSize%>></nobr></td>
</tr>

<tr><td colspan=4>
<table style="border:1px solid #282828;width:100%;" CELLPADDING="0" CELLSPACING="0">
<tr><td>

<table border="0">
<tr>
<td><B>Title Position</B></td>
<td>
<SELECT name=title_text_postion style="width:80">
<option value="left">LEFT
<option value="center">CENTER
<option value="right">RIGHT
</SELECT>
</td>
<td><nobr><%=bar%>
<B>Title Color</B></nobr></td>
<td valign=bottom>
<INPUT TYPE="text" NAME="titleColor" id="titleColor" size=9>
<img class="actimage" src="<%=imagePath%>/palette.gif" title="Click to pick a color" onclick="colorPopup('titleColor');">
</td>
</tr>
<tr>
<td><B>Title Font Size</B></td>
<td>
<SELECT name=title_font_size style="width:80">
<option value="18">DEFAULT
<%=PublicAPI.fontSizeList()%>
</SELECT>
</td>
<td><nobr><%=bar%>
<B>Title Font</B></nobr></td>
<td>
<SELECT name=title_font style="width:125">
<jsp:include page="/jsp/inc/font.html" flush="true" />
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
<td><B>Background Color</B></td>
<td>
<INPUT TYPE="text" name="headerBgcolor" id="headerBgcolor" size=9>
<img class="actimage" src="<%=imagePath%>/palette.gif" title="Click to pick a color" onclick="colorPopup('headerBgcolor');">
</td>
<td align=right>&nbsp;<B>Text Color</B></td>
<td>
<INPUT TYPE="text" name="headerTextColor" id="headerTextColor" size=9>
<img class="actimage" src="<%=imagePath%>/palette.gif" title="Click to pick a color" onclick="colorPopup('headerTextColor');">
</td>
</tr>
<tr>
<td><B>Text Font Size</B></td>
<td>
<SELECT name=header_text_font_size  style="width:125">
<option value="11">DEFAULT
<%=PublicAPI.fontSizeList()%>
</SELECT>
</td>
<td><nobr>&nbsp;<B>Text Font</B></nobr></td>
<td>
<SELECT name=header_text_font style="width:125">
<jsp:include page="/jsp/inc/font.html" flush="true" />
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
<td><B>Even Row Backgd Color</B></td>
<td>
<INPUT TYPE="text" name="resultBgcolor1" id="resultBgcolor1" size=9>
<img class="actimage" src="<%=imagePath%>/palette.gif" title="Click to pick a color" onclick="colorPopup('resultBgcolor1');">
</td>
<td><B>Text Color</B></td>
<td>
<INPUT TYPE="text" name="resultTextColor" id="resultTextColor" size=9>
<img class="actimage" src="<%=imagePath%>/palette.gif" title="Click to pick a color" onclick="colorPopup('resultTextColor');">
</td>
</tr>
<tr>
<td><B>Odd Row Backgd Color</B></td>
<td>
<INPUT TYPE="text" name="resultBgcolor2" id="resultBgcolor2" size=9>
<img class="actimage" src="<%=imagePath%>/palette.gif" title="Click to pick a color" onclick="colorPopup('resultBgcolor2');">
</td>
<td><B>Text Font</B></td>
<td>
<SELECT name=result_text_font  style="width:125">
<option value="Arial">DEFAULT
<jsp:include page="/jsp/inc/font.html" flush="true" />
</SELECT>
</td>
</tr>
<tr>

<td><B>Text Font Size</B></td>
<td>
<SELECT name=result_text_font_size  style="width:125">
<option value="11">DEFAULT
<%=PublicAPI.fontSizeList()%>
</SELECT>
</td>
<td><B>CLOB View</B></td>
<td>
<SELECT name=clobAsOriginal  style="width:125">
<option value="true">As Original
<option value="false">Collapsed
</SELECT>
</tr>
</table>
</td></tr>
</table>
</td></tr>
<tr style="height:35px;">
<td><nobr>
<B>Report Backgroung Color</B>
<INPUT TYPE="text" name="reportBgcolor" id="reportBgcolor" size=9>
<img class="actimage" src="<%=imagePath%>/palette.gif" title="Click to pick a color" onclick="colorPopup('reportBgcolor');">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
<li><a href="javascript:preview();" title="Preview the report quickly - only preview the current page">&nbsp;Preview&nbsp;&nbsp;</a></li>
<li><a href="javascript:checkFields();" style="color:#ffffff;background-color:#8080C0;" title="Generate the whole report">&nbsp;Generate&nbsp;&nbsp;</a></li>
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

function setTextBoxColor() {
   var obj = getObj("titleColor");
   var bgColor = document.inputForm.titleColor.value; 
   if (bgColor != null && bgColor != "") {
       obj.style.backgroundColor = bgColor;
   }
   obj = getObj("headerBgcolor");
   bgColor = document.inputForm.headerBgcolor.value; 
   if (bgColor != null && bgColor != "") {
       obj.style.backgroundColor = bgColor;
   }
   obj = getObj("headerTextColor");
   bgColor = document.inputForm.headerTextColor.value; 
   if (bgColor != null && bgColor != "") {
       obj.style.backgroundColor = bgColor;
   }
   obj = getObj("resultBgcolor1");
   bgColor = document.inputForm.resultBgcolor1.value; 
   if (bgColor != null && bgColor != "") {
       obj.style.backgroundColor = bgColor;
   }
   obj = getObj("resultBgcolor2");
   bgColor = document.inputForm.resultBgcolor2.value; 
   if (bgColor != null && bgColor != "") {
       obj.style.backgroundColor = bgColor;
   }
   obj = getObj("resultTextColor");
   bgColor = document.inputForm.resultTextColor.value; 
   if (bgColor != null && bgColor != "") {
       obj.style.backgroundColor = bgColor;
   }
   obj = getObj("reportBgcolor");
   bgColor = document.inputForm.reportBgcolor.value; 
   if (bgColor != null && bgColor != "") {
       obj.style.backgroundColor = bgColor;
   }
}
function colorPopup(fieldname) {
   var url = '<%=actionPath%>/Palette?fieldname='+fieldname;
   <% if (browser.indexOf("MSIE") > 0) { %>
   colorwin=dhtmlwindow.open('colorbox', 'iframe', url, 'Color Picker', 'width=245px,height=209px,resize=1,scrolling=1,center=0', 'blue');
   <% } else if (browser.indexOf("Netscape") > 0) { %>
   colorwin=dhtmlwindow.open('colorbox', 'iframe', url, 'Color Picker', 'width=242px,height=203px,resize=1,scrolling=1,center=0', 'blue');
   <% } else {%>
   colorwin=dhtmlwindow.open('colorbox', 'iframe', url, 'Color Picker', 'width=240px,height=201px,resize=1,scrolling=1,center=0', 'blue');
   <% } %>
}
var myForm = document.inputForm;

function checkFields() {
	check_fields();
}

function check_fields() {
	if (checkData()) {
	    setCookies();
	    document.inputForm.preview.value="false";
	    document.inputForm.target = "_self";
	    document.inputForm.submit();
    }
}

function checkData() {
	if (document.inputForm.title.value == "") {
		alert("Please enter report Title.");
        document.inputForm.title.focus();
		return false;
	}
	if (document.inputForm.titleColor.value == "") {
		alert("Please enter report Title Color.");
        document.inputForm.titleColor.focus();
		return false;
	}
	if (document.inputForm.headerBgcolor.value == "") {
		alert("Please enter report Header Bacground Color.");
        document.inputForm.headerBgcolor.focus();
		return false;
	}
	if (document.inputForm.headerTextColor.value == "") {
		alert("Please enter report Header Text Color.");
        document.inputForm.headerTextColor.focus();
		return false;
	}
	if (document.inputForm.resultBgcolor1.value == "") {
		alert("Please enter report Body Background Color 1.");
        document.inputForm.resultBgcolor1.focus();
		return false;
	}
	if (document.inputForm.resultBgcolor2.value == "") {
		alert("Please enter report Body Background Color 2.");
        document.inputForm.resultBgcolor2.focus();
		return false;
	}
	if (document.inputForm.resultTextColor.value == "") {
		alert("Please enter report Body Text Color.");
        document.inputForm.resultTextColor.focus();
		return false;
	}
	if (document.inputForm.reportBgcolor.value == "") {
		alert("Please enter report Background Color.");
        document.inputForm.reportBgcolor.focus();
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
    document.inputForm.titleColor.value = "<%=reportFormat.getProperty("titleColor")%>";
	document.inputForm.headerBgcolor.value = "<%=reportFormat.getProperty("headerBgcolor")%>";
	document.inputForm.headerTextColor.value = "<%=reportFormat.getProperty("headerTextColor")%>";
	document.inputForm.resultBgcolor1.value = "<%=reportFormat.getProperty("resultBgcolor1")%>";
	document.inputForm.resultBgcolor2.value = "<%=reportFormat.getProperty("resultBgcolor2")%>";
	document.inputForm.resultTextColor.value = "<%=reportFormat.getProperty("resultTextColor")%>";
	document.inputForm.reportBgcolor.value = "<%=reportFormat.getProperty("reportBgcolor")%>";
    for (var i=0; i<myForm.title_text_postion.length; i++) {
		 if (myForm.title_text_postion.options[i].text == "<%=reportFormat.getProperty("title_text_postion")%>") {
             myForm.title_text_postion.options[i].selected = true;
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
	for (var i=0; i<myForm.clobAsOriginal.length; i++) {
		 if (myForm.clobAsOriginal.options[i].value == "<%=reportFormat.getProperty("clobAsOriginal")%>") {
             myForm.clobAsOriginal.options[i].selected = true;
		 }
    }
}
<% } else { %>
	document.inputForm.title.value = getCookie("title")?getCookie("title"):"My Special Report";
	document.inputForm.titleColor.value = getCookie("titleColor")?getCookie("titleColor"):"#0000CC";
	document.inputForm.headerBgcolor.value = getCookie("headerBgcolor")?getCookie("headerBgcolor"):"<%=info.get("header_color").toUpperCase()%>"; 
	document.inputForm.headerTextColor.value = getCookie("headerTextColor")?getCookie("headerTextColor"):"#000000";
	document.inputForm.resultBgcolor1.value = getCookie("resultBgcolor1")?getCookie("resultBgcolor1"):"WHITE";
	document.inputForm.resultBgcolor2.value = getCookie("resultBgcolor2")?getCookie("resultBgcolor2"):"<%=info.get("result_bgcolor").toUpperCase()%>";
	document.inputForm.resultTextColor.value = getCookie("resultTextColor")?getCookie("resultTextColor"):"NAVY";
	document.inputForm.reportBgcolor.value = getCookie("reportBgcolor")?getCookie("reportBgcolor"):"WHITE";
	document.inputForm.title_text_postion.selectedIndex = getCookie("titleTextPostionIndex")?getCookie("titleTextPostionIndex"):"0";
	document.inputForm.title_font_size.selectedIndex = getCookie("titleFontSizeIndex")?getCookie("titleFontSizeIndex"):"18";
	document.inputForm.title_font.selectedIndex = getCookie("titleFontIndex")?getCookie("titleFontIndex"):"0";
	document.inputForm.header_text_font_size.selectedIndex = getCookie("headerTextFontSizeIndex")?getCookie("headerTextFontSizeIndex"):"0";
	document.inputForm.header_text_font.selectedIndex = getCookie("headerTextFontIndex")?getCookie("headerTextFontIndex"):"0";
	document.inputForm.result_text_font.selectedIndex = getCookie("resultTextFontIndex")?getCookie("resultTextFontIndex"):"0";
	document.inputForm.result_text_font_size.selectedIndex = getCookie("resultTextFontSizeIndex")?getCookie("resultTextFontSizeIndex"):"0";
	document.inputForm.displayDate.selectedIndex = getCookie("displayDateIndex")?getCookie("displayDateIndex"):"0";
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
}
</SCRIPT>
<%=PublicAPI.reportFormatScript(jspPath)%>