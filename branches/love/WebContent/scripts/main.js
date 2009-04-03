
var ROW_SPACER='\u00A0\u00A0\u00A0\u00A0';
var HISTORY_SIZE=4;
var moduleCacheSize=null;
var rowCount=30;
isOpera=null;
siteFrame=null;
tocFrameVar=null;
textInput=null;
menuTable=null;
menuTableRows=new Array();
currentSearchId=0;
previousQuery=null;
searchLink=null;
var emptyResultIndicator='empty';
var displayedUrl=null;
stats='';
searchWhatSpan=null;
searchInSpan=null;
tocNodes=new Array();
searchHistory=null;// will be loaded on demand
//activeModule=null;
activeConn=null;
openMoreLink=null;
E_LINKS_ROW='E_LINKS';
S_LINKS_ROW='S_LINKS';
NODE_SPACER=new Array(null,
                     '\u00A0\u00A0\u00A0\u00A0',
                     '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0',
                     '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0',
                     '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0');
var resizeStart=0;
var textInputSize=null;
var connTabRow=null;
var connTabList=new Array();// list of connections in the tab table
var currentHistoryIndex=0;
var directSiteLink=null;
var relatedLink=null;
var MAX_VISIBLE_URL_LENGTH=40;
var selectedRowClass='selectedRow';
var headerRowClass='headerRow';
var matchingItemsTitle='Matching Items:';

function initialize(){
  isOpera=window.opera;
  siteFrame=document.getElementById('siteFrame');
  tocFrameVar=document.getElementById('tocFrame');
  searchWhatSpan=document.getElementById('searchWhat');
  searchInSpan=document.getElementById('searchIn');
  connTabRow=document.getElementById('connTabRow');
  menuTable=document.getElementById('menu');
  //var movable=document.getElementById('movable');
  //movable.onmousedown=onMovableMouseDown;
  buildConnTabs();
}
function onMovableMouseDown(evt){
  evt=evt?evt:window.event;
  resizeStart=evt.clientX;
  siteFrame.style.display='none';
  tocFrameVar.style.display='none';
  document.documentElement.style.cursor='col-resize';
  document.onmouseup=onMovableMouseUp;
  document.onmousemove=onMovableMouseMove;
  return false;}
