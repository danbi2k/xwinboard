

function DefaultFormValidation(f) {
	var submitcount=0; 
	for(var intLoop = 0; intLoop < f.elements.length; intLoop++) {
		if(f.elements[intLoop].tagName == "INPUT" || f.elements[intLoop].tagName == "SELECT" || f.elements[intLoop].tagName == "TEXTAREA") {
			if("Required" == f.elements[intLoop].getAttribute("Information")) {	
				if(!trim(f.elements[intLoop].value) ) {	
					alert(f.elements[intLoop].title + "은(는) 필수항목입니다.");
					f.elements[intLoop].value='';
					f.elements[intLoop].focus();
					return false;

				}
			}
		}

		//MAX Bytes 계산 - INPUT, TEXTAREA만 체크
		if(f.elements[intLoop].tagName == "INPUT" || f.elements[intLoop].tagName == "TEXTAREA") {
			if(null != f.elements[intLoop].getAttribute("MaxBytes")) {
				if(!fCheckByte(f.elements[intLoop],f.elements[intLoop].title)) {
					f.elements[intLoop].focus();
					return false;
				}
				
				//반드시 숫자형
				if("ONLYNUMBER" == f.elements[intLoop].getAttribute("TextFormat")) {
					if(trim(f.elements[intLoop].value) ) {	
						if(!fCheckNumber(f.elements[intLoop].value)){
							alert(f.elements[intLoop].title + "은(는) 반드시 숫자형이어야 합니다.");
							f.elements[intLoop].value='';
							f.elements[intLoop].focus();
							return false;
						}
					}
				}	


				//반드시 한글
				if("ONLYKOREA" == f.elements[intLoop].getAttribute("TextFormat")) {
					if(trim(f.elements[intLoop].value) ) {	
						if(fIsAlphabet(f.elements[intLoop].value)) {
							alert(f.elements[intLoop].title + "은(는) 한글이어야 합니다.");
							f.elements[intLoop].value='';
							f.elements[intLoop].focus();
							return false;
						}
					}
				}	
												
			}
			
		}

		//이메일 체크
		if(f.elements[intLoop].name.toLowerCase() == "email" ) {
			if (trim(f.elements[intLoop].value) ) {
				if(!CheckEmail(f.elements[intLoop])) {
					return false;
				}
								
			}
		}	
		

		if(f.elements[intLoop].name.toLowerCase() == "pwd" ) {
			//비밀번호 체크
			var r = _chkpasswd(f.pwd.value, f.repwd.value); 
			if (r==1) {
				alert("비밀번호 1길이는 4~15이어야 합니다. ");
				f.pwd.focus(); return false;

			} else if (r==2) {
				alert("비밀번호 1길이는 4~15이어야 합니다. ");
				f.repwd.focus();
				return false;

			} else if (r==3) {
				alert("비밀번호와 확인이 일치하지 않습니다.");
				f.pwd.value = ""; f.repwd.value = ""; f.pwd.focus();
				return false;

			}
			
		}

					
		if(f.elements[intLoop].name.toLowerCase() == "id" ) {
			if ( (f.id.value.length == 0) || (f.id.value.length < 4) || (f.id.value.length > 10) ) {
				alert("아이디는 4-10까지 가능합니다.");
				f.id.focus(); return false;
				} else if (dupstr(f.id.value)) {
					alert("동일한 문자또는 숫자열로된 아이디는 보안상 사용하실 수 없습니다.");
					f.id.focus(); f.id.value='';return false;
			}
		}
	
		if(f.elements[intLoop].name.toLowerCase() == "jumin01" ) {
			if(trim(f.jumin01.value) || trim(f.jumin02.value) ) {	
				if (!JuminCheck(f.jumin01.value,f.jumin02.value)) {
					alert("정확하지 않은 주민등록 번호입니다.");
					f.jumin01.value='';f.jumin02.value='';f.jumin01.focus(); return false;
				}
			}
		}								
		
		
			
	}




	if(typeof(pNumber) != "undefined") {
		document.all["RegImg"].style.visibility="hidden";
	}
	
	if(typeof(f.uploadproc) == "object") {
		ShowProgress();//프로그레스바를 보여준다.
	}

}


