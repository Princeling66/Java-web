<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<base href="<%=basePath %>"/>
		<title>月度采购报表</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
		
		<link href="css/style.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="script/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/script/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="script/common.js"></script>
		
		
		
		<script  type="text/javascript">
		
		//加载数据
			function goPage(currentPage){
				var params = {
					"month":$("#month").val(),
					"currentPage":currentPage
				};
				$("#detail").load("main/report/pomain_detail",params)
			}
			
			function query(){
				var month = $("#month").val();
				if(month != ""){
					var params = {"month":month};
					$("#main").load("main/report/pomain_main",params);
					goPage(1);
				}
			}
			
			
		</script>
	</head>

	<body>
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td nowrap class="title1">您的位置：业务报表－－月度采购报表</td>
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
				请选择月份：
				<input class="Wdate" type="text" id="month" onFocus="WdatePicker({dateFmt:'yyyy-MM',isShowClear:true,readOnly:true})"/>
				<input type="button" value="查询" onclick="query()"/>
			</div>
			
			<div id="main"></div>
			<div id="detail"></div>
		</div>
		
		
	</body>
</html>
