<!--	#include virtual="/common/asp/connect.asp"					-->
<!--	#include virtual="/common/asp/Utilityclass.asp"					-->
<!--	#include file="config.asp"					-->
<%
	IntIdx			= Request("Idx")
	strTableName	= Request("TableName")
	IntCurPage		= Request("CurPage")
	strKeyField		= Request("KeyField")
	strKeyWord		= Request("KeyWord")
	strSortColumn	= Request("SortColumn")
	strSort			= Request("Sort")
	If not checkRight(Session("UId"), "board") Then Call descment("권한이 없습니다.", "back","")
%>
<body onload="delform.submit();">
<form name=delform method=post action="Action.asp" enctype="multipart/form-data" >
<input type="hidden" name=Idx value="<%=IntIdx%>">
<input type="hidden" name=TableName value="<%=strTableName%>">
<input type="hidden" name=CurPage value="<%=IntCurPage%>">
<input type="hidden" name=KeyField value="<%=strKeyField%>">
<input type="hidden" name=KeyWord value="<%=strKeyWord%>">
<input type="hidden" name=SortColumn value="<%=strSortColumn%>">
<input type="hidden" name=Sort value="<%=strSort%>">
<input type="hidden" name=flag value="DELETE">
<input type="hidden" name=Sect value="<%=Request("Sect")%>">
<input type="hidden" name=pageSize value="<%=Request("pageSize")%>">
</form>
