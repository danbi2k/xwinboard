
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}


function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}


function activeX (file,width,height) {
document.write ("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='"+width+"' height='"+height+"'><param name='movie' value='"+file+"'><param name='quality' value='high'><embed src='images/main_flash.swf' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"+width+"' height='"+height+"'></embed></object>");
}

function activeX2 (file,width,height) {
document.write ("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='"+width+"' height='"+height+"'><param name='movie' value='"+file+"'><param name='quality' value='high'><param name='wmode' value='transparent'><embed src='images/main_flash.swf' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"+width+"' height='"+height+"'></embed></object>");
}
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

/*
var hideBuf;
function hideBeforePrint() {
    hideBuf = document.body.innerHTML;
              document.body.innerHTML = '';
}
function showAfterPrint() {
    document.body.innerHTML = hideBuf;
    }
        window.onbeforeprint = hideBeforePrint;
        window.onafterprint = showAfterPrint;
*/
function CheckUIElements() {
  var yMenu1From, yMenu1To, yOffset, timeoutNextCheck;
  var wndWidth = parseInt(document.body.clientWidth);
  yMenu1From   = parseInt (qLayer.style.top, 10);
  yMenu1To     = document.body.scrollTop + 0;
  timeoutNextCheck = 500;

  if ( yMenu1From != yMenu1To ) {
    yOffset = Math.ceil( Math.abs( yMenu1To - yMenu1From ) / 20 );
    if ( yMenu1To < yMenu1From )
      yOffset = -yOffset;

    qLayer.style.top = parseInt (qLayer.style.top, 10) + yOffset;

    timeoutNextCheck = 10;
  }
  qLayer.style.left = 740;
  setTimeout ("CheckUIElements()", timeoutNextCheck);
}

function MovePosition() {
  var wndWidth = parseInt(document.body.clientWidth);

  qLayer.style.top = 10;
  qLayer.style.left = 930;
  qLayer.style.visibility = "visible";

  CheckUIElements();
  return true;
}

var imgseq = 0;
function blursStart0() {
	blurs0();
}

function blurs0() {
	var max = 5;				//Images
	var imgs = new Array;
	var urls = new Array;
	var interval0 = 5000;		//Speed

	imgs[0] = '/images/main_f_img_01.jpg' ;
	imgs[1] = '/images/main_f_img_02.jpg' ;
	imgs[2] = '/images/main_f_img_03.jpg' ;
	imgs[3] = '/images/main_f_img_04.jpg' ;
	imgs[4] = '/images/main_f_img_01.jpg' ;

	urls[0] = '#';
	urls[1] = '#';
	urls[2] = '#';
	urls[3] = '#';
	urls[4] = '#';

		var ci0 = eval('document.all.num_img0'+imgseq);
		document.all.Roll0Img.filters.blendTrans.apply();
		document.all.Roll0Url.href=urls[imgseq];
		document.all.Roll0Img.src=imgs[imgseq];
		document.all.Roll0Img.filters.blendTrans.play();
	if (imgseq == --max)
	{
		imgseq=0;
	}
	imgseq++;
	


	setTimeId0=setTimeout("blursStart0()",interval0);
}

