<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table width="100%"  border="0" align="center" cellspacing="1" class="a1" id="spxxTable">
  <tr>
    <td class="title1">选择</td>
    <td class="title1">产品编码</td>
    <td class="title1">产品名称</td>
    <td class="title1">数量单位</td>
  </tr>
  <c:forEach items="${products}" var="p">
	  <tr onclick="selectItem(this)"  ondblclick="confirmProduct()" align="center">
	    <td>&nbsp;</td>
	    <td>${p.productCode }</td>
	    <td>${p.name }</td>
	    <td>${p.unitName }</td>
	  </tr>
  </c:forEach>
  
</table>