function checkIds(){
	var ifrms = document.regfrms
//	alert(ifrms.id.value);
	if((ifrms.id.value.length == 0)||(ifrms.id.value.length < 4)||(ifrms.id.value.length > 10)) {
		alert("아이디는 4-10까지 가능합니다.");
		ifrms.id.focus();return;
	} else if (!fIsAlphabet(ifrms.id.value)) {
	    alert("아이디는 영문 과 숫자만 사용가능 합니다.\n\n사용하실 아이디를 정확히 입력해 주세요!");
		ifrms.id.focus(); ifrms.id.value='';return;
//	} else if (dupstr(ifrm.id.value)) {
//	    alert("반복된 문자또는 숫자열은 보안상 사용하실 수 없습니다.");
//		ifrm.id.focus(); ifrm.id.value='';return;
	}
	var IdPopup = '/member/Idcheck.asp?id='+ifrms.id.value
	window.showModalDialog(IdPopup,self,'width=0,height=0')
	return;
}	


function checkSubAdminId(){
	var ifrms = document.frms
//	alert(ifrms.Sid.value);
	if((ifrms.Sid.value.length == 0)||(ifrms.Sid.value.length < 4)||(ifrms.Sid.value.length > 50)) {
		alert("아이디는 4-50까지 가능합니다.");
		ifrms.Sid.focus();return;
	} else if (!fIsAlphabet(ifrms.Sid.value)) {
	    alert("아이디는 영문 과 숫자만 사용가능 합니다.\n\n사용하실 아이디를 정확히 입력해 주세요!");
		ifrms.Sid.focus(); ifrms.Sid.value='';return;
//	} else if (dupstr(ifrm.Sid.value)) {
//	    alert("반복된 문자또는 숫자열은 보안상 사용하실 수 없습니다.");
//		ifrm.Sid.focus(); ifrm.Sid.value='';return;
	}
	var IdPopup = '/admin/Member/Idcheck.asp?id='+ifrms.Sid.value
	window.showModalDialog(IdPopup,self,'width=0,height=0')
	return;
}	


function NextInfo(schar,f1, f2, f3, f4){
	f1.value=schar.substring(0,2);
	f2.value=schar.substring(2,4);
	f3.value=schar.substring(4,6);
	f4.value=schar.substring(0,2);
}	


function ShowProgress() {
	strAppVersion = navigator.appVersion
			
	if (strAppVersion.indexOf('MSIE') != -1 && strAppVersion.substr(strAppVersion.indexOf('MSIE')+5,1) > 4) {
		winstyle = "dialogWidth=385px; dialogHeight:200px; center:yes";
		window.showModelessDialog("/common/asp/show_progress.asp", null, winstyle);
	}
	else {
		winpos = "left=" + ((window.screen.width-385)/2) + ",top=" + ((window.screen.height-200)/2-200);
		winstyle="height=180,width=380,status=no,toolbar=no,menubar=no,location=no,resizable=no,"
					&& "scrollbars=no,copyhistory=no," + winpos;
		window.open("/common/asp/show_progress.asp",null,winstyle);
	}
			
	return true;
}

function NextFieldMove(f,nfocus,size) {
	siz = f.length;
	alert(size);
	if(siz == size){nfocus.focus();}
	
}

function fCheckByte(pCtrl, pTitle){
	var intMaxByte = parseInt(pCtrl.MaxBytes);
	var strString = pCtrl.value;
	var currentByte = fGetStringLength(strString);

	if( currentByte > intMaxByte){
		alert( pTitle + "에는 영문 " + pCtrl.MaxBytes + "자, 한글 " + intMaxByte/2 + "자 이상 입력하실수 없습니다.");
		pCtrl.value = fGetStringToByte(intMaxByte, pCtrl.value);
		return false;
	}else return true;
}


function fGetStringLength(pSourceString){
	var intByteCount = 0;
	for(var i=0; i < pSourceString.length; i++)
	{
		var tmpChar = pSourceString.charAt(i);
		if( escape(tmpChar).length > 4)
			intByteCount += 2;
		else if(tmpChar != '\r')
			intByteCount++;
	}
	return(intByteCount);
}



