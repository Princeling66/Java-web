<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>login</title>
<base href="<%=basePath %>">
<link href="css/style.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#ffffff">

	<form action="login" method="post">
		<table width="100%" border="0">
			<tr>
				<td class="title1">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" style="color:red;" align="center">${info}</td>
			</tr>
			<tr>
				<td width="50%" align="right">用户名&nbsp;&nbsp;</td>
				<td width="50%"><input type="text" name="account"/></td>
			</tr>
			<tr>
				<td align="right">密码&nbsp;&nbsp;&nbsp;</td>
				<td><input type="password" name="password" /></td>
			</tr>
			<tr>
				<td class="title1"><div align="right">
						<input type="submit" value="登录" />
					</div></td>
				<td class="title1"><div align="left">
						<input type="reset" value="重置" />
					</div></td>
			</tr>
		</table>
	</form>
</body>
</html>
