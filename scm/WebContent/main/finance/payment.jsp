<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<base href="<%=basePath %>"/>
		<title>付款登记</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
		
		<link href="css/style.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="script/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="script/common.js"></script>
		
		
		<script  type="text/javascript">
			$(function(){
				//初始化首页
				goPage(1,"");
			});
		//加载数据
			function goPage(currentPage,payType){
				var params = {
					"currentPage":currentPage,
					"payType":payType
				};
				
				$("#dataList").load("main/finance/paymentIndex",params)
			}
		
		//付款登记
			function payment(poid,type){
				if(confirm("确定要操作吗？")){
					$.post("main/finance/payment",{"poid":poid,"type":type},function(data){
						if(data == "ok"){
							alert("登记成功！")
							goPage($("#currentPage").text());//刷新页面
						}else{
							alert("登记失败！")
						}
					});
				}
			}
			
		</script>
	</head>

	<body>
		<div id="pomain">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td nowrap class="title1">您的位置：财务收支－－付款登记</td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="30px" nowrap class="toolbar">&nbsp;</td>
					<td width="40px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)" onclick="goPage(1,'')">
						全部
					</td>
					<td width="80px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)" onclick="goPage(1,1)">
						货到付款
					</td>
					<td width="80px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)" onclick="goPage(1,2)">
						款到发货
					</td>
					<td width="90px" nowrap class="toolbar" onMouseOver="OMO(event)"
						onMouseOut="OMOU(event)" onclick="goPage(1,3)">
						预付款到发货
					</td>
					<td nowrap class="toolbar">&nbsp;</td>
					
				</tr>
			</table>
	
			<div id="dataList"></div>
		</div>

	</body>
</html>
