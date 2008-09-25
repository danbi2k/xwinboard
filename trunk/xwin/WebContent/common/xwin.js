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