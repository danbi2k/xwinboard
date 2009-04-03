ns4 = (navigator.appName.indexOf("Netscape")>=0 && document.layers)? true : false;
ie4 = (document.all && !document.getElementById)? true : false;
ie5 = (document.all && document.getElementById)? true : false;
ns6 = (document.getElementById && navigator.appName.indexOf("Netscape")>=0 )? true: false;
w3c = (document.getElementById)? true : false;
var mx=0;
var my=0;

document.onmousemove=function(evt){
   mx=(ie4||ie5)?event.clientX:evt.pageX;
   my=(ie4||ie5)?event.clientY:evt.pageY;
}

function setCookie(name, value, expire) {
          document.cookie = name + "=" + escape(value)
          + ((expire == null) ? "" : ("; expires=" + expire.toGMTString()))
    return true;
}
function getCookie(Name) {
          var search = Name + "="
          if (document.cookie.length > 0) { // if there are any cookies
                    offset = document.cookie.indexOf(search) 
                    if (offset != -1) { // if cookie exists 
                              offset += search.length 
                              // set index of beginning of value
                              end = document.cookie.indexOf(";", offset) 
                              // set index of end of cookie value
                              if (end == -1) 
                                        end = document.cookie.length
                              return unescape(document.cookie.substring(offset, end))
                    } 
          }
          return null;
}
// delete info on cookie. 
function deleteCookie(name) {
var expire = new Date ();
expire.setTime (expire.getTime() - (24 * 60 * 60 * 1000)); 
document.cookie = name + "=; expires=" + expire.toGMTString(); 
}

function openPopup(s, n, width, height, top, left) {
   var winProperty = 'resizable=yes,scrollbars=no,dependent=1,titlebar=no,menubar=no,toolbar=no,location=no'
                   + ',width='+width+',height='+height+',top='+top+',left='+left;
   var newWin = open(s,n,winProperty);
   newWin.focus();
}
function openPopup2(s, n, width, height, top, left) {
   var winProperty = 'resizable=yes,scrollbars=yes,dependent=no,titlebar=no,menubar=no,toolbar=yes,location=no'
                   + ',width='+width+',height='+height+',top='+top+',left='+left;
   var newWin = open(s,n,winProperty);
   newWin.focus();
}
function openPopup3(s, n, width, height, top, left) {
   var winProperty = 'resizable=yes,scrollbars=yes,dependent=no,titlebar=no,menubar=no,toolbar=no,location=no'
                   + ',width='+width+',height='+height+',top='+top+',left='+left;
   var newWin = open(s,n,winProperty);
   newWin.focus();
}
function centerPopup(s, n, width, height) {
   var winl = (screen.width - width) / 2;
   var wint = (screen.height - height) / 2;
   openPopup(s, n, width, height, wint, winl);
}
function centerPopup3(s, n, width, height) {
   var winl = (screen.width - width) / 2;
   var wint = (screen.height - height) / 2;
   openPopup3(s, n, width, height, wint, winl);
}
function showImage(imageName, imageFile) {
	if (document.images) {
	    document.images[imageName].src = imageFile;
    }
}
function calculate_absolute_X( theElement ) {
	var xPosition = 0;
	while ( theElement != null ) {
		xPosition += theElement.offsetLeft;
		theElement = theElement.offsetParent;
	}
	return xPosition;
}
function calculate_absolute_Y( theElement ) {
	var yPosition = 0;
	while ( theElement != null ) {
		yPosition += theElement.offsetTop;
		theElement = theElement.offsetParent;
	}
	return yPosition;
}
/*function openPopup(s, n, width, height, top, left)
{
   var winProperty = 'resizable=1,scrollbars=1,titlebar=yes,menubar=no,toolbar=no,location=no'
                   + ',width='+width+',height='+height+',top='+top+',left='+left;
   var newWin = open(s,n,winProperty);
   newWin.focus();
}*/
function trimLead(str) {
	while(str.charAt(0)==' ') str=str.substring(1,str.length);
	return str;
}

var da = (document.all) ? 1 : 0;
var pr = (window.print) ? 1 : 0;
var mac = (navigator.userAgent.indexOf("Mac") != -1);
 
function printPage() {
  if (pr) // NS4, IE5
    window.print()
  else if (da && !mac) // IE4 (Windows)
    vbPrintPage()
  else // other browsers
    alert("Sorry, your browser doesn't support this feature.\nTo print, from the File Menu or Tool Bar, select Print.");
  //return false;
}
 
if (da && !pr && !mac) with (document) {
  writeln('<OBJECT ID="WB" WIDTH="0" HEIGHT="0" CLASSID="clsid:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>');
  writeln('<' + 'SCRIPT LANGUAGE="VBScript">');
  writeln('Sub window_onunload');
  writeln('  On Error Resume Next');
  writeln('  Set WB = nothing');
  writeln('End Sub');
  writeln('Sub vbPrintPage');
  writeln('  OLECMDID_PRINT = 6');
  writeln('  OLECMDEXECOPT_DONTPROMPTUSER = 2');
  writeln('  OLECMDEXECOPT_PROMPTUSER = 1');
  writeln('  On Error Resume Next');
  writeln('  WB.ExecWB OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER');
  writeln('End Sub');
  writeln('<' + '/SCRIPT>');
}

