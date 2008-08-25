function isEmail(s)
{
  return s.search(/^\s*[\w\~\-\.]+\@[\w\~\-]+(\.[\w\~\-]+)+\s*$/g)>=0;
}

function isnull(f,str)
{
	if (f==null || f.value==""){
		alert(str);
		try{
			f.focus();
		}catch(e){}
		return true;
	}else{
		return false;
	}
}

function only_number(){
	if ((event.keyCode>=48 && event.keyCode<=57) || event.keyCode==13){
		return true;
	}else{
		return false;
	}
}

function only_eng(){
	if ((event.keyCode>=48 && event.keyCode<=57) || (event.keyCode>=65 && event.keyCode<=90) || (event.keyCode>=97 && event.keyCode<=122) || event.keyCode==45 || event.keyCode==95 || event.keyCode==13){
		return true;
	}else{
		return false;
	}
}

function isEng(str){
	var chrcode=0;
	for (i=0;i<str.length;i++){
		chrcode=str.charCodeAt(i);
		if (!((chrcode>=48 && chrcode<=57) || (chrcode>=97 && chrcode<=122))){
			return false;
		}
	}
	return true;
}

function JuminCheck(jumin1,jumin2) {
	var resno=jumin1 + "-" + jumin2;
	
	// 주민번호의 형태와 7번째 자리(성별) 유효성 검사
	fmt = /^\d{6}-[1234]\d{6}$/;
	if (!fmt.test(resno)) {
		return false;
	}

	// 날짜 유효성 검사
	var birthYear = (resno.charAt(7) <= "2") ? "19" : "20";
	if (!isDate(birthYear+jumin1))
	{
		return false;
	}

	// Check Sum 코드의 유효성 검사
	buf = new Array(13);
	for (i = 0; i < 6; i++) buf[i] = parseInt(resno.charAt(i));
	for (i = 6; i < 13; i++) buf[i] = parseInt(resno.charAt(i + 1));

	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
	for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);

	if ((11 - (sum % 11)) % 10 != buf[12]) {
		return false;
	}
	return true;
}

function isDate(dt){
	var birthYear = dt.substr(0, 4);
	var birthMonth = dt.substr(4, 2) - 1;
	var birthDate = dt.substr(6, 2);
	var birth = new Date(birthYear, birthMonth, birthDate);

	if ( birth.getYear() % 100 != birthYear.substr(2, 2) || birth.getMonth() != birthMonth || birth.getDate() != birthDate) {
		return false;
	}
	return true;
}

function lenb(str){
	var chrcode;
	var leng=0;
	for (i=0;i<str.length;i++){
		chrcode=str.charCodeAt(i);
		if (chrcode<=127)
			leng++;
		else
			leng+=2;
	}
	return leng;
}


//Validation

// Validator Object
var valid = new Object();

// REGEX Elements
	
	valid.num = /[0-9]$/;

	valid.eng = /[a-zA-Z0-9]$/;
	
	// matches zip codes
	valid.zipCode = /\d{5}(-\d{4})?/;

	// matches $17.23 or $14,281,545.45 or ...
	valid.Currency = /\$\d{1,3}(,\d{3})*\.\d{2}/;

	// matches 5:04 or 12:34 but not 75:83
	valid.Time = /^([1-9]|1[0-2]):[0-5]\d$/;

	//matches email
	valid.email = /^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/;

	// matches phone ###-###-####
	valid.phoneNumber = /^\(?\d{3}\)?\s|-\d{3}-\d{4}$/;

	// International Phone Number
	valid.phoneNumberInternational = /^\d(\d|-){7,20}/;

	// IP Address
	valid.ipAddress = /^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$/;

	// Date xx/xx/xxxx
	valid.Date = /^\d{4}([-/])\d{1,2}\1\d{1,2}$/;	

	// State Abbreviation
	valid.State = /^(AK|AL|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MD|ME|MI|MN|MO|MS|MT|NB|NC|ND|NH|NJ|NM|NV|NY|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WI|WV|WY)$/i;

	// Social Security Number
	valid.SSN = /^\d{3}\-\d{2}\-\d{4}$/;

	valid.jumin = /^\d{6}\-\d{7}$/;	

	valid.handphone = /^0(?:10|11|16|17|18|19)(?:\d{3}|\d{4})\d{4}$/;
 
