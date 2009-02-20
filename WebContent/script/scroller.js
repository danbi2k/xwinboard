window.onload = function(){
	quickMenuCtr();
}

var timer;
function quickMenuCtr() {
	var obj = document.getElementById('sub_right_content');

	var topPosition = 182;
	var topLimit = 0;
	var highScrollSpeed = 30;
	var lowScrollSpeed = 10;
	var btmLimit = 62;

	obj.initTop = topPosition;
	obj.topLimit = topLimit;
	obj.bottomLimit = document.body.scrollHeight - obj.offsetHeight - btmLimit;
	//document.getElementById('bettingPrice').value = document.body.scrollHeight;
	obj.style.position = "absolute";
	obj.top = obj.initTop;
	obj.style.top = obj.top + "px";

	obj.getTop = function() {
		if (document.body.scrollTop) {
			return document.body.scrollTop;
		} else if (window.pageYOffset) {
			return window.pageYOffset;
		} else {
			return 0;
		}
	}
	obj.getHeight = function() {
		if (self.innerHeight) {
			return self.innerHeight;
		} else if(document.body.clientHeight) {
			return document.body.clientHeight;
		} else {
			return 500;
		}
	}

	obj.getLeft = function() {
		if (document.body.scrollTop) {
			return document.body.scrollLeft;
		} else if (window.pageXOffset) {
			return window.pageXOffset;
		} else {
			return 0;
		}
	}
	obj.getWidth = function() {
		if (self.innerWidth) {
			return self.innerWidth;
		} else if(document.body.clientWidth) {
			return document.body.clientWidth;
		} else {
			return 500;
		}
	}

	obj.move = function() {
		
		var startPoint, endPoint, refreshTime; 

		startPoint = obj.style.top; 
		endPoint = obj.getTop + topPosition; 

		if (endPoint < topPosition) endPoint = topPosition;

		refreshTime = highScrollSpeed; 

		if ( startPoint != endPoint ) refreshTime = lowScrollSpeed;

		pos = obj.getTop() + topPosition;
		
		if (pos > obj.bottomLimit)
			pos = obj.bottomLimit;
		if (pos < obj.topLimit)
			pos = obj.topLimit;

		interval = obj.top - pos;
		obj.top = obj.top - interval / 15;
		obj.style.top = obj.top + "px";
		//obj.style.left = (document.body.scrollWidth - 460)/2 + 460 + "px";
		timer = setTimeout (obj.move, refreshTime);
	};

	obj.Init = function(){
		var animate = document.getElementById('animate');
		if (readCookie("ANIMATEST") == "false") { 
			animate.checked = false;
			clearTimeout(timer); 
		} 
		else { 
			animate.checked = true; 
			obj.move();
		}
		//obj.style.left = (document.body.scrollWidth - 460)/2 + 460 + "px";
	};

	obj.Init();
}

function toggleAnimate(){ 
	var animate = document.getElementById('animate');
	if (animate.checked) { 
		saveCookie("ANIMATEST", "true", 300); 
	} 
	else { 
		saveCookie("ANIMATEST", "false", 300); 
	} 
	quickMenuCtr();
}

function readCookie(name) { 
	var label = name + "="; 
	var labelLen = label.length; 
	var cLen = document.cookie.length; 
	var i = 0; 

	while (i < cLen) { 
		var j = i + labelLen; 

		if (document.cookie.substring(i, j) == label) { 
			var cEnd = document.cookie.indexOf(";", j); 
			if (cEnd == -1) cEnd = document.cookie.length; 

			return unescape(document.cookie.substring(j, cEnd)); 
		} 

		i++; 
	} 

	return ""; 
} 

function saveCookie(name, value, expire){ 
	var eDate = new Date(); 
	eDate.setDate(eDate.getDate() + expire); 
	document.cookie = name + "=" + value + "; expires=" +  eDate.toGMTString()+ "; path=/"; 
}