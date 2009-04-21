function FnMemReg(frm)
{
	if (frm.bankName != undefined) {
		if (!frm.bankName.value || !frm.bankNumber.value || !frm.bankOwner.value) {
			alert("환전계좌정보를 입력해 주십시오");
			return;
		}
	}
	
	if (havingSqlKeyword(frm.userId.value)) {
		alert("아이디에 사용할수 없는 문자열이 있습니다");
		return;
	}
	
	if (havingSqlKeyword(frm.password1.value)) {
		alert("패스워드에 사용할수 없는 문자열이 있습니다");
		return;
	}
	
	if (havingSqlKeyword(frm.nickName.value)) {
		alert("닉네임에 사용할수 없는 문자열이 있습니다");
		return;
	}
	
	frm.password.value = frm.password1.value;
	var query = "mode=registerMember";
	query += "&userId=" + frm.userId.value;
	query += "&password1=" + frm.password1.value;
	query += "&password2=" + frm.password2.value;
	query += "&nickName=" + frm.nickName.value;
	query += "&phone1=" + frm.phone1.value;
	query += "&phone2=" + frm.phone2.value;
	query += "&phone3=" + frm.phone3.value;
	query += "&email1=" + frm.email1.value;
	query += "&email2=" + frm.email2.value;
	query += "&pin=" + frm.pin.value;
	query += "&bankName=" + frm.bankName.value;
	query += "&bankNumber=" + frm.bankNumber.value;
	query += "&bankOwner=" + frm.bankOwner.value;
	
	var http = new JKL.ParseXML("member.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		alert(result.resultXml.message);
		frm.password.value = frm.password1.value;
		FnLogin_Submit(frm);
	} else {
		alert(result.resultXml.message);
		if (result.resultXml.code == -2)
			location.href = "index.aspx";
	}
}

function FnMemModify(frm)
{
	if (frm.bankName != undefined) {
		if (!frm.bankName.value || !frm.bankNumber.value || !frm.bankOwner.value) {
			alert("환전계좌정보를 입력해 주십시오");
			return;
		}
	}
	var query = "mode=modifyMember";
	query += "&userId=" + frm.userId.value;
	query += "&password1=" + frm.password1.value;
	query += "&password2=" + frm.password2.value;
	query += "&pin=" + frm.pin.value;
	query += "&email1=" + frm.email1.value;
	query += "&email2=" + frm.email2.value;
	query += "&phone1=" + frm.phone1.value;
	query += "&phone2=" + frm.phone2.value;
	query += "&phone3=" + frm.phone3.value;
	
	if (frm.bankName != undefined) {
		query += "&bankName=" + frm.bankName.value;
		query += "&bankNumber=" + frm.bankNumber.value;
		query += "&bankOwner=" + frm.bankOwner.value
	}
	
	var http = new JKL.ParseXML("member.aspx", query);
	var result = http.parse();
	
	if (result.resultXml.code == 0) {
		alert("수정되었습니다");
		location.href ="home.aspx";
	} else {
		alert(result.resultXml.message);
	}	
}
function FnMemOut(){
	if(confirm("탈퇴를 신청하시겠습니까?\n\n탈퇴를 신청하시면, 관리자가 확인후 탈퇴를 시켜드립니다.")){
		var query = "mode=requestSecede";
		var http = new JKL.ParseXML("member.aspx", query);
		var result = http.parse();
		if (result.resultXml.code == 0) {
			alert(result.resultXml.message);
			location.href = "home.aspx";
		}
	}
}
function FnMemOutCancle(){
	if(confirm("탈퇴를 신청을 취소하시겠습니까?")){
		hidden_iframe.location.href = "/member/member_out.asp?cancle=1";
	}
}
function check_id(frm){
	var query = "mode=checkExistUserId";
	query += "&userId=" + frm.id_input.value;
	var http= new JKL.ParseXML("member.aspx", query);
	var result = http.parse();
	
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		frm.id.value = frm.id_input.value;
	else
		frm.id.value = '';
}

function check_rid(frm){
	var w = 380;
	var h = 200;
	var window_left = (screen.width-w)/2;
	var window_top  = (screen.height-h)/2;
	window.open("check_rid.asp?r_id="+ frm.r_id.value,"checkRIDwin",'status=no,width='+ w +',height='+ h +',top=' + window_top + ',left=' + window_left + '');
}

function check_nick(frm){
	var query = "mode=checkExistNickName";
	query += "&nickName=" + frm.nick_input.value;
	var http= new JKL.ParseXML("member.aspx", query);
	var result = http.parse();
	
	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		frm.nick.value = frm.nick_input.value;
	else
		frm.nick.value = '';
}

