$(function(){
	//修改产品数量时 触发事件
	$("input[name=num]").live("change",function(){
		var num = $(this).val();
		var reg = /^\d+$/;
		if(!reg.test(num)){
			$(this).val(0);
		}else{
			countProductTotal();
			countItemPrice($(this).parent().parent());
		}
	});
	//修改产品价格时 和附加费用,最低预付款金额时 触发事件
	$("input[name=unitPrice],#tipFee,#prePayFee").live("change",function(){
		var unitPrice = $(this).val();
		var reg = /^\d+$|^\d+\.\d{1,2}$/;
		if(!reg.test(unitPrice)){
			$(this).val(0);
		}else{
			countProductTotal();
			countItemPrice($(this).parent().parent());
		}
	});
	
});
//改变付款方式时触发事件
function chgPayType(obj){
	var payType = $(obj).val();
	if(payType == "预付款到发货"){
		$("#prePayFee").attr("readonly",false);
	}else{
		$("#prePayFee").attr("readonly",true);
		$("#prePayFee").val(0);
	}
}

function backPomainNew(){
	window.location.href = "main/pomain/pomain_new.jsp";
}

//打开选择供应商窗口
function openVender(){
	$("body>div").hide();
	$("#venderCode,#venderName").val("");
	queryVender();
}
//查询供应商
function queryVender(){
	var venderCode = $.trim($("#venderCode").val());
	var name = $.trim($("#venderName").val());
	var params = {
			"venderCode":venderCode,
			"name":name
	};
	$("#venderDataList").load("main/pomain/venderSelect",params,function(){
		$("#venderDiv").show();
	})
}
//取消选择
function cancleSelect(){
	$("body>div").hide();
	$("#main").show();
}
//选中行
function selectItem(tr){
	//清除其他行的选中状态
	clearSelected($(tr).parent());
	$(tr).find("td").css({"background":"#C1CDD8"});//选中行颜色改变
	$(tr).find("td:eq(0)").text("√");//选中行颜色改变
}
//清除选中状态
function clearSelected(obj){
	obj.find("tr:gt(0) td").css({"background":"#fff7e5"});
	obj.find("tr:gt(0)").find("td:eq(0)").text("");
}
//供应商选择 点击确定按钮
function confirmVender(){
	$("#venderDataList table tr:gt(0)").find("td:eq(0)").each(function(){
		if(this.innerHTML == "√"){
			//设置选中的供应商信息
			$("#vName").val($(this).parent().find("td:eq(2)").text());
			$("#vCode").val($(this).parent().find("td:eq(1)").text());
			cancleSelect();//关闭选择供应商列表层
			return false;//退出循环
		}
	});
}
//增加明细
function addItem(){
	var d = $("#detailTable");
	//当前行号
	var i = d.find("tr").length;
	
	var html = "<tr align='center'>" 
					+"<td>"+i+"</td>" 
					+"<td><input type='text'  name='productCode' size='10' readonly/> <span class='LL'><image src='images/selectDate.gif' onclick='openProduct(\"" + i + "\")'></span></td>" 
					+"<td><input type='text'  name='name' size='15' readonly/></td>" 
					+"<td><input type='text'  name='unitName' size='15' readonly/></td>" 
					+"<td><input type='text'  name='num' size='15' value='1'/></td>" 
					+"<td><input type='text'  name='unitPrice' size='15' value='0'/></td>" 
					+"<td><input type='text'  name='itemPrice' size='15' value='0' readonly/></td>" 
					+"<td><img src='images/delete.gif' class='LL' onclick='delItem(this)'/></td>" 
			   "</tr>"

	d.append(html);
}

