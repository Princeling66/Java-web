package com.scm.model;
/**
 *	产品分类表模型 
 */
public class Category {
	private Integer categoryId;//类别序列号
	private String name;//名称
	private String remark;//描述
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Override
	public String toString() {
		return "Category [categoryId=" + categoryId + ", name=" + name + ", remark=" + remark + "]";
	}
	
	
	
	
}
