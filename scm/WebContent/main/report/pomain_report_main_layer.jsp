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
		<td class="title1">采购单总数</td>
		<td class="title1">已了结数</td>
		<td class="title1">采购单总金额</td>
		<td class="title1">已付款金额</td>
	</tr>
		<tr>
			<td align="center">${mainInfo.totalNum }</td>
			<td align="center">${mainInfo.endTotalNum }</td>
			<td align="center">${mainInfo.pototal}</td>
			<td align="center">${mainInfo.totalpay}</td>
		</tr>
</table>


