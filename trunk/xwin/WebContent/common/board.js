//��������
function blockError(){ window.status = "����ũ��Ʈ ������ �ֽ��ϴ٢� �������� �۵��� �ȵɽÿ��� F5�� ���� ������ ���ΰ�ħ�� �Ͻñ� �ٶ��ϴ�."; return true; }
//window.onerror = blockError;

function img_resize(obj,frame_w,frame_h){

	obj.style.display='';

	var w,h,x,y;
	img_w = obj.width;
	img_h = obj.height;
	
	//����
	if(frame_w>=frame_h){	
		w = frame_w;
		h = frame_w * img_h / img_w;		
	}else{
		w = frame_h;
		h = frame_h * img_w / img_h;
	}


	//���� ������ ��������� �۾��������
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

	//��ġ
	x = (w - frame_w)/2 
	y = (h - frame_h)/2

	x = Math.round(x);
	y = Math.round(y);

	obj.width = w;
	obj.height = h;
	obj.style.marginLeft = x * -1 ;
	obj.style.marginTop = y * -1 ;
	
}