package com.scm.constants;
/**
 * 系统配置
 * @author Administrator
 *
 */
public interface ScmConfig {
	
	
	/**
	 * 采购单 销售单状态
	 */
	/**
	 * 新增 状态
	 */
	int ADD = 1;
	/**
	 * 已收货或者已发货状态
	 */
	int RECEIVE = 2;
	/**
	 * 已付款或者已收款状态
	 */
	int PAY = 3;
	/**
	 * 已了结状态
	 */
	int END = 4;
	/**
	 * 已预付或者已收预付款状态
	 */
	int PREPAY = 5;
	
	
	/**
	 * 库存变动类型
	 */
	/**
	 * 采购入库
	 */
	int PO_INSTOCK = 1;
	/**
	 * 销售出库
	 */
	int SO_OUTSTOCK = 2;
	/**
	 * 盘点入库
	 */
	int CHECK_INSTOCK = 3;
	/**
	 * 盘点出库
	 */
	int CHECK_OUTSTOCK = 4;
	
	/**
	 * 货到付款1 
	 */
	int PAYTYPE_LAST_PAY = 1;
	/**
	款到发货2 
	 */
	int PAYTYPE_FIRST_PAY = 2;
	/**
	预付款到发货3
	 */
	int PAYTYPE_PRE_PAY = 3;
	
	
	/**
	 * 收款1
	 */
	int RECEIVE_MONEY = 1;
	/**
	付款2
	 */
	int PAY_MONEY = 2;
	/**
	收预付款3
	 */
	int RECEIVE_PRE_MONEY = 3;
	/**
	付预付款4
	 */
	int PAY_PRE_MONEY = 4;
	
	
	
	
}
