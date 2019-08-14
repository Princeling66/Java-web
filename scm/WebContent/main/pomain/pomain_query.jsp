<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<base href="<%=basePath %>"/>
		<title>采购单查询</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
		
		<link href="css/style.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="script/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/script/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="script/common.js"></script>
		
		
		
		<script  type="text/javascript">
		
		//加载数据
			function goPage(currentPage){
				var params = {
					"poId":$.trim($("#poId").val()),
					"venderCode":$("#venderCode").val(),
					"payType":$("#payType").val(),
					"startDate":$("#startDate").val(),
					"endDate":$("#endDate").val(),
					"currentPage":currentPage
				};
				$("#dataList").load("main/pomain/pomainQuery",params)
			}
			
		$(function(){
			goPage(1);
		});
			
			
		</script>
	</head>

	<body>
		<div id="pomain">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td nowrap class="title1">您的位置：采购管理－－采购单查询</td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="30px" nowrap class="toolbar">&nbsp;</td>
					
					<td nowrap class="toolbar">&nbsp;</td>
					<td width="60px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)">&nbsp;</td>
					<td width="20px" nowrap class="toolbar">&nbsp;</td>
					<td width="60px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)">&nbsp;</td>
					<td width="20px" nowrap class="toolbar">&nbsp;</td>
					<td width="60px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)">&nbsp;</td>
					<td width="20px" nowrap class="toolbar">&nbsp;</td>
					<td width="60px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)">&nbsp;</td>
					<td width="20px" nowrap class="toolbar">&nbsp;</td>
				</tr>
			</table>
			
			<div class="queryDiv">
				采购单编号：<input type="text" id="poId" />
				供应商：
				<select id="venderCode">
					<option value="">请选择 </option>
				</select>
				付款方式：
					<select id="payType">
						<option value="">请选择</option>
						<option value="1">货到付款</option>
						<option value="2">款到发货</option>
						<option value="3">预付款到发货</option>
					</select>
				创建日期：
				<input class="Wdate" type="text" id="startDate"  onFocus="WdatePicker({isShowClear:true,readOnly:true})"/>
				-
				<input class="Wdate" type="text" id="endDate"  onFocus="WdatePicker({isShowClear:true,readOnly:true})"/>
				<input type="button" value="查询" onclick="goPage(1)"/>
			</div>
			
			<div id="dataList"></div>
		</div>
		
		
	</body>
</html>
