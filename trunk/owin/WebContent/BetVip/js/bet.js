var itemstr='<TABLE cellSpacing="0" cellPadding="0" width="320" border="0">	';
itemstr+='		<TR>';
itemstr+='			<TD class="ch_game" width="199" height="20">$team1 <FONT color="#FFC602">VS</FONT> $team2</TD>';
itemstr+='			<TD class="ch_game" align="middle" width="23" height="20"></TD>';
itemstr+='			<TD class="ch_game" align="middle" height="20"><FONT color="FFFFFF"><B>$betteam</B></FONT></TD>';
itemstr+='			<TD class="ch_game" align="middle" width="50" height="20">$ratio</TD>';
itemstr+='			<TD align="middle" width="35" height="20"><IMG style="CURSOR: pointer" onclick="del_bet($betid)" src="/images/bet_delete2.gif" align=absmiddle border="0"></TD>';
itemstr+='		</TR>';
itemstr+='	</TABLE>';

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
}
function check_bet(e) {
	
	if (window.event) e = window.event;  
	var src = getSrcElement(e) 
	add_bet(src);
}
function add_bet(src) {
	
	var num = src.getAttribute("num");
	
	var chk1=getObject("chk1_" + num);
	var chk2=getObject("chk2_" + num);
	var chk3=getObject("chk3_" + num);
	
	if(chk1 && src!=chk1) chk1.checked=false;
	if(chk2 && src!=chk2) chk2.checked=false;
	if(chk3 && src!=chk3) chk3.checked=false;
	
	var team1 = getObject("team1_" + num).innerHTML;
	var team2 = getObject("team2_" + num).innerHTML;
	var ratio = getObject("bet" + src.value + "_" + num).innerHTML;

	var bet1 = getObject("bet1_" + num);if(bet1)bet1=bet1.innerHTML;
	var bet2 = getObject("bet2_" + num);if(bet2)bet2=bet2.innerHTML;
	var bet3 = getObject("bet3_" + num);if(bet3)bet3=bet3.innerHTML;else bet3="0";	
	var hand = getObject("handicap_" + num);if(hand)hand=hand.innerHTML;else hand="0";
	
	if(src.checked) {
		
		var item = new Item(num,team1,team2,src.value,ratio,bet1,bet2,bet3,hand);
		bet.addItem(item);
		
		
	} else {
		bet.removeItem(num);
		
	}
	
	//alert(bet.getList());
	calc();
}
function del_bet(num)
{
	for(var i=1;i<=3;i++)
	{
		var chk = getObject("chk" + i + "_" + num);
		chk.checked = false;
	}
	bet.removeItem(num);
	calc();
}

var bet = new BetList();

// JavaScript item class
function Item(betid,team1,team2,betteam,ratio,bet1,bet2,bet3,handicap) {
    this._betid = betid;
	this._team1 = team1;
	this._team2 = team2;
	this._betteam = betteam;
	this._ratio = ratio;
	this._bet1 = bet1;
	this._bet2 = bet2;
	this._bet3 = bet3;
	this._handicap= handicap;
}
Item.prototype._betid;
Item.prototype._team1;
Item.prototype._team2;
Item.prototype._betteam;
Item.prototype._ratio;
Item.prototype._bet1;
Item.prototype._bet2;
Item.prototype._bet3;
Item.prototype._handicap;

//Item.prototype._name;

//Item.prototype.getName = function() {
//    return this._name;
//}


// JavaScript BetList class
function BetList() {
	this._items = new Array();   
}
BetList.prototype._totalprice;
BetList.prototype._point;
BetList.prototype._bet;
BetList.prototype._items;