function onMovableMouseMove(evt){
  return false;
}
function onMovableMouseUp(evt){
  evt=evt?evt:window.event;
  var shift=evt.clientX - resizeStart;
  //textInputSize=(textInputSize?textInputSize:textInput.offsetWidth)+shift;
  //textInput.style.width=textInputSize;
  siteFrame.style.display='';
  tocFrameVar.style.display='';
  document.documentElement.style.cursor=null;
  document.onmouseup=null;
  document.onmousemove=null;
  return false;
}
function removeAllChilds(argNode){
  while(argNode.firstChild){
    argNode.removeChild(argNode.firstChild);
  }
}
function processFocus(evt){
  var value=textInput.value;
  if(value==''||value=='Loading...'){
     setMenuVisible(false);return;}setMenuVisible(true);
}
function processBlur(evt){
  setMenuVisible(false);
}
function setMenuVisible(argVisible){
  var visibleNow=menuTable.style.display=='';
  if(visibleNow==argVisible){return;}
  if(argVisible){
     showPopupNode(menuTable,textInput,3,0);
  }else{
     menuTable.style.display='none';
  }
  if(isOpera){
     siteFrame.style.display=argVisible?'none':'';
     tocFrameVar.style.display=argVisible?'none':'';
  }
}
function showPopupNode(showNode,relativeNode,offsetX,offsetY){
  var nodeX=relativeNode.offsetLeft;
  var nodeY=relativeNode.offsetTop+relativeNode.offsetHeight;
  var node=relativeNode;
  while(node.offsetParent){
    node=node.offsetParent;
	nodeX+=node.offsetLeft;
	nodeY+=node.offsetTop;
  }
  showNode.style.left=nodeX+offsetX;
  showNode.style.top=nodeY+offsetY;
  showNode.style.display='';
}
function isMenuVisible(){
  var visibleNow=menuTable.style.display=='';
  return visibleNow;
}
function selectRow(argRow,argDirection){
  var row=argRow;
  for(;;){
      if(row >=rowCount||row < 0||menuTableRows[row].style.display=='none'){
         return;
      }
      if(menuTableRows[row].n){break;}
      row+=argDirection;
  }
  if(selectedRow >=0){
     var activeRow=menuTableRows[selectedRow];
     activeRow.className='regularRow';
  }
  selectedRow=row;
  var activeRow=menuTableRows[selectedRow];
  activeRow.className=selectedRowClass;
}
function keyup(evt){
  var key=evt?evt.keyCode:window.event.keyCode;
  if(key !=13 && key !=255 && key !=40 && key !=38){
     update();
     return false;
  }
}
function keydown(evt){
  var key=evt?evt.keyCode:window.event.keyCode;
  if(key==13){
     showRow(selectedRow,false);
     var isNetscape=navigator.appName.toLowerCase().indexOf('netscape') >=0;
     if(isNetscape){
        if (evt.preventDefault) evt.preventDefault();
        if (evt.returnValue) evt.returnValue=false;
        if (evt.stopPropagation) evt.stopPropagation();
     }
     return false;
  }else if(key==40){
     selectRow(selectedRow+1,+1);
     setMenuVisible(true);
  }else if(key==38){
     selectRow(selectedRow-1,-1);
     setMenuVisible(true);
  }else if(key !=255){
     setMenuVisible(true);
     return true;
  }
  return false;
}
/*
function showRow(argRow,argMenuVisible){
  if(argRow < 0){return;}
  setMenuVisible(argMenuVisible);
  var row=menuTableRows[argRow];
  if(isString(row.n) && E_LINKS_ROW==row.n) {
     showRelated();
     return;
  }
  if(isString(row.n) && S_LINKS_ROW==row.n) {
     window.site.location='search.html';
     return;
  }
  showItem(row.n);
}
function showItem(argItem){
  var url=getResourceUrl(argItem);
  if(displayedUrl !=url||! isMenuVisible()){
     window.site.location=url;
     displayedUrl=url;
     addToRecent(activeModule.technology+' -> '+getResourceTitle(argItem,' -> ',' '),url);
  }
  addStats('go',argItem.n);
  sendStats();
}

function getResourceContext(argNode){
  var context=argNode.p?getResourceContext(argNode.p):'';var c=argNode.c;
  if(c){
     c=uncompressValue(c,argNode);
     context=c.indexOf('http://')==0?c:context+c;
  }
  return context;
}
function getResourceUrl(argNode){
  if(argNode.u||argNode.c){
     var ctx=getResourceContext(argNode);
     var u=argNode.u;
     if(! u){
        return ctx;
     }
     u=uncompressValue(u,argNode);
     return u.indexOf('http://')==0?u:ctx+u;
  }else{
     return argNode.p?getResourceUrl(argNode.p):null;
  }
}*/
function uncompressValue(argValue,argNode){
  var idx=argValue.indexOf('`');
  if(idx < 0){return argValue;}
  var name=argNode.n;
  return argValue.substr(0,idx)+name+argValue.substr(idx+1);
}
function goToResource(argResourceIndex){
  showRow(argResourceIndex,false);
}

