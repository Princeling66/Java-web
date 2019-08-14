<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<base href="<%=basePath %>"/>
		<title>添加采购单</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
		
		<link href="css/style.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="script/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/script/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="script/common.js"></script>
		
		<style type="text/css">
			div.product{
				position: absolute;
				top:2px;
				left: 2px;
				width:100%;
				height: 98%;
				background-color: #fffffe;
			}
		</style>
		
		<script  type="text/javascript">
		
			$(function(){
				//页面加载完，加载供应商列表
				$.get("main/pomain/venderlist",function(data){
					$.each(data,function(i,obj){
						$("#venderCode").append("<option value='"+obj.venderCode+"'>"+obj.name+"</option>");
					});
				},"json")
				
				//初始化首页
				goPage(1);
			});
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
				
				$("#dataList").load("main/pomain/pomainNew",params)
			}
			//打开新增页面
			function openAdd(){
				window.location.href = "main/pomain/pomain_opt.jsp";
			}
			//打开修改页面
			function openUpdate(poid){
				window.location.href = "main/pomain/pomainUptPage?poid="+poid;
			}
			
			
		</script>
	</head>

	<body>
		<div id="pomain">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td nowrap class="title1">您的位置：采购管理－－新添采购单</td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="30px" nowrap class="toolbar">&nbsp;</td>
					<td width="40px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)" onclick="openAdd()">
						<img src="images/new.gif">新增</td>
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
		
		<%--数据操作层 --%>
		<div id="opt"></div>
		<!-- 供应商选择层 -->
		<div id="venderSelect"></div>
	</body>
</html>
