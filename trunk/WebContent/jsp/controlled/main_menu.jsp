<%@ include file="/jsp/inc/definitions.inc" %>
<%
String menuStyle = info.get("dbcruiser_menu_bg");
if (menuStyle == null || menuStyle.endsWith("jpg") || menuStyle.endsWith("gif")) {
    menuStyle = "markermenu";
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0"> 
    <title>My JSP 'main_menu.jsp' starting page</title>
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/menu.css">
	<style type="text/css">
	  /*Credits: Dynamic Drive CSS Library */
      /*URL: http://www.dynamicdrive.com/style/ */

      .markermenu{
        list-style-type: none;
        margin: 5px 0;
        padding: 0;
        width: 135px;
        border: 1px solid #9A9A9A;
      }

     .markermenu li a{
       background: white url(<%=contextPath%>/images/arrow-list.gif) no-repeat 2px center;
       font: bold 11px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
       color: #00014e;
       display: block;
       width: auto;
       padding: 3px 0;
       padding-left: 20px;
       text-decoration: none;
       border-bottom: 1px solid #B5B5B5;
     }

     * html .markermenu li a { /*IE only. Actual menu width minus left padding of LINK (20px) */
       width: 100%;
     }

    .markermenu li a:visited, .markermenu li a:active{
       color: #00014e;
    }

    .markermenu li a:hover{
       color: black;
       background-color: #ffffcb;
       background-image:url(<%=contextPath%>/images/arrow-list-red.gif); /*onMouseover image change. Remove if none*/
    }
    .resultmenu{
       list-style-type: disc;
       margin: 1px 5px 5px 15px;
       padding: 0px;
       border: 0px;
    }
    .resultmenu li a{
       font: 9px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
       width: auto;
       color: #00014e;
       text-decoration: none;
    }
    .resultmenu li a:hover{
       color: crimson;
    }
  
    </style>
	<script src="<%=contextPath%>/scripts/prototype.js" type="text/javascript"></script>
	<script>
	  function getMenuItems(){
		var myAjax = new Ajax.Updater('menuList', '<%=contextPath%>/action/MainMenu?connId=<%=connId%>', { method: 'get' });
	  }
	  function getResultItems(){
		var myAjax = new Ajax.PeriodicalUpdater('resultList', '<%=contextPath%>/action/QueryResultList?connId=<%=connId%>', { method: 'get', frequency: 30 });
	  }
	  function refrechResultItems(){
	    var now = new Date();
		var myAjax = new Ajax.Updater('resultList', '<%=contextPath%>/action/QueryResultList?connId=<%=connId%>&id='+now.getTime(), { method: 'get' });
	  }
	  function removeAllQueryResults(){
		var myAjax = new Ajax.Updater('resultList', '<%=contextPath%>/action/QueryResultRemove?connId=<%=connId%>', { method: 'get' });
	  }
	  function removeQueryResult(tablename){
		var myAjax = new Ajax.Updater('resultList', '<%=contextPath%>/action/QueryResultRemove?connId=<%=connId%>&tablename='+tablename, { method: 'get' });
	  }
	  function refrechTableItems(){
	    var now = new Date();
		var myAjax = new Ajax.Updater('tableList', '<%=contextPath%>/action/TableVisitedList?connId=<%=connId%>&id='+now.getTime(), { method: 'get' });
	  }
	  function removeAllTableItems(){
		var myAjax = new Ajax.Updater('tableList', '<%=contextPath%>/action/TableVisitedRemove?connId=<%=connId%>', { method: 'get' });
	  }
	  function removeTableItem(tablename){
		var myAjax = new Ajax.Updater('tableList', '<%=contextPath%>/action/TableVisitedRemove?connId=<%=connId%>&tablename='+tablename, { method: 'get' });
	  }
    </script>
	
  </head>
  
  <body onLoad='getMenuItems();refrechTableItems();refrechResultItems();'>
    <ul id="menuList" name="menuList" class="<%=menuStyle%>">		
    </ul>
    <span class="resultTitle">Tables Visited:</span>
    <a href="javascript:refrechTableItems()" title="Refresh/update the visited table list"><img src="<%=imagePath%>/refresh_tiny.gif" border=0></a>
    <a href="javascript:removeAllTableItems()" title="Remove all the items from the visited table list below and corresponding query results if applicable"><img src="<%=imagePath%>/trash.gif" border=0></a>
    <ul id="tableList" name="tableList" class="resultmenu">		
    </ul>
    <span class="resultTitle">Query Results:</span>
    <a href="javascript:refrechResultItems()" title="Refresh/update the query result list"><img src="<%=imagePath%>/refresh_tiny.gif" border=0></a>
    <a href="javascript:removeAllQueryResults()" title="Remove all the items from the query result list below"><img src="<%=imagePath%>/trash.gif" border=0></a>
    <ul id="resultList" name="resultList" class="resultmenu">		
    </ul>

  </body>
</html>
