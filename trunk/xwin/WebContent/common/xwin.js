if ( typeof(Terebi) == 'undefined' ) Xwin = function() {};

debug = function(str)
{
	var _debug = document.getElementById('_debug');
	_debug.innerHTML += str + '<br>'; 
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
	var str = "" + value;
	var num = str.split(".");
	var frag = num[1].substr(0, 2);
	
	var ret = num[0] + "." + frag;
	
	return ret;
}