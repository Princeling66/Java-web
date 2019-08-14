package com.scm.model;

/**
 *	盘点表模型 
 */
public class CheckStock {
	private Integer stockId; //序列号
	private String productCode;//产品编号
	private Integer originNum;//原始数量
	private Integer realNum;//实际数量
	private String stockTime;//盘点时间
	private String createUser;//经手人
	private String description;//损益原因
	private String type;//损益类型
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
	public Integer getOriginNum() {
		return originNum;
	}
	public void setOriginNum(Integer originNum) {
		this.originNum = originNum;
	}
	public Integer getRealNum() {
		return realNum;
	}
	public void setRealNum(Integer realNum) {
		this.realNum = realNum;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "CheckStock [stockId=" + stockId + ", productCode=" + productCode + ", originNum=" + originNum
				+ ", realNum=" + realNum + ", stockTime=" + stockTime + ", createUser=" + createUser + ", description="
				+ description + ", type=" + type + "]";
	}
	
	
	
}
