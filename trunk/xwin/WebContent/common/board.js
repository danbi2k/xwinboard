//에러금지
function blockError(){ window.status = "▶스크립트 오류가 있습니다◀ 정상적인 작동이 안될시에는 F5를 눌러 페이지 새로고침을 하시기 바랍니다."; return true; }
//window.onerror = blockError;

function img_resize(obj,frame_w,frame_h){

	obj.style.display='';

	var w,h,x,y;
	img_w = obj.width;
	img_h = obj.height;
	
	//비율
	if(frame_w>=frame_h){	
		w = frame_w;
		h = frame_w * img_h / img_w;		
	}else{
		w = frame_h;
		h = frame_h * img_w / img_h;
	}


	//비율 교정시 상대적으로 작아졌을경우
	if(w<frame_w){ 
		w = frame_w;
		h = frame_w * img_h / img_w;			
	}
	if(h<frame_h){  
		h = frame_h;
		w = frame_h * img_w / img_h;	
	}

	h = Math.round(h);
	w = Math.round(w);

	//위치
	x = (w - frame_w)/2 
	y = (h - frame_h)/2

	x = Math.round(x);
	y = Math.round(y);

	obj.width = w;
	obj.height = h;
	obj.style.marginLeft = x * -1 ;
	obj.style.marginTop = y * -1 ;
	
}