function fGetStringToByte(pMaxByte, pSourceString)
{
	var intByteCount = 0;
	for(var i=0; i < pSourceString.length; i++)
	{
		var tmpChar = pSourceString.charAt(i);
		if( escape(tmpChar).length > 4)
			intByteCount += 2;
		else if(tmpChar != '\r')
			intByteCount++;

		if(intByteCount > pMaxByte) break;
	}
	return pSourceString.substr(0,i);
}



	function trim(txt){
		return txt.replace(/(^\s*)|(\s*$)/g, "");
	}

	function strSpace(str)	{
		var index,len
		while(true) {
			index = str.indexOf(" ");
			if (index == -1)
				break;
				len = str.length;
				str = str.substring(0,index) + str.substring((index + 1),len);
		}
		return str.length;
	}


function dupstr(Str) { 
	fStr=Str.substring(0,1);
	var i, maxlen;
	var maxstr = 4;
	maxlen = Str.length;
	if (maxlen < maxstr) return true;
		for ( i=0; i<maxlen; i++ ) {
			if (fStr != Str.substring(i, i + 1)) break;
		}
		if (i >= maxlen) return true;
			if (maxlen=="1234") return true;
				return false;
		}
  
  
  
function fCheckNumber(pNumber) {
	// 값이 없으면 FALSE 리턴
	if(typeof(pNumber) == "undefined") return false;
	var pNumber = trim(pNumber)
	if(pNumber.length == 0) return false;

	// 문자열화시켜 변수에 저장
	var vNumber = pNumber.toString();
	// 문자열 길이만큼 loop
	for(var i=0; i<vNumber.length; i++) {
		var vTemp = vNumber.substring(i, i+1);
		
		// 숫자가 아니면 FALSE 리턴
		if(isNaN(vTemp)) return false;
		
		// 공백이면 FALSE 리턴
		if(" " == vTemp) return false;
	}

	// 이상 없으므로 TRUE 리턴
	return true;
}



function fnOnlyNumChk(objNum) {
  var objNum = eval(objNum);
  var szValue = objNum.value;
  szValue = szValue.toUpperCase();
  for(var i=0; i < szValue.length; i++) {
    if (szValue.charAt(i) == ' '){
      return false;
    }else if ((szValue.charAt(i) < '0') || (szValue.charAt(i) > '9'))	{
      return false;
    }
  }
}

function fIsAlphabet(str) {
	if(isNaN(str)) {
		for(var intLoop = 0; intLoop < str.length; intLoop++) {
			//var chr = str.substr(intLoop,1).toLowerCase();
			var chr = str.charAt(intLoop).toLowerCase();
			/* 영문과 숫자, '_' 사용 */
			if((chr < '0' || chr > '9') && (chr < 'a' || chr > 'z')&&(chr != '_')) 
				return false;
		}
		return true;
	} else {
		return false;
	}
}



function __fIsAlphabet(strValue) {
  for(var i=0; i<strValue.length;i ++) {
    var strCh = strValue.charAt(i).toUpperCase();
    if(strCh >="A" && strCh <="Z") continue;
    if(strCh >="0" && strCh <="9") continue;
    if(strCh  !=" ") continue;
    return false;
  }
}

function fMoveFocus(thisPut,nextPut,Lng) {
//	alert(thisPut.length);
	if(thisPut.length == Lng) {
		nextPut.focus();
	}
}	


function onlyNumber(){
 // 90:ctrl+z, 67:ctrl+c, 86:ctrl+v
 if( (event.ctrlKey && event.keyCode==90) || (event.ctrlKey && event.keyCode==67) || (event.ctrlKey && event.keyCode==86) || (event.keyCode==190) || (event.keyCode>=96 && event.keyCode<=105) || (event.keyCode==110) || (event.keyCode>47 && event.keyCode<58) || event.keyCode==8 || event.keyCode==16 || event.keyCode==116 || event.keyCode==18 || event.keyCode==9 ||(event.keyCode>=37 && event.keyCode<=40) || event.keyCode==46 );
 else event.returnValue=false;
}


function isValidDaum(email){
        var checkString = email.toLowerCase(); 
        var atpoint = checkString.indexOf('@'); 
        var e_domain = checkString.substring(atpoint+1);
        if( e_domain == 'hanmail.net' || e_domain == 'daum.net' || e_domain == 'daum' || e_domain == 'hanmail' || e_domain == 'hanmail.com' || e_domain == 'hotmail.net')   return true; 
     return false; 
} 