function validateForm(theForm) {

	var elArr = theForm.elements; 
	for(var i = 0; i < elArr.length; i++) {
		
		with(elArr[i]) {
			var v,kname;
			var objv = elArr[i].attributes["validator"]; if(typeof(objv)!="undefined") v=objv.value;
			var objk = elArr[i].attributes["kname"]; if(typeof(objk)!="undefined") kname=objk.value;			

			if(typeof(objv)=="undefined") continue;
			if(v=="") continue;
			
			if ((type=="radio" || type=="checkbox"))
			{
				var tmp=false;
				var a = document.all.item(name);
				if (a!=null) {
					if (a.length!=null) {
						for (j=0; j<a.length; j++) {
							if(a[j].checked){
								tmp=true;								
							}							
						}
					}
				} 
  
				if(!tmp){
					alert(kname + "을(를) 선택하십시오.");
					return false;
				}
			}		  

			if (value=="")
			{
				alert(kname + "을(를) 입력하십시오.");
				//elArr[i].select();
				try
				{
					elArr[i].focus();
				}
				catch (ex)
				{
				}
				
				return false;
			}			
			
			if(elArr[i].getAttribute("maxlength")){
				if(lenb(value)>parseInt(elArr[i].getAttribute("maxlength"))){
					alert(kname + "은(는) " + elArr[i].getAttribute("maxlength") + "Byte이상 입력할 수 없습니다. (현재 "+lenb(value)+"byte)");
					return false;
				}
			}

			var thePat = valid[v];
			if(!thePat) continue;

			var gotIt = thePat.exec(value); 

			if(!gotIt){
				if(v=="eng"){
					alert(kname + "은(는) 영문과 숫자만 입력가능합니다.");
				}else if(v=="num"){
					alert(kname + "은(는) 숫자만 입력가능합니다.");
				}else if(v=="handphone"){
					alert(kname + "은(는) 핸드폰 번호만 입력가능합니다. ex)01012345678");
				}else{
					alert(kname + "의 형식이 잘못되었습니다.");
				}
				try
				{
					elArr[i].select();
					elArr[i].focus();					
				}
				catch (ex)
				{
				}
				return false;
			}
		}
	}
	return true;
}

function photo_popup(fname){
	window.open('photo_popup.asp?src='+fname,'','left='+(screen.width-850)/2+',top='+(screen.height-580)/2+',width=850,height=580,scrollbars=yes,resizable=yes');
}

function btnover(img){
	var tmp=img.src;
	var tmp1=tmp.substring(0,tmp.length-4);
	img.src=tmp1 + "_.gif";
}
function btnout(img){
	var tmp=img.src;
	var tmp1=tmp.substring(0,tmp.length-5);
	img.src=tmp1 + ".gif";
}
function WinHTTP(sUrl)
{
	try
	{
		var arr=location.href.split("/");
		var url=arr[0]+"/"+arr[1]+"/"+arr[2];
		url+=sUrl;

		var d = new Date();
		var t = d.getTime();
		
		url+="&"+t;
		var oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
		
		oXMLHTTP.open("Get", url, false);
		oXMLHTTP.setRequestHeader("Content-Type", "text/xml;charset=ks_c_5601-1987");
		oXMLHTTP.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		oXMLHTTP.send();
		
		return oXMLHTTP.responseText;
	}
	catch(e)
	{
		return "브라우저 버전이 낮습니다. IE 5.0이상에서 적용됩니다.";
	}
}
function winhttp(surl)
{
	try
	{
		var oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
		oXMLHTTP.open("Get", surl, false);
		oXMLHTTP.setRequestHeader("Content-Type", "text/xml;charset=ks_c_5601-1987");
		oXMLHTTP.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		oXMLHTTP.send();
		return oXMLHTTP.responseText;
	}
	catch(e)
	{
		return "브라우저 버전이 낮습니다. IE 5.0이상에서 적용됩니다.";
	}
}

function go_club(clubid,surl){
	if(clubid=="") return;
	if(typeof(surl)=="undefined") surl="";
	else surl=escape(surl);
	
	var url="/uni_club/default.asp?clubid="+clubid;
	if(surl!="") url+="&surl=" + surl;
	try{
		top.fr_main.location.href=url;
	}catch(e){
			parent.location.href=url;
	}
}
function go_plaza(comp){
	var url="";
	if(comp=="0" || typeof(comp)=="undefined" || comp=="") url="/mlm_plaza/default.asp";
	else url="/mlm_plaza/plaza.asp?comp="+comp;
	try{
		top.fr_main.location.href=url;
	}catch(e){
			parent.location.href=url;
	}
}
function go_blog(homeid,surl){
	if(homeid=="") return;
	if(typeof(surl)=="undefined") surl="";
	else surl=escape(surl);

	var url="/uni_blog/blog.asp?homeid="+homeid;
	if(surl!="") url+="&surl=" + surl;
	try{
		top.fr_main.location.href=url;
	}catch(e){
			parent.location.href=url;
	}
}
function goView(homeid,num)
{
	if (top.fr_main==window)
		window.navigate("/uni_blog/blog.asp?homeid="+homeid+'&bdnum='+num);
	else parent.navigate("/uni_blog/blog.asp?homeid="+homeid+'&bdnum='+num);
}

