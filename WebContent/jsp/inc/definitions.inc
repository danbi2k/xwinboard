<%@ page language="java" import="java.util.*,com.maththinking.dbcruiser.*" pageEncoding="ISO-8859-1"%>
<% 
   ConfigBean info = ConfigBean.getInstance();
   String contextPath = request.getContextPath();
   String actionPath     = contextPath+"/action";
   String imagePath   = contextPath+"/images";
   String jspPath     = contextPath+"/jsp";
   String scriptPath  = contextPath+"/scripts";
   String stylePath   = contextPath+"/styles";
   String message = (String)request.getAttribute("message");
   String browser = request.getHeader("user-agent");
   String connId = request.getParameter("connId");
   String db_name = request.getParameter("db_name");
 %>