function CheckEmail(pCtrl) {
	var fmt3 = /^[-!#$%&amp;\'*+\\./0-9=?A-Z^_a-z{|}~]+@[-!#$%&amp;\'*+\\/0-9=?A-Z^_a-z{|}~]+\.[-!#$%&amp;\'*+\\./0-9=?A-Z^_a-z{|}~]+$/;
	var strEmail = pCtrl.value;
	if (!fmt3.test(strEmail)) {
		alert("이메일주소가 올바르지 않습니다.");
		pCtrl.focus();
		return false;
	} else return true;

}


function Incredit_comma(numb) {
	var  s = parseFloat(numb.replace(/\,/g,""));
	var ns = s.toString();
	var dp;
						 
	if(isNaN(ns))
		return '';
		dp = ns.search(/\./);
	
	if(dp<0) 
		dp = ns.length;
		dp-=3;
	
		while(dp>0) {
		ns = ns.substr(0,dp)+","+ns.substr(dp);
		dp-=3;
	}
	
	numb.value = ns;
//	return true;
}


function fCheckFloat(pValue)
{
	// 파라미터 값이 parseFloat()후에도 같으면 TRUE 리턴
	if(pValue == parseFloat(pValue)) return true;
	else return false;
}

function fConvertNumberToAmount(pNumber)
{
	var vNumber;
	var vAddPoint = 0;
	var vAmount = "";
	var vTempArray;

	if(fCheckFloat(pNumber))
	{
		vNumber = pNumber.toString();

		if(vNumber.substring(0, 1) == "-")
		{
			vAmount = "-";
			vNumber = vNumber.substring(1, pNumber.length);
		}

		vTempArray = vNumber.split(".");

		if(vTempArray[0].length > 3)
		{
			if(vTempArray[0].length % 3 == 0) vAddPoint = 3;
			else vAddPoint = vTempArray[0].length % 3;
		}

		for(var i=0; i<vTempArray[0].length; i++)
		{
			vAmount += vTempArray[0].substring(i, i + 1);

			if(i == vAddPoint - 1 && i != vTempArray[0].length - 1)
			{
				vAmount += ",";

				vAddPoint = eval(vAddPoint) + 3;
			}
		}

		if(vTempArray.length == 2) vAmount += "." + vTempArray[1];
	}
	else
	{
//		alert(pNumber);
	}

	return vAmount;
}


function fConvertAmountToNumber(pAmount)
{
	return fReplaceWord(pAmount, ",", "");
}


function fReplaceWord(pSourceString, pFindWord, pReplaceWord)
{
	if(pSourceString != ""){
		var vTempArray;
		var vReturnString = "";
		vTempArray = pSourceString.split(pFindWord);

		for(var i=0; i<vTempArray.length-1; i++)
		{
			vReturnString += vTempArray[i] + pReplaceWord;
		}

		vReturnString += vTempArray[vTempArray.length-1];
	}else vReturnString = pSourceString;
	return vReturnString;
}

function MM_winopen(URL,alia,Spec) {
	window.open(URL,alia,Spec)
	return;
}



function MM_Modalwinopen(URL,alia,Spec) {
	window.showModelessDialog(URL,alia,Spec)
	return;
}


function hanCheck(word) {	var str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
	for (i=0; i< word.length; i++) {
		idcheck = word.charAt(i);
		for (j = 0 ;  j < str.length ; j++) {
			if (idcheck == str.charAt(j)) break;
			if (j+1 == str.length) {
				return false;
			}
		}
	}
	return true;
}

function _chkpasswd(pw1, pw2) {

	if(pw1.length < 4 || pw1.length > 15) {
		return 1;
	}

	if(pw2.length < 4 || pw2.length > 15) {
		return 2;
	}

	if (pw1 != pw2)
		return 3;

	//영문자 + 숫자만
	if(!fIsAlphabet(pw1)) {	
		return 4;
	}
	
	//영문자 + 숫자만
	if(dupstr(pw1)) {	
		return 5;
	}	
}

function JuminCheck(n1,n2)  { 
	var chk=0;
		for (var i = 0; i <=5 ; i++){ 
		chk = chk + ((i%8+2) * parseInt(n1.substring(i,i+1))) 
	 } 

		for (var i = 6; i <=11 ; i++){ 
		chk = chk + ((i%8+2) * parseInt(n2.substring(i-6,i-5))) 
	 } 
		chk = 11 - (chk %11) 
		chk = chk % 10 
		
		if (chk != n2.substring(6,7)){ 
			return false; 
	 } else {
			return true; 
		}
}


function SectStatus(index, flag) {
	if(flag == 'on')	{
		if(navigator.appName == 'Netscape') {
			flag = 'show';
			target = eval("document.layers['Layer" + index + "']")
		} else	{
			flag = "visible"
			target = eval("document.all['Layer" + index + "'].style")
		}
	} else	{
		if(navigator.appName == 'Netscape') {
			flag = 'hide';
			target = eval("document.layers['Layer" + index + "']")
		} else {
			flag = "hidden"
			target = eval("document.all['Layer" + index + "'].style")
		}

	}
target.visibility = flag;
}

function SectStatusTop(index, flag) {
	if(flag == 'on')	{
		if(navigator.appName == 'Netscape') {
			flag = 'show';
			target = eval("document.layers['LayerTop" + index + "']")
		} else	{
			flag = "visible"
			target = eval("document.all['LayerTop" + index + "'].style")
		}
	} else	{
		if(navigator.appName == 'Netscape') {
			flag = 'hide';
			target = eval("document.layers['LayerTop" + index + "']")
		} else {
			flag = "hidden"
			target = eval("document.all['LayerTop" + index + "'].style")
		}

	}
target.visibility = flag;
}



function autoPlay() {
	var max_size = document.getElementById("mainTD").offsetWidth - 100;
//		alert(document.getElementById("mainTD").offsetWidth);
		
	if (max_size >= 0) {
		max_size = 450;
	}
		
	for (var i = 0; ; i++) {
		if (apImg[i])
		{
			autoPlayImg(apImg[i], max_size);
		}
		else
		{
			break;
		}
			
		if (i > 100)
		{
			alert("실행의 안정상 자동실행 이미지의 수는 100개로 제한되어 있습니다.");
			break;
		}
	}
}
	

function autoPlay2() {
	var max_size = document.getElementById("mainTD").offsetWidth - 100;
//		alert(document.getElementById("mainTD").offsetWidth);
		
	if (max_size >= 0) {
		max_size = 300;
	}
		
	for (var i = 0; ; i++) {
		if (apImg[i]) {
			autoPlayImg(apImg[i], max_size);
		} else {
			break;
		}
			
		if (i > 100) {
			alert("실행의 안정상 자동실행 이미지의 수는 100개로 제한되어 있습니다.");
			break;
		}
	}
}	

var apImg = new Array();
function addAutoPlayImg(f_obj) {
	for (var i = 0; ; i++) {
		if (!apImg[i]) {
			break;
		}
			
		if (i > 100) {
			alert("실행의 안정상 자동실행 이미지의 수는 100개로 제한되어 있습니다.");
			break;
		}
	}
	apImg[i] = f_obj;
}
	
function autoPlayImg(obj, max_size) {
	if (obj.width > max_size) {
		obj.width = max_size;
	}
}	



function autoPlay3(ms) {
	var max_size = document.getElementById("mainTD").offsetWidth - 100;
//		alert(document.getElementById("mainTD").offsetWidth);
		
	if (max_size >= 0) {
		max_size = ms;
	}
		
	for (var i = 0; ; i++) {
		if (apImg[i]) {
			autoPlayImg(apImg[i], max_size);
		} else {
			break;
		}
			
		if (i > 100) {
			alert("실행의 안정상 자동실행 이미지의 수는 100개로 제한되어 있습니다.");
			break;
		}
	}
}	

var apImg = new Array();
function addAutoPlayImg(f_obj) {
	for (var i = 0; ; i++) {
		if (!apImg[i]) {
			break;
		}
			
		if (i > 100) {
			alert("실행의 안정상 자동실행 이미지의 수는 100개로 제한되어 있습니다.");
			break;
		}
	}
	apImg[i] = f_obj;
}
	
function autoPlayImg(obj, max_size) {
	if (obj.width > max_size) {
		obj.width = max_size;
	}
}	