function getchk()
{
	var re="";
	var num=document.all.item("num");
	if(!num) return re;

	if(num.length)
	{
		for(i=0;i<num.length;i++)
		{
			if(num[i].checked)re += num[i].value + ",";
		}
	}else{
		if(num.checked)re += num.value + ",";
	}
	if (re!="")
	{
		re=re.substring(0,re.length-1);
	}
	return re;
}

function chkall(chk) //게시물 전체 선택
{
	var num=document.all.item("num");
	if(!num) return;
	if(num.length)
	{
		for(i=0;i<num.length;i++)
		{
			num[i].checked=chk;
		}
	}else{
		num.checked=chk;
	}		
}

function chkone()
{
	var kk=false;
	var num=document.all.item("num");
	
	if(!num) return kk;
	if(num.length)
	{
		for(i=0;i<num.length;i++)
		{
			if (num[i].checked)
			{
				kk=true;
			}
		}
	}else{
		if (num.checked)
		{
			kk=true;
		}
	}
	return kk;
}


function getObject(objectId) { 
	// checkW3C DOM, then MSIE 4, then NN 4. 
	var obj;

	obj = document.getElementsByName(objectId);
	if(obj && obj.length==1) obj = obj[0];	
	
	//alert(obj + ":" + obj.id + ":" + obj.name + ":" + obj.length + typeof(obj));
	if(obj.length==0 && typeof(obj.name)=="undefined")
	{
		if(document.getElementById ) { 
			obj = document.getElementById(objectId); 
		} 
		else if (document.all && document.all[objectId]) { 
			obj = document.all[objectId]; 
		} 
		else if (document.layers && document.layers[objectId]) { 
			obj =  document.layers[objectId]; 
		}
	}
	
	
	return obj;
} 

function WinHTTP(sUrl)
{
	try
	{
		var arr=location.href.split("/");
		var url=arr[0]+"/"+arr[1]+"/"+arr[2];
		url+=sUrl;

		var d = new Date();
		var t = d.getTime();
		
		url+="&"+t;
		var oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
		
		oXMLHTTP.open("Get", url, false);
		oXMLHTTP.setRequestHeader("Content-Type", "text/xml;charset=ks_c_5601-1987");
		oXMLHTTP.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		oXMLHTTP.send();
		
		return oXMLHTTP.responseText;
	}
	catch(e)
	{
		return "브라우저 버전이 낮습니다. IE 5.0이상";
	}
}


function setCookie(cookieName,cookieValue,nDays) {
	var today = new Date();
	var expire = new Date();
	
	if (typeof(nDays)=="undefined" || nDays==null || nDays==0) 
	{
		document.cookie = cookieName+"="+escape(cookieValue) + ";";
	}
	else
	{
		expire.setTime(today.getTime() + 3600000*24*nDays);
		document.cookie = cookieName+"="+escape(cookieValue) + ";expires="+expire.toGMTString();
	}
}

function getCookie(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
        begin = dc.indexOf(prefix);
        if (begin != 0) return null;
    } else {
        begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1) {
        end = dc.length;
    }
    return unescape(dc.substring(begin + prefix.length, end));
}

function isAdult(jumin1,jumin2)
{
	yy=jumin1.substring(0,2);
	mm=jumin1.substring(2,4);
	dd=jumin1.substring(4,6);

	bl=jumin2.substring(0,1);
	
	if(bl=="1" || bl=="2")
		yy="19"+ yy;
	else
		yy="20"+ yy;
	
	adate=new Date();
	adate.setFullYear(parseInt(yy)+19,parseInt(mm)-1,dd);
	now = new Date();
	if(adate<=now)
		return true;
	else
		return false;
}

function MoneyFormat(str)
{
	var re="";
	str = str + "";
	str=str.replace(/-/gi,"");
	str=str.replace(/ /gi,"");
	
	str2=str.replace(/-/gi,"");
	str2=str2.replace(/,/gi,"");
	str2=str2.replace(/\./gi,"");	
	
	if(isNaN(str2) && str!="-") return "";
	try
	{
		for(var i=0;i<str2.length;i++)
		{
			var c = str2.substring(str2.length-1-i,str2.length-i);
			re = c + re;
			if(i%3==2 && i<str2.length-1) re = "," + re;
		}
		
	}catch(e)
	{
		re="";
	}
	
	if(str.indexOf("-")==0)
	{
		re = "-" + re;
	}

	return re;
}

function format(str,n)
{
	str = str + "";
	for(i=str.length;i<n;i++)
	{
		str = "0" + str;
	}
	return str;
}