function Connection(argUserId,
                    argName,
                    argConnUrl,
                    argConnId) {
  this.userId=argUserId;
  this.name=argName;
  this.connUrl=argConnUrl;
  this.connId=argConnId;
}
function nullToEmpty(argString){
  return argString?argString:'';
}
function submitToWindow(argWindow,argContent){
  argWindow.document.open();
  argWindow.document.write('<HTML><HEAD>');
  argWindow.document.write(argContent);
  argWindow.document.write('</HEAD><BODY></BODY></HTML>');
  argWindow.document.close();
}
function postLoadActive(){
  if(! adsenseRefreshRequired) return;
  adsenseRefreshRequired=false;
  updateAdsense();
}
function getConnIndexByConnUrl(argConnUrl){
  for(var i=0;i<connTabList.length;i++){
      var conn=connTabList[i];
      if(conn.connUrl==argConnUrl){return i;}
  }
  return -1;
}
function getConnIndexByConnId(argConnId){
  for(var i=0;i<connTabList.length;i++){
      var conn=connTabList[i];
      if(conn.connId==argConnId){return i;}
  }
  return -1;
  //throw 'Connection '+argConnUrl+' can not be found';
}
function cleanToc(){
  var doc=getTocDoc();
  var list=doc.getElementById('toc');
  list.style.display='none';
  removeAllChilds(list);
  searchWhatSpan.firstChild.nodeValue='\u00A0';
  searchInSpan.firstChild.nodeValue='\u00A0';
}
function getTocDoc(){
  var doc=window.frames.tocFrame.document;
  return doc?doc:tocFrameVar.contentDocument;
}
function getActiveCacheSize(){
  var currentTotal=0;
  for(var i=0;i<allModules.length;i++){
      var m=allModules[i];
      if(m.data){
         currentTotal+=m.data.length;
      }
  }
  return currentTotal;
}
function buildToc(argModule){
  var doc=getTocDoc();
  var tocElement=doc.createElement('nobr');
  tocElement.id='toc';
  argModule.tocElement=tocElement;
  argModule.tocNodes=new Array();
  insertChildsToToc(doc,argModule,argModule.data[0],0,0);
}
function insertChildsToToc(argDoc,argModule,argParentItem,argPosition,argLevel){
  var items=argModule.data;
  for(var i=0;i<items.length;i++){
      var item=items[i];
      if(item && item.p==argParentItem){
         var allowExpand=hasChildItems(items,item,i);
         var node=new Node(argModule,argDoc,item,allowExpand,true,argLevel);
         insertChildToToc(argModule,node,argPosition++);
      }
  }
}
function insertChildToToc(argModule,argNode,argPosition){
  var tocNodes=argModule.tocNodes;
  var tocElement=argModule.tocElement;
  if(argPosition >=tocNodes.length){
     tocElement.appendChild(argNode.nobr);
     tocElement.appendChild(argNode.br);
     tocNodes.push(argNode);
  }else{
     var nextNobr=argPosition==0?null:tocNodes[ argPosition ].nobr;tocElement.insertBefore(argNode.nobr,nextNobr);
     tocElement.insertBefore(argNode.br,nextNobr);
     tocNodes.splice(argPosition,0,argNode);
  }
}
function onTocClick(evt){
  var nod=this.node;
  if(nod.folded){
     toggleNode(this.node);
  }
  var item=nod.item;
  showItem(item);
  return false;
}
function toggleNode(argNode){
  var doc=getTocDoc();
  var tocNodes=activeModule.tocNodes;
  var list=activeModule.tocElement;
  var nod=argNode;
  var item=nod.item;
  if(nod.folded){
     var pos=arrayIndexOf(tocNodes,nod);
     insertChildsToToc(doc,activeModule,item,pos+1,nod.level+1);
     updateNodeFolded(nod,false);
  }else{
     var level=nod.level;var i=arrayIndexOf(tocNodes,nod)+1;
     while(i<tocNodes.length){
       var n=tocNodes[i];
       if(n.level <=level){break;}
       removeTocNode(list,tocNodes,n,i);
     }
     updateNodeFolded(nod,true);
  }
}
function onToggleClick(evt){
  toggleNode(this.node);
  return false;
}
function removeTocNode(argList,argTocNodes,argNode,argPosition){
  argList.removeChild(argNode.nobr);
  argList.removeChild(argNode.br);
  argTocNodes.splice(argPosition,1);
}
function Node(argModule,argDoc,argItem,argFoldable,argFolded,argLevel){
  this.item=argItem;
  this.folded=argFolded;
  this.level=argLevel;
  var iconSrc=null;
  var type=argItem.t;
  /*
  if(type=='C'||type=='I'||type=='O'||type=='V'||type=='P'){ 
     iconSrc='type'+type+'.gif';
  }
  */
  this.nobr=argDoc.createElement('nobr');
  this.br=argDoc.createElement('br');
  this.img=createFoldingButton(argDoc,argFoldable,argFolded);
  this.img.node=this;this.img.onclick=onToggleClick;
  var text=argDoc.createElement('span');
  text.node=this;
  text.onclick=onTocClick;
  text.appendChild(argDoc.createTextNode(iconSrc?argItem.n:getResourceLabel(argItem)));
  if(type=='C'||type=='I'){
     text.className='tocItem';
  }else if(type=='M'){
     text.className='tocItem2';
  }else if(type=='O'){
     text.className='tocItem3';
  }else{
     text.className='tocGroup';
  }
  var spacer=NODE_SPACER[argLevel];
  if(spacer){
     this.nobr.appendChild(argDoc.createTextNode(spacer));
  }
  if(! argModule.showFirstLevelOnly){
     this.nobr.appendChild(this.img);
  }
  if(iconSrc){
     var icon=argDoc.createElement('img');
     icon.src=iconSrc;
     icon.hspace=0;
     icon.width=type=='V'?8:14;
     icon.height=10;
     this.nobr.appendChild(icon);
  }
  this.text=text;
  this.nobr.appendChild(text);
}
function arrayIndexOf(argArray,argItem){
  for(var i=0;i<argArray.length;i++){
      if(argArray[i]==argItem) return i;
  }
  return -1;
}
function hasChildItems(argItems,argItem,argItemIndex){
  var list=argItems;
  var i=argItemIndex;
  return i+1>=list.length||list[i+1]==null?false:list[i+1].p==argItem;
}
function insertNodeAt(argParent,argPosition,argNode){
  var n=argParent.firstChild;
  //var n=argParent.lastChild;
  for(var i=0;n;i++){
      if(i==argPosition){
         argParent.insertBefore(argNode,n);
         break;
      }
      n=n.nextSibling;
  }
  if(! n){
     argParent.appendChild(argNode);
  }
}
function show(argModule){
  showModule(argModule);
  return false;
}
function activiateConn(argConn) {
  updateConnSelection(activeConn,false);
  if(argConn){
     updateConnSelection(argConn,true);
     activeConn = argConn;
  }
}

