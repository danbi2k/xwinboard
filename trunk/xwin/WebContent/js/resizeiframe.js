var minHeight=600;
function resizeFrame(iframeObj)
{
	if (iframeObj.tagName!="IFRAME")
	{
		iframeObj=document.getElementById(iframeObj);		
	}
	var innerBody; 
	var innerHeight; 
	var innerWidth;
	try
	{
		innerBody = iframeObj.contentWindow.document.body;
		innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
		innerWidth = innerBody.scrollWidth + (innerBody.offsetWidth - innerBody.clientWidth);			
	}
	catch (e)
	{
		innerHeight = 1253;		
	}
	if(innerHeight<minHeight)innerHeight=minHeight;

	if (innerHeight==0)
	{
		setTimeout("resizeFrame('"+iframeObj.id+"')",100);
		return;
	}	
	
	iframeObj.style.height = innerHeight;
	//iframeObj.style.width = innerWidth;	
}