function callXMLHttp(url,cont){
    var xmlHttp = null;
    if( window.XMLHttpRequest ){
	    xmlHttp = new XMLHttpRequest();
    }
    else{
	    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

	try{
		if( xmlHttp ){
			if( url != undefined && url != null ){
				if(url.indexOf("?")>=0)
				{
					url+="&"+GetDate();
				}
				else
				{
					url+="?"+GetDate();
				}
				
				xmlHttp.open("POST", url, false);
				xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
				xmlHttp.send(cont);

				return xmlHttp.responseText;
			}
		}
	}catch(e)
	{
				
	}
}

function callXMLHttpAsync(url,cont){
	var xmlHttp = null;
    if( window.XMLHttpRequest ){
	    xmlHttp = new XMLHttpRequest();
    }
    else{
	    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

	if( xmlHttp ){
		if(url.indexOf("?")>=0)
		{
			url+="&"+GetDate();
		}
		else
		{
			url+="?"+GetDate();
		}
		
		xmlHttp.open("POST", url, true);
		xmlHttp.onreadystatechange = function(){
			if( xmlHttp.readyState == 4 )
			{
				//viewarea.innerHTML = xmlHttp.responseText;
				AsyncProc(xmlHttp.responseText);
				//alert(xmlHttp.responseText);
			}
		}
		xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
		xmlHttp.send(cont);
		

		//xmlHttp.send(null);		
	}
}

function addEvent(obj, evType, fn){
	if( obj.addEventListener ){
		obj.addEventListener(evType, fn, true);
		return true;
	}
	else if( obj.attachEvent ){
		var r = obj.attachEvent('on'+evType, fn);
		return r;
	}
	else{
		return false;
	}
}

function en(s)
{
	return encodeURIComponent(htmlEncode(s));	
	//return htmlEncode(s);
	
}
function de(s)
{
	return htmlDecode(decodeURIComponent(s));
	//return htmlDecode(s);
}

function htmlEncode(s) {
	s = s.replace(/&/g, "&amp;");
	s = s.replace(/</g, "&lt;");
	s = s.replace(/>/g, "&gt;");
	s = s.replace(/"/g, "&quot;");
	return s;
}

function htmlDecode(s) {
	s = s.replace(/&amp;/g, "&");
	s = s.replace(/&lt;/g, "<");
	s = s.replace(/&gt;/g, ">");
	s = s.replace(/&quot;/g, "\"");
	return s;
}


function hide_dialog(obj)
{
	getObject(obj).style.display="none";
}


function show_dialog(obj,x,y)
{
	getObject(obj).style.display="";
	if(typeof(x)!="undefined") getObject(obj).style.left=x;
	if(typeof(y)!="undefined") getObject(obj).style.top=y;
}

function GetDate()
{
	var str=Date.parse(new Date())+"";
	return str.substring(0,10);
}


function getObject(objectId) { 
	// checkW3C DOM, then MSIE 4, then NN 4. 
	
	if(document.getElementById && document.getElementById[objectId]) { 
		return document.getElementById[objectId]; 
	} 
	else if (document.all && document.all[objectId]) { 
		return document.all[objectId]; 
	} 
	else if (document.layers && document.layers[objectId]) { 
		return document.layers[objectId]; 
	}
	else if(document.getElementById && document.getElementById(objectId)) { 
		return document.getElementById(objectId); 
	}
	else 
	{ 
		return false; 
	} 
} 


function getParameter(name)
{
	var url=location.href;
	var str="";
	var a0=url.indexOf("?");
	if(a0>=0 && url.indexOf(name,a0)>=0)
	{
		var qry=url.substring(a0+1);
		
		var arr=qry.split("&");
		for(i=0;i<arr.length;i++)
		{
			var arr2=arr[i].split("=");
			if(arr2[0]==name)
			{
				str=unescape(arr2[1]);
				break;
			}
		}		
	}
	return str;
}

function returnfalse()
{
	return false;
}

function setCookie(cookieName,cookieValue,nDays) {
	var today = new Date();
	var expire = new Date();
	var strexpires="";
	if (nDays==null || nDays==0)
	{
	}
	else
	{
		expire.setTime(today.getTime() + 3600000*24*nDays);
		strexpires=";expires="+expire.toGMTString();
	}
	document.cookie = cookieName+"="+escape(cookieValue) + strexpires;
}

function getCookie(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
        begin = dc.indexOf(prefix);
        if (begin != 0) return "";
    } else {
        begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1) {
        end = dc.length;
    }
    return unescape(dc.substring(begin + prefix.length, end));
}


function getSrcElement(e)
{
	var src = e.srcElement? e.srcElement : e.target; 
	return src;
}

function Floor(s,n)
{
	s=s+"";
	if(s.indexOf(".")>=0)
	{
		s=s.substring(0,s.indexOf(".")+3);
	}
	s = parseFloat(s);
	return s;
}

function IsPhone(value)
{
	var v="handphone";
	var thePat = valid[v];
	var gotIt = thePat.exec(value);
	if(gotIt) return true;
	return false;
}