function showConn(argUserId,argName,argConnUrl,argConnId) {
  //addStats('module',argModule.path);
  //alert(argConnUrl);
  //var idx=arrayIndexOf(moduleTabList,argModule);
  //alert("idx="+idx);
  //var index = getConnIndexByConnUrl(argConnUrl);
  var index = getConnIndexByConnId(argConnId);
  var conn = connTabList[index];
  updateConnSelection(activeConn,false);
  if(conn){
     updateConnSelection(conn,true);
  }else{
     conn = new Connection(argUserId,argName,argConnUrl,argConnId);
     insertConnTab(connTabList.length,conn,true);
  }
  activeConn = conn;
  //loadModule(argModule);
}
function updateConnSelection(argConn,argSelected){
  if(argConn && argConn.tabTd){
     argConn.tabTd.className=argSelected?'tabSelected':'tab';
	 argConn.tabCornerTd.className=argSelected?'tabCornerSelected':'tabCorner';
	 argConn.tabCornerImg.src=argSelected?'images/corner1Active.gif':'images/corner1.gif';
	 argConn.tabCornerImg.style.cursor=argSelected?'pointer':'';
	 setTocDoc(argConn.connId);
	 setSiteDoc(argConn.connId,argConn.name);
	 //window.parent.tocFrame.document.location.href='<%=actionPath%>/MainMenu?connId=<c:out value="${requestScope.connId}" />';
	 //new Ajax.Request(contextPath+'/action/Disconnect', { method: 'get',  parameters: {connId: activeConn.connId}  }); 
  }
}
function insertConnTab(argPos,argConn,argSelected){
  //alert("argPos="+argPos);
  var td=document.createElement('td');
  td.className=argSelected?'tabSelected':'tab';
  td.vAlign='top';
  td.conn=argConn;
  td.onclick=onTabClick;
  td.appendChild(document.createTextNode(argConn.userId));
  td.appendChild(document.createElement('br'));
  var noteSpan=document.createElement('nobr');
  noteSpan.className='tabNote';
  //noteSpan.appendChild(document.createTextNode(shorten(argModule.title,16)));
  noteSpan.appendChild(document.createTextNode(shorten(argConn.name,30)));
  td.appendChild(noteSpan);
  argConn.tabTd=td;
  insertNodeAt(connTabRow,argPos*2,td);
  var td1=document.createElement('td');
  td1.className=argSelected?'tabCornerSelected':'tabCorner';;
  td1.vAlign='top';
  td1.conn=argConn;
  td1.onclick=onTabClick;
  var img1=document.createElement('img');
  img1.src=argSelected?'images/corner1Active.gif':'images/corner1.gif';
  img1.style.cursor=argSelected?'pointer':'';
  img1.border=0;
  img1.hSpace=0;
  img1.vSpace=0;
  img1.conn=argConn;
  img1.onclick=onCloseOrActivateConn;
  td1.appendChild(img1);
  //td1.appendChild(img1);
  insertNodeAt(connTabRow,argPos*2+1,td1);
  argConn.tabCornerTd=td1;
  argConn.tabCornerImg=img1;
  connTabList.splice(argPos,0,argConn);
  setTocDoc(argConn.connId);
  setSiteDoc(argConn.connId,argConn.name);
}
function setTocDoc(argConnId) {
  if(argConnId){
     getTocDoc().location.href=contextPath+'/jsp/controlled/main_menu.jsp?connId='+argConnId;
  }else{
     getTocDoc().location.href=contextPath+'/toc.html';
  }
}
function setSiteDoc(argConnId,argName) {
  if(argConnId){
     window.site.location.href=contextPath+'/jsp/controlled/table_list.jsp?connId='+argConnId+'&db_name='+argName;
  }else{
     window.site.location.href=contextPath+'/welcome.html';
  }
}
function onTabClick(){
  activiateConn(this.conn);
  return false;
}
function onCloseOrActivateConn(){
  if(this.conn==activeConn){
     closeActiveConn();
  }
}
function closeAllConns(){
  if(connTabList.length > 0) {
     if (confirm("Close all connections?")) {
         new Ajax.Request(contextPath+'/action/Logout', { method: 'get',  parameters: {connId: activeConn.connId}  }); 
         closeConn(activeConn);
     }
  }else{
     alert("No active connection");
  }
}
function closeActiveConn(){
   if (confirm("Close this connection?\n"+activeConn.userId+"\n"+activeConn.name)) {
       new Ajax.Request(contextPath+'/action/Disconnect', { method: 'get',  parameters: {connId: activeConn.connId}  }); 
       closeConn(activeConn);
   }
}
function closeConnById(argConnId){
  var index = getConnIndexByConnId(argConnId);
  var conn = connTabList[index];
  closeConn(conn);
}
function closeConn(argConn){
  var idx=arrayIndexOf(connTabList,argConn);
  connTabRow.removeChild(argConn.tabTd);
  connTabRow.removeChild(argConn.tabCornerTd);
  connTabList.splice(idx,1);
  argConn=null;
  if(connTabList.length > 0) {
     activiateConn(connTabList[0]);
  } else {
     setTocDoc();
     window.site.location=contextPath+'/jsp/login.jsp';
  }
  return false;
}

