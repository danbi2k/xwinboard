 function GET(arrayKey, arrayValue, Value) {
        count = arrayKey.length;
        for(i=0;i<count;i++) {
            if(arrayKey[i]==Value) {
                return arrayValue[i];
                break;
            }
        }
    }

    function mEmbed() {
        var key = new Array();
        var value = new Array();
        error_check=0;
        for(i=0;i<mEmbed.arguments.length;i++) {
            data = mEmbed.arguments[i].split('=');
            key[i] = data[0];
            value[i] = data[1];
        }

        contents = '';
        srcdata = GET(key,value,'src');
        if(/\.(...)$/.test(srcdata)) {
            flashon = 1;
        }

        classid = GET(key,value,'classid');
        codebase = GET(key,value,'codebase');
        if(flashon==1) {
            classid = 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000';
            codebase = 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.c-ab#version=6,0,29,0';
        }
        if(classid && codebase) {
            contents += '<object';
            if(classid) {
                contents += ' classid="' + classid + '"';
            }
            if(codebase) {
                contents += ' codebase="' + codebase + '"';
            }
            count = key.length;
            for(i=0;i<count;i++) {
                if(value[i]!='') {
                    if(key[i]!='src') {
                        contents += ' ' + key[i] + '="' + value[i] + '"';
                    }
                }
            }
            contents += '>';
            for(i=0;i<count;i++) {
                if(value[i]!='') {
                    if(flashon==1 && key[i]=='src') {
                        contents += '<param name="movie" value="' + value[i] + '" />';
                    } else {
                        contents += '<param name="' + key[i] + '" value="' + value[i] + '" />';
                    }
                }
            }
        }
        contents += '<embed';
        for(i=0;i<count;i++) {
            if(value[i]!='') {
                contents += ' ' + key[i] + '="' + value[i] + '"';
            }
        }
        contents += '>';
        contents += '</embed>';
        if(classid && codebase) {
            contents += '</object>';
        }
        document.write(contents);
    }