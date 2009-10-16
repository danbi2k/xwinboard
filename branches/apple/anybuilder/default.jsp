<%@ page import="java.io.*,java.util.*,java.net.*" %>
<%
    // Phone Header Infomation
    // Programmed By Mobile Solution Team
    // CopyRight ⓒ 2000 - 2009 ANYBIL
    // Date : 2005.02
    // 웹서버 : Tomcat / Regin
    // 순서를 바꾸면 정상적으로 작동되지 않을 수도 있습니다.
    String agent = request.getHeader("user-agent");
    String subno = request.getHeader("x-up-subno");
    String accept = request.getHeader("accept");
    String httpsid = request.getHeader("sid");
        String token = request.getParameter("token");

    String redirect="";

    if(subno != null && subno.indexOf("ezweb") >= 0 && agent.indexOf("UP.Browser/4.1") >= 0){
        //ez-i(UP4.1)
        redirect = "http://localhost:8080/apple/upwml/index.jsp?token=" + URLEncoder.encode(token);
    } else if((subno != null && subno.indexOf("ezweb") >= 0)  && agent.substring(0,3).equals("111")){
        //ez-i(AUR)
        redirect = "http://localhost:8080/apple/wml/index.jsp?token=" + URLEncoder.encode(token);
    } else if((agent.substring(0,3).equals("111") || agent.substring(0,3).equals("117") || agent.substring(0,3).equals("116") || agent.substring(0,3).equals("118") || agent.substring(0,3).equals("119") || agent.substring(0,3).equals("010") || agent.substring(0,3).equals("SKT") || agent.substring(0,3).equals("STI") || agent.substring(0,3).equals("KTF") || agent.substring(0,3).equals("HSP") || agent.substring(0,3).equals("LGT") || agent.substring(0,1).equals("I")) && (Integer.parseInt(agent.substring(9,11)) >= 10)){
        //NATE(nateⓜ)
        redirect = "http://localhost:8080/apple/wml2/index.jsp?token=" + URLEncoder.encode(token);
        if(agent.substring(4,4+1).equals("2") || agent.substring(4,4+1).equals("3")) {
            //PDA, Smartphone
            redirect = "http://localhost:8080/apple/mw2/index.jsp?token=" + URLEncoder.encode(token);
            }
    } else if(agent.substring(0,3).equals("111") || agent.substring(0,3).equals("117") || agent.substring(0,3).equals("116") || agent.substring(0,3).equals("118") || agent.substring(0,3).equals("119") || agent.substring(0,3).equals("010") || agent.substring(0,3).equals("SKT") || agent.substring(0,3).equals("STI") || agent.substring(0,3).equals("KTF") || agent.substring(0,3).equals("HSP") || agent.substring(0,3).equals("LGT") || agent.substring(0,1).equals("I")){
        //NATE(AUR)
        redirect = "http://localhost:8080/apple/wml/index.jsp?token=" + URLEncoder.encode(token);
        if(agent.substring(4,4+1).equals("2") || agent.substring(4,4+1).equals("3")) {
            //PDA, Smartphone
            redirect = "http://localhost:8080/apple/mw2/index.jsp?token=" + URLEncoder.encode(token);
            }
    } else if(subno != null && subno.indexOf("EB") >= 0){
        if(agent.substring(15,15+1).equals("1")){
            //ez-i(Embidder) Text
            redirect = "http://localhost:8080/apple/wml/index.jsp?token=" + URLEncoder.encode(token);
        } else {
            //ez-i(Embidder)
            redirect = "http://localhost:8080/apple/xhtml/index.jsp?token=" + URLEncoder.encode(token);
        }
        if(agent.substring(2,2+1).equals("3") || agent.substring(2,2+1).equals("4")) {
            //PDA, Smartphone
            redirect = "http://localhost:8080/apple/mw2/index.jsp?token=" + URLEncoder.encode(token);
            }
    } else if(subno != null && subno.indexOf("KB") >= 0){
        //ez-i(KB)
        redirect = "http://localhost:8080/apple/upwml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(agent != null && agent.indexOf("DoCoMo") >= 0 ){
        //i-mode
        redirect = "http://localhost:8080/apple/chtml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(agent != null && agent.indexOf("J-PHONE") >= 0 ){
        //J-Phone
            redirect = "http://localhost:8080/apple/chtml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(subno != null && subno.indexOf("itouch") >= 0 && agent.indexOf("UP.Browser/4.1") >= 0){
        //iTouch(UP4.1)
        redirect = "http://localhost:8080/apple/upwml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(subno != null && subno.indexOf("itouch") >= 0){
        //iTouch(UP3.1)
        redirect = "http://localhost:8080/apple/upwml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(subno != null && subno.indexOf("ezweb") >= 0){
        //ez-i(UP3.1)
        redirect = "http://localhost:8080/apple/upwml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(agent != null && agent.indexOf("KUN") >= 0){
        //magicⓝ(KUN)
        redirect = "http://localhost:8080/apple/kun/index.jsp?token=" + URLEncoder.encode(token);
    } else if(agent != null && agent.indexOf("CellPhone") >= 0){
        //magicⓝ(ME)
        redirect = "http://localhost:8080/apple/mhtml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(agent != null && agent.indexOf("MMEF300") >= 0){
        //MME30 시뮬레이터인 경우
        redirect = "http://localhost:8080/apple/mhtml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(agent.indexOf("UP.Browser") >= 0){
        if(agent.indexOf("UP.Browser/3") >= 0){
            //UP브라우저3.1/3.2인 경우
            redirect = "http://localhost:8080/apple/upwml/index.jsp?token=" + URLEncoder.encode(token);
        } else if(agent.indexOf("UP.Browser/6") >= 0 || agent.indexOf("UP.Browser/7") >= 0){
            //UP브라우저 6.x인 경우
            redirect = "http://localhost:8080/apple/xhtml/index.jsp?token=" + URLEncoder.encode(token);
        } else {
            //UP브라우저4.0/4.1/5.x인 경우
            redirect = "http://localhost:8080/apple/upwml/index.jsp?token=" + URLEncoder.encode(token);
        }
    } else if((agent != null && agent.indexOf("Smartphone") >= 0) || (agent != null && agent.indexOf("Symbian") >= 0) || (agent != null && agent.indexOf("PPC") >= 0) || (agent != null && agent.indexOf("Windows CE") >= 0) || (agent != null && agent.indexOf("iPhone") >= 0) || (agent != null && agent.indexOf("iPod") >= 0)) {
        //알려진 PDA, Smartphone
        redirect = "http://localhost:8080/apple/mw2/index.jsp?token=" + URLEncoder.encode(token);
    } else if(agent.substring(0,3).equals("K_T")) {
        //KT_SoIP폰
        redirect = "http://localhost:8080/apple/mw2/index.jsp?token=" + URLEncoder.encode(token);
    } else if(httpsid != null && httpsid.indexOf("EB") >= 0){
        //OZ(Full Browser)
        redirect = "http://localhost:8080/apple/mw2/index.jsp?token=" + URLEncoder.encode(token);
    } else if(accept != null && accept.indexOf("application/vnd.wap.xhtml+xml") >= 0){
        //xHTML,HTML을 지원하는 웹 브라우저
        redirect = "http://localhost:8080/apple/xhtml/index.jsp?token=" + URLEncoder.encode(token);
    } else if(accept != null && accept.indexOf("wml") >= 0){
        //wml을 지원하는 기타/해외 단말
        redirect = "http://localhost:8080/apple/wml/index.jsp?token=" + URLEncoder.encode(token);
    } else {
        //Web 브라우저
        redirect = "http://localhost:8080/apple/mw2/index.jsp?token=" + URLEncoder.encode(token);
    }
    response.sendRedirect(redirect);
%>
