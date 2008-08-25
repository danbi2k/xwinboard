// 2006년 2월 15일 Windows Updater관련 플레쉬 object 생성을 위한 펑션
function printFlashObject(flash_src,name,width,height,option_param_tag)
{
	obj_html = getFlashObject(flash_src,name,width,height,option_param_tag);
	document.write(obj_html);
}
function getFlashObject(flash_src,name,width,height,flashvars)
{
	obj_html = "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0' width='"+width+"' height='"+height+"' name='"+name+"' align='middle'>";
	obj_html = obj_html + "<param name='allowScriptAccess' value='always' />";
	obj_html = obj_html + "<param name='allowfullscreen' value='true' />";
	obj_html = obj_html + "<param name='movie' value='"+flash_src+"' />";
	obj_html = obj_html + "<param name='quality' value='high' />";
	obj_html = obj_html + "<param name='wmode' value='transparent' />";
	obj_html = obj_html + "<param name='menu' value='false'>";
	obj_html = obj_html + "<param name='FlashVars' value='" + flashvars + "' />";
	obj_html = obj_html + "<embed allowfullscreen='true' wmode='transparent' src='"+flash_src+"' flashvars='" + flashvars + "' quality='high' bgcolor='#ffffff' width='"+width+"' height='"+height+"' name='"+name+"' align='middle' allowscriptaccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />";
	obj_html = obj_html + "</object>";
	return obj_html;
}
/*
obj_html = '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="'+width+'" height="'+height+'" id="'+name+'" align="middle">';
obj_html += '<embed src="'+flash_src+'" quality="high" bgcolor="#ffffff" width="'+width+'" height="'+height+'" name="'+name+'" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
obj_html += '<param name="allowScriptAccess" value="sameDomain" />';
obj_html += '<param name="movie" value="'+flash_src+'" />';
obj_html += '<param name="quality" value="high" />';
obj_html += '<param name="bgcolor" value="#ffffff" />';
obj_html += '</object>';
*/
