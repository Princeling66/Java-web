<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
	/**
	 * 查看采购单详情
	 * @param poid
	 */
	function showDetail(poid,tr){
		var nextTr = $(tr).next("tr");
		if(nextTr.css("display") == "none"){
			nextTr.find("td").load("main/stock/pomainDetail",{"poid":poid},function(){
				
			});
		}
		nextTr.toggle();
	}
	
	
</script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table width="100%" border="0" align="center" cellspacing="1"
	class="c">
	<tr>
		<td class="title1">采购单编号</td>
		<td class="title1">创建时间</td>
		<td class="title1">供应商名称</td>
		<td class="title1">创建用户</td>
		<td class="title1">附加费用</td>
		<td class="title1">采购产品总价</td>
		<td class="title1">采购单总价格</td>
		<td class="title1">付款方式</td>
		<td class="title1">最低预付款金额</td>
		<td class="title1">处理状态</td>
		<td class="title1">操作</td>
	</tr>
	<c:forEach items="${page.dataList }" var="po">
		<tr ondblclick="showDetail(${po.poId},this)">
			<td align="center">${po.poId }</td>
			<td align="center">${po.createTime }</td>
			<td align="center">${po.venderName}</td>
			<td align="center">${po.account}</td>
			<td align="center">${po.tipFee}</td>
			<td align="center">${po.poTotal}</td>
			<td align="center">${po.productTotal}</td>
			<td align="center">${po.payType}</td>
			<td align="center">${po.prePayFee}</td>
			<td align="center">
				<c:if test="${po.status ==1 }">新增</c:if>
				<c:if test="${po.status ==2 }">已收货</c:if>
				<c:if test="${po.status ==3 }">已付款</c:if>
				<c:if test="${po.status ==4 }">已了结</c:if>
				<c:if test="${po.status ==5 }">已预付</c:if>
			</td>
			
			<td align="center">
				<a href="javascript:instock(${po.poId })" >入库</a>
				
			</td>
		</tr>
		<tr style="display:none"><td colspan="11" name="detail"></td></tr>
	</c:forEach>
</table>
<%--导入分页层 --%>
<%@include file="../../public/page.jsp"%>