function buildConnTabs(){
  var date=new Date();
  new Ajax.Request(contextPath+'/action/BuildConnTabs?sec='+date.getTime(), 
     { 
       method: 'get',  
       onComplete: function(transport){
         eval(transport.responseText);
       } 
     }); 
  return false;
}
function shorten(argString,argLength){
  return argString.length > argLength?argString.substr(0,argLength)+'...':argString;
}
function readCookie(name){
  var nameEQ=name+"=";
  var ca=document.cookie.split(';');
  for(var i=0;i < ca.length;i++){
      var c=ca[i];
      while (c.charAt(0)==' ') 
        c=c.substring(1,c.length);
        if (c.indexOf(nameEQ)==0) 
            return c.substring(nameEQ.length,c.length);
  }
  return null;
}
function saveCookie(name,value){
  var date=new Date();
  date.setTime(date.getTime()+(365*24*60*60*1000));
  document.cookie=name+"="+value+";expires="+date.toGMTString()+";path=/";
}
function createFoldingButton(argDoc,argFoldable,argFolded){
  /*
  var button=argDoc.createElement('img');
  button.hspace=1;
  button.src=argFoldable?(argFolded?'plus1.gif':'minus1.gif'):'none1.gif';
  button.className='tocToggle';
  */
  var txt=argDoc.createTextNode(argFoldable?(argFolded?'+':'\u2013'):'+');
  var button=argDoc.createElement('span');
  button.appendChild(txt);
  button.className=argFoldable?'textToggle':'textNoToggle';
  return button;
}
function updateNodeFolded(argNode,argFolded){
  argNode.folded=argFolded;
  argNode.img.firstChild.nodeValue=argFolded?'+':'\u2013';
}
function addStats(argType,argMsg){
  if(stats.length < 3000){
     stats+='|'+argType+':'+argMsg;
  }
}
function sendStats(){
  window.loader.location='blank.html?stats='+stats;
  stats='';
}
function mouseLeaves(element,evt) {
  if (typeof evt.toElement !='undefined' && evt.toElement && typeof element.contains !='undefined') {
      return !element.contains(evt.toElement);
  }else if (typeof evt.relatedTarget !='undefined' && evt.relatedTarget) {
      return !contains(element,evt.relatedTarget);
  }
}
function contains (container,containee) {
  while (containee) {
    if (container==containee) {return true;}
    containee=containee.parentNode;
  }
  return false;
}
function isString(str) {
  return str && (typeof str).toLowerCase()=='string';
}
function about(){
  //window.site.location = contextPath+'/action/About';
  siteFrame.src = contextPath+'/action/About';
}
function admin(){
  siteFrame.src = contextPath+'/jsp/admin_login.jsp'
}
function clientInfo(){
  siteFrame.src = contextPath+'/action/RequestInfo'
}
function addNewConn(){
  siteFrame.src = contextPath+'/jsp/login.jsp'
}
function refrechResultItems(){
  window.tocFrame.refrechResultItems();
}
function refrechTableItems() {
  window.tocFrame.refrechTableItems();
}
function setVisibility(objectID,state) {
	var object = document.getElementById(objectID);
	object.style.visibility = state;
}

function displayObject(objectID) {
	setVisibility(objectID, "visible")
}

function hideObject(objectID) {
	setVisibility(objectID, "hidden")
}
function adminWindow(){
  var winl = (window.innerWidth)?(window.innerWidth/2)-100:(document.body.clientWidth/2)-100;
  var wint = (window.innerHeight)?(window.innerHeight/2)-150:(document.body.clientHeight/2)-150;
  alert(winl);
  alert(wint);
  var object = document.getElementById("adminLogin");
  object.style.left = winl;
  object.style.top = wint;
  displayObject("adminLogin");
}
function contactWindow(){
  contactwin=dhtmlwindow.open('contactbox', 'iframe', contextPath+'/action/AdminContact', 'DB Cruiser Administration Contact', 'width=350px,height=100px,resize=1,scrolling=1,center=0', 'blue');
}