var selectIndex = -1;//选择产品的行号 
//打开选择产品层
function openProduct(i){
	selectIndex = i;
	$("body>div").hide();
	$("#productCode,#productName").val("");
	queryProduct();
}
//查询产品
function queryProduct(){
	var productCode = $.trim($("#productCode").val());
	var name = $.trim($("#productName").val());
	var params = {
			"productCode":productCode,
			"name":name
	};
	$("#productDataList").load("main/pomain/productSelect",params,function(){
		$("#productDiv").show();
	})
}
//确定选择产品
function confirmProduct(){
	$("#productDataList table tr:gt(0)").find("td:eq(0)").each(function(){
		if(this.innerHTML == "√"){
			var productCode = $(this).parent().find("td:eq(1)").text();
			//判断是否已经选择过
			if($("#detailTable input[name=productCode]:not(:eq("+(selectIndex-1)+"))[value="+productCode+"]").length == 1){
				alert("该产品已经存在！");
				return false;
			}
			//设置选中的供应商信息
			$("input[name=productCode]:eq("+(selectIndex-1)+")").val(productCode);
			$("input[name=name]:eq("+(selectIndex-1)+")").val($(this).parent().find("td:eq(2)").text());
			$("input[name=unitName]:eq("+(selectIndex-1)+")").val($(this).parent().find("td:eq(3)").text());
			$("input[name=num]:eq("+(selectIndex-1)+")").val(1);
			$("input[name=unitPrice]:eq("+(selectIndex-1)+")").val(0);
			countProductTotal();
			cancleSelect();//关闭选择层
			return false;//退出循环
		}
	});
}
//删除选中行
function delItem(obj){
	$(obj).parent().parent().remove();//删除一行
	$("#detailTable tr:gt(0)").each(function(i){
		$(this).find("td:eq(0)").text(i+1);
	});
	
	countProductTotal();
}
//计算产品总价格
function countProductTotal(){
	var total = 0;
	$("#detailTable tr:gt(0)").each(function(){
		var num = $(this).find("input[name=num]").val();
		var unitPrice = $(this).find("input[name=unitPrice]").val();
		total += num*unitPrice;
	});
	$("#productTotal").val(total);
}
//计算明细价格
function countItemPrice(tr){
	var num = tr.find("input[name=num]").val();
	var unitPrice = tr.find("input[name=unitPrice]").val();
	var itemPrice = num*unitPrice;
	tr.find("input[name=itemPrice]").val(itemPrice);
}

/**
 * 
 * @param flag boolean类型 true-新增 false-修改
 */
function savePomain(flag){
	$("#wrong").text("");
	var b = true;//标记数据校验结果 true为校验正确 false为校验失败
	
	var poId = $("#poId").val();
	var createTime = $("#createTime").val();
	var venderCode = $("#vCode").val();//供应商编号
	var createTime = $("#createTime").val();
	var tipFee = $("#tipFee").val();//附加费用
	var productTotal = $("#productTotal").val();//产品总价格
	var payType = $("#payType").val();//付款方式
	var prePayFee = $("#prePayFee").val();//最低预付款金额
	var remark = $("#remark").val();//备注
	
	if(venderCode == ""){
		$("#wrong").text("请选择供应商");
		return;
	}
	
	var poitems = [];
	$("#detailTable tr:gt(0)").each(function(){
		var productCode = $(this).find("input[name=productCode]").val();
		var unitPrice = $(this).find("input[name=unitPrice]").val();
		var num = $(this).find("input[name=num]").val();
		var unitName = $(this).find("input[name=unitName]").val();
		var itemPrice = $(this).find("input[name=itemPrice]").val();
		
		if(productCode == ""){
			b = false;
			$("#wrong").text("请选择产品");
			return false;//退出循环
		}
		if(num == 0){
			b = false;
			$("#wrong").text("产品数量不能为0");
			return false;//退出循环
		}
		if(unitPrice == 0){
			b = false;
			$("#wrong").text("采购单价不能为0");
			return false;//退出循环
		}
		var poitem = {
			"productCode":productCode,
			"unitPrice":unitPrice,
			"num":num,
			"unitName":unitName,
			"itemPrice":itemPrice
		};
		poitems.push(poitem);
	});
	
	
	//数据校验失败
	if(!b){
		return ;
	}
	if(poitems.length == 0){
		$("#wrong").text("请增加明细");
		return;
	}
	
	if(payType == "3"){
		if(prePayFee == 0){
			$("#wrong").text("预付款金额不能为0");
			return;
		}else if(parseFloat(prePayFee) >= parseFloat(tipFee)+parseFloat(productTotal)){
			$("#wrong").text("预付款金额不能大于订单总价格");
			return;
		}
	}
	
	var pomain = {
		"poId":poId,
		"createTime":createTime,
		"venderCode":venderCode,
		"createTime":createTime,
		"tipFee":tipFee,
		"productTotal":productTotal,
		"payType":payType,
		"prePayFee":prePayFee,
		"remark":remark,
		"poitems":poitems
	};
	
	if(flag){//新增
		//发送数据到服务端
		$.post("main/pomain/pomainAdd",{"pomain":JSON.stringify(pomain)},function(data){
			if(data == "ok"){
				alert("新增成功！");
				window.location.href = "/scm/main/pomain/pomain_new.jsp";
			}else{
				alert("新增失败！");
			}
		});
	}else{
		//修改
		//发送数据到服务端
		$.post("main/pomain/pomainUpdate",{"pomain":JSON.stringify(pomain)},function(data){
			if(data == "ok"){
				alert("修改成功！");
				window.location.href = "/scm/main/pomain/pomain_new.jsp";
			}else{
				alert("修改失败！");
			}
		});
	}
}

