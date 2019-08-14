package com.scm.model;

/**
 *	入库记录表模型 
 */
public class StockRecord {
	
	private Integer stockId;//序列号
	private String productCode;//产品编号
	private String orderCode;//相关单据号
	private Integer stockNum;//入库数量
	private Integer stockType;//入库类型
	private String stockTime;//入库时间
	private String createUser;//经手人
	public Integer getStockId() {
		return stockId;
	}
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	public Integer getStockNum() {
		return stockNum;
	}
	public void setStockNum(Integer stockNum) {
		this.stockNum = stockNum;
	}
	public Integer getStockType() {
		return stockType;
	}
	public void setStockType(Integer stockType) {
		this.stockType = stockType;
	}
	public String getStockTime() {
		return stockTime;
	}
	public void setStockTime(String stockTime) {
		this.stockTime = stockTime;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	
	
	
	
	
}
