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
			nextTr.find("td").load("main/pomain/pomainDetail",{"poid":poid},function(){
				
			});
		}
		nextTr.toggle();
	}
	
	//删除
	function del(poid){
		if(confirm("确定要删除吗？")){
			$.post("main/pomain/pomainDel",{"poid":poid},function(data){
				if(data == "ok"){
					alert("删除成功！");
					goPage(${page.currentPage});
				}else{
					alert("删除失败！");
				}
			});
		}
		
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
			<td align="center">
				<c:if test="${po.payType == 1}">货到付款</c:if>
				<c:if test="${po.payType == 2}">款到发货</c:if>
				<c:if test="${po.payType == 3}">预付款到发货</c:if>
			</td>
			<td align="center">${po.prePayFee}</td>
			
			<td align="center">
				<a href="javascript:openUpdate(${po.poId })" >修改</a>
				<a href="javascript:del('${po.poId}')">删除</a>
			</td>
		</tr>
		<tr style="display:none"><td colspan="10" name="detail"></td></tr>
	</c:forEach>
</table>
<%--导入分页层 --%>
<%@include file="../../public/page.jsp"%>

