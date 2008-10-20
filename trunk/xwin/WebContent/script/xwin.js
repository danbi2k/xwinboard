if ( typeof(Xwin) == 'undefined' ) Xwin = function() {};

debug = function(str)
{
	var _debug = document.getElementById('_debug');
	_debug.innerHTML += str + '<br>'; 
}

Xwin.Escape = function(str)
{
	if (str == undefined)
		return "";
	
	var regexp= RegExp(/%/ig);
	var retStr = str.replace(regexp, "%25");
	regexp= RegExp(/&/ig);
	retStr = retStr.replace(regexp, "%26");
	
	return retStr;
}

Xwin.ToArray = function(data)
{
	if (data == undefined)
		data = [];
	else if (data.length == undefined) {
		var tmp = [data];		
		return tmp;
	}
	
	return data;
}

Xwin.Digit2 = function(value)
{
	if (value == 0)
		value = "0.0";
	var str = "" + value;
	if (str.indexOf(".") < 0)
		str += "."
	str = str + "000";
	var num = str.split(".");
	var frag = num[1].substr(0, 2);
	
	var ret = num[0] + "." + frag;
	
	return ret;
}

Xwin.ToInt = function(value)
{
	var strvalue = "" + value;
	var k = strvalue.indexOf(".");
	if (k >= 0)
		strvalue = strvalue.substr(0, k);
	
	return strvalue;
}

Xwin.Currency = function(value)
{
	var strvalue = "" + value;
    var minus = false;
    if(strvalue.indexOf("-") != -1)
        minus = true;

    var sMoney = strvalue.replace(/(,|-)/g,"");
    var tMoney = "";

    var rMoney = "";
    var rCheck = false;
    if(sMoney.indexOf(".") != -1){
        rMoney = sMoney.substring(sMoney.indexOf("."));
        sMoney = sMoney.substring(0, sMoney.indexOf("."));
        rCheck = true;
    }

    var len = sMoney.length;

    if ( sMoney.length <= 3 ) return sMoney;

    for(i = 0; i < len; i++){
        if(i != 0 && ( i % 3 == len % 3) ) tMoney += ",";
        if(i < len ) tMoney += sMoney.charAt(i);
    }
    if(minus) tMoney = "-" + tMoney;
    if(rCheck) tMoney = tMoney + rMoney;

    return tMoney;
}