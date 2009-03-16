<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>


<%
	String _colNum = request.getParameter("colNum");
	String _rowNum = request.getParameter("rowNum");
	
	Integer colNum = 0, rowNum = 0;
	if (_colNum != null)
		colNum = Integer.parseInt(_colNum);
	if (_rowNum != null)
		rowNum = Integer.parseInt(_rowNum);
%>
<SCRIPT LANGUAGE="JavaScript">

</SCRIPT>
<div class="title">토토 등록</div>

※ 입력란에 update, select, delete, create, alter 라는 문자열은 사용하지 마세요

<form>
<input type="hidden" name="mode" value="viewRegisterTotoForm"/>
제목 : <input type="text" size="80"/><br>
<select name="colNum">
	<option value="1" <%=colNum==1?"selected":""%>>1경기</option>
	<option value="2" <%=colNum==2?"selected":""%>>2경기</option>
	<option value="3" <%=colNum==3?"selected":""%>>3경기</option>
</select>
<input type="text" name="rowNum" size="2" value="<%=rowNum%>"/>줄
<input type="submit" value="입력폼생성"/>
</form>

<form name="totoFrm" action="adminToto.aspx" method="post">
<input type="hidden" name="mode" value="registerToto"/>
<table class="toto"">
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="6"><%=j+1%> 경기</td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="2"><input type="text" size="10" name="T<%=j%>L" value="T<%=j%>L"/></td>
	<td align="center" colspan="2">VS</td>
	<td align="center" colspan="2"><input type="text" size="10" name="T<%=j%>R" value="T<%=j%>R"/></td>
<%
	}
%>
</tr>
<tr>
<%
	for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center" colspan="3"><input type="text" size="14" name="I<%=j%>L" value="I<%=j%>L"/></td>
	<td align="center" colspan="3"><input type="text" size="14" name="I<%=j%>R" value="I<%=j%>R"/></td>
<%
	}
%>
</tr>
<%
	for (int i = 0 ; i < rowNum ; i++) {
%>
<tr>
<%
		for (int j = 0 ; j < colNum ; j++) {
%>
	<td align="center"><input type="checkbox" id="<%=j%>A<%=i%>" name="<%=j%>A" onclick="checkToto(this)"/></td>
	<td align="center"><input type="text" size="8" name="C<%=j%>L" value="C<%=j%>L<%=i%>"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>B<%=i%>" name="<%=j%>B" onclick="checkToto(this)"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>C<%=i%>" name="<%=j%>C" onclick="checkToto(this)"/></td>
	<td align="center"><input type="text" size="8" name="C<%=j%>R" value="C<%=j%>R<%=i%>"/></td>
	<td align="center"><input type="checkbox" id="<%=j%>D<%=i%>" name="<%=j%>D" onclick="checkToto(this)"/></td>
<%		
		}
%>
</tr>
<%
	}
%>
</table>
<input type="submit" value="저장"/>
<input type="button" value="검사" onclick="confirmMarking()"/>
<input type="button" value="로드" onclick="loadMarking('0A3-0B0-0C0-0D0-1A5-1B4-1C7-1D3-2A3-2B2-2C2-2D7')"/>
</form>

<script>
var selected = [];
var rowNum = <%=rowNum%>;
var colNum = <%=colNum%>;

var spot = [];
spot[0] = "A";
spot[1] = "B";
spot[2] = "C";
spot[3] = "D";

function checkToto(cobj)
{
	var cobjList = document.getElementsByName(cobj.name);
	if (cobj.checked) {
		for (var i = 0 ; i < cobjList.length ; i++) {
			if (cobjList[i] != cobj)
				cobjList[i].checked = false;
		}
	}
}

function confirmMarking()
{
	var markId = [];
	for (var i = 0 ; i < colNum ; i++) {
		for (var j = 0 ; j < 4 ; j++) {
			var name = i + spot[j];
			var cobjList = document.getElementsByName(name);
			var flag = false;
			for (var x = 0 ; x < cobjList.length ; x++) {
				flag |= cobjList[x].checked;
				if (cobjList[x].checked)
					markId.push(cobjList[x].id);
			}
			if (flag == false) {
				alert("선택되지 않은 항목이 있습니다");
				return;
			}
		}
	}

	var markString = markId.join("-");
	_debug.innerHTML = markString;
	return markString;
}

function loadMarking(markString)
{
	var markId = markString.split("-");
	for (var i = 0 ; i < markId.length ; i++) {
		var cobj = document.getElementById(markId[i]);
		cobj.checked = true;
	}
}
</script>
<div id="_debug"></div>