function checkid_form(frm){
	if(frm.id.value.length<2){ alert("아이디를 2자 이상 입력해주세요!"); frm.id.focus(); return false; }
	frm.submit();
}
function checkrid_form(frm){
	if(frm.r_id.value.length<2){ alert("아이디를 2자 이상 입력해주세요!"); frm.r_id.focus(); return false; }
	frm.submit();
}
function checknick_form(frm){
	if(frm.nick.value.length<2){ alert("닉네임을 2자 이상 입력해주세요!"); frm.nick.focus(); return false; }
	frm.submit();
}
function out_pw_set(){
	var w = 380;
	var h = 200;
	var window_left = (screen.width-w)/2;
	var window_top  = (screen.height-h)/2;
	window.open("outmoney_pw_set.asp","checkNICKwin",'status=no,width='+ w +',height='+ h +',top=' + window_top + ',left=' + window_left + '');
}

//######### 머니충전신청 ##############
function FnInMoney_Submit(frm)
{
	var query = "mode=moneyInRequest";
	query += "&money=" + trimComma3(frm.money.value);
	query += "&name=" + frm.name.value;
	query += "&bankBookId=" + frm.bankBookId.value;
	var http = new JKL.ParseXML("moneyIn.aspx", query);
	var result = http.parse();
	alert(result.resultXml.message);
	if (result.resultXml.code == 0) {
		location.href="moneyIn.aspx?mode=viewMoneyInRequestList";
	}
}

function FnInMoneyCancle(idx){
	if(confirm("머니충전신청을 취소하시겠습니까?")){
		location.href="inmoney.asp?cancle="+ idx;
	}
}
function FnOutMoney_Submit(frm){
	if(!frm.out_money.value) {alert("금액을 입력하세요"); frm.out_money.focus(); return; }
	if(!frm.pin.value) {alert("환전비밀번호를 입력하세요"); frm.pin.focus(); return; }
	if(frm.account_bank.value==""){ alert("환전받으실 은행을 선택하세요!"); frm.account_bank.focus(); return; }
	if(frm.account_num.value.length<7){ alert("환전받으실 계좌번호를 다시 한번 확인해주세요!"); frm.account_num.focus(); return; }
	if(frm.account_name.value.length<2){ alert("수취인 이름을 정확히 입력해주세요!!"); frm.account_name.focus(); return; }
	
	var query = "mode=moneyOutRequest";
	query += "&money=" + trimComma3(frm.out_money.value);
	query += "&bankName=" + frm.account_bank.value;
	query += "&number=" + frm.account_num.value;
	query += "&name=" + frm.account_name.value;
	query += "&pin=" + frm.pin.value;
	
	var http = new JKL.ParseXML("moneyOut.aspx", query);
	var result = http.parse();
	
	alert(result.resultXml.message);
	if (result.resultXml.code == 0) {
		location.href='moneyOut.aspx?mode=viewMoneyOutRequestList';
	}
}
function FnOutMoneyCancle(idx){
	if(confirm("환전신청을 취소하시겠습니까?")){
		location.href="outmoney.asp?cancle="+ idx;
	}
}


function comma(obj){ 
    var str=new Array(); 
    v1=String(obj.value); 
	v1=v1.replace(',','');
	v1=v1.replace(',','');
	v1=v1.replace(',','');
	v1=v1.replace(',','');
	v1=v1.replace('.','');
	v1=v1.replace('.','');
	v1=v1.replace('.','');
	v1=v1.replace('.','');
    for(var i=1;i<=v1.length;i++){ 
        if(i%3){ str[v1.length-i]=v1.charAt(v1.length-i); }else{ str[v1.length-i]=','+v1.charAt(v1.length-i); } 
    } 
    obj.value = str.join('').replace(/^,/,''); //스트링을 조합하여 반환 
} 

//############ 한글 입력 방지 스크립트 ##########################
function abc123(obj){
    if((event.keyCode>47&&event.keyCode<58)||(event.keyCode>64&&event.keyCode<91)||(event.keyCode>96&&event.keyCode<123)){
        event.returnValue = true;
    }else{
        event.returnValue = false;
    }
    char_clear_obj = obj;
    setTimeout("han_clear('')",5);
}
function only123(obj){
    if((event.keyCode>47&&event.keyCode<58)||(event.keyCode>64&&event.keyCode<91)||(event.keyCode>96&&event.keyCode<123)){
        event.returnValue = true;
    }else{
        event.returnValue = false;
    }
    char_clear_obj = obj;
    setTimeout("eng_clear('')",5);
}
function han_clear(obj){
    if(obj==''){ obj = char_clear_obj; }
    var word=obj.value;
    for(i=0;i<obj.value.length;i++) {
        var a=obj.value.charCodeAt(i);
        if (a > 128) { word=word.replace(obj.value.charAt(i),""); }
    }
    obj.value = word;
}
function eng_clear(obj){
    if(obj==''){ obj = char_clear_obj; }
    var word=obj.value;
    for(i=0;i<obj.value.length;i++) {
        var a=obj.value.charCodeAt(i);
        if ( (a>57 || a <48) && a!=44 && a!=45 && a!=46) { word=word.replace(obj.value.charAt(i),""); }
    }
    obj.value = word;
}

