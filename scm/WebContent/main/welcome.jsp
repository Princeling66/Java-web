<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>欢迎</title>
<base href="<%=basePath %>">
<link href="css/style.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#ffffff">
	<h2 style="text-align:center;margin-top:20px;">欢迎使用供应商管理系统</h2>
</body>
	
</html>
