package com.scm.model;

/**
 *	用户模块表 
 */
public class UserModel {
	private String account;//用户账号
	private Integer modelCode;//模块编号
	
	private String modelName;//模块名称
	private String modelUri;//模块路径
	
	
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public Integer getModelCode() {
		return modelCode;
	}
	public void setModelCode(Integer modelCode) {
		this.modelCode = modelCode;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getModelUri() {
		return modelUri;
	}
	public void setModelUri(String modelUri) {
		this.modelUri = modelUri;
	}
	
}
