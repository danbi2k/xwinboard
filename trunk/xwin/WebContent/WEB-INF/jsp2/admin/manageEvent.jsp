<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type='text/javascript' src='/xwin/dwr/interface/EventService.js'></script>
<script type='text/javascript' src='/xwin/dwr/engine.js'></script>
<script>
_getEventList();

function _getEventList()
{
	EventService.getEventList(_printEventList);
}

function _createEvent()
{
	var event = {};
	var eventName = document.getElementById('eventName').value;
	
	event.name = eventName;
	try {
		EventService.createEvent(event, _callback);
	} catch (e) {
		alert(e);
	}
	_getEventList();
}

function _removeEvent(id)
{
	EventService.removeEvent(id);
	_getEventList();
}

function _printEventList(eventList)
{
	var eventTable = document.getElementById('eventTable');
	var tableString = '';
	for (i in eventList)
	{
		tableString += '<tr>';
		tableString += '<td>' + eventList[i].id + '</td>';
		tableString += '<td>' + eventList[i].name + '</td>';
		tableString += '<td><a onclick=\'_removeEvent(' +  eventList[i].id + ')\'>x</a></td>';
		tableString += '</tr>';
	}
	//alert(tableString);
	eventTable.innerHTML = tableString;
}

function _callback(result)
{
	alert(result);
}
</script>
</head>
<input type='text' id='eventName'>
<input type='submit' onclick='_createEvent()'>
<body>
<table id='eventTable'></table>
</body>
</html>