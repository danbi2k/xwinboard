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
		alert("������ īƮ�� �����Ͻʽÿ�.");
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
		alert("������ īƮ�� �����Ͻʽÿ�.");
		return;
	}
	if(parseInt(getObject("amount").value)>f_coin)
	{
		alert("���þ��� ����ݺ��� Ŭ �� �����ϴ�.");
		return;
	}
	
	
	if (submitcountcrt == 0) {
		submitcountcrt++;
		
		document.frmcs.gCnt.value=nums;
		document.frmcs.action='Bet_Prc.asp';
		document.frmcs.submit()
//		location.href='Cart_Prc.asp?mode=cart_bet&gCnt=' + nums;

		return;
	}  else  { // �� �������϶� �ٽ� �� ������ ������
	    alert("���� �������Դϴ�. ��ø� ��ٷ� �ּ���.");
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
	var tmAllAllAllot=obj2.viewAllAllot.value;							// �����
	var tmbetmoney=fConvertAmountToNumber(obj2.viewbetmoney.value);		// ���ñݾ�
	var tmAllmoney=fConvertAmountToNumber(obj2.viewAllhMoney.value);	// �����ְ� ���߱ݾ�
	var bv=fConvertAmountToNumber(obj2.amount.value);					// �����ְ� ���߱ݾ�
	
	if(!fCheckNumber(bv)) {
		alert("���� ���ñݾ��� ���ڸ� �Է��� �ּ���."+bv);
		obj2.amount.value = fConvertAmountToNumber(obj2.oviewbetmoney.value);
		return;
	}
	
	totalprice = Math.floor(tmAllAllAllot * bv);	

	if(parseInt(bv)<min_bet || parseInt(bv)>max_bet)
	{
		alert("���þ��� " + MoneyFormat(min_bet) + "~" + MoneyFormat(max_bet) + "�� �����Դϴ�.");
		obj2.amount.value = fConvertAmountToNumber(obj2.oviewbetmoney.value);
		return;
	}
	
	
	if(parseInt(totalprice)>max_amount)
	{
		alert("�ִ����߱��� " + fConvertNumberToAmount(max_amount) + "�� ���� �� �����ϴ�.");
		obj2.amount.value = fConvertAmountToNumber(obj2.oviewbetmoney.value);
		return;
	}
	
	if(parseInt(bv)>f_coin)
	{
		alert("���þ��� ����ݺ��� Ŭ �� �����ϴ�.");
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
		}  else  { // �� �������϶� �ٽ� �� ������ ������
		    alert("���� �������Դϴ�. ��ø� ��ٷ� �ּ���.");
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
		alert("������ īƮ�� �����Ͻʽÿ�.");
		return;
	}
	*/
//	alert(myform.AllhMoney.value);
	alert(max_amount);
	if(parseInt(myform.AllhMoney.value)>max_amount)
	{
		alert("�ִ����߱��� " + MoneyFormat(max_amount) + "�� ���� �� �����ϴ�.");
		return;
	}
	
	if(parseInt(getObject("amount").value)>f_coin)
	{
		alert("���þ��� ����ݺ��� Ŭ �� �����ϴ�.");
		return;
	}
	location.href='TmpCart_Prc.asp?mode=cart_bet';
}