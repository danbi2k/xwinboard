var target;
var stime;
var calendar;

document.writeln('<div id="minical" onmouseover="Calendar_Over()" onmouseout="Calendar_Out()" style="background: buttonface; margin:0; border: 1 solid buttonshadow; width:160; display:none; position:absolute; z-index:1">');
document.writeln('<iframe id="Cal_iFrame" width=160 height=130 src=cal.html scrolling=no frameborder=no border=1 bordercolor=red></iframe>');
document.writeln('</div>');

function Calendar_Over() {
	window.clearTimeout(stime);
}

function Calendar_Out() {
	stime=window.setTimeout("calendar.style.display='none';", 200);
}

function Calendar_Click(e) {
	cal_Day = e.title;
	if (cal_Day.length > 6) {
		target.value = cal_Day
	}	
	calendar.style.display='none';
}

function Calendar_D(obj) {
	var now = obj.value.split("-");
	target = obj;															

	var top = document.body.clientTop + GetObjectTop(obj);
	var left = document.body.clientLeft + GetObjectLeft(obj);

	calendar = document.all.minical;
	calendar.style.pixelTop = top + obj.offsetHeight;
	calendar.style.pixelLeft = left;
	calendar.style.display = '';
	
	if (now.length == 3) {											
		Cal_iFrame.Show_cal(now[0],now[1],now[2]);					
	} else {
		now = new Date();
		Cal_iFrame.Show_cal(now.getFullYear(), now.getMonth()+1, now.getDate());
	}
}

function Calendar_M(obj) {
	var now = obj.value.split("-");
	target = obj;															

	var top = document.body.clientTop + GetObjectTop(obj);
	var left = document.body.clientLeft + GetObjectLeft(obj);

	calendar = document.all.minical;
	calendar.style.pixelTop = top + obj.offsetHeight;
	calendar.style.pixelLeft = left;
	calendar.style.display = '';
	
	if (now.length == 2) {
		Cal_iFrame.Show_cal_M(now[0],now[1]);					
	} else {
		now = new Date();
		Cal_iFrame.Show_cal_M(now.getFullYear(), now.getMonth()+1);
	}
}

/**
	HTML 개체용 유틸리티 함수
**/
function GetObjectTop(obj)
{
	if (obj.offsetParent == document.body)
		return obj.offsetTop;
	else
		return obj.offsetTop + GetObjectTop(obj.offsetParent);
}

function GetObjectLeft(obj)
{
	if (obj.offsetParent == document.body)
		return obj.offsetLeft;
	else
		return obj.offsetLeft + GetObjectLeft(obj.offsetParent);
}



nowdate = new Date();
IntYear = nowdate.getYear();
IntMonth = (nowdate.getMonth()+1);
if(IntMonth<=9) IntMonth="0"+IntMonth;
IntDay = nowdate.getDate();
if(IntDay<=9) IntDay="0"+IntDay; 
strToday = IntYear + "" + IntMonth + "" + IntDay; 

function BeforeDay(f,str) {
//	var f = document.lfm;
	var Today = strToday;
	var strYY  = Today.substring(0,4);
	var strMM = Today.substring(4,6);
	var strDD   = Today.substring(6,8);
	
	var strTYY  = Today.substring(0,4);
	var strTMM = Today.substring(4,6);
	var strTDD   = Today.substring(6,8);
	
	today = new Date(strYY, strMM - 1, strDD);
	today.setDate(today.getDate()-str);
	years  = today.getYear();
	months = today.getMonth() + 1;
	days   = today.getDate();

	if( years < 2000)  strYY = years+1900; else strYY = years
		strMM = ((months < 10) ? "0" : "") + months;
		strDD = ((days < 10) ? "0" : "") + days;

	if (f=='') {
	// 폼의 일자를 표시하는 입력란에 문자열을 출력한다.
		document.all.f_date.value = strYY+'-'+strMM+'-'+strDD;
		document.all.t_date.value = strTYY+'-'+strTMM+'-'+strTDD;
	
	} else {
	// 폼의 일자를 표시하는 입력란에 문자열을 출력한다.
		f.f_date.value = strYY+'-'+strMM+'-'+strDD;
		f.t_date.value = strTYY+'-'+strTMM+'-'+strTDD;
	}
}