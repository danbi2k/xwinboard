function del_cart(num)
{
	
	document.betForm.gCnt.value=num;
	document.betForm.mode.value="del_cart";
//	alert(document.betForm.gCnt.value);
	document.betForm.action="Cart_Prc.asp";
	document.betForm.submit();
//	location.href='Cart_Prc.asp?mode=del_cart&gCnt=' + num;
}

function check_cart()
{
	var mypoint=0;
	var obj = myform.cart_num;
	if(!obj) return;

	if(obj.length)
	{
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].checked)mypoint+=parseInt(myform.betmoney[i].value);
		}
	}
	else
	{
		if(obj.checked)mypoint+=parseInt(myform.betmoney.value);
	}
	getObject("amount").value = mypoint;
}

function delall()
{
	var nums="";
	var obj = myform.cart_num;
	if(!obj) return;

	if(obj.length)
	{
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].checked)nums+=obj[i].value+",";
		}
	}
	else
	{
		if(obj.checked)nums+=obj.value+",";
	}
	if (nums.length>0)
	{
		nums=nums.substring(0,nums.length-1);
	}
	if(nums=="") 
	{
		alert("삭제할 카트를 선택하십시오.");
		return;
	}
	
	document.betForm.gCnt.value=nums;
//	alert(document.betForm.gCnt.value);
	document.betForm.mode.value="del_cart";
	document.betForm.action="Cart_Prc.asp";
	document.betForm.submit();
//	location.href='Cart_Prc.asp?mode=del_cart&gCnt=' + nums;
}


function delalltmp()
{
	location.href='TmpCart_Prc.asp?mode=del_cart';
}

var submitcountcrt=0;
function cart_bet()
{
	var nums="";
	var obj = myform.cart_num;
	if(!obj) return;

	if(obj.length)
	{
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].checked)nums+=obj[i].value+",";
		}
	}
	else
	{
		if(obj.checked)nums+=obj.value+",";
	}
	if (nums.length>0)
	{
		nums=nums.substring(0,nums.length-1);
	}
	if(nums=="") 
	{
		alert("배팅할 카트를 선택하십시오.");
		return;
	}
	if(parseInt(getObject("amount").value)>f_coin)
	{
		alert("배팅액이 현재금보다 클 수 없습니다.");
		return;
	}
	
	
	if (submitcountcrt == 0) {
		submitcountcrt++;
		
		document.frmcs.gCnt.value=nums;
		document.frmcs.action='Bet_Prc.asp';
		document.frmcs.submit()
//		location.href='Cart_Prc.asp?mode=cart_bet&gCnt=' + nums;

		return;
	}  else  { // 폼 전송줄일때 다시 폼 전송을 누를때
	    alert("베팅 전송중입니다. 잠시만 기다려 주세요.");
	    return;
    }
    
    
	
}

var submitcountcrttm=0;
function tmpcart_betch(ac)
{
	var obj2 = document.myform;
	var obj = myform.cart_num;
	if(!obj2) return;
	
	var min_bet="5000";
	var max_bet="1000000";
	var max_amount="3000000";
	var tmAllAllAllot=obj2.viewAllAllot.value;							// 배당율
	var tmbetmoney=fConvertAmountToNumber(obj2.viewbetmoney.value);		// 배팅금액
	var tmAllmoney=fConvertAmountToNumber(obj2.viewAllhMoney.value);	// 예상최고 적중금액
	var bv=fConvertAmountToNumber(obj2.amount.value);					// 예상최고 적중금액
	
	if(!fCheckNumber(bv)) {
		alert("복식 베팅금액은 숫자만 입력해 주세요."+bv);
		obj2.amount.value = fConvertAmountToNumber(obj2.oviewbetmoney.value);
		return;
	}
	
	totalprice = Math.floor(tmAllAllAllot * bv);	

	if(parseInt(bv)<min_bet || parseInt(bv)>max_bet)
	{
		alert("배팅액은 " + MoneyFormat(min_bet) + "~" + MoneyFormat(max_bet) + "원 사이입니다.");
		obj2.amount.value = fConvertAmountToNumber(obj2.oviewbetmoney.value);
		return;
	}
	
	
	if(parseInt(totalprice)>max_amount)
	{
		alert("최대적중금은 " + fConvertNumberToAmount(max_amount) + "를 넘을 수 없습니다.");
		obj2.amount.value = fConvertAmountToNumber(obj2.oviewbetmoney.value);
		return;
	}
	
	if(parseInt(bv)>f_coin)
	{
		alert("배팅액이 현재금보다 클 수 없습니다.");
		return;
	}
	obj2.viewbetmoney.value = fConvertNumberToAmount(bv);
	obj2.amount.value = fConvertAmountToNumber(bv);
	obj2.viewAllhMoney.value = fConvertNumberToAmount(totalprice);
	
	if (ac=="1") {
	
		if (submitcountcrttm == 0) {
			submitcountcrttm++;
		
//			obj2.betmoney.value = bet._point;
//			obj2.betcontent.value = bet.getList();
			obj2.action='TmpCart_Prc.asp?mode=cart_bet';
			obj2.submit();

			return;
		}  else  { // 폼 전송줄일때 다시 폼 전송을 누를때
		    alert("베팅 전송중입니다. 잠시만 기다려 주세요.");
		    return;
		}
		
	}
}

function tmpcart_bet()
{
	var min_bet = 0;
	var max_bet = 0;
	var max_amount = 0;
	var g_type = getObject("game_type").value;
	
	min_bet = parseInt(eval("min_bet" + g_type));
	max_bet = parseInt(eval("max_bet" + g_type));
	max_amount = 3000000;
	var nums="";
	var obj = myform.cart_num;
	if(!obj) return;


	/*
	if(nums=="") 
	{
		alert("배팅할 카트를 선택하십시오.");
		return;
	}
	*/
//	alert(myform.AllhMoney.value);
	alert(max_amount);
	if(parseInt(myform.AllhMoney.value)>max_amount)
	{
		alert("최대적중금은 " + MoneyFormat(max_amount) + "를 넘을 수 없습니다.");
		return;
	}
	
	if(parseInt(getObject("amount").value)>f_coin)
	{
		alert("배팅액이 현재금보다 클 수 없습니다.");
		return;
	}
	location.href='TmpCart_Prc.asp?mode=cart_bet';
}