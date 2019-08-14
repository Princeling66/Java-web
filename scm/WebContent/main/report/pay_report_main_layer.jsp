<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
	
</script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table width="100%" border="0" cellpadding="0" cellspacing="0" >
	<tr>
		<td nowrap class="title1">主信息</td>
	</tr>
</table>
<table width="100%" border="0" align="center" cellspacing="1"
	class="c">
	<tr>
		<td class="title1">收款总金额</td>
		<td class="title1">付款总金额</td>
		<td class="title1">收款交易次数</td>
		<td class="title1">付款交易次数</td>
	</tr>
		<tr>
			<td align="center">${mainInfo.receivePrice }</td>
			<td align="center">${mainInfo.payPrice }</td>
			<td align="center">${mainInfo.receiveCount}</td>
			<td align="center">${mainInfo.payCount}</td>
		</tr>
</table>