BetList.prototype.addItem = function(item) 
{
	this.removeItem(item._betid);
	this._items.push(item);
	add_bet_list(item);	
	
}
BetList.prototype.removeItem = function(num)
{
	var pos=-1;
	for(var i=0;i<this._items.length;i++)
	{
		if(this._items[i]._betid==num)
		{
			pos = i;
			break;
		}
	}
	if(pos>=0)
	{
		del_bet_list(num);
		this._items.remove(pos,pos);		
	}
}
BetList.prototype.getList = function()
{
	var re="";
	for(var i=0;i<this._items.length;i++)
	{
		re+= this._items[i]._betid + "\t" + this._items[i]._betteam + "\t" + this._items[i]._team1 + "\t" + this._items[i]._team2 + "\t" + this._items[i]._bet1 + "\t" + this._items[i]._bet2 + "\t" + this._items[i]._bet3 + "\t" + this._items[i]._ratio + "\t" + this._items[i]._handicap + "\n";
	}
	return re;
}
BetList.prototype.setPoint = function(point)
{
	this._point = point;
}
BetList.prototype.exec = function()
{
	this._bet =0;
	for(var i=0;i<this._items.length;i++)
	{
		if(i==0) this._bet=1;

		this._bet = this._bet * (this._items[i]._ratio * 100);
		this._bet = this._bet / 100;
	}	
	this._bet = Floor(this._bet,2);
	//alert(this._bet );
	//this._bet = this._bet * 100;
	
	//this._bet = this._bet / 100;
	//if (this._bet.toFixed)this._bet.toFixed(2);
	this._totalprice = Math.floor(this._point * this._bet);
	betForm.hapr.value = Math.floor(this._point * this._bet);
	
}
BetList.prototype.dealAll = function()
{
	this._items = new Array();
	var tb = getObject("tb_list");
	while(tb.rows.length>0)
		tb.deleteRow(0);

	var arr=document.getElementsByTagName("input");
	if(arr.length)
	{
		for(i=0;i<arr.length;i++)
		{
			if(arr[i].checked)arr[i].checked=false;
		}
	}

	this.exec();
}

function add_bet_list(item)
{
	var str=bet.getList();
	var tb = getObject("tb_list");
	var tr=tb.insertRow(tb.rowIndex);
	tr.id = "tb_row_" + item._betid;
	var td=tr.insertCell(0);
	
	td.innerHTML=get_item_html(item);
}
function del_bet_list(num)
{
	var tb = getObject("tb_list");
	var row = getObject("tb_row_" + num);
	tb.deleteRow(row.rowIndex);	
}
function get_item_html(item)
{
	var re=itemstr;
	var betteam_str="";
	if (item._betteam=="1")
		betteam_str="승";
	else if(item._betteam=="2")
		betteam_str="패";
	else if(item._betteam=="3")
		betteam_str="무";
	
	re=re.replace("$betid",item._betid);
	re=re.replace("$team1",item._team1);
	re=re.replace("$team2",item._team2);
	re=re.replace("$betteam",betteam_str);
	re=re.replace("$ratio",item._ratio);
	return re;
}
function calc()
{
	var point = getObject("txt_point").value;
	point = point.replace(/,/gi,"");
	point = parseInt(point);
	bet.setPoint(point);
	bet.exec();
	
	var betstr = bet._bet;
	if (betstr.toFixed) betstr=betstr.toFixed(2);

	getObject("sp_bet").innerHTML = betstr;
	getObject("sp_total").innerHTML = MoneyFormat(bet._totalprice);
	betForm.haa.value = betstr;
}

