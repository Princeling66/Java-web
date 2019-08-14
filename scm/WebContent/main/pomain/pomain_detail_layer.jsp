<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table width="100%" border="0" align="center" cellspacing="1"
	class="c">
	<tr>
		<td class="title1" colspan="6" style="font-size:14px;"><b>采购单${pomain.poId}详情</b></td>
	</tr>
	<tr>
		<td style="text-align:left" class="title1" colspan="6">备注：${pomain.remark }</td>
	</tr>
	<tr>
		<td class="title1">序号</td>
		<td class="title1">产品名称</td>
		<td class="title1">产品单价</td>
		<td class="title1">产品数量</td>
		<td class="title1">数量单位</td>
		<td class="title1">明细总价</td>
	</tr>
	<c:forEach items="${pomain.poitems}" var="item" varStatus="i">
		<tr >
			<td align="center">${i.index+1}</td>
			<td align="center">${item.productName}</td>
			<td align="center">${item.unitPrice}</td>
			<td align="center">${item.num}</td>
			<td align="center">${item.unitName}</td>
			<td align="center">${item.itemPrice}</td>
		</tr>
	</c:forEach>
</table>


