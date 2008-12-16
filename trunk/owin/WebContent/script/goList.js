

	var getQuery = window.location.search.substr(1, window.location.search.length).split("&");
	var queryInfo = new Array();
	
	for (var i = 0; getQuery[i]; i++)
	{
		queryInfo[getQuery[i].substring(0, (getQuery[i].indexOf("=")))] = getQuery[i].substring((getQuery[i].indexOf("=") + 1), (getQuery[i].length));
	}

	function request(theName)
	{
		if (queryInfo[theName])
		{
			return queryInfo[theName]
		}
		else
		{
			return null;
		}
	}

	var query = "";
	
	function setQuery()
	{
		for (var i = 0; i < arguments.length; i++)
		{
			if (getQuery[arguments[i]])
			{
				if (query)
				{
					query += "&";
				}
				
				query += (arguments[i] + "=" + getQuery[arguments[i]]);
			}
		}
	}
	

	function action(f_obj, f_target)
	{
		setQuery("Idx", "Id", "cIdx", "goPage", "CurPage", "CurBlock", "TableName", "ThisPage", "refPage", "SortColumn", "Sort", "KeyField", "KeyField2", "KeyWord", "KeyWord2", "category", "OrdNo", "flag","K1","KD1","KD01","K2","KD2","K3","KD3","K4","KD4","K5","KD5","K6","KD6","K7","KD7","K8","KD8","KD9","KD10","KD11","KD12","KD13","senum","Sect","ACode","BCode","BHID","OldFile","ScFlag","CateCode","sDate","Flag","SYear","SMonth","SDay","League","hCont","vCont","gName","f_date","t_date","pageSize","ListFlag" )
		
		var target;
		
		if (f_target) {
			target = f_target;
		} else {
			target = window.location.pathname;
		}
		
		if (query) {
			query = "?" + query;
		}
		
		if (f_obj) {
			f_obj.method = 'post'
			f_obj.action = target + query;
			f_obj.submit();
		} else {
			window.location.href = target + query;
		}
	}	


/*
	내    용 : 체크박스들의 체크상태를 일괄 변경
*/
 function fSelectAllCheckBox(frms){
	para = frms.selcheck;
	if(typeof(para)=="object") {
		if(para.length) {
			if (para.length > 1) {
				for (var x=0; x< para.length; x++){
					if (para[x].checked == true) {
						for (var x=0; x < para.length; x++) {
							para[x].checked = false;
						}
					} else {
						for (var x=0; x < para.length; x++){
							para[x].checked = true;
						}
					}
				}
			} else {
				if (para.checked == true){
					para.checked = false;
				} else {
					para.checked = true;
				}
			}
		} else {
			if (para.checked == true){
				para.checked = false;
			} else {
				para.checked = true;
			}		
		}
	} else {
		alert("선택 대상이 없습니다");
		frms.allcheck.checked=false
		return false;
	}
}


function SelectCheck(obj){
	para = obj.selcheck;
	if(typeof(para)=="object") {
		if(para.length) {
			if (para.length > 1) {
				counnt = 0
				for (var x=0; x< para.length; x++){
					if (para[x].checked == true) {
							counnt++ ;
					}
				}
				
				if (counnt == 0 ) {
					return 0;
				} else {
					return 1;
				}
			} else {
				if (para.checked == true){
					return 1;
				} else {
					return 1;
				}
			}
		} else {
			if (para.checked == true){
				return 1;
			} else {
				return 1;
			}		
		}
	} else {
		return 2;
	}
}