var submitcount=0;
function betting(type)
{
	var min_bet = 0;
	var max_bet = 0;
	var max_amount = 0;
	var g_type = getObject("game_type").value;
	
	min_bet = parseInt(eval("min_bet" + g_type));
	max_bet = parseInt(eval("max_bet" + g_type));
	max_amount = parseInt(eval("max_amount" + g_type));
	
	if(bet._point<min_bet || bet._point>max_bet)
	{
		alert("배팅액은 " + MoneyFormat(min_bet) + "~" + MoneyFormat(max_bet) + "원 사이입니다.");
		return;
	}
	if(bet._totalprice>max_amount)
	{
		alert("최대적중금은 " + MoneyFormat(max_amount) + "를 넘을 수 없습니다.");
		return;
	}
	if(bet._totalprice==0 || bet._items.length==0)
	{
		alert("배팅할 경기를 선택하십시오.");
		return;
	}
	if(bet._point>f_coin)
	{
		alert("배팅금액이 현재금보다 클 수 없습니다.");
		return;
	}
	if (bet._items.length>10) {
		alert("10개 이상 베팅하실 수 없습니다.");
		return;
	}
	if (type=="cart")
	{
		betForm.mode.value=type;
		betForm.action="Cart_Prc.asp"
	} 
	else if (type=="tmpcart")
	{
		betForm.mode.value=type;
		betForm.action="TmpCart_Prc.asp"
	}
	else if (type=="cart_bet")
	{
		betForm.mode.value=type;
		betForm.action="TmpCart_Prc.asp"
	}
	else
	{
		betForm.action="Bet_Prc.asp"
		betForm.mode.value="betting";
		if(!confirm("배팅완료시 취소가 불가합니다.\n정말로 배팅하시겠습니까?"))return;	
	}
	
	if (submitcount == 0) {
		submitcount++;
		
		betForm.betmoney.value = bet._point;
		betForm.betcontent.value = bet.getList();
		betForm.submit();

		return;
	}  else  { // 폼 전송줄일때 다시 폼 전송을 누를때
	    alert("베팅 전송중입니다. 잠시만 기다려 주세요.");
	    return;
    }
	

}


function tmpbetting(type)
{
	var min_bet = 0;
	var max_bet = 0;
	var max_amount = 0;
	var g_type = getObject("game_type").value;
	
	min_bet = parseInt(eval("min_bet" + g_type));
	max_bet = parseInt(eval("max_bet" + g_type));
	max_amount = parseInt(eval("max_amount" + g_type));
	
	if(bet._point<min_bet || bet._point>max_bet)
	{
		alert("배팅액은 " + MoneyFormat(min_bet) + "~" + MoneyFormat(max_bet) + "원 사이입니다.");
		return;
	}
	if(bet._totalprice>max_amount)
	{
		alert("최대적중금은 " + MoneyFormat(max_amount) + "를 넘을 수 없습니다.");
		return;
	}
	
	/*
	if(bet._items.length==0)
	{
		alert("배팅 가능한 경기가 없습니다.");
		return;
	}
	*/
	
	if(bet._point>f_coin)
	{
		alert("배팅금액이 현재금보다 클 수 없습니다.");
		return;
	}
	if (bet._items.length>10) {
		alert("10개 이상 베팅하실 수 없습니다.");
		return;
	}
	if (type=="cart")
	{
		betForm.mode.value=type;
		betForm.action="Cart_Prc.asp"
	} 
	else if (type=="tmpcart")
	{
		betForm.mode.value=type;
		betForm.action="TmpCart_Prc.asp"
	}
	else if (type=="cart_bet")
	{
		betForm.mode.value=type;
		betForm.action="TmpCart_Prc.asp"
	}
	else
	{
		betForm.action="Bet_Prc.asp"
		betForm.mode.value="betting";
		if(!confirm("배팅완료시 취소가 불가합니다.\n정말로 배팅하시겠습니까?"))return;	
	}
//	alert(betForm.haa.value);return;
	betForm.betmoney.value = bet._point;
	betForm.betcontent.value = bet.getList();
	betForm.submit();
}


function init()
{
	return;
	/*
	var elArr = myform.elements; 
	for(var i = 0; i < elArr.length; i++) 
	{
		if (elArr[i].type=="checkbox" && elArr[i].id.substring(0,3)=="bet")
		{
			if (elArr[i].checked)
			{
				add_bet(elArr[i]);
			}
		}
	}
	*/
}
function del_all()
{
	bet.dealAll();	
	calc();
}