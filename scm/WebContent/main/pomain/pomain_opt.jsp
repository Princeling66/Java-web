<%@page import="com.scm.constants.ScmConfig"%>
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
		<title>采购单操作</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
		
		<link href="css/style.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="script/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/script/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="script/common.js"></script>
		<script type="text/javascript" src="script/pomain.js"></script> 
	</head>
<body>
	<div id="main">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td nowrap class="title1">您的位置：采购管理－－新添采购单－－
		    <c:if test="${empty pomain }">
		    	采购单新增
		    </c:if>
		    <c:if test="${not empty pomain }">
		    	采购单修改
		    </c:if>
		    </td>
		  </tr>
		</table>
		
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td width="30px" nowrap class="toolbar">&nbsp;</td>
		    <td width="70px" nowrap class="toolbar" onMouseOver="OMO(event)" onMouseOut="OMOU(event)" onclick="addItem()"><img src="images/add.gif">增加明细</td>
		    <td width="20px" nowrap class="toolbar">|</td>
		    <td width="40px" nowrap class="toolbar" onMouseOver="OMO(event)" onMouseOut="OMOU(event)" onclick="savePomain(${empty pomain})"><img src="images/save.gif">保存</td>
		    <td width="20px" nowrap class="toolbar">|</td>
		    <td width="40px" nowrap class="toolbar" onMouseOver="OMO(event)" onMouseOut="OMOU(event)" onclick="window.location.href='main/pomain/pomainNew'"><img src="images/cancel.gif">返回</td>
			<td nowrap class="toolbar">&nbsp;</td>
		  </tr>
		</table>
	
		<table id="headTable" width="100%"  border="0" align="center" class="a1">
		  <tr align="justify">
		    <td>采购单编号</td>
		    <%
		    	//自动生成采购单编号
		    	String poid = DateUtil.currentTime("yyyyMMddHHmmss");
		    	pageContext.setAttribute("poid", poid);
		    	
		    	String createTime = DateUtil.currentTime();
		    	pageContext.setAttribute("createTime", createTime);
		    	
		    %>
		    <td><input type="text" id="poId" value="${empty pomain?poid:pomain.poId }" size="15"/>
		      <span class="requred_symbol">*</span>
		    </td>
		    <td>创建时间</td>
		    <td><input type="text" size="15" id="createTime" value="${empty pomain?createTime:pomain.createTime }" readonly="readonly"/>
		      <span class="requred_symbol">*</span>
		     </td>
		    <td>供应商的名称</td>
		    <td>
		    	<input type="text" size="15" value="${pomain.venderName }" id="vName" readonly="readonly"/>
		    	<span class='LL' onclick="openVender()"><img src='images/selectDate.gif'/></span>
		    	<input type="hidden" id="vCode" value="${pomain.venderCode }"/>
		      	<span class="requred_symbol">*</span>
		      </td>
		    <td>创建用户</td>
		    <td><input name="textfield" type="text" size="15" value="${empty pomain?scmuser.account:pomain.account}" readonly="readonly">
		        <span class="requred_symbol">*</span></td>
		  </tr>
		  <tr align="justify">
		    <td>附加费用</td>
		    <td><input type="text" size="15" id="tipFee" value="${empty pomain.tipFee?0:pomain.tipFee}"/>
		        <span class="requred_symbol">*</span></td>
		    <td>采购产品总价</td>
		    <td><input type="text" size="15" id="productTotal" value="${empty pomain.productTotal?0:pomain.productTotal}" readonly="readonly"/></td>
		    <td>付款方式</td>
		    <td>
		    	<select id="payType" onchange="chgPayType(this)">
					<option value="<%=ScmConfig.PAYTYPE_LAST_PAY %>" <c:if test="${pomain.payType==1}">selected="selected"</c:if> >货到付款</option>
					<option value="<%=ScmConfig.PAYTYPE_FIRST_PAY %>" <c:if test="${pomain.payType==2}">selected="selected"</c:if>>款到发货</option>
					<option value="<%=ScmConfig.PAYTYPE_PRE_PAY %>" <c:if test="${pomain.payType==3}">selected="selected"</c:if>>预付款到发货</option>
				</select>
		    </td>
		    <td>最低预付款金额</td>
		    <td><input name="text"  id="prePayFee" value="${empty pomain.prePayFee?0:pomain.prePayFee }" type="text" size="15" <c:if test="${not empty pomain and pomain.payType!='3'}">readonly="readonly"</c:if>/></td>
		   </tr>
		  <tr align="justify">
		    <td>备注</td>
		    <td colspan="7"><input type="text" id="remark" size="100" value="${pomain.remark }"/></td>
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
		    <td class="toolbar">&nbsp;</td>
		  </tr>
		  
		  <c:forEach items="${pomain.poitems }" var="item" varStatus="i">
		  	<tr align="center">
		  		<td>${i.index+1}</td>
		  		<td><input type='text' value="${item.productCode }"  name='productCode'  size='10' readonly/> <span class='LL'><image src='images/selectDate.gif' onclick='openProduct(${i.index+1})'></span></td>
		  		<td><input type='text' value="${item.productName }"  name='name' size='15' readonly/></td>
				<td><input type='text' value="${item.unitName }"  name='unitName' size='15' readonly/></td>
				<td><input type='text' value="${item.num }"  name='num' size='15' value='1'/></td> 
				<td><input type='text' value="${item.unitPrice }"  name='unitPrice' size='15' value='0'/></td> 
				<td><input type='text' value="${item.itemPrice }"  name='itemPrice' size='15' value='0' readonly/></td>
				<td><img src='images/delete.gif' class='LL' onclick='delItem(this)'/></td>
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
		    <input type="button" id="mx" value="增加明细" onclick="addItem()"/>
		    <input type="button" id="bc" value="保存" onclick="savePomain(${empty pomain})"/>
		    <input type="button" id="gb" value="返回" onclick="backPomainNew()"/>
		</div>
	</div>
	<!-- 供应商选择层 -->
	<div id="venderDiv" class="product" style="display:none">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td width="30px" nowrap="nowrap" class="toolbar">&nbsp;</td>
		    <td width="40px" nowrap="nowrap" class="toolbar" onMouseOver="OMO(event)" onMouseOut="OMOU(event)" onclick="confirmVender()"><img src="images/confirm.gif">确定</td>
		    <td width="20px" nowrap="nowrap" class="toolbar">|</td>
		    <td width="40px" nowrap="nowrap" class="toolbar" onMouseOver="OMO(event)" onMouseOut="OMOU(event)" onclick="cancleSelect()"><img src="images/cancel.gif">取消</td>
			<td align="center" valign="middle" nowrap="nowrap" class="toolbar">&nbsp;</td>
		  </tr>
		</table>
		
		<div class="queryDiv">
			供应商编号：<input type="text" id="venderCode" />
			供应商名称：<input type="text" id="venderName" />
			<input type="button" value="查询" onclick="queryVender()"/>
		</div>
		
		<div id="venderDataList"></div>
	</div>
		 
	<div id="productDiv" style="display:none" class="product">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td width="30px" nowrap="nowrap" class="toolbar">&nbsp;</td>
		    <td width="40px" nowrap="nowrap" class="toolbar" onMouseOver="OMO(event)" onMouseOut="OMOU(event)" onClick="confirmProduct()"><img src="images/confirm.gif">确定</td>
		    <td width="20px" nowrap="nowrap" class="toolbar">|</td>
		    <td width="40px" nowrap="nowrap" class="toolbar" onMouseOver="OMO(event)" onMouseOut="OMOU(event)" onClick="cancleSelect()"><img src="images/cancel.gif">取消</td>
			<td align="center" valign="middle" nowrap="nowrap" class="toolbar">&nbsp;</td>
		  </tr>
		</table>
		
		
		<div class="queryDiv">
			产品编号：<input type="text" id="productCode" />
			产品名称：<input type="text" id="productName" />
			<input type="button" value="查询" onclick="queryProduct()"/>
		</div>
		
		<div id="productDataList"></div>
	</div>
 </body>
</html>