//function getSeleled() {
//	if (document.selection) return document.selection.createRange().text;
//	else return "";
//}

function isEmptyString(str) {
    if (str.length == 0) {
        return true;
    }
    for (i = 0; i <(str.length); i++) {
         if (str.charAt(i) != ' ' && str.charAt(i) != '\r' && str.charAt(i) != '\n') {
             return false;
         } 
    }
    return true;
}
function uncheckAll(field) {
  for (i=0; i<field.length; i++) {field[i].checked = false;}
} 
function checkAll(field) {
  for (i=0; i<field.length; i++) {field[i].checked = true;}
} 
function firstChar(str) {
	if (str.length == 0) {
        return '';
    }
    for (i = 0; i <(str.length); i++) {
         if (str.charAt(i) != ' ' && str.charAt(i) != '\r' && str.charAt(i) != '\n') {
             return str.charAt(i);
         } 
    }
}

function getObj(id) {
	return document.getElementById(id);
}

function setDisplay(objectID,state) {
	var object = document.getElementById(objectID);
	object.style.display = state;
}

function toggleInlineDisplay(objectID) {
	var object = document.getElementById(objectID);
	state = object.style.display;
	if (state == 'none')
		object.style.display = 'inline';
	else if (state != 'none')
		object.style.display = 'none'; 
}

function toggleDisplay(objectID) {
	var object = document.getElementById(objectID);
	state = object.style.display;
	if (state == 'none')
		object.style.display = 'block';
	else if (state != 'none')
		object.style.display = 'none'; 
}

function setVisibility(objectID,state) {
	var object = document.getElementById(objectID);
	object.style.visibility = state;
}

function displayObject(objectID) {
	setVisibility(objectID, "visible")
}

function hideObject(objectID) {
	setVisibility(objectID, "hidden")
}

function startFetching() {
    var wh=(ie4||ie5)?document.body.clientHeight:window.innerHeight;
	var ww=(ie4||ie5)?document.body.clientWidth:window.innerWidth;
    ypx = 40;
    xpx = ww/2 - 150;
	showDivXY(xpx, ypx, "fetchTableDIV"); 
}

function stopFetchTableDIVProcessing() {
    setDisplay("fetchTableDIV","none");
}

function startProcessing() {
    var wh=(ie4||ie5)?document.body.clientHeight:window.innerHeight;
	var ww=(ie4||ie5)?document.body.clientWidth:window.innerWidth;
    ypx = wh/2 - 130;
    xpx = ww/2 - 150;
	startProcessingXY(xpx, ypx);
}

function startProcessingY(ypx) {
	var ww=(ie4||ie5)?document.body.clientWidth:window.innerWidth;
	var xpx = ww/2 - 150;
    startProcessingXY(xpx, ypx);
}

function startProcessingX(xpx) {
    var wh=(ie4||ie5)?document.body.clientHeight:window.innerHeight;
	var ypx = wh/2 - 150;
	startProcessingXY(xpx, ypx);
}

function startProcessingXY(xpx, ypx) {
    showDivXY(xpx, ypx, "processingDIV"); 
}

function showDivXY(xpx, ypx, id) {
	var object = document.getElementById(id);
    object.style.left = xpx;
	object.style.top  = ypx;
    object.style.display = 'block';
}

function stopProcessing() {
    setDisplay("processingDIV","none");
}

var dragapproved=false

function drag_drop(e) {
  if (ie5&&dragapproved&&event.button==1){
       document.getElementById("processingDIV").style.left=tempx+event.clientX-offsetx+"px"
       document.getElementById("processingDIV").style.top=tempy+event.clientY-offsety+"px"
  }
  else if (ns6&&dragapproved){
       document.getElementById("processingDIV").style.left=tempx+e.clientX-offsetx+"px"
       document.getElementById("processingDIV").style.top=tempy+e.clientY-offsety+"px"
  }
}

function initializedrag(e){
  offsetx=ie5? event.clientX : e.clientX
  offsety=ie5? event.clientY : e.clientY
  tempx=parseInt(document.getElementById("processingDIV").style.left)
  tempy=parseInt(document.getElementById("processingDIV").style.top)
  dragapproved=true
  document.getElementById("processingDIV").onmousemove=drag_drop
}

function stopdrag(){
  dragapproved=false;
  document.getElementById("processingDIV").onmousemove=null;
}

// Catch Firefox/NS key event
function getUnicode(e){
    var unicode=e.keyCode? e.keyCode : e.charCode;
    return unicode;
}
function addLoadEvent(func) {
	  var oldonload = window.onload;
	  if (typeof window.onload != 'function') {
	    window.onload = func;
	  } else {
	    window.onload = function() {
	      if (oldonload) {
	        oldonload();
	      }
	      func();
	    }
	  }
}
