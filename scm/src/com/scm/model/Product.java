package com.scm.model;

/**
 *	产品表模型 
 */
public class Product {
	private String productCode;//产品编号
	private Integer categoryId;//类别序列号
	private String name;//名称
	private String unitName;//数量单位
	private Double price;//销售价
	private String createDate;//添加日期
	private String remark;//产品描述
	private Integer num;//库存数
	private Integer poNum;//采购在途数
	private Integer soNum;//销售待发数
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public Integer getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getPoNum() {
		return poNum;
	}
	public void setPoNum(Integer poNum) {
		this.poNum = poNum;
	}
	public Integer getSoNum() {
		return soNum;
	}
	public void setSoNum(Integer soNum) {
		this.soNum = soNum;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	
}
