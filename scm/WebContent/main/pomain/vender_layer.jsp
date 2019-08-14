<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table width="100%" border="0" align="center" cellspacing="1"
	class="c">
	<tr>
		<td class="title1">供应商编号</td>
		<td class="title1">供应商名称</td>
		<td class="title1">联系人</td>
		<td class="title1">地址</td>
		<td class="title1">邮政编码</td>
		<td class="title1">注册日期</td>
		<td class="title1">电话</td>
		<td class="title1">传真</td>
		
	</tr>
	<c:forEach items="${page.dataList }" var="v">
		<tr>
			<td align="center">${v.venderCode }</td>
			<td align="center">${v.name }</td>
			<td align="center">${v.contactor}</td>
			<td align="center">${v.address}</td>
			<td align="center">${v.postCode}</td>
			<td align="center">${v.createDate}</td>
			<td align="center">${v.tel}</td>
			<td align="center">${v.fax}</td>
		</tr>
	</c:forEach>
</table>
<%--导入分页层 --%>
<%@include file="../../public/page.jsp"%>

