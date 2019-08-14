<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<base href="<%=basePath %>"/>
		<title>用户管理</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
		
		<link href="css/style.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="script/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/script/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="script/common.js"></script>
		<script type="text/javascript" src="script/productDiv.js"></script>
		<script  type="text/javascript">
			var flag = true;//定义一个 标记变量
			
	
		
			//分页查询
			function goPage(currentPage){
				var account = $.trim($("#account").val());
				var name = $.trim($("#name").val());
				var startDate = $.trim($("#startDate").val());
				var endDate = $.trim($("#endDate").val());
				var status = -1;//什么 都没有选中
				if($("input[name=status]:checked").length == 1){
					status = $("input[name=status]:checked").val();
				}
				window.location.href = "<%=path%>/main/system/scmuserShow?currentPage="+currentPage+"&account="+account+"&name="+name+"&startDate="+startDate+"&endDate="+endDate+"&status="+status;
			}
			//查看用户权限
			function showModels(account){
				if(flag){
					flag = false;
					$("body>div").hide();
					$("#account_").text(account);
					
					var xmlHttp = new XMLHttpRequest();
					xmlHttp.open("get", "main/system/usermodelShows?account="+account, true);
					xmlHttp.send();//发送请求
					//状态发生改变时调用的函数
					xmlHttp.onreadystatechange = function(){
						//响应完成时执行
						if(xmlHttp.status == 200 && xmlHttp.readyState == 4){
							var userModels = $("#userModels");
							userModels.html("");
							var models = JSON.parse(xmlHttp.responseText);
							for(var i=0;i<models.length;i++){
								userModels.append(models[i].modelName+" ");
							}
						}
						$("#models").show();
						flag = true;
					}
				}
				
			}
			//返回scmuser列表页显示
			function backScmuser(){
				$("body>div").hide();
				$("#m").show();
			}
			
			//打开新增用户层
			function openAdd(){
				if(flag){//设置变量的目的是防止多次点击
					flag = false;//修改变量
					
					$("body>div").hide();
					
					//初始化窗口内容
					$("#new_account,#new_name,#password").val("");
					$("#optTab tr").find("td:eq(2)").text("");//错误信息显示空白
					$(":input:radio[value=0]").attr("checked",true);
					$(":input[name=modelCode]").attr("checked",false);
					$("#HideTitle").text("新增");
					
					var xmlHttp = new XMLHttpRequest();
					xmlHttp.open("get","main/system/systemmodels",true);
					xmlHttp.send();
					
					xmlHttp.onreadystatechange = function(){
						if(xmlHttp.status == 200 && xmlHttp.readyState == 4){
							var sys = $("#systemModels");
							sys.html("");
							var m = JSON.parse(xmlHttp.responseText);
							for(var i=0;i<m.length;i++){
								sys.append("<input type='checkbox' name='modelCode'  value='"+m[i].modelCode+"'/>")
								.append(m[i].modelName).append(" ");
							}
							$("#add").show();
							flag = true;
						}
					}
				}
			}
			/*保存用户*/
			function saveScmuser(btn){
				var b = true;//标记验证通过
				var hidTitel = $("#HideTitle").text();
				
				var account = $.trim($("#new_account").val());
				var name = $.trim($("#new_name").val());
				var password = $.trim($("#password").val());
				var status = $("input[name=status]:checked").val();
				
				var modelCode = $("input[name=modelCode]:checked");
				if(account == ""){
					$("#accountInfo").text("用户账号不能为空");//用户账号不能为空
					b = false;
				}else{
					$("#accountInfo").text("");
				}
				if(name == ""){
					$("#nameInfo").text("用户姓名不能为空");//用户姓名不能为空
					b = false;
				}else{
					$("#nameInfo").text("");
				}
			
				if(password == ""){
					$("#passwordInfo").text("密码不能为空");//密码不能为空
					b = false;
				}else{
					$("#passwordInfo").text("");
					
				}
				if(modelCode.length == 0){
					$("#modelInfo").text("请选择用户权限");
					b = false;
				}else{
					$("#modelInfo").text("");
				}
				//验证通过
				if(b){
					//请求参数
					var params = "account="+account+"&name="+name+"&password="+password+"&status="+status;
					modelCode.each(function(){
						params += "&modelCode="+$(this).val();
					});
					
					var req = new XMLHttpRequest();
					
					if(hidTitel == "新增"){
						req.open("get","<%=path%>/main/system/scmuserAdd?"+params,false);
						req.send();
						
						var r = req.responseText;
						if(r == "ok"){
							alert("新增成功！");
							window.location.reload();//重新加载页面
						}else if(r == "duplicate"){
							$("#accountInfo").text("账户已经存在！");
						}else{
							$("#accountInfo").text("新增失败！");
						}
					}else if(hidTitel == "修改"){
						if(confirm("确认要修改吗？")){
							req.open("get","<%=path%>/main/system/scmuserUpdate?"+params,false);
							req.send();
							
							var r = req.responseText;
							if(r == "ok"){
								alert("修改成功！");
								window.location.reload();//重新加载页面
							}else{
								$("#accountInfo").text("修改失败！");
							}
						}
					}
				}
			}
			
			//删除用户
			function del(account){
				if(confirm("确认要删除吗？")){
					var req = new XMLHttpRequest();
					req.open("get","<%=path%>/main/system/scmuserDelete?account="+account,false);
					req.send();
					var r = req.responseText;
					if(r == "ok"){
						alert("删除成功！");
						window.location.reload();
					}else if(r == "fail"){
						alert("删除失败！");
					}
				}
			}
				
			//打开修改显示页面
			function upd(account){
				if(flag){//设置变量的目的是防止多次点击
					flag = false;//修改变量
					
					$("body>div").hide();
					
					//初始化窗口内容
					$("#optTab tr").find("td:eq(2)").text("");//错误信息显示空白
					$("#HideTitle").text("修改");
					
					var xmlHttp = new XMLHttpRequest();
					xmlHttp.open("get","main/system/scmuserupdateinfo?account="+account,true);
					xmlHttp.send();
					
					xmlHttp.onreadystatechange = function(){
						if(xmlHttp.status == 200 && xmlHttp.readyState == 4){
							var sys = $("#systemModels");
							sys.html("");
							var r = JSON.parse(xmlHttp.responseText);
							
							var user = r.scmuser;//用户信息
							var m = r.models;//权限信息
							//显示用户信息
							$("#new_account,#new_name,#password").val("");
							$("#new_account").attr("readonly",true);
							$("#new_account").val(user.account);
							$("#new_name").val(user.name);
							$("#password").val(user.passWord);
							
							$("input[name=status][value="+user.status+"]").attr("checked",true);
							//显示所有权限
							for(var i=0;i<m.length;i++){
								sys.append("<input type='checkbox' name='modelCode'  value='"+m[i].modelCode+"'/>")
								.append(m[i].modelName).append(" ");
							}
							//选中自己已有的权限
							 for(var i=0;i<user.models.length;i++){
								$("input[name=modelCode][value="+user.models[i].modelCode+"]").attr("checked",true);//自己权限选中
							}
							 
							
							$("#add").show();
							flag = true;
						}
					}
				}
			}
				
				
				
			
		</script>
	</head>

	<body>
		<div id="m">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td nowrap class="title1">您的位置：系统管理－－用户管理</td>
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
				用户账号：<input type="text" id="account" value="${param.account }"/>
				用户姓名：<input type="text" id="name" value="${param.name }"/>
				添加日期：
				<input class="Wdate" type="text" id="startDate" value="${param.startDate }" onFocus="WdatePicker({isShowClear:true,readOnly:true})"/>
				-
				<input class="Wdate" type="text" id="endDate" value="${param.endDate }" onFocus="WdatePicker({isShowClear:true,readOnly:true})"/>
				锁定状态：
				<input type='radio' name='status' value='0' <c:if test="${param.status==0}">checked='checked'</c:if>/>不锁定
				<input type='radio' name='status' value='1' <c:if test="${param.status==1}">checked='checked'</c:if>/>锁定
				
				<input type="button" value="查询" onclick="goPage(1)"/>
			</div>
			<table width="100%" border="0" align="center" cellspacing="1"
				class="c">
				<tr>
					<td class="title1">用户账号</td>
					<td class="title1">用户姓名</td>
					<td class="title1">添加日期</td>
					<td class="title1">锁定状态</td>
					<td class="title1">权限</td>
					<td class="title1">操作</td>
				</tr>
				<c:forEach items="${page.dataList }" var="user">
					<tr>
						<td align="center">${user.account }</td>
						<td align="center">${user.name }</td>
						<td align="center">${user.createDate }</td>
						<td align="center">
							<c:if test="${user.status ==0 }">不锁定</c:if>
							<c:if test="${user.status ==1 }">锁定</c:if>
						</td>
						<td align="center">
							<input type="button" value="查看权限" onclick="showModels('${user.account}')"/>
						</td>
						<td align="center">
							<a href="javascript:upd('${user.account }')" >修改</a>
							<a href="javascript:del('${user.account}')">删除</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<%--导入分页层 --%>
			<%@include file="../../public/page.jsp"%>
		</div>
		<!-- 查看权限层 -->
		<div id="models" class="hidd">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td nowrap class="title1">您的位置：系统管理－－用户管理－－查看<span id="account_"></span>权限</td>
				</tr>
			</table>
			
			<div id="userModels" class="pageDiv">
				
			</div>
			<div  class="pageDiv">
				<input type="button" value="返回" onclick="backScmuser()"/>
			</div>
		</div>
		<!-- 新增或者修改用户层 -->
		<div id="add" class="hidd">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td nowrap class="title1">您的位置：系统管理－－用户管理－－<span id="HideTitle"></span>用户</td>
				</tr>
			</table>
			<table width="100%" border="0" align="center" cellspacing="1" class="c" id="optTab">
				<tr>
					<td align="center">用户账号</td>
					<td align="left"><input type="text" id="new_account"/></td>
					<td width="30%" id="accountInfo" class="wrong"></td>
				</tr>
				<tr>
					<td align="center">用户姓名</td>
					<td align="left"><input type="text" id="new_name"/></td>
					<td width="30%" id="nameInfo" class="wrong"></td>
				</tr>
				<tr>
					<td align="center">密码</td>
					<td align="left" ><input type="password" id="password"/></td>
					<td width="30%" id="passwordInfo" class="wrong"></td>
				</tr>
				<tr>
					<td align="center">锁定状态</td>
					<td align="left">
					 	<input type="radio" name="new_status" value="0" checked="checked"/>否
						<input type="radio" name="new_status" value="1"/>是
					</td>
					<td width="30%" id="accountInfo" class="wrong"></td>
				</tr>
				<tr>
					<td align="center">用户权限</td>
					<td align="left" id="systemModels"></td>
					<td align="left" id="modelInfo" class="wrong"></td>
				</tr>
				<tr>
					<td height="18" colspan="3" align="center">
						<input type="button" value="保存" onClick="saveScmuser(this)" />
						<input type="button" value="取消" onclick="backScmuser()"/>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
