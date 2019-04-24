<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String base = "http://" + request.getLocalAddr()+":"+request.getLocalPort();
String contextPath = this.getServletContext().getContextPath();
String fule = base + "" + contextPath + "/";
%>
<!DOCTYPE html>
<body>
<center style="padding-top:50px;">
登录过期，请重新登录<br/>
<a href="<%=fule %>login.jsp" >返回</a>
</center>
</body>
</html>