//### 메일 체크 ####################################
function FnEmailCheck(emailStr) {
    var checkTLD=1;
    var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
    var emailPat=/^(.+)@(.+)$/;
    var specialChars="()><@,;:\".[]";
    var validChars="[^s" + specialChars + "]";
//  var quotedUser="(\"[^\"]*\")";
    var ipDomainPat=/^[(d{1,3}).(d{1,3}).(d{1,3}).(d{1,3})]$/;
    var atom=validChars + "+";
//  var word="(" + atom + "|" + quotedUser + ")";
//  var userPat=new RegExp("^" + word + "(." + word + ")*$");
    var domainPat=new RegExp("^" + atom + "(." + atom +")*$");
    var matchArray=emailStr.match(emailPat);
    if (matchArray==null) {
        //alert("Email address seems incorrect (check @ and .'s)");
        return false;
    }
    var user=matchArray[1];
    var domain=matchArray[2];
    for (i=0; i<user.length; i++) {
        if (user.charCodeAt(i)>127) {
            //alert("Ths username contains invalid characters.");
            return false;
        }
    }
    for (i=0; i<domain.length; i++) {
        if (domain.charCodeAt(i)>127) {
            //alert("Ths domain name contains invalid characters.");
            return false;
       }
    }
//  if (user.match(userPat)==null) {
        //alert("The username doesn't seem to be valid.");
//      return false;
//  }
    var IPArray=domain.match(ipDomainPat);
    if (IPArray!=null) {
        for (var i=1;i<=4;i++) {
            if (IPArray[i]>255) {
                //alert("Destination IP address is invalid!");
                return false;
            }
        }
        return true;
    }
    var atomPat=new RegExp("^" + atom + "$");
    var domArr=domain.split(".");
    var len=domArr.length;
//  for (i=0;i<len;i++) {
//      if (domArr[i].search(atomPat)==-1) {
//          alert("The domain name does not seem to be valid.");
//          return false;
//      }
//  }
    if (checkTLD && domArr[domArr.length-1].length!=2 && domArr[domArr.length-1].search(knownDomsPat)==-1) {
        //alert("The address must end in a well-known domain or two letter " + "country.");
        return false;
    }
    if (len<2) {
        //alert("This address is missing a hostname!");
        return false;
    }

    return true;
}

//##### 필드 기본값 ###################################
function onfocusText(thefield){
    if (thefield.defaultValue==thefield.value) thefield.value = "";
}
function onblurText(thefield){
    if (thefield.value=='') thefield.value = thefield.defaultValue;
}


//###### enter 를 tab 으로 ###########################
function EnterToTab (field, event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13) {
        var i;
        for (i = 0; i < field.form.elements.length; i++)
            if (field == field.form.elements[i])
                break;
        i = (i + 1) % field.form.elements.length;
        field.form.elements[i].focus();
        return false;
    }
    else
    return true;
}

//###### enter 를 submit 으로 ###########################
function EnterToSubmit (frm, event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13) {
        frm.submit();
        return false;
    }
    else
    return true;
}

//### 오토 탭 #################################
var isNN = (navigator.appName.indexOf("Netscape")!=-1);
function autoTab(input,len, e) {
    var keyCode = (isNN) ? e.which : e.keyCode;
    var filter = (isNN) ? [0,8,9] : [0,8,9,16,17,18,37,38,39,40,46];
    if(input.value.length >= len && !containsElement(filter,keyCode)) {
    input.value = input.value.slice(0, len);
    input.form[(getIndex(input)+1) % input.form.length].focus();
}
function containsElement(arr, ele) {
    var found = false, index = 0;
    while(!found && index < arr.length)
    if(arr[index] == ele)
    found = true;
    else
    index++;
    return found;
}
function getIndex(input) {
    var index = -1, i = 0, found = false;
    while (i < input.form.length && index == -1)
    if (input.form[i] == input)index = i;
    else i++;
    return index;
    }
return true;
}