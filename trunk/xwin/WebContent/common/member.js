function FnMemReg(frm){

	if(!frm.agree.checked){ alert("����� �����ϼž� �մϴ�."); return false; }
	if(frm.id_input.value.length<2){ alert("ȸ�� ID�� 2�ڸ� �̻� �Է��ϼž� �մϴ�."); frm.id_input.focus(); return; }
	if(frm.id_input.value!=frm.id.value){ alert("ID �ߺ� üũ�� �մϴ�."); check_id(frm); return; }

	if(frm.pw.value.length<4){ alert("��й�ȣ�� �ּ� 4�ڸ� �̻� �Է��ϼž� �մϴ�."); frm.pw.focus(); return; }
	if(frm.pw2.value.length<4){ alert("��й�ȣ�� �ּ� 4�ڸ� �̻� �Է��ϼž� �մϴ�."); frm.pw2.focus(); return; }
	if(frm.pw.value!=frm.pw2.value){ alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.\n��й�ȣ�� �ٽ� �Է����ּ���."); frm.pw.value=""; frm.pw2.value=""; frm.pw.focus(); return; }

	if(frm.nick_input.value.length<2){ alert("�г����� 2�ڸ� �̻� �Է��ϼž� �մϴ�."); frm.nick_input.focus(); return; }
	if(frm.nick.value!=frm.nick_input.value){ alert("�г��� �ߺ� üũ�� �մϴ�."); check_nick(frm); return; }

	if(frm.phone2.value.length<3){ alert("�ڵ��� ��ȣ�� ��Ȯ�� �Է��Ͽ��ּ���!"); frm.phone2.focus(); return false; }
	if(frm.phone3.value.length<4){ alert("�ڵ��� ��ȣ�� ��Ȯ�� �Է��Ͽ��ּ���!"); frm.phone3.focus(); return false; }

	if(frm.out_pw.value.length<4){ alert("��� ��й�ȣ�� �Է��Ͽ� �ּ���!."); frm.out_pw.value=""; frm.out_pw.focus(); return; }


//	if(frm.email1.value.length<3){ alert("E-mail �ּҸ� ��Ȯ�� �Է����ּ���!"); frm.email1.focus(); return false; }
//	if(frm.email2.value.length<5){ alert("E-mail �ּҸ� ��Ȯ�� �Է����ּ���!"); frm.email2.focus(); return false; }

//	if(!FnEmailCheck(frm.email1.value + "@"+ frm.email2.value)){ alert("�����ּҰ� �ùٸ��� �ʽ��ϴ�.\n�����ּҸ� ��Ȯ�� �Է��Ͻñ� �ٶ��ϴ�."); frm.email1.value=""; frm.email2.value=""; frm.email1.focus(); return; }

	frm.phone.value = frm.phone1.value +"-"+ frm.phone2.value +"-"+ frm.phone3.value;
	frm.email.value = frm.email1.value +"@"+ frm.email2.value;

	if(confirm("ȸ�������� �Ͻðڽ��ϱ�?\n\n- �߸� ������ �׸��� ������ Ȯ�ιٶ��ϴ�.\n- ���̵� �� ��й�ȣ�� �߸� �ԷµǾ������ �α����� ���� �ʽ��ϴ�.\n- ��Ÿ �߸��� ������ ȸ�������������� ���������մϴ�.")){		
		frm.submit();
	}

}
function FnMemModify(frm){

	if(frm.pw.value.length>0){
		if(frm.pw.value.length<4){ alert("��й�ȣ�� �ּ� 4�ڸ� �̻� �Է��ϼž� �մϴ�."); frm.pw.focus(); return; }
		if(frm.pw2.value.length<4){ alert("��й�ȣ�� �ּ� 4�ڸ� �̻� �Է��ϼž� �մϴ�."); frm.pw2.focus(); return; }
		if(frm.pw.value!=frm.pw2.value){ alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.\n��й�ȣ�� �ٽ� �Է����ּ���."); frm.pw.value=""; frm.pw2.value=""; frm.pw.focus(); return; }
	}

	if(frm.nick_input.value.length<2){ alert("�г����� 2�ڸ� �̻� �Է��ϼž� �մϴ�."); frm.nick_input.focus(); return; }
	if(frm.nick.value!=frm.nick_input.value){ alert("�г��� �ߺ� üũ�� �մϴ�."); check_nick(frm); return; }

	if(frm.phone2.value.length<3){ alert("�ڵ��� ��ȣ�� ��Ȯ�� �Է��Ͽ��ּ���!"); frm.phone2.focus(); return false; }
	if(frm.phone3.value.length<4){ alert("�ڵ��� ��ȣ�� ��Ȯ�� �Է��Ͽ��ּ���!"); frm.phone3.focus(); return false; }

	//if(frm.email1.value.length<3){ alert("E-mail �ּҸ� ��Ȯ�� �Է����ּ���!"); frm.email1.focus(); return false; }
	//if(frm.email2.value.length<5){ alert("E-mail �ּҸ� ��Ȯ�� �Է����ּ���!"); frm.email2.focus(); return false; }

	//if(!FnEmailCheck(frm.email1.value + "@"+ frm.email2.value)){ alert("�����ּҰ� �ùٸ��� �ʽ��ϴ�.\n�����ּҸ� ��Ȯ�� �Է��Ͻñ� �ٶ��ϴ�."); frm.email1.value=""; frm.email2.value=""; frm.email1.focus(); return; }

	frm.phone.value = frm.phone1.value +"-"+ frm.phone2.value +"-"+ frm.phone3.value;
	frm.email.value = frm.email1.value +"@"+ frm.email2.value;
	
	frm.target = "hidden_iframe";
	frm.submit();
	
}
function FnMemOut(){
	if(confirm("Ż�� ��û�Ͻðڽ��ϱ�?\n\nŻ�� ��û�Ͻø�, �����ڰ� Ȯ���� Ż�� ���ѵ帳�ϴ�.")){
		hidden_iframe.location.href = "/member/member_out.asp";
	}
}
function FnMemOutCancle(){
	if(confirm("Ż�� ��û�� ����Ͻðڽ��ϱ�?")){
		hidden_iframe.location.href = "/member/member_out.asp?cancle=1";
	}
}
function check_id(frm){
	var w = 380;
	var h = 200;
	var window_left = (screen.width-w)/2;
	var window_top  = (screen.height-h)/2;
	window.open("check_id.asp?id="+ frm.id_input.value,"checkIDwin",'status=no,width='+ w +',height='+ h +',top=' + window_top + ',left=' + window_left + '');
}
function check_rid(frm){
	var w = 380;
	var h = 200;
	var window_left = (screen.width-w)/2;
	var window_top  = (screen.height-h)/2;
	window.open("check_rid.asp?r_id="+ frm.r_id.value,"checkRIDwin",'status=no,width='+ w +',height='+ h +',top=' + window_top + ',left=' + window_left + '');
}
function check_nick(frm){
	var w = 380;
	var h = 200;
	var window_left = (screen.width-w)/2;
	var window_top  = (screen.height-h)/2;
	window.open("check_nick.asp?nick="+ frm.nick_input.value,"checkNICKwin",'status=no,width='+ w +',height='+ h +',top=' + window_top + ',left=' + window_left + '');
}
function checkid_form(frm){
	if(frm.id.value.length<2){ alert("���̵� 2�� �̻� �Է����ּ���!"); frm.id.focus(); return false; }
	frm.submit();
}
function checkrid_form(frm){
	if(frm.r_id.value.length<2){ alert("���̵� 2�� �̻� �Է����ּ���!"); frm.r_id.focus(); return false; }
	frm.submit();
}
function checknick_form(frm){
	if(frm.nick.value.length<2){ alert("�г����� 2�� �̻� �Է����ּ���!"); frm.nick.focus(); return false; }
	frm.submit();
}
function out_pw_set(){
	var w = 380;
	var h = 200;
	var window_left = (screen.width-w)/2;
	var window_top  = (screen.height-h)/2;
	window.open("outmoney_pw_set.asp","checkNICKwin",'status=no,width='+ w +',height='+ h +',top=' + window_top + ',left=' + window_left + '');
}

//######### �Ӵ�������û ##############
function FnInMoney_Submit(frm){
	if(frm.in_name.value.length<2){ alert("�Ա��ڸ��� �Է��ϼ���!"); frm.in_name.focus(); return; }
	frm.submit();
}
function FnInMoneyCancle(idx){
	if(confirm("�Ӵ�������û�� ����Ͻðڽ��ϱ�?")){
		location.href="inmoney.asp?cancle="+ idx;
	}
}
function FnOutMoney_Submit(frm){
	if(frm.account_bank.value==""){ alert("��ݹ����� ������ �����ϼ���!"); frm.account_bank.focus(); return; }
	if(frm.account_num.value.length<7){ alert("��ݹ����� ���¹�ȣ�� �ٽ� �ѹ� Ȯ�����ּ���!"); frm.account_num.focus(); return; }
	if(frm.account_name.value.length<2){ alert("������ �̸��� ��Ȯ�� �Է����ּ���!!"); frm.account_name.focus(); return; }
	frm.submit();
}
function FnOutMoneyCancle(idx){
	if(confirm("��ݽ�û�� ����Ͻðڽ��ϱ�?")){
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
    obj.value = str.join('').replace(/^,/,''); //��Ʈ���� �����Ͽ� ��ȯ 
} 

//############ �ѱ� �Է� ���� ��ũ��Ʈ ##########################
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

//### ���� üũ ####################################
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

//##### �ʵ� �⺻�� ###################################
function onfocusText(thefield){
    if (thefield.defaultValue==thefield.value) thefield.value = "";
}
function onblurText(thefield){
    if (thefield.value=='') thefield.value = thefield.defaultValue;
}


//###### enter �� tab ���� ###########################
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

//###### enter �� submit ���� ###########################
function EnterToSubmit (frm, event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13) {
        frm.submit();
        return false;
    }
    else
    return true;
}

//### ���� �� #################################
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