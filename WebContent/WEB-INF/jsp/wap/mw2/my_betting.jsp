﻿<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
    <title>&nbsp; </title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=0" />
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
    <div style="width:<%=lcdlx%>px">
        <div><table width="100%" cellspacing="0" cellpadding="0">
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">?배팅내역?</td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
        </table></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr style="color:#000000;width:100%;"/>
<%
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
%>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
        <div>
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>배팅일시</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>배당율</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getRateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>배팅금액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betting.getMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>예상적중액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betting.getExpect())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>적중액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div><a title="배팅상세" href="betlog.wap?mode=viewMyBettingDetail&bettingId=<%=betting.getId()%>&token=<%=token%>">배팅내역상세</a></div>
                </td>
            </tr>
        </table>
        </div>
<%
	}
} else {
	out.println("배팅 내역이 없습니다");
}
%>
<%
		int SHOWPAGE = 5;
		int ROWSIZE = 5;
		Integer totalCount = (Integer) request.getAttribute("totalCount");
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil((double)totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + SHOWPAGE;
%>
<%	
	if (startPage > 0) {
%>
        <div style="display:inline;"><a title="이전" href="javascript:goPage(<%=startPage - 1%>)" accesskey="2">이전</a></div>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
%>
<%
		if (i == pIdx) {
%>
        <div style="display:inline;"><%=i+1%></div>
<%
		} else {
%>	
        <div style="display:inline;"><a title="<%=i+1%>" href="<a href='javascript:goPage(<%=i%>)'>"><%=i+1%></a></div>
<%			
		}
	}
	if (i < pageNum) {
%>
        <div style="display:inline;"><a title="다음" href="javascript:goPage(<%=i%>)" accesskey="3">다음</a></div>
<%
}
%>
        <div>
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                </td>
                <td style="border-width:1;border-style:solid;">
                </td>
                <td style="border-width:1;border-style:solid;">
                </td>
                <td style="border-width:1;border-style:solid;">
                </td>
            </tr>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.getMMddDate(betting.getDate())%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betting.getRateStr()%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betting.getMoney())%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betting.getExpect())%></div>
                </td>
            </tr>
<%
	}
} else {
	out.println("배팅 내역이 없습니다");
}
%>
        </table>
        </div>
        <div><a title="상위" href="main.wap?token=<%=token%>">상위</a></div>
    </div>
    </body>
</html>