<%@page import="javax.xml.parsers.SAXParser,javax.xml.parsers.SAXParserFactory,org.xml.sax.*,org.xml.sax.helpers.DefaultHandler" %>
<%
//   Anybuilder VX 1.0 Edition Include File
//   Programmed By Mobile Solution Team
//   CopyRight ⓒ 2000-2009  ANYBIL Co.,Ltd.
//------ Parameter Definition ----------------------------------------------------------------------------
//	lcdlx=		: 2~3자리 숫자 (가로 LCD의 pixel 사이즈 - 064는 64로 처리)
//	lcdly=		: 2~3자리 숫자 (세로 LCD의 pixel 사이즈 - 064는 64로 처리)
//	imglx=		: 120|176|240|320|480|640|800 (통신사의 이미지 규격 옵션)
//	carrier=	: skt|ktf|lgt|dacom|kt 
//	browver=	: 2자리의 브라우저 버전 (2세대 브라우저에 대한 정보) 
//			  [SKT] 00 | 03 | 05 | 10 | 15 | 20 | 25 | 30 | 35 | 40 | etc... 	/ NateM
//			  [KTF] 10 | 12 | 20 | 21 | 22 | 30 etc...				/ KUN
//			  [LGT] 10 | 41 | 50 | etc...						/ LION
//			  [KT] 00|...|99							/ KT
//	teleca=		: 1 (skt natem 브라우저 중에서 teleca 브라우저인 경우 1)
//	javascript=	: true|false (javascript 지원 유무)
//      phoneno=	: 폰번호 또는 고유번호(Subno)
//			  - SKT : 폰번호(MDN) 아닌 MIN인 경우도 있음
//				  [10~11 자리 숫자 (- 포함안됨)]
//			  - KTF : 실제 폰번호와 동일
//				  [10~11 자리 숫자 (- 포함안됨)]
//			  - LGT, STI UP 브라우저 : subno로 고유 번호임
//				  [예 : 969432198-11424099]
//			  - LGT AU, K, Lion 브라우저 : 실제 폰번호와 동일
//				  [10~11 자리 숫자 (- 포함안됨)]
//	bkind=          : Device 탑재 브라우저 종류
//			  [au] : AU 브라우저(SKT or LGT)
//			  [natem] : natem 브라우저(SKT)
//			  [telson] : telson 브라우저(SKT)
//			  [nokia] : nokia 브라우저(SKT)
//			  [me] : ME브라우저(KTF)
//			  [kun] : KUN 브라우저(KTF)
//			  [pico] : AnyWeb 브라우저(KTF 구형모델)
//			  [pim] : 삼성단말 브라우저(KTF 구형모델)
//			  [up] : UP 브라우저(LGT, SKT)
//			  [kb] : K Browser(LGT)
//			  [lion] : Lion 브라우저(LGT)
//			  [polaris] : Infraware 브라우저
//	wapaccess=	: Device 탑재 브라우저 종류
//			  0: 실제 폰 접근이 아님
//			  1: 실제 폰 접근
//	gatewayip=	: 현재 접속한 Device가 경유한 이통사 Gateway IP 주소 정보 (PC에서 접속시에는 해당 PC의 IP)
//	lcdcolor=	: 접속한 단말 LCD 컬러(pixel)
//			  [1] : 흑백 LCD
//			  [2] : 4그레이 LCD
//			  [8] : 256 컬러 LCD
//			  [12] : 4,096 컬러 LCD
//			  [16] : 65,000 컬러 LCD
//			  [18] : 260,000 컬러 LCD
//			  [24] : 1,600,000 컬러 LCD
//	network=	: 단말이 현재 접속한 망의 종류
//			  DMDB 지원 EVDO 단말은 접속시 95b나 95c 망으로도 접속함
//			  [95b] : IS-95B 망 접속
//			  [95c] : IS-95C 망 접속
//			  [evdo] : EVDO 망 접속
//			  [wcdma] : WCDMA 또는 HSDPA, HSUPA 망 접속
//			  [wlan] : Wireless LAN 접속
//	model=		: 현재 접속한 Device의 모델 별 코드 값을 리턴
//			  SKT : SSF0 형태
//			  KTF : SPHV3000 형태
//			  LGT : HD09 또는 LGLP3800 등의 형태
//	markuptype=	: 현재 접속한 Browser의 Markup Language 타입
//			  wml | wml2 | mhtml | kun | upwml | xhtml | mw2
//	browser2g=	: 현재 접속 브라우저 2세대 여부 (true|false)
//	imagemap=	: 현재 접속 브라우저 이미지 맵 지원 여부 (true|false)
//	style=		: 현재 접속 브라우저 style 지원 여부 true|false
//	sslSupport= 	: true|false(SSL보안 접속 유무)
//	e2eSupport = 	: true|false(E2E 지원 유무)
//--------------------------------------------------------------------------------------------------------
    //DDR 연동 관련 클래스
    class ScreenSizeReader extends DefaultHandler {
        private static final String elementName = "prf:BrowserScreenSize";
        private boolean _IS_SCREEN_SIZE = false;
        private StringBuffer _ScreenSizeValue = new StringBuffer();
        private String _width = "";
        private String _height = "";
        //@Override
        public void startElement(String uri, String localName, String qName, Attributes atts) {
            if(qName.equals(elementName)) {
                _IS_SCREEN_SIZE = true;
                _ScreenSizeValue.setLength(0);
            }
            else
                _IS_SCREEN_SIZE = false;
        }
        //@Override
        public void endElement(String uri, String localName, String qName) {
            if(qName.equals(elementName)) {
                String values = _ScreenSizeValue.toString();
                String[] value = values.split("x");
                if(value != null && value.length == 2) {
                    _width = value[0];
                    _height = value[1];
                }
                _IS_SCREEN_SIZE = false;
            }
        }
        //@Override
        public void characters(char[] chars, int start, int len) throws SAXException {
            if(_IS_SCREEN_SIZE) _ScreenSizeValue.append(chars, start, len);
        }
        public String getScreenWidth() {
            return _width;
        }
        public String getScreenHeight() {
            return _height;
        }
    }
    String lcdlx = "";
    String lcdly = "";
    String imglx = "";
    String carrier = "";
    String browver = "";
    String teleca = "";
    String weblike = "";
    String javascript = "";
    String phoneno = "";
    String sNum = "";
    String pgt = "";
    String phoneno1 = "";
    String phoneno2 = "";
    String bkind = "";
    String browtype = "";
    String wapaccess = "";
    String gatewayip = "";
    String lcdcolor = "";
    String network = "";
    String model = "";
    String markuptype = "";
    int vpos;
    int p_len;
    String networktype = "";
    String browser2g = null;
    String imagemap = null;
    String style = null;
    String gateway07 = "";
    String sslSupport = "";
    String e2eSupport = "";
    String ab_prof_url = "";

    String ab_agent = request.getHeader("User-Agent") == null ? "" : request.getHeader("User-Agent"); 
    String ab_subno = request.getHeader("x-up-subno") == null ? "" : request.getHeader("x-up-subno"); 
    String ab_device = request.getHeader("HTTP_DEVICE_INFO") == null ? "" : request.getHeader("HTTP_DEVICE_INFO");
    String ad_phoneno = request.getHeader("HTTP_PHONE_NUMBER") == null ? "" : request.getHeader("HTTP_PHONE_NUMBER");
    String ad_screenpixels = request.getHeader("HTTP_X_UP_DEVCAP_SCREENPIXELS") == null ? "" : request.getHeader("HTTP_X_UP_DEVCAP_SCREENPIXELS");
    String ad_remotehostname = request.getRemoteHost() == null ? "" : request.getRemoteHost();
    String ad_screendepth = request.getHeader("X-UP-DEVCAP-SCREENDEPTH") == null ? "" : request.getHeader("X-UP-DEVCAP-SCREENDEPTH");
    String ad_channelinfo = request.getHeader("HTTP_CHANNEL_INFO") == null ? "" : request.getHeader("HTTP_CHANNEL_INFO");
    
    String ab_agent01 = ab_agent.substring(0,1);
    String ab_agent02 = ab_agent.substring(0,2);
    String ab_agent03 = ab_agent.substring(0,3); 
    carrier = "";
    browver = "";
    weblike = "false";
    javascript = "false";
    browser2g = "false";
    imagemap = "false";
    style = "false";
    sslSupport = "false";
    e2eSupport = "false";
    gatewayip = ad_remotehostname;
    String ab_prof = "";

    if (ab_agent03.equals("WEB") || ab_agent03.equals("SKT") || ab_agent03.equals("STI") || ab_agent03.equals("010") || ab_agent03.equals("KTF") || ab_agent03.equals("HSP") || ((ab_agent01.equals("I") || ab_agent01.equals("1") || ab_agent03.equals("LGT")) && ab_subno.indexOf("ezweb") == -1)) {
        // SKT natem
        carrier = "skt";
        lcdlx = ab_agent.substring(13,13+3);
        lcdly = ab_agent.substring(16,16+3);
        imglx = "120";
	if (Integer.parseInt(lcdlx) >= 320) {
            imglx = "320";
	}else if (Integer.parseInt(lcdlx) >= 240) {
            imglx = "240";
	}else if (Integer.parseInt(lcdlx) >= 176) {
            imglx = "176";
        }
	browver = ab_agent.substring(9,9+2);
	if (Integer.parseInt(browver) == 10 || Integer.parseInt(browver) == 20 || Integer.parseInt(browver) == 30) {
            teleca = "1";
        }
	if (Integer.parseInt(browver) >= 40) {
            weblike = "true";
            javascript = "true";
        }
        markuptype = "wml";
        if (browver.equals("00")) {
            bkind = "au";
        } else if (browver.equals("01")) {
            bkind = "eric";
        } else if (browver.equals("02")) {
            bkind = "nokia";
        } else if (browver.equals("03")) {
            bkind = "telson";
        } else {
            bkind = "natem";
            markuptype = "wml2";
            browser2g = "true";
            imagemap = "true";
            style = "true";
            e2eSupport = "true";
        }
        lcdcolor = ab_agent.substring(23,23+2);
        if (lcdcolor.equals("91") || lcdcolor.equals("94")) {
            lcdcolor = "1";
        } else if (lcdcolor.equals("04")) {
            lcdcolor = "2";
        } else {
            if (lcdcolor.substring(0,1).equals("0")) {
                lcdcolor = lcdcolor.substring(1,1+1);
            }
        }
        model = ab_agent.substring(5,5+4);
        networktype = ab_agent.substring(3,3+1);
        network = "95c";
        if (networktype.equals("1")) {
            network = "95b";
        }else if (networktype.equals("5")) {
            network = "evdo";
        }else if (networktype.equals("6") || networktype.equals("7") || networktype.equals("8") || networktype.equals("0")) {
            network = "wcdma";
        }
        //SCH-W600(SSN3), SCH-W740(SSN7) 단말에 대해 서비스 대응 예외처리 사항 2008-11-28
        if (model.equals("SSN3") ||model.equals("SSN7")) {
            lcdlx = "240";
            lcdly = "400";
            imglx = "240";
        }
	if (Integer.parseInt(browver) >= 30) {
            sslSupport = "true";
        }
        String model01 = model.substring(0,0+2);
        String model02 = model.substring(2,2+2);        
        if (e2eSupport.equals("false")) {
            if (model01.equals("SK")) {
                if (model02.equals("11") || Integer.parseInt(model02) >= 17) {
                    sslSupport = "true";
                }
            } else if (model01.equals("SS")) {
                if (model02.equals("36") || model02.equals("37") || model02.equals("38")) {
                    sslSupport = "true";
                } else if (model02.equals("41") || model02.equals("46") || model02.equals("48") || model02.equals("49")) {
                    sslSupport = "true";
                } else if (model02.equals("50") || model02.equals("51") || model02.equals("52") || model02.equals("53") || model02.equals("54") || Integer.parseInt(model02) >= 56) {
                    sslSupport = "true";
                }
            } else if (model01.equals("LG")) {
                if (model02.equals("22") || model02.equals("23") || Integer.parseInt(model02) >= 29) {
                    sslSupport = "true";
                }
            } else if (model01.equals("HD")) {
                if (model02.equals("06") || model02.equals("08") || model02.equals("09") || model02.equals("13")) {
                    sslSupport = "true";
                }
            } else if (model01.equals("PC")) {
                if (model02.equals("32")) {
                    sslSupport = "true";
                }
            } else if (model01.equals("MT")) {
                if (model02.equals("07")) {
                    sslSupport = "true";
                }
            }
        }
        if (ab_agent.substring(4,4+1).equals("2") || ab_agent.substring(4,4+1).equals("3")) {
            weblike = "true";
            javascript = "true";
            markuptype = "mw2";
            browser2g = "true";
            imagemap = "true";
            style = "true";
            sslSupport = "true";
            e2eSupport = "true";
        }
    } else if (ab_agent.indexOf("CellPhone") > -1) {
        // KTF
        carrier = "ktf";
        markuptype = "mhtml";
        if (ab_agent.indexOf("KUN") > -1 || ab_agent.indexOf("MSMB13") > -1 || ab_agent.indexOf("MSMB14") > -1) {
            // KUN/MSMB13이상
            int abxpos = ab_device.indexOf("LX:");
            int abypos = ab_device.indexOf("LY:");
            if (abxpos > -1){
                lcdlx = ab_device.substring(abxpos+3,abxpos+6);
	    }
            if (abypos > -1){
                lcdly = ab_device.substring(abypos+3,abypos+6);
	    }
            imglx = "120";
            if (Integer.parseInt(lcdlx) >= 320) {
                imglx = "320";
            }else if (Integer.parseInt(lcdlx) >= 240) {
                imglx = "240";
            }else if (Integer.parseInt(lcdlx) >= 176) {
                imglx = "176";
            }
            lcdcolor = "2";
            if (ab_device.indexOf("CL:24") > -1) {
                lcdcolor = "24";
            } else if (ab_device.indexOf("CL:18") > -1) {
                lcdcolor = "18";
            } else if (ab_device.indexOf("CL:16") > -1) {
                lcdcolor = "16";
            } else if (ab_device.indexOf("CL:12") > -1) {
                lcdcolor = "12";
            } else if (ab_device.indexOf("CL:8") > -1) {
                lcdcolor = "8";
            }            
            if (ab_agent.indexOf("KUN") > -1) {
                if (ab_agent.indexOf("KUN/1.0") > -1) {
                    browver = "10";
                } else if (ab_agent.indexOf("KUN/1.2") > -1) {
                    browver = "12";
                } else if (ab_agent.indexOf("KUN/2.0") > -1) {
                    browver = "20";
                    imagemap = "true";
                } else if (ab_agent.indexOf("KUN/2.1") > -1) {
                    browver = "21";
                    imagemap = "true";
                } else if (ab_agent.indexOf("KUN/2.2") > -1) {
                    browver = "22";
                    imagemap = "true";
                } else if (ab_agent.indexOf("KUN/3") > -1) {
                    browver = "30";
                    imagemap = "true";
                } else {
                    browver = "10";
                }
                if (Integer.parseInt(browver) >= 30) {
                    weblike = "true";
                    javascript = "true";
                }
                bkind = "kun";
                markuptype = "kun";
                browser2g = "true";
                style = "true";
                sslSupport = "true";
            } else {
                if (ab_agent.indexOf("MSMB13") > -1) {
                    browver = "13";
                    sslSupport = "true";
                } else if (ab_agent.indexOf("MSMB14") > -1) {
                    browver = "14";
                    sslSupport = "true";
                }
                bkind = "me";
            }
            network = "95c";
            if (ab_agent.indexOf("KUN") > -1 || ab_agent.indexOf("MSMB142") > -1) {
                networktype = ad_channelinfo;
                if (networktype.equals("B")) {
                    network = "95b";
                } else if (networktype.equals("E")) {
                    network = "evdo";
                } else if (networktype.equals("W") || networktype.equals("H")) {
                    network = "wcdma";
                }
            }
        } else {
            lcdlx = "120";
            lcdly = "64";
            browver = "";
            lcdcolor = "1";
            network = "95b";
            if (ab_agent.indexOf("MSMB12C") > -1) {
                lcdly = "96";
                browver = "12";
                lcdcolor = "8";
            } else if (ab_agent.indexOf("MSMB12") > -1) {
                lcdly = "80";
                browver = "12";
                lcdcolor = "2";
            }
            imglx = "120";
            if (ab_agent.indexOf("MSMB") > -1) {
                if (ab_agent.indexOf("MSMB11") > -1) {
                    browver = "11";
                } else if (ab_agent.indexOf("MSMB10") > -1) {
                    browver = "10";
                }
                bkind = "me";
            } else if (ab_agent.indexOf("PICO") > -1) {
                bkind = "pico";
                browver = "10";
            } else if (ab_agent.indexOf("PIM1") > -1) {
                bkind = "pim";
                browver = "10";
            } else if (ab_agent.indexOf("PIM2") > -1) {
                bkind = "pim";
                browver = "20";
            }
        }
        String[] modelarr = ab_agent.split(";");
        model = modelarr[2];
    } else if (ab_subno.indexOf("ezweb") > -1 || ab_subno.indexOf("itouch") > -1) {
        carrier = "lgt";
        markuptype = "upwml";
        int abmpos = 0;
        String e2eStr = "";
        if (ab_subno.indexOf("itouch") > -1) {
            carrier = "sti";
        }
        if (ab_agent02.equals("15") || ab_agent02.equals("12")) {
            if (ab_agent02.equals("15")) {
                lcdlx = ab_agent.substring(16,16+3);
                lcdly = ab_agent.substring(19,19+3);
                //LGT OZ 단말 ez-i 브라우저 처리 -  2008-04-04
                if (Integer.parseInt(lcdlx) >= 480 || Integer.parseInt(lcdly) >= 800) {
                    lcdlx="240";
                    lcdly="400";
                }
                browver = ab_agent.substring(13,13+2);
                bkind = "lion";
                lcdcolor = ab_agent.substring(30,30+2);
                network = "95c";
                markuptype = "xhtml";
                model = ab_agent.substring(3,3+8);
                browser2g = "true";
                imagemap = "true";
                style = "true";
                e2eSupport = "true";
            } else {
                lcdlx = ab_agent.substring(12,12+3);
                lcdly = ab_agent.substring(15,15+3);
                browver = ab_agent.substring(9,9+2);
                browtype = ab_agent.substring(7,7+2);
                if (browtype.equals("00")) {
                    bkind = "au";
                } else if (browtype.equals("01")) {
                    bkind = "up";
                } else if (browtype.equals("02")) {
                    bkind = "eric";
                } else if (browtype.equals("03")) {
                    bkind = "nokia";
                } else if (browtype.equals("04")) {
                    bkind = "lg";
                } else if (browtype.equals("05")) {
                    bkind = "telson";
                } else if (browtype.equals("07")) {
                    bkind = "kb";
                    e2eSupport = "true";
                } else {
                    bkind = "lion";
                    browser2g = "true";
                    imagemap = "true";
                    style = "true";
                    e2eSupport = "true";
                }
                lcdcolor = ab_agent.substring(26,26+2);
                network = "95b";
                if (ab_agent03.equals("122")) {
                    network = "95c";
                }
                model = ab_agent.substring(3,3+4);                
            }
            imglx = "120";
            if (Integer.parseInt(lcdlx) >= 320) {
                imglx = "320";
            }else if (Integer.parseInt(lcdlx) >= 240) {
                imglx = "240";
            }else if (Integer.parseInt(lcdlx) >= 176) {
                imglx = "176";
            }
            if (Integer.parseInt(browver) >= 50) {
                weblike = "true";
                javascript = "true";
            }
            if (lcdcolor.substring(0,1).equals("0")) {
                lcdcolor = lcdcolor.substring(1,1+1);
            }
            if (ab_agent.substring(2,2+1).equals("3") || ab_agent.substring(2,2+1).equals("4")) {
                weblike = "true";
                javascript = "true";
                markuptype = "mw2";
                browser2g = "true";
                imagemap = "true";
                style = "true";
                sslSupport = "true";
                e2eSupport = "true";
            }
        } else {
            vpos = ad_screenpixels.indexOf(",");
            lcdlx = "96";
            lcdly = "48";
            if (vpos > -1) {
                lcdlx = ad_screenpixels.substring(0,vpos);
                lcdly = ad_screenpixels.substring(vpos+1);
            }
            browver = "";
            imglx = "120";
            bkind = "up";
            lcdcolor = ad_screendepth;
            network = "95b";
            if (ab_agent.indexOf("UP.Browser/4") > -1) {
                abmpos = ab_agent.indexOf(" ");
                model = ab_agent.substring(0,abmpos-1);
            } else {
                abmpos = ab_agent.indexOf("-");
                model = ab_agent.substring(abmpos+1,abmpos+1+4);
            }            
        }
        if (e2eSupport.equals("false")) {
            abmpos = ab_agent.indexOf("V");
            e2eStr = ab_agent.substring(abmpos+2,abmpos+2+1);
            if (e2eStr.equals("1") || e2eStr.equals("3") || e2eStr.equals("5") || e2eStr.equals("7") || e2eStr.equals("9") || e2eStr.equals("B") || e2eStr.equals("D") || e2eStr.equals("F")) {
                e2eSupport = "true";
            }
        }
    } else if (ab_agent.indexOf("UP.Browser") > -1 || ab_agent.indexOf("OPWV") > -1) {
        // 1세대 브라우저
        lcdlx = "120";
        lcdly = "96";
	imglx = "120";
	markuptype = "upwml";
    } else {
        if (ab_agent03.equals("K_T")) { 
            //KT_SoIP폰
            carrier = "kt";
            wapaccess = "0";
            network = "wlan";
            model = ab_agent.substring(5,5+4);
            bkind = "polaris";
            browver = ab_agent.substring(11,11+2);
            lcdlx = ab_agent.substring(13,13+3);
            lcdly = ab_agent.substring(16,16+3);
            lcdcolor = ab_agent.substring(23,23+2);
            phoneno = ab_agent.substring(41,41+11);
            phoneno1 = phoneno.substring(3,3+1);
            if (phoneno1.equals("0")) { 
                phoneno1 = phoneno.substring(0,3);
                phoneno2 = phoneno.substring(4,4+7);
                phoneno = phoneno1 + phoneno2;
            }
        } else {
            //Other Internet Browser
            //풀브라우징 대응
            ab_prof = "false";
            gateway07 = gatewayip.substring(0,7);
            if (gateway07.equals("211.115")) {
                lcdlx = "800";
                lcdly = "480";
                ab_prof = "true";
            } else { 
                lcdlx = "240";
                lcdly = "320";
            }
            if (ab_agent.indexOf("iPhone") > -1 || ab_agent.indexOf("iPod") > -1) {
                lcdlx = "320";
                lcdly = "480";
                ab_prof = "true";
            }
            if (ab_agent.indexOf("SAMSUNG-SGH-i600V") > -1) {
                lcdlx = "320";
                lcdly = "240";
                ab_prof = "true";
            }
            String ad_screensize = "";
            ad_screensize = request.getHeader("HTTP_SCREENSIZE") == null ? "" : request.getHeader("HTTP_SCREENSIZE");
            if (ad_screensize.indexOf("x") > -1) {
                vpos = ad_screensize.indexOf("x");
                if (vpos > -1) {
                    lcdlx = ad_screensize.substring(0,vpos);
                    lcdly = ad_screensize.substring(vpos+1);
                    ab_prof = "true";
                }
            }
            String ad_uapixels = "";
            ad_uapixels = request.getHeader("HTTP_UA_PIXELS") == null ? "" : request.getHeader("HTTP_UA_PIXELS");
            if (ad_uapixels.indexOf("x") > -1) {
                vpos = ad_uapixels.indexOf("x");
                if (vpos > -1) {
                    lcdlx = ad_uapixels.substring(0,vpos);
                    lcdly = ad_uapixels.substring(vpos+1);
                    ab_prof = "true";
                }
            }
            String ad_xprofile = "";
            if (ab_agent.indexOf("Opera/9.5") > -1 || ab_agent.indexOf("Opera 9.5") > -1) {
                ad_xprofile = request.getHeader("HTTP_X_WAP_PROFILE") == null ? "" : request.getHeader("HTTP_X_WAP_PROFILE");
                if (ad_xprofile.indexOf("SGH-i900.xml") > -1) {
                    lcdlx = "240";
                    lcdly = "400";
                    ab_prof = "true";
                }
            }
            String ad_xprefs = "";
            ad_xprefs = request.getHeader("HTTP_X_OS_PREFS") == null ? "" : request.getHeader("HTTP_X_OS_PREFS");
            if (ad_xprefs.indexOf("fw:") > -1 && ad_xprefs.indexOf("fh:") > -1) {
                String[] ad_xprefsarr = ad_xprefs.split(";");
                for (int k=0; k < ad_xprefsarr.length-1; k++) {
                    if (ad_xprefsarr[k].indexOf("fw:") >= 0) {
                        lcdlx = ad_xprefsarr[k].substring(3);
                    }
                    if (ad_xprefsarr[k].indexOf("fh:") >= 0) {
                        lcdly = ad_xprefsarr[k].substring(3);
                    }
                }
                ab_prof = "true";
            } 
            if (ab_agent.indexOf("LGDacom") > -1) {
                carrier = "dacom";
            }
            //DDR 연동
            if (ab_prof.equals("false")) {
                String ab_screenSize = "";
                ab_prof_url = request.getHeader("PROFILE") == null ? "" : request.getHeader("PROFILE");
                if (ab_prof_url.equals("")) {
                    ab_prof_url = "http://ddr.mobileok.kr/profile/DeviceProfile.do?ua=" + URLEncoder.encode(ab_agent);
                }
                URL ddrRequestURL = new URL(ab_prof_url);
                URLConnection connection = ddrRequestURL.openConnection();
                // JAVA 1.5 이상 사용 가능, 이하에서는 org.apache.commons.httpclient 사용 활용
                //connection.setConnectTimeout(3 * 1000); // 3 Secs 
                try {
                    connection.connect();
                    connection.getInputStream();
                    SAXParserFactory factory = SAXParserFactory.newInstance();
                    SAXParser saxParser = factory.newSAXParser();
                    ScreenSizeReader reader = new ScreenSizeReader();
                    saxParser.parse(connection.getInputStream(), reader);
                    lcdlx = reader.getScreenWidth();
                    lcdly = reader.getScreenHeight();
                } catch(Exception e) {
                    lcdlx = "240";
                    lcdly = "320";
                } finally {
                }
            }            
        }
        imglx = lcdlx;
        weblike = "true";
        javascript = "true";
        markuptype = "mw2";
        browser2g = "true";
        imagemap = "true";
        style = "true";
        sslSupport = "true";
        e2eSupport = "false";
    }
    if (ab_agent.indexOf("UP.Browser/3") > -1) {
        browver = "30";
        bkind = "up";
        markuptype = "upwml";
    } else if (ab_agent.indexOf("UP.Browser/4") > -1) {
        browver = "40";
        bkind = "up";
        markuptype = "upwml";
    } else if (ab_agent.indexOf("UP.Browser/5") > -1) {
        browver = "50";
        bkind = "up";
        markuptype = "upwml";
    } else if (ab_agent.indexOf("UP.Browser/6") > -1) {
        browver = "60";
        bkind = "up";
        markuptype = "xhtml";
        browser2g = "true";
        imagemap = "true";
        style = "true";
    } else if (ab_agent.indexOf("UP.Browser/7") > -1) {
        browver = "70";
        bkind = "up";
        markuptype = "xhtml";
        browser2g = "true";
        imagemap = "true";
        style = "true";
    }
    if (ab_agent.indexOf("j-phone") > -1) {
        markuptype = "chtml";
    }
    wapaccess = "0";
    if (carrier.equals("skt")) {
        // SKT Phone Number
        if(ab_agent03.equals("SKT") || ab_agent03.equals("111")) {
            phoneno = "011";
        } else if(ab_agent03.equals("STI") || ab_agent03.equals("117")) {
            phoneno = "017";
        } else if(ab_agent03.equals("010") || ab_agent03.equals("110")) {
            phoneno = "010";
        } else if(ab_agent03.equals("LGT") || ab_agent03.equals("119")) {
            phoneno = "019";
        } else if(ab_agent03.equals("KTF") || ab_agent03.equals("116")) {
            phoneno = "016";
        } else if(ab_agent03.equals("HSP") || ab_agent03.equals("118")) {
            phoneno = "018";
        }
        if(ab_agent01.equals("I")) {
            phoneno = "";
        } else {
            sNum = ab_agent.substring(25,33);
            if(sNum.substring(0,1).equals("0")) {
                phoneno = phoneno + sNum.substring(1,8);
            } else {
                phoneno = phoneno + sNum;
            }
        }
        wapaccess = "1";
    } else if (carrier.equals("ktf")) {
        // KTF Phone Number
        if (!ad_phoneno.equals("")){
            if (ad_phoneno.substring(0,3).equals("820")){
                phoneno = ad_phoneno.substring(2);
            }else{
                phoneno = "0" + ad_phoneno.substring(2);
            }
            wapaccess = "1";
        }
        if (phoneno.indexOf("HTTP") > -1) {
            phoneno = "";
            wapaccess = "0";
        }        
    } else if (carrier.equals("lgt") || carrier.equals("sti")) {
        // LGT 전화번호
        if (ab_agent01.equals("1")) {
            if (ab_agent02.equals("15")) {
                phoneno = ab_agent.substring(32,32+11);
            } else if (ab_agent02.equals("12")) {
                phoneno = ab_agent.substring(28,28+11);
            }        
            if (phoneno.substring(3,4).equals("0")) {
                phoneno1 = phoneno.substring(0,3);
                phoneno2 = phoneno.substring(4);
                phoneno = phoneno1 + phoneno2;
            }else{
                phoneno = phoneno.substring(0);
            }
        }else{
            vpos = ab_subno.indexOf("_");
            phoneno = ab_subno.substring(0,vpos);
        }
        wapaccess = "1";
    }
%>
