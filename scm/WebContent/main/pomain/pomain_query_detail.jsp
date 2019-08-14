<%@page import="java.util.Date"%>
<%@page import="com.scm.util.DateUtil"%>
<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<base href="<%=basePath %>"/>
		<title>
			<c:choose>
				<c:when test="${param.flag == 2 }">
					月度采购报表
				</c:when>
				<c:otherwise>采购单查询-查看详情</c:otherwise>
			</c:choose>
		</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
		
		<link href="css/style.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="script/jquery-1.8.1.min.js"></script>
		
		<script>
			function backPomainQuery(){
				window.location.href = "<%=path%>/main/pomain/pomain_query.jsp";
			}
		</script>
	</head>
<body>
	<div id="main">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td nowrap class="title1">
		    <c:choose>
				<c:when test="${param.flag == 2 }">
					您的位置：业务报表－－月度采购报表 －－ 查看详情
				</c:when>
				<c:otherwise>
					您的位置：采购管理－－采购单查询－－查看详情
				</c:otherwise>
			</c:choose>
		    	
		    </td>
		  </tr>
		</table>
		
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td width="30px" nowrap class="toolbar">&nbsp;</td>
			<td nowrap class="toolbar">&nbsp;</td>
		  </tr>
		</table>
	
		<table id="headTable" width="100%"  border="0" align="center" class="a1">
		  <tr align="justify">
		    <td>采购单编号</td>
		    <td>${pomain.poId}</td>
		    <td>创建时间</td>
		    <td>${pomain.createTime}</td>
		    <td>供应商的名称</td>
		    <td>${pomain.venderName }</td>
		    <td>创建用户</td>
		    <td>${pomain.account}</td>
		  </tr>
		  <tr align="justify">
		    <td>附加费用</td>
		    <td>${pomain.tipFee}</td>
		    <td>采购产品总价</td>
		    <td>${pomain.productTotal}</td>
		    <td>付款方式</td>
		    <td>${pomain.payType}</td>
		    <td>最低预付款金额</td>
		    <td>${pomain.prePayFee}</td>
		  </tr>
		  <tr align="justify">
		    <td colspan="8">&nbsp;</td>
		  </tr>
		  <tr align="justify">
		    <td>处理状态</td>
		    <td>
		    	<c:if test="${pomain.status == 1}">新增</c:if>
				<c:if test="${pomain.status == 2}">已收货</c:if>
				<c:if test="${pomain.status == 3}">已付款</c:if>
				<c:if test="${pomain.status == 4}">已了结</c:if>
				<c:if test="${pomain.status == 5}">已预付</c:if>
			</td>
		    <td>入库登记时间</td>
		    <td>${pomain.stockTime}</td>
		    <td>入库登记用户</td>
		    <td>${pomain.stockUser}</td>
		    <td>付款登记时间</td>
		    <td>${pomain.payTime}</td>
		  </tr>
		  <tr align="justify">
		    <td>付款登记用户</td>
		    <td>${pomain.payUser}</td>
		    <td>预付登记时间</td>
		    <td>${pomain.prePayTime}</td>
		    <td>预付登记用户</td>
		    <td>${pomain.prePayUser}</td>
		    <td>了结时间</td>
		    <td>${pomain.endTime}</td>
		  </tr>
		  <tr align="justify">
		    <td>了结用户</td>
		    <td>${pomain.endUser}</td>
		    <td>备注</td>
		    <td colspan="5">${pomain.remark}</td>
		   </tr>
		  <tr>
		  	<td class="title2"></td>
		  </tr>
		</table>
	
		<table width="100%"  border="0" align="center" cellspacing="1" id="detailTable">
		  <tr>
		    <td class="toolbar">序号 </td>
		    <td class="toolbar">产品编号 </td>
		    <td class="toolbar">产品名称 </td>
		    <td class="toolbar">数量单位 </td>
		    <td class="toolbar">产品数量 </td>
		    <td class="toolbar">采购单价</td>
		    <td class="toolbar">明细总价</td>
		  </tr>
		  
		  <c:forEach items="${pomain.poitems }" var="item" varStatus="i">
		  	<tr align="center">
		  		<td>${i.index+1}</td>
		  		<td>${item.productCode }</td>
		  		<td>${item.productName }</td>
				<td>${item.unitName }</td>
				<td>${item.num }</td> 
				<td>${item.unitPrice }</td> 
				<td>${item.itemPrice }</td>
		  	</tr>
		  </c:forEach>
		  
		</table>
		<table width="100%"  border="0" align="center" cellspacing="1">
		  <tr>
		    <td class="title2"></td>
		  </tr>
		</table>
		<br/>
		<div align="center" class="wrong" id="wrong" style="padding:10px;"></div>
		<div align="center">
			<c:choose>
				<c:when test="${param.flag == 2 }">
					<input type="button" id="gb" value="关闭"  onclick="window.close()"/>
				</c:when>
				<c:otherwise>
					<input type="button" id="gb" value="返回" onclick="backPomainQuery()"/>
				</c:otherwise>
			</c:choose>
		    
		</div>
	</div>
	
 </